Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF5921A017E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 14:34:42 +1000 (EST)
Message-ID: <1406522073.4935.46.camel@pasglop>
Subject: Re: [PATCH v3 03/18] KVM: PPC: Account TCE pages in locked_vm
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 28 Jul 2014 14:34:33 +1000
In-Reply-To: <53D5D04F.7000507@ozlabs.ru>
References: <1406191691-31441-1-git-send-email-aik@ozlabs.ru>
 <1406191691-31441-4-git-send-email-aik@ozlabs.ru>
 <1406508232.4935.23.camel@pasglop> <53D5D04F.7000507@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-07-28 at 14:23 +1000, Alexey Kardashevskiy wrote:
> On 07/28/2014 10:43 AM, Benjamin Herrenschmidt wrote:
> > On Thu, 2014-07-24 at 18:47 +1000, Alexey Kardashevskiy wrote:
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> > 
> > You need a description.
> > 
> >>  arch/powerpc/kvm/book3s_64_vio.c | 35 ++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 34 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
> >> index 516f2ee..48b7ed4 100644
> >> --- a/arch/powerpc/kvm/book3s_64_vio.c
> >> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> >> @@ -45,18 +45,48 @@ static long kvmppc_stt_npages(unsigned long window_size)
> >>  		     * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
> >>  }
> >>  
> >> +/*
> >> + * Checks ulimit in order not to let the user space to pin all
> >> + * available memory for TCE tables.
> >> + */
> >> +static long kvmppc_account_memlimit(long npages)
> >> +{
> >> +	unsigned long ret = 0, locked, lock_limit;
> >> +
> >> +	if (!current->mm)
> >> +		return -ESRCH; /* process exited */
> >> +
> >> +	down_write(&current->mm->mmap_sem);
> >> +	locked = current->mm->locked_vm + npages;
> >> +	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> >> +	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
> >> +		pr_warn("RLIMIT_MEMLOCK (%ld) exceeded\n",
> >> +				rlimit(RLIMIT_MEMLOCK));
> >> +		ret = -ENOMEM;
> >> +	} else {
> >> +		current->mm->locked_vm += npages;
> >> +	}
> >> +	up_write(&current->mm->mmap_sem);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >>  static void release_spapr_tce_table(struct kvmppc_spapr_tce_table *stt)
> >>  {
> >>  	struct kvm *kvm = stt->kvm;
> >>  	int i;
> >> +	long npages = kvmppc_stt_npages(stt->window_size);
> >>  
> >>  	mutex_lock(&kvm->lock);
> >>  	list_del(&stt->list);
> >> -	for (i = 0; i < kvmppc_stt_npages(stt->window_size); i++)
> >> +	for (i = 0; i < npages; i++)
> >>  		__free_page(stt->pages[i]);
> >> +
> >>  	kfree(stt);
> >>  	mutex_unlock(&kvm->lock);
> >>  
> >> +	kvmppc_account_memlimit(-(npages + 1));
> >> +
> >>  	kvm_put_kvm(kvm);
> >>  }
> >>  
> >> @@ -112,6 +142,9 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
> >>  	}
> >>  
> >>  	npages = kvmppc_stt_npages(args->window_size);
> >> +	ret = kvmppc_account_memlimit(npages + 1);
> >> +	if (ret)
> >> +		goto fail;
> > 
> > This is called for VFIO only or is it also called when creating TCE
> > tables for emulated devices ? Because in the latter case, you don't
> > want to account the pages as locked, do you ?
> 
> At the moment TCE-containing pages (for emulated TCE) are allocated with
> alloc_page() which is kernel memory and therefore always locked, no?

So the npages up there is the number of TCE-containing pages, not the
number of mapped-by-TCE pages ? In that case it makes sense yes.

> 
> > Also, you need to explain what +1
> > 
> > Finally, do I correctly deduce that creating 10 TCE tables of 2G
> > each will end up accounting 20G as locked even if the guest for
> > example only has 4G of RAM ? 
> 
> 
> The user is required to set the limit to 20G, correct. But this does not
> mean all 20G will be pinned. Ugly but better than nothing. As I remember
> from you explanations, even if we give up real/virtual mode handlers for
> H_PUT_TCE&Co, we cannot rely of existing counters in page struct in order
> to understand whether we need to account a page again or not so we are
> stuck with this code till we have a "clone DDW window" API.

Right but please put that explanation somewhere in one of the changeset
comments or as comments near the code.

> But this patch is not about guest pages, it is about pages with TCEs, there
> was no counting for this at all.

Ok.

> 
> 
> > 
> >>  	stt = kzalloc(sizeof(*stt) + npages * sizeof(struct page *),
> >>  		      GFP_KERNEL);
> > 
> > Ben.
> > 
> > 
> 
> 
