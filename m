Return-Path: <paulus@ozlabs.org>
Date: Tue, 30 Mar 2010 16:24:42 +1100
From: Paul Mackerras <paulus@samba.org>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [RFC Patch 1/2] PPC64-HWBKPT: Disable interrupts for data
	breakpoint exceptions
Message-ID: <20100330052442.GB12619@drongo>
References: <20100323140008.954823303@pr> <20100323140702.GB21836@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100323140702.GB21836@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 23, 2010 at 07:37:02PM +0530, K.Prasad wrote:

> Index: linux-2.6.ppc64_test/arch/powerpc/kernel/exceptions-64s.S
> ===================================================================
> --- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/exceptions-64s.S
> +++ linux-2.6.ppc64_test/arch/powerpc/kernel/exceptions-64s.S
> @@ -735,6 +735,9 @@ _STATIC(do_hash_page)
>  	std	r3,_DAR(r1)
>  	std	r4,_DSISR(r1)
>  
> +	andis.  r0,r4,0x0040		/* Data Address Breakpoint match? */

Minor comment: why not DSISR_DABRMATCH@h instead of 0x0040?

> +	bne-    handle_dabr_fault
> +
>  	andis.	r0,r4,0xa450		/* weird error? */
>  	bne-	handle_page_fault	/* if not, try to insert a HPTE */
>  BEGIN_FTR_SECTION
> @@ -823,6 +826,15 @@ END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISER
>  	bl	.raw_local_irq_restore
>  	b	11f
>  
> +/* We have a data breakpoint exception - handle it */
> +handle_dabr_fault:
> +	/* Populate the pt_regs structure */

Another minor comment: that comment isn't accurate since you're not
putting anything in the pt_regs, just getting arguments to do_dabr
from it.

> +	ld      r4,_DAR(r1)
> +	ld      r5,_DSISR(r1)
> +	addi    r3,r1,STACK_FRAME_OVERHEAD
> +	bl      .do_dabr
> +	b       .ret_from_except_lite
> +
>  /* Here we have a page fault that hash_page can't handle. */
>  handle_page_fault:
>  	ENABLE_INTS
> Index: linux-2.6.ppc64_test/arch/powerpc/mm/fault.c
> ===================================================================
> --- linux-2.6.ppc64_test.orig/arch/powerpc/mm/fault.c
> +++ linux-2.6.ppc64_test/arch/powerpc/mm/fault.c
> @@ -151,7 +151,7 @@ int __kprobes do_page_fault(struct pt_re
>  	if (!user_mode(regs) && (address >= TASK_SIZE))
>  		return SIGSEGV;
>  
> -#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
> +#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE) || defined(CONFIG_PPC64))

If we added similar code to head_32.S, we could probably remove this
whole ifdef block.  But that can be done in a later patch.

Paul.
