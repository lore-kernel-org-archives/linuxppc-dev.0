Subject: Re: head_8xx.S
To: "Dan Malek <dan" <dan@embeddededge.com>
Cc: linuxppc-dev@lists.linuxppc.org
From: "Luca Risso" <Luca.Risso@marconi.com>
Date: Fri, 6 Feb 2004 09:08:37 +0100
Message-ID: <OFBF7609F1.4667B3D5-ONC1256E32.002AD496@uk.marconicomms.com>
MIME-Version: 1.0
Content-type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks a lot for your help Dan.

With some further investigation I bypassed the problem removing the "tophys" instructions as shown below.
I'm not sure that's the right thing to do, but at least it took me a step forward so to be able to crash as soon as the
transfer_to_handler is called by the decrementer interrupt.

Unfortunately my BDM doesn't support MMU relocation and I can't debug easily.

If you feel that my "patch" is the wrong way to solve the problem or if you have any suggestion about my new fault please let me know.

Regards

      Luca


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

//      tophys(r21,r21)               <--------------------- COMMENT

        ori     r21,r21,1               /* Set valid bit */
#ifdef CONFIG_8xx_CPU6
        li      r3, 0x2b80
        stw     r3, 12(r0)
        lwz     r3, 12(r0)
#endif
        mtspr   MI_TWC, r21     /* Set segment attributes */
#ifdef CONFIG_8xx_CPU6
        li      r3, 0x3b80
.
.
.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
