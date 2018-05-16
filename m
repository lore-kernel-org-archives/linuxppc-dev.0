Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m5B946xKzF1fl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 17:08:17 +1000 (AEST)
Date: Wed, 16 May 2018 17:08:14 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au,
 Matthew Wilcox <willy@infradead.org>, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc: kvm: Change return type to vm_fault_t
Message-ID: <20180516070814.GA20588@fergus.ozlabs.ibm.com>
References: <20180510182719.GA22217@jordon-HP-15-Notebook-PC>
 <CAFqt6zbxWkOQXtKZXyDae=ZEQR+d0xf42fvnvUoBSHQZcHRCBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFqt6zbxWkOQXtKZXyDae=ZEQR+d0xf42fvnvUoBSHQZcHRCBg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 16, 2018 at 10:11:11AM +0530, Souptick Joarder wrote:
> On Thu, May 10, 2018 at 11:57 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > Use new return type vm_fault_t for fault handler
> > in struct vm_operations_struct. For now, this is
> > just documenting that the function returns a
> > VM_FAULT value rather than an errno.  Once all
> > instances are converted, vm_fault_t will become
> > a distinct type.
> >
> > commit 1c8f422059ae ("mm: change return type to
> > vm_fault_t")
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> > v2: Updated the change log
> >
> >  arch/powerpc/kvm/book3s_64_vio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
> > index 4dffa61..346ac0d 100644
> > --- a/arch/powerpc/kvm/book3s_64_vio.c
> > +++ b/arch/powerpc/kvm/book3s_64_vio.c
> > @@ -237,7 +237,7 @@ static void release_spapr_tce_table(struct rcu_head *head)
> >         kfree(stt);
> >  }
> >
> > -static int kvm_spapr_tce_fault(struct vm_fault *vmf)
> > +static vm_fault_t kvm_spapr_tce_fault(struct vm_fault *vmf)
> >  {
> >         struct kvmppc_spapr_tce_table *stt = vmf->vma->vm_file->private_data;
> >         struct page *page;
> > --
> > 1.9.1
> >
> 
> If no comment, we would like to get this patch in queue
> for 4.18.

It looks fine - I'll queue it up.

Paul.
