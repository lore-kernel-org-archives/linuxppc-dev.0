Subject: head_8xx.S
To: linuxppc-dev@lists.linuxppc.org
From: "Luca Risso" <Luca.Risso@marconi.com>
Date: Tue, 3 Feb 2004 19:39:27 +0100
Message-ID: <OFF7D15ED9.F8808C2B-ONC1256E2F.0064A364@uk.marconicomms.com>
MIME-Version: 1.0
Content-type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
I'm trying to port Linux2.6.0 from to a MPC860 based board.
I'm currently in trouble with the head_8xx.S file during early MMU
operations.
I get an exception because of the following instructions:


InstructionTLBMiss:
#ifdef CONFIG_8xx_CPU6
        stw     r3, 8(r0)
        li      r3, 0x3f80
.
.
.
.

3:
        lwz     r21, 0(r20)     /* Get the level 1 entry */
        rlwinm. r20, r21,0,0,19 /* Extract page descriptor page address */
        beq     2f              /* If zero, don't try to find a pte */

        /* We have a pte table, so load the MI_TWC with the attributes
         * for this "segment."
         */
        tophys(r21,r21)
        ori     r21,r21,1               /* Set valid bit */
#ifdef CONFIG_8xx_CPU6
        li      r3, 0x2b80
        stw     r3, 12(r0)
        lwz     r3, 12(r0)
#endif
        mtspr   MI_TWC, r21     /* Set segment attributes */
#ifdef CONFIG_8xx_CPU6
        li      r3, 0x3b80
        stw     r3, 12(r0)
        lwz     r3, 12(r0)
#endif
        mtspr   MD_TWC, r21     /* Load pte table base address */
        mfspr   r21, MD_TWC     /* ....and get the pte address */
        lwz     r20, 0(r21)     /* Get the pte */

<HERE I GOT THE FAULT>


        ori     r20, r20, _PAGE_ACCESSED
        stw     r20, 0(r21)


 MD_TWC (and so R21) contains a  wrong address (out of my physical memory) while it
should already be a real one.
I read several mails about a problem like this but probably I missed the solution,
please can give me a pointer to it.

Thanks

      Luca


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
