Message-ID: <3DADA1EB.1D382BD8@esteem.com>
Date: Wed, 16 Oct 2002 10:29:15 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Cameron Rich <CameronR@nulec.com.au>
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>,
	Patrick Mahoney <pmahoney@8d.com>
Subject: Re: mpc8xx - power save modes - PIT
References: <1072F1A27E99D3119747005004B9A380016F9573@MAIL>
Content-Type: multipart/mixed;
 boundary="------------F14E2E0DF2C901B1C7E7BF28"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------F14E2E0DF2C901B1C7E7BF28
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Cameron Rich wrote:
>
> Hi,
>
> I've been following this series of emails closely as we are interested in
> low power mode also.
>
> I've tried Conn's code, but I'm experiencing problems with PLPRCR[CSCR] as
> being 1 all the time after a rfi. I am also occasionally seeing MSR_POW set
> to 1 after the rfi return.

	An interrupt doesn't change the MSR_POW bit.So seeing the MSR_POW bit
set is to be expected. However there may be a problem with the PLPRCR[CSRC].
The MPC860 and MPC850 User's Manuals were vague on the subject of the
PLPRCR[CSRC] gets cleared by an interrupt if the SCCR[PRQEN] is set. I
contacted our motorola rep to ask about it and he said it was. I have not
checked it to be certain that this was true. On our system everything worked
beautifully so I assumed that this was so.


>
> I can work around this problem by setting PLPRCR[CSCR] = 0 and MSR_POW = 0
> after the rfi and this eventually works. But is this the solution? I'm also

I may be wrong about the PLPRCR[CSRC] bit being reset by an interrupt. It might
be necessary to clear the PLPRCR[CSRC] after a rfi.

I did have something that reset the MSR_POW bit but commented it out because I
didn't think it was needed.

I have attached a revised idle.c that makes certain that the PLPRCR[CSRC] gets
cleared.

> noticing no great decrease in power consumption even though I've only got a
> couple of (sleeping) processes. And it seems that there is (mostly) no time
> between entering Doze Low mode and the rfi which confirms the unsatisfactory
> power consumption figures.
>
> I have SCCR[CPQEN] (and SCCR[PRQEN]) set to 1.
>
> I'm using a PPC850 processor with Doze Low mode set. DFNL=DFNH=0 and I'm
> running 2.4.17 (with a RTAI patch).
>
> Cheers,
>
> Cameron
>

There may be something with the RTAI patch that generates alot of interrupts
or prevents or reduces the time the idle loop from running which would reduce
power savings. Setting the SCCR[DFNL] to a higher number will help.


--

*****************************************************************
  If you live at home long enough, your parents will move out.
 (Warning they may try to sell their house out from under you.)
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


--------------F14E2E0DF2C901B1C7E7BF28
Content-Type: text/plain; charset=us-ascii;
 name="idle.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="idle.c"

/*
 * BK Id: SCCS/s.idle.c 1.20 03/19/02 15:04:39 benh
 */
/*
 * Idle daemon for PowerPC.  Idle daemon will handle any action
 * that needs to be taken when the system becomes idle.
 *
 * Written by Cort Dougan (cort@cs.nmt.edu)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version
 * 2 of the License, or (at your option) any later version.
 */
#include <linux/config.h>
#include <linux/errno.h>
#include <linux/sched.h>
#include <linux/kernel.h>
#include <linux/mm.h>
#include <linux/smp.h>
#include <linux/smp_lock.h>
#include <linux/stddef.h>
#include <linux/unistd.h>
#include <linux/ptrace.h>
#include <linux/slab.h>

#include <asm/pgtable.h>
#include <asm/uaccess.h>
#include <asm/system.h>
#include <asm/io.h>
#include <asm/processor.h>
#include <asm/mmu.h>
#include <asm/cache.h>
#include <asm/cputable.h>


#define MPC8XX_POWERSAVE


#ifdef MPC8XX_POWERSAVE
#include <asm/mpc8xx.h>
#include <asm/8xx_immap.h>
#endif


void zero_paged(void);

#ifndef MPC8XX_POWERSAVE
void power_save(void);
#endif

unsigned long zero_paged_on = 0;
unsigned long powersave_nap = 0;

unsigned long *zero_cache;    /* head linked list of pre-zero'd pages */
atomic_t zerototal;      /* # pages zero'd over time */
atomic_t zeropage_hits;  /* # zero'd pages request that we've done */
atomic_t zero_sz;	      /* # currently pre-zero'd pages */
atomic_t zeropage_calls; /* # zero'd pages request that've been made */

int idled(void)
{
#ifdef MPC8XX_POWERSAVE
	int reg;
#else
	int do_power_save = 0;
	/* Check if CPU can powersave */
	if (cur_cpu_spec[smp_processor_id()]->cpu_features &
		(CPU_FTR_CAN_DOZE | CPU_FTR_CAN_NAP))
		do_power_save = 1;
#endif
	/* endless loop with no priority at all */
	current->nice = 20;
	current->counter = -100;
	init_idle();
	for (;;) {
#ifdef CONFIG_SMP
		if (!do_power_save) {
			/*
			 * Deal with another CPU just having chosen a thread to
			 * run here:
			 */
			int oldval = xchg(&current->need_resched, -1);

			if (!oldval) {
				while(current->need_resched == -1)
					; /* Do Nothing */
			}
		}
#endif

#ifdef MPC8XX_POWERSAVE
/*********************************************************

	IMPORTANT!!

if using doze modes make sure the SCCR[PRQEN] is set!

*********************************************************/



		while(!current->need_resched) {
			_nmask_and_or_msr( ( MSR_POW | MSR_EE ), 0);	/* disable interupts and Powersave Mode*/
			/* we disable interupts to avoid losing an interupt that should cause a wake up.
			Powersave Mode needs to be disabled to prevent entering Powersaving Mode right
			after PLPRCR is writen. We need to re-enable interupts first or we won't wake up */

			((immap_t *)IMAP_ADDR)->im_clkrstk.cark_plprcrk = KAPWR_KEY;	/*unlock PLPRCR register*/
			reg = ((immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr;  /*Read current PLPRCR*/
			((immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr = reg ; /* program PLPRCR */
			/* Reset the TMIST bit here or we might not (probaly won't) make it to Powersaving mode */
			reg &= 0xFFFFF8FF;		/*clear CSRC bit and the LPM bits*/
			((immap_t *)IMAP_ADDR)->im_clkrstk.cark_plprcrk = KAPWR_KEY;	/*unlock PLPRCR register*/
/*			reg |= 0x00000400; */		/*set just the CSRC bit placing in Normal Low Mode */
			/* Note Noramal Low Mode just keeps reprograming its self and has interupts blocked most
			of the time. Should not be much of a problem as long as DFNL is not set to divide clock
			by too much. This probably won't save very much power */
/*			reg |= 0x00000100; */		/*set LPM bits to 01 placing in Doze High Mode */
			reg |= 0x00000500;		/*set the CSRC bit and the LPM bits placing in Doze Low Mode*/
			((immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr = reg;	/* program PLPRCR */
			_nmask_and_or_msr(0, MSR_POW | MSR_EE); /*re-enable interupts set into Powersave Mode*/
			/* processor should transition in to powersave mode as soon as MSR bits are set*/

			((immap_t *)IMAP_ADDR)->im_clkrstk.cark_plprcrk = KAPWR_KEY;	/*unlock PLPRCR register*/
				/*clear CSRC bit to make certain we pop back into Normal High Mode */
			((immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr &= 0xFFFFFBFF;

/*			_nmask_and_or_msr(MSR_POW,0);*/ /*dissable Powersave Mode (probably not needed)*/
		}
			schedule();
			check_pgt_cache();

#else

		if (do_power_save && !current->need_resched)
			power_save();

		if (current->need_resched) {
			schedule();
			check_pgt_cache();
		}
#endif
	}
	return 0;
}

/*
 * SMP entry into the idle task - calls the same thing as the
 * non-smp versions. -- Cort
 */
int cpu_idle(void)
{
	idled();
	return 0;
}

#if 0
/*
 * Returns a pre-zero'd page from the list otherwise returns
 * NULL.
 */
unsigned long get_zero_page_fast(void)
{
	unsigned long page = 0;

	atomic_inc(&zero_cache_calls);
	if ( zero_quicklist )
	{
		/* atomically remove this page from the list */
		register unsigned long tmp;
		asm (	"101:lwarx  %1,0,%3\n"  /* reserve zero_cache */
			"    lwz    %0,0(%1)\n" /* get next -- new zero_cache */
			"    stwcx. %0,0,%3\n"  /* update zero_cache */
			"    bne-   101b\n"     /* if lost reservation try again */
			: "=&r" (tmp), "=&r" (page), "+m" (zero_cache)
			: "r" (&zero_quicklist)
			: "cc" );
#ifdef CONFIG_SMP
		/* if another cpu beat us above this can happen -- Cort */
		if ( page == 0 )
			return 0;
#endif /* CONFIG_SMP */
		/* we can update zerocount after the fact since it is not
		 * used for anything but control of a loop which doesn't
		 * matter since it won't affect anything if it zeros one
		 * less page -- Cort
		 */
		atomic_inc((atomic_t *)&zero_cache_hits);
		atomic_dec((atomic_t *)&zero_cache_sz);

		/* zero out the pointer to next in the page */
		*(unsigned long *)page = 0;
		return page;
	}
	return 0;
}

/*
 * Experimental stuff to zero out pages in the idle task
 * to speed up get_free_pages(). Zero's out pages until
 * we've reached the limit of zero'd pages.  We handle
 * reschedule()'s in here so when we return we know we've
 * zero'd all we need to for now.
 */
int zero_cache_water[2] = { 25, 96 }; /* high and low water marks for zero cache */
void zero_paged(void)
{
	unsigned long pageptr = 0;	/* current page being zero'd */
	unsigned long bytecount = 0;
        register unsigned long tmp;
	pte_t *pte;

	if ( atomic_read(&zero_cache_sz) >= zero_cache_water[0] )
		return;
	while ( (atomic_read(&zero_cache_sz) < zero_cache_water[1]) && (!current->need_resched) )
	{
		/*
		 * Mark a page as reserved so we can mess with it
		 * If we're interrupted we keep this page and our place in it
		 * since we validly hold it and it's reserved for us.
		 */
		pageptr = __get_free_pages(GFP_ATOMIC, 0);
		if ( !pageptr )
			return;

		if ( current->need_resched )
			schedule();

		/*
		 * Make the page no cache so we don't blow our cache with 0's
		 */
		pte = find_pte(&init_mm, pageptr);
		if ( !pte )
		{
			printk("pte NULL in zero_paged()\n");
			return;
		}

		pte_uncache(*pte);
		flush_tlb_page(find_vma(&init_mm,pageptr),pageptr);
		/*
		 * Important here to not take time away from real processes.
		 */
		for ( bytecount = 0; bytecount < PAGE_SIZE ; bytecount += 4 )
		{
			if ( current->need_resched )
				schedule();
			*(unsigned long *)(bytecount + pageptr) = 0;
		}

		/*
		 * If we finished zero-ing out a page add this page to
		 * the zero_cache atomically -- we can't use
		 * down/up since we can't sleep in idle.
		 * Disabling interrupts is also a bad idea since we would
		 * steal time away from real processes.
		 * We can also have several zero_paged's running
		 * on different processors so we can't interfere with them.
		 * So we update the list atomically without locking it.
		 * -- Cort
		 */

		/* turn cache on for this page */
		pte_cache(*pte);
		flush_tlb_page(find_vma(&init_mm,pageptr),pageptr);
		/* atomically add this page to the list */
		asm (	"101:lwarx  %0,0,%2\n"  /* reserve zero_cache */
			"    stw    %0,0(%3)\n" /* update *pageptr */
#ifdef CONFIG_SMP
			"    sync\n"            /* let store settle */
#endif
			"    stwcx. %3,0,%2\n"  /* update zero_cache in mem */
			"    bne-   101b\n"     /* if lost reservation try again */
			: "=&r" (tmp), "+m" (zero_quicklist)
			: "r" (&zero_quicklist), "r" (pageptr)
			: "cc" );
		/*
		 * This variable is used in the above loop and nowhere
		 * else so the worst that could happen is we would
		 * zero out one more or one less page than we want
		 * per processor on the machine.  This is because
		 * we could add our page to the list but not have
		 * zerocount updated yet when another processor
		 * reads it.  -- Cort
		 */
		atomic_inc((atomic_t *)&zero_cache_sz);
		atomic_inc((atomic_t *)&zero_cache_total);
	}
}
#endif /* 0 */

#ifndef MPC8XX_POWERSAVE
#define DSSALL		.long	(0x1f<<26)+(0x10<<21)+(0x336<<1)

void power_save(void)
{
	unsigned long hid0;
	int nap = powersave_nap;

	/* 7450 has no DOZE mode mode, we return if powersave_nap
	 * isn't enabled
	 */
	if (!(nap || (cur_cpu_spec[smp_processor_id()]->cpu_features & CPU_FTR_CAN_DOZE)))
		return;
	/*
	 * Disable interrupts to prevent a lost wakeup
	 * when going to sleep.  This is necessary even with
	 * RTLinux since we are not guaranteed an interrupt
	 * didn't come in and is waiting for a __sti() before
	 * emulating one.  This way, we really do hard disable.
	 *
	 * We assume that we're sti-ed when we come in here.  We
	 * are in the idle loop so if we're cli-ed then it's a bug
	 * anyway.
	 *  -- Cort
	 */
	_nmask_and_or_msr(MSR_EE, 0);
	if (!current->need_resched)
	{
		__asm__ __volatile__("mfspr %0,1008" : "=r" (hid0) :);
		hid0 &= ~(HID0_NAP | HID0_SLEEP | HID0_DOZE);
		hid0 |= (powersave_nap? HID0_NAP: HID0_DOZE) | HID0_DPM;
		__asm__ __volatile__("mtspr 1008,%0" : : "r" (hid0));
		/* Flush pending data streams, consider this instruction
		 * exist on all altivec capable CPUs
		 */
		__asm__ __volatile__(
			"98:	" stringify(DSSALL) "\n"
			"	sync\n"
			"99:\n"
			".section __ftr_fixup,\"a\"\n"
			"	.long %0\n"
			"	.long %1\n"
			"	.long 98b\n"
			"	.long 99b\n"
			".previous" : : "i" (CPU_FTR_ALTIVEC), "i" (CPU_FTR_ALTIVEC));

		/* set the POW bit in the MSR, and enable interrupts
		 * so we wake up sometime! */
		_nmask_and_or_msr(0, MSR_POW | MSR_EE);
	}
	_nmask_and_or_msr(0, MSR_EE);
}
#endif

--------------F14E2E0DF2C901B1C7E7BF28--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
