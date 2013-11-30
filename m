Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id E14D62C0098
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Dec 2013 02:45:43 +1100 (EST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Wim Van Sebroeck <wim@iguana.be>, <scottwood@freescale.com>
Subject: [PATCH] watchdog: mpc8xxx_wdt: MPC8xx is HW enabled
Message-Id: <20131130154540.E83D743E15@localhost.localdomain>
Date: Sat, 30 Nov 2013 16:45:40 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPC8xx watchdog is enabled at startup by HW.
If the bootloader disables it, it cannot be reenabled.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

diff -ur a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
--- a/drivers/watchdog/mpc8xxx_wdt.c	2013-05-11 22:57:46.000000000 +0200
+++ b/drivers/watchdog/mpc8xxx_wdt.c	2013-08-08 02:12:15.000000000 +0200
@@ -273,6 +310,7 @@
 		.compatible =3D "fsl,mpc823-wdt",
 		.data =3D &(struct mpc8xxx_wdt_type) {
 			.prescaler =3D 0x800,
+			.hw_enabled =3D true,
 		},
 	},
 	{},

---
Ce courrier =C3=A9lectronique ne contient aucun virus ou logiciel malveilla=
nt parce que la protection avast! Antivirus est active.
http://www.avast.com
