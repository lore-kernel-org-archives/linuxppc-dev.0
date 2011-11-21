Return-Path: <paulus@ozlabs.org>
Date: Mon, 21 Nov 2011 22:03:56 +1100
From: Paul Mackerras <paulus@samba.org>
To: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 01/11] KVM: PPC: Add memory-mapping support for PCI
 passthrough and emulation
Message-ID: <20111121110356.GA1516@bloggs.ozlabs.ibm.com>
References: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
 <20111116225209.GB26985@bloggs.ozlabs.ibm.com>
 <4EC8F158.8010706@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EC8F158.8010706@redhat.com>
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

On Sun, Nov 20, 2011 at 02:23:52PM +0200, Avi Kivity wrote:
> 
> There is no "the VMA".  There could be multiple VMAs, or none (with the
> mmap() coming afterwards).  You could do all the checks you want here,
> only to have host userspace remap it under your feet.  This needs to be
> done on a per-page basis at fault time.

OK, so that's a somewhat different mental model than I had in mind.  I
can change the code to do almost everything on a per-page basis at
fault time on POWER7.  There is one thing we can't do at fault time,
which is to tell the hardware the page size for the "virtual real mode
area" (VRMA), which is a mapping of the memory starting at guest
physical address zero.  We can however work out that pagesize the
first time we run a vcpu.  By that stage we must have some memory
mapped at gpa 0, otherwise the vcpu is not going to get very far.  We
will need to look for the page size of whatever is mapped at gpa 0 at
that point and give it to the hardware.

On PPC970, which is a much older processor, we can't intercept the
page faults (at least not without running the whole guest in user mode
and emulating all the privileged instructions), so once we have given
the guest access to a page, we can't revoke it.  We will have to take
and keep a reference to the page so it doesn't go away underneath us,
which of course doesn't guarantee that userland can continue to see
it, but does at least mean we won't corrupt memory.

> > +		/*
> > +		 * We require read & write permission as we cannot yet
> > +		 * enforce guest read-only protection or no access.
> > +		 */
> > +		if ((vma->vm_flags & (VM_READ | VM_WRITE)) !=
> > +		    (VM_READ | VM_WRITE))
> > +			goto err_unlock;
> 
> This, too, must be done at get_user_pages() time.
> 
> What happens if mmu notifiers tell you to write protect a page?

On POWER7, we have to remove access to the page, and then when we get
a fault on the page, request write access when we do
get_user_pages_fast.

Paul.
