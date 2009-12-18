Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 79599B7F21
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 11:46:00 +1100 (EST)
Message-Id: <200912180045.nBI0jFVV028429@imap1.linux-foundation.org>
Subject: [patch 5/5] powerpc/85xx: wrong variable returned on error
To: benh@kernel.crashing.org
From: akpm@linux-foundation.org
Date: Thu, 17 Dec 2009 16:45:15 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, roel.kluin@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Roel Kluin <roel.kluin@gmail.com>

The wrong variable was returned in the case of an error.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/powerpc/platforms/85xx/mpc85xx_mds.c~powerpc-85xx-wrong-variable-returned-on-error arch/powerpc/platforms/85xx/mpc85xx_mds.c
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c~powerpc-85xx-wrong-variable-returned-on-error
+++ a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -86,7 +86,7 @@ static int mpc8568_fixup_125_clock(struc
 	scr = phy_read(phydev, MV88E1111_SCR);
 
 	if (scr < 0)
-		return err;
+		return scr;
 
 	err = phy_write(phydev, MV88E1111_SCR, scr | 0x0008);
 
_
