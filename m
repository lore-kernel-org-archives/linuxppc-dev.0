Message-ID: <37148013.F263819@siemens.at>
Date: Wed, 14 Apr 1999 13:46:27 +0200
From: Helmut Buchsbaum <helmut.buchsbaum@siemens.at>
MIME-Version: 1.0
To: "Thomas E. Arvanitis" <tharvan@ellemedia.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC on FADS
References: <Pine.GSO.4.05.9904131709060.29269-100000@lucifer>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello Thomas!

The behaviour you describe is nearly the same I had on my FADS823.

But I'm glad to announce I've my FADS now up and running with a kernel
based on Dan's 2.2.0-pre7 tarball.
After a few months I took up the work on my FADS-Linux kernel again and
I tracked down the problem I had beyond that SET_PAGE_DIR macro, where
the M_TWB is set.
I discovered that I get a TLB miss with a zero pte when accessing the
ethernet controller (yes I boot via Root-NFS and it works great!!) and
somehow do_page_fault() can't build an appropriate entry for this
I/O-region (should it?). Since I'm not a Linux-MM guru I circumvented
that situation by reserving two TLB entries in arch/ppc/kernel/head.S:


......

#if defined(CONFIG_MBX) || defined(CONFIG_RPXLITE)
#define BOOT_IMMR       0xfa000000
#endif
#ifdef CONFIG_BSEIP
#define BOOT_IMMR       0xff000000
#endif
#ifdef CONFIG_FADS
#define BOOT_IMMR       0x02000000
#endif
        /* Map another 8 MByte at 0xfa000000 to get the processor
         * internal registers (among other things).
         */
#ifndef CONFIG_FADS
        lis     r8, BOOT_IMMR@h         /* Create vaddr for TLB */
        ori     r8, r8, MD_EVALID       /* Mark it valid */
        mtspr   MD_EPN, r8
        li      r8, MD_PS8MEG           /* Set 8M byte page */
        ori     r8, r8, MD_SVALID       /* Make it valid */
        mtspr   MD_TWC, r8
        lis     r8, BOOT_IMMR@h         /* Create paddr for TLB */
        ori     r8, r8, MI_BOOTINIT|0x2 /* Inhibit cache -- Cort */
        mtspr   MD_RPN, r8

#else
        bl      fadsForceIO
#endif

        
        /* Since the cache is enabled according to the information we
         * just loaded into the TLB, invalidate and enable the caches
here.
         * We should probably check/set other modes....later.
         */
        lis     r8, IDC_INVALL@h
        mtspr   IC_CST, r8
        mtspr   DC_CST, r8
        lis     r8, IDC_ENABLE@h
        mtspr   IC_CST, r8

.....

fadsForceIO:    
    mfspr   r8,MD_CTR
    ori     r8,r8,0700      /* set TBL idx to 7 */
    mtspr   MD_CTR, r8
    lis     r8, BOOT_IMMR@h         /* Create vaddr for TLB */
    ori     r8, r8, MD_EVALID       /* Mark it valid */
    mtspr   MD_EPN, r8
    li      r8, MD_PS8MEG           /* Set 8M byte page */
    ori     r8, r8, MD_SVALID       /* Make it valid */
    mtspr   MD_TWC, r8
    lis     r8, BOOT_IMMR@h         /* Create paddr for TLB */
    ori     r8, r8, MI_BOOTINIT|0x2 /* Inhibit cache -- Cort */
    mtspr   MD_RPN, r8
    mfspr   r8,MD_CTR
    oris    r8,r8,0x0800    /* set RSV2D */
    mtspr   MD_CTR, r8
    blr



Additionally I use the tlbia macro for the 603, since I'm quite sure the
tlbia instruction of an 8xx deletes my fixed entry, too.

That's been all what I've done to be able to start /sbin/init.
In fact I'm not really happy with such a hack and I'd appriciate a
proper solution. BTW, I don't understand why this kind of problem does
not appear on the other boards(?!).


BTW, I added some FADS specific parts by extending Dan's #define's and
configs for RPXLITE, BSEIP and MBX.


Hope it helps,
Helmut

P.S.: I'd like to contribute my minor changes for the FADS
(configuration, board setup), but how? 
-- 
*********************************************************
* Helmut Buchsbaum               * Siemens AG Austria   *
* Tel:   ++43-1-1707-36686       * EZE PN 5             *
* Fax:   ++43-1-1707-55169       * Erdberger Laende 26  *
*                                * A-1030 Vienna/Europe *
*********************************************************
* mailto:Helmut.Buchsbaum@siemens.at                    *
*        buc@eze22.siemens.co.at                        *
*********************************************************

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
