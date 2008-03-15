Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C0655DDE18
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Mar 2008 04:27:20 +1100 (EST)
Received: from cpe001d60ad7267-cm001225dbafb6.cpe.net.cable.rogers.com
	([99.236.100.208] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68) (envelope-from <rpjday@crashcourse.ca>)
	id 1JaaAJ-0008Cy-Jc
	for linuxppc-dev@ozlabs.org; Sat, 15 Mar 2008 13:27:27 -0400
Date: Sat, 15 Mar 2008 13:27:07 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
Subject: [PATCH] PPC: Use newer, non-deprecated __SPIN_LOCK_UNLOCKED macro.
Message-ID: <alpine.LFD.1.00.0803151324400.24502@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/arch/ppc/syslib/mpc52xx_setup.c b/arch/ppc/syslib/mpc52xx_setup.c
index 9f504fc..ab0cf4c 100644
--- a/arch/ppc/syslib/mpc52xx_setup.c
+++ b/arch/ppc/syslib/mpc52xx_setup.c
@@ -279,7 +279,7 @@ int mpc52xx_match_psc_function(int psc_idx, const char *func)

 int mpc52xx_set_psc_clkdiv(int psc_id, int clkdiv)
 {
-	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
+	static DEFINE_SPINLOCK(lock);
 	struct mpc52xx_cdm __iomem *cdm;
 	unsigned long flags;
 	u16 mclken_div;


========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry:
    Have classroom, will lecture.

http://crashcourse.ca                          Waterloo, Ontario, CANADA
========================================================================
