Message-ID: <37BD73BB.3272A3BC@switchboard.ericsson.se>
Date: Fri, 20 Aug 1999 17:26:51 +0200
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: Pierre_Juste@email.mot.com
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC Linux crash resulting MMU problem !!
References: <37BD4FF7.D77C6019@email.sps.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there!

I've experienced some strange things with my 860 and linux.

I've got a few different board around; MBX, ADS, FADS and some custom
ones.

The MBX has got some kind of boot software that loads the kernel.
I've written boot code to the rest of the boards.

The strange thing that happened was that my kernel died on all boards
except 
for the MBX. I got a hint from a guy called Helmut Buchsbaum
<helmut.buchsbaum@siemens.at>.
He had a FADS with a 823 and he told me that he had to reserve a few TLB
entries to make it work.

Some other guy said that he had been using a bdm and seen the interrupt
code trashed.
Helmut gave him the patch and he said it worked much better with it.

And my kernel works better with it.
I think I get some kind of bad opcode in the bad opcode routine with out
the patch and everything stops.

That is maybe not your problem, but you might want to add this code to
head.S 
and see if anything works better...

Keep the list informed if you find out anything.

Thanks /

Magnus Damm


the code:

#ifdef CONFIG_FADS_FORCE_IO
fadsForceIO:    
#ifdef CONFIG_MPC823
    mfspr   r8,MD_CTR
    ori     r8,r8,0x0700      /* set TBL idx to 7 */
#endif
#if defined(CONFIG_MPC860) || defined (CONFIG_MPC860T)
    mfspr   r8,MD_CTR
    ori     r8,r8,0x1F00      /* set TBL idx to 31 */
#endif 
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
#endif /* CONFIG_FADS_FORCE_IO */

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
