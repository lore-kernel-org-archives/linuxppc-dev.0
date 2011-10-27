Return-Path: <arusev@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
 by ozlabs.org (Postfix) with SMTP id 4BE041007DA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 01:25:19 +1100 (EST)
Message-ID: <4EA9683D.8030100@dev.rtsoft.ru>
Date: Thu, 27 Oct 2011 18:18:37 +0400
From: Rusev <arusev@dev.rtsoft.ru>
MIME-Version: 1.0
To: benh@kernel.crashing.org,  paulus@samba.org,
 galak@kernel.crashing.org,  Shengzhou.Liu@freescale.com,
 Shaohui.Xie@freescale.com,  linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Fix for fsl_upm
Content-Type: multipart/mixed; boundary="------------090608020905030200050608"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090608020905030200050608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

patch is vs. 2.6.39, yet it applied to 3.1




--------------090608020905030200050608
Content-Type: text/x-patch;
 name="fsl_lbc.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fsl_lbc.c.patch"

Fix of UPM driver for Freescale PowerPC processors

If Freescale LBC driver fails to initialise itself from device tree,
then internal structure is freed only but not NULL-fied.
As result functions fsl_lbc_find() after checking the structure is not NULL are
trying to access device registers.

Signed-off-by: Alexandre Rusev <arusev@dev.rtsoft.ru> 
--- linux-2.6.39.old/arch/powerpc/sysdev/fsl_lbc.c	2011-10-27 03:17:28.000000000 +0400
+++ linux-2.6.39/arch/powerpc/sysdev/fsl_lbc.c	2011-10-27 05:06:44.000000000 +0400
@@ -322,6 +322,7 @@ static int __devinit fsl_lbc_ctrl_probe(
 err:
 	iounmap(fsl_lbc_ctrl_dev->regs);
 	kfree(fsl_lbc_ctrl_dev);
+	fsl_lbc_ctrl_dev = NULL;
 	return ret;
 }
 

--------------090608020905030200050608--
