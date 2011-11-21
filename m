Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 34E3DB7213
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Nov 2011 23:23:01 +1100 (EST)
Message-ID: <4ECA42A2.1040300@redhat.com>
Date: Mon, 21 Nov 2011 14:22:58 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 01/11] KVM: PPC: Add memory-mapping support for PCI
 passthrough and emulation
References: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
 <20111116225209.GB26985@bloggs.ozlabs.ibm.com> <4EC8F158.8010706@redhat.com>
 <20111121110356.GA1516@bloggs.ozlabs.ibm.com>
In-Reply-To: <20111121110356.GA1516@bloggs.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/21/2011 01:03 PM, Paul Mackerras wrote:
> On Sun, Nov 20, 2011 at 02:23:52PM +0200, Avi Kivity wrote:
> > 
> > There is no "the VMA".  There could be multiple VMAs, or none (with the
> > mmap() coming afterwards).  You could do all the checks you want here,
> > only to have host userspace remap it under your feet.  This needs to be
> > done on a per-page basis at fault time.
>
> OK, so that's a somewhat different mental model than I had in mind.  I
> can change the code to do almost everything on a per-page basis at
> fault time on POWER7.  There is one thing we can't do at fault time,
> which is to tell the hardware the page size for the "virtual real mode
> area" (VRMA), which is a mapping of the memory starting at guest
> physical address zero.  We can however work out that pagesize the
> first time we run a vcpu.  By that stage we must have some memory
> mapped at gpa 0, otherwise the vcpu is not going to get very far.  We
> will need to look for the page size of whatever is mapped at gpa 0 at
> that point and give it to the hardware.

Ok.  Do you need to check at fault time that your assumptions haven't
changed, then?

> On PPC970, which is a much older processor, we can't intercept the
> page faults (at least not without running the whole guest in user mode
> and emulating all the privileged instructions), so once we have given
> the guest access to a page, we can't revoke it.  We will have to take
> and keep a reference to the page so it doesn't go away underneath us,
> which of course doesn't guarantee that userland can continue to see
> it, but does at least mean we won't corrupt memory.

Yes, this is similar to kvm/x86 before mmu notifiers were added.

>
> > > +		/*
> > > +		 * We require read & write permission as we cannot yet
> > > +		 * enforce guest read-only protection or no access.
> > > +		 */
> > > +		if ((vma->vm_flags & (VM_READ | VM_WRITE)) !=
> > > +		    (VM_READ | VM_WRITE))
> > > +			goto err_unlock;
> > 
> > This, too, must be done at get_user_pages() time.
> > 
> > What happens if mmu notifiers tell you to write protect a page?
>
> On POWER7, we have to remove access to the page, and then when we get
> a fault on the page, request write access when we do
> get_user_pages_fast.

Ok, so no ksm for you.  Does this apply to kvm-internal write
protection, like we do for the framebuffer and live migration?  I guess
you don't care much about the framebuffer (and anyway it doesn't need
read-only access), but removing access for live migration is painful.

-- 
error compiling committee.c: too many arguments to function
