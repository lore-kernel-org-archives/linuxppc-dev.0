Message-ID: <3E4B9D4E.7080808@intracom.gr>
Date: Thu, 13 Feb 2003 15:27:42 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>, Dan Malek <dan@embeddededge.com>,
	Tom Rini <trini@kernel.crashing.org>
Subject: [2.5] Hang on 8xx in head_8xx.S
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello

I'm trying to make 2.5 work for 8xx processors.

After some tweaking it compiles, but now it hangs
in arch/ppc/kernel/head_8xx.S  at the marked point
below.

I know this is not enough to make it work, since
it appears that the calling convention and registers
used for exception are changed between 2.4 <-> 2.5.

I could use some help in trying to understand what's going on.

Regards

Pantelis


/*
 * Go back to running unmapped so we can load up new values
 * and change to using our exception vectors.
 * On the 8xx, all we have to do is invalidate the TLB to clear
 * the old 8M byte TLB mappings and load the page table base register.
 */
        /* The right way to do this would be to track it down through
         * init's THREAD like the context switch code does, but this is
         * easier......until someone changes init's static structures.
         */
        lis     r6, swapper_pg_dir@h
        ori     r6, r6, swapper_pg_dir@l
        tophys(r6,r6)
#ifdef CONFIG_8xx_CPU6
        lis     r4, cpu6_errata_word@h
        ori     r4, r4, cpu6_errata_word@l
        li      r3, 0x3980
        stw     r3, 12(r4)
        lwz     r3, 12(r4)
#endif
        mtspr   M_TWB, r6
        lis     r4,2f@h
        ori     r4,r4,2f@l
        tophys(r4,r4)
        li      r3,MSR_KERNEL & ~(MSR_IR|MSR_DR)
        mtspr   SRR0,r4
        mtspr   SRR1,r3

---> Gets here <---

        rfi
2:

---> Never gets here <---

        SYNC                    /* Force all PTE updates to finish */
        tlbia                   /* Clear all TLB entries */
        sync                    /* wait for tlbia/tlbie to finish */
        TLBSYNC                 /* ... on all CPUs */


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
