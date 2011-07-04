Return-Path: <paulus@ozlabs.org>
Date: Mon, 4 Jul 2011 21:51:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH 10/17] KVM: PPC: Add support for Book3S processors in
	hypervisor mode
Message-ID: <20110704115108.GA2607@bloggs.ozlabs.ibm.com>
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
	<20110629102134.GK25406@bloggs.ozlabs.ibm.com>
	<1309545462.16582.12.camel@nimitz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309545462.16582.12.camel@nimitz>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
	Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 01, 2011 at 11:37:42AM -0700, Dave Hansen wrote:
> On Wed, 2011-06-29 at 20:21 +1000, Paul Mackerras wrote: 
> > +struct kvmppc_pginfo {
> > +	unsigned long pfn;
> > +	atomic_t refcnt;
> > +};
> 
> I only see this refcnt inc'd in one spot and never decremented or read.
> Is the refcnt just the number of hptes we have for this particular page
> at the moment?  

It's redundant at present, because the guest physical memory is all
large pages and we don't hand any pages back until the guest quits.

We're going to have to keep some sort of list of HPTEs for each
guest-physical page and we will probably need this refcnt then.

> > +static unsigned long user_page_size(unsigned long addr)
> > +{
> > +	struct vm_area_struct *vma;
> > +	unsigned long size = PAGE_SIZE;
> > +
> > +	down_read(&current->mm->mmap_sem);
> > +	vma = find_vma(current->mm, addr);
> > +	if (vma)
> > +		size = vma_kernel_pagesize(vma);
> > +	up_read(&current->mm->mmap_sem);
> > +	return size;
> > +}
> 
> That one looks pretty arch-independent and like it could use some
> consolidation with: virt/kvm/kvm_main.c::kvm_host_page_size()

Actually, it goes away again in patch 14. :)

> > +	/* VRMA can't be > 1TB */
> > +	if (npages > 1ul << (40 - kvm->arch.ram_porder))
> > +		npages = 1ul << (40 - kvm->arch.ram_porder);
> 
> Is that because it can only be a single segment?  Does that mean that we
> can't ever have guests larger than 1TB?  Or just that they have to live
> with 1TB until they get their own page tables up?

It can only be a single segment, and that's because that's how the
hardware works.

It means that the when running in real mode the guest can access at
most the first 1TB of physical memory.  Real mode is used early in the
boot process and also in the early stages of exception/interrupt
processing.  (Under pHyp we typically only get to access the first
128MB or 256MB of memory in real mode.)

> > +	/* Can't use more than 1 HPTE per HPTEG */
> > +	if (npages > HPT_NPTEG)
> > +		npages = HPT_NPTEG;
> > +
> > +	for (i = 0; i < npages; ++i) {
> > +		pfn = pginfo[i].pfn;
> > +		/* can't use hpt_hash since va > 64 bits */
> > +		hash = (i ^ (VRMA_VSID ^ (VRMA_VSID << 25))) & HPT_HASH_MASK;
> 
> Is that because 'i' could potentially have a very large pfn?  Nish
> thought it might have something to do with the hpte entries being larger
> than 64-bits themselves with the vsid included, but we got thoroughly
> confused. :)

It's because VRMA_VSID (which is set by hardware, we don't control it)
is larger than 2^24.  The hpt_hash() function takes a 64-bit VA
composed of a 24-bit VSID and 40 bits of segment offset (for addresses
in 1TB segments).

Paul.
