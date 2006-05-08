Return-Path: <hoffman@marvell.com>
Received: from il.marvell.com (shoshil.marvell.com [199.203.130.250])
	by ozlabs.org (Postfix) with ESMTP id 37336679E6
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  8 May 2006 20:54:34 +1000 (EST)
Received: from msilexch01.marvell.com (msilexch01.il.marvell.com [10.4.5.104])
	by il.marvell.com (8.13.1/8.13.1) with ESMTP id k48AdE2n011281
	for <linuxppc-embedded@ozlabs.org>; Mon, 8 May 2006 13:39:14 +0300 (IDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Setting I&D cache enable in the same mtspr instruction
Date: Mon, 8 May 2006 13:39:13 +0300
Message-ID: <B9FFC3F97441D04093A504CEA31B7C419E2438@msilexch01.marvell.com>
From: "Assaf Hoffman" <hoffman@marvell.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: Rita Shtern <rita@marvell.com>, Ronen Shitrit <rshitrit@marvell.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
I think the implementation of setup_common_caches() in file
cpu_setup_6xx.S; not according to the spec as far as MPC74xx concerns.
Looking in the spec (MPC7450 RISC Microprocessor Family Reference
Manual, MPC7450UM Rev. 5 1/2005) section 3.4.1.5 L1 Instruction and Data
Cache Flash Invalidation it says:=20
"Note that HID0[ICFI] and HID0[DCFI] must not both be set with the same
mtspr instruction, due to the synchronization requirements described in
Section 2.4.2.4.1, "Context Synchronization."
But in the code those two do set together.
Also, the same section says:=20
"An isync must precede the setting of the HID0[ICFI] in order for the
setting to take effect."
But in the code, only 'sync' can be found.

/* Enable caches for 603's, 604, 750 & 7400 */
setup_common_caches:
	mfspr	r11,SPRN_HID0
	andi.	r0,r11,HID0_DCE
	ori	r11,r11,HID0_ICE|HID0_DCE
	ori	r8,r11,HID0_ICFI
	bne	1f			/* don't invalidate the D-cache
*/
	ori	r8,r8,HID0_DCI		/* unless it wasn't enabled */
1:	sync
	mtspr	SPRN_HID0,r8		/* enable and invalidate caches
*/=20
      ^^^^^^^^^^^^^^^^^^^ Here we set both ICFI and DCFI in the same
mtspr instruction. Also, no isync before setting ICFI.
	sync
	mtspr	SPRN_HID0,r11		/* enable caches */
	sync
	isync
	blr

Please advice.
Thanks.
