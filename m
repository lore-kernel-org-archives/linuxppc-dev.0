Return-Path: <paulus@ozlabs.org>
Date: Wed, 24 Apr 2013 15:47:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V6 05/27] powerpc: New hugepage directory format
Message-ID: <20130424054734.GA2073@drongo>
References: <1366624861-24948-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1366624861-24948-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366624861-24948-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 22, 2013 at 03:30:39PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

[snip]

>  /*
> - * Use the top bit of the higher-level page table entries to indicate whether
> - * the entries we point to contain hugepages.  This works because we know that
> - * the page tables live in kernel space.  If we ever decide to support having
> - * page tables at arbitrary addresses, this breaks and will have to change.
> - */
> -#ifdef CONFIG_PPC64
> -#define PD_HUGE 0x8000000000000000
> -#else
> -#define PD_HUGE 0x80000000
> -#endif

I think this is a good thing to do ultimately, but if you do this you
also need to fix arch/powerpc/kernel/head_fsl_booke.S:

#ifdef CONFIG_PTE_64BIT
#ifdef CONFIG_HUGETLB_PAGE
#define FIND_PTE	\
	rlwinm	r12, r10, 13, 19, 29;	/* Compute pgdir/pmd offset */	\
	lwzx	r11, r12, r11;		/* Get pgd/pmd entry */		\
	rlwinm.	r12, r11, 0, 0, 20;	/* Extract pt base address */	\
	blt	1000f;			/* Normal non-huge page */	\
	beq	2f;			/* Bail if no table */		\
	oris	r11, r11, PD_HUGE@h;	/* Put back address bit */	\
	andi.	r10, r11, HUGEPD_SHIFT_MASK@l; /* extract size field */	\
	xor	r12, r10, r11;		/* drop size bits from pointer */ \
	b	1001f;							\

and this, from arch/powerpc/mm/tlb_low_64e.S:

	cmpdi	cr0,r14,0
	bge	tlb_miss_fault_bolted	/* Bad pgd entry or hugepage; bail */

(of which there are several similar instances in that file).

If you want to avoid fixing these bits of assembly code (and any
others I missed in my quick scan), you'll need to keep the definition
of PD_HUGE, at least on anything not 64-bit Book3S.

Paul.
