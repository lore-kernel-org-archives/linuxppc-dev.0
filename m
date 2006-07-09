Return-Path: <benavi@marvell.com>
Received: from il.marvell.com (shoshil.marvell.com [199.203.130.250])
	by ozlabs.org (Postfix) with ESMTP id DEE08679E2
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  9 Jul 2006 23:47:14 +1000 (EST)
Received: from msilexch01.marvell.com (msilexch01.il.marvell.com [10.4.5.104])
	by il.marvell.com (8.13.1/8.13.1) with ESMTP id k69Dl9Km002555
	for <linuxppc-embedded@ozlabs.org>; Sun, 9 Jul 2006 16:47:09 +0300 (IDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: board hangs during reboot
Date: Sun, 9 Jul 2006 16:46:54 +0300
Message-ID: <3DBBCC5C2604704D9351456CFE118AC10460F146@msilexch01.marvell.com>
From: "Eran Ben-Avi" <benavi@marvell.com>
To: <linuxppc-embedded@ozlabs.org>
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

When I tried to restart the board (using reboot command), after all
services being shut down
the board hangs .The last printed line is "Restarting system." .
I implemented the restart api as follows:

            u32 jumpaddr=3D0xfff00100;
	u32 defaultmsr=3DMSR_IP;

	_disable_interrupts();

	__asm__ __volatile__("\n\
	mtspr   26, %1  /* SRR0 */
	mtspr   27, %0  /* SRR1 */
	rfi"
	:
	: "r" (defaultmsr), "r" (jumpaddr));
=09
            /*
	 * Not reached
	 */


I'm using IBM750Gl cpu .

Does anyone familiar with this ?

Regards,

Eran.
