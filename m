Return-Path: <jgeissel@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 88989679EA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Apr 2006 19:46:09 +1000 (EST)
From: Arno Geissel <jgeissel@gmx.net>
To: linuxppc-embedded@ozlabs.org
Subject: problem with watchdog/reboot MPC5200
Date: Thu, 20 Apr 2006 11:46:01 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200604201146.01342.jgeissel@gmx.net>
Reply-To: jgeissel@gmx.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello all,

I have a custom board based on MPC5200 processor running
the latest linuxppc_2_4_devel.
Everything is working fine until a flash write access is performed
using MTD. After this a (soft) reboot stucks in mpc5xxx_restart()
where the watchdog timer is charged and linux waits with closed
interrupts until the MPC performs the reset. Only power off helps
in this situation.
It seems to me like a hardware problem, because the freescale
MPC5200lite reference board does not run into this.
The main difference of the custom board to the reference board
is, that it is using 16MB Intel Strada Flash instead of AMD flash,
which has an erase block size of 128kB.
Has anybody else experienced such behaviour?

Arno Geissel
