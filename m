Subject: Re: ibook2 will not wake from sleep on 2.4.20-ben7
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ethan Blanton <eblanton@cs.ohiou.edu>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <1046557102.2030.89.camel@zion.wanadoo.fr>
References: <20030301202916.GA6120@paco.resnet.purdue.edu>
	 <1046557102.2030.89.camel@zion.wanadoo.fr>
Content-Type: text/plain
Message-Id: <1046557625.2030.91.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 01 Mar 2003 23:27:05 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2003-03-01 at 23:18, Benjamin Herrenschmidt wrote:
> On Sat, 2003-03-01 at 21:29, Ethan Blanton wrote:
> > I have an iBook 2 (PowerBook 4,1) and I rsync'd my kernel to
> > 2.4.20-ben7 last night (I had previously been running 2.4.20-pre7-ben0
> > with no trouble).  The lid latch does not seem to put the machine to
> > sleep any more, and when I put it to sleep with the power button,
> > waking the machine up shuts it off rather than waking it.  I then have
> > to depress the power button for a few seconds, release it, and press
> > it briefly in order to power the machine back up.
> >
> > The machine is not losing its time/etc, merely shutting down.
> >
> > I'm running pbbuttonsd-0.5.2 in pmud replacement mode.
>
> Can you try -ben4 or -ben5 ? Patches against official 2.4.20
> are on kernel.org/pub/linux/kernel/people/benh.
>
> Let me know if it works

Hrm... before that, try this patch against -ben7

--- 1.1/arch/ppc/kernel/cpu_setup_6xx.S	Thu Feb 27 09:50:24 2003
+++ edited/arch/ppc/kernel/cpu_setup_6xx.S	Sat Mar  1 23:25:37 2003
@@ -356,7 +356,7 @@
 	cror	4*cr0+eq,4*cr0+eq,4*cr3+eq
 	cror	4*cr0+eq,4*cr0+eq,4*cr4+eq
 	cror	4*cr0+eq,4*cr0+eq,4*cr1+eq
-	bne	1f
+	bne	2f
 	/* Restore 74xx specific regs */
 	lwz	r4,CS_MSSCR0(r5)
 	sync
@@ -372,7 +372,7 @@
 	/* Clear 7410 L2CR2 */
 	li	r4,0
 	mtspr	SPRN_L2CR2,r4
-1:	beq	cr1,1f
+1:	beq	cr1,2f
 	/* Restore 745x specific registers */
 	lwz	r4,CS_HID1(r5)
 	sync
@@ -394,7 +394,7 @@
 	mtspr	SPRN_LDSTDB,r4
 	isync
 	sync
-1:	bne	cr5,1f
+2:	bne	cr5,1f
 	/* Restore 750FX specific registers
 	 * that is restore PLL config & switch
 	 * to PLL 0
@@ -404,10 +404,10 @@
 	mtspr	SPRN_HID1,r5
 		/* Wait for PLL to stabilize */
 	mftbl	r5
-2:	mftbl	r6
+3:	mftbl	r6
 	sub	r6,r6,r5
 	cmpli	cr0,r6,10000
-	ble	2b
+	ble	3b
 	/* Setup final PLL */
 	mtspr	SPRN_HID1,r4
 1:


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
