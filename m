Return-Path: <Stefan.Nickl@kontron.com>
Received: from kom-mail1.kontron-modular.com (unknown [62.159.155.196])
	by ozlabs.org (Postfix) with ESMTP id 511CD67A64
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Mar 2005 17:44:27 +1000 (EST)
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Kumar Gala <kumar.gala@freescale.com>,
	Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-Nx3SdYs/ziFRUTmfVjP4"
Date: Wed, 30 Mar 2005 09:44:24 +0200
Message-Id: <1112168665.12794.24.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] MPC8555 CPM2 size/pointers for FCCs aka "All-ones problem"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-Nx3SdYs/ziFRUTmfVjP4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've seen that MPC8555 support also made it into linux-2.6 by now.

I don't have hardware and time to test, but it looks like this bug has
made it over from the linuxppc-2.4 tree. The 8541/8555 has a smaller CPM
DPRAM than the standard CPM2, just like the 8272.

Unfortunately, the manual recommends you to use a segment of CPM DPRAM
that is not implemented in the 8541/55. If the smaller DPRAM is not
taken into account, fcc_enet.c will initialise the internal CPM buffer
pointers (fcc_riptr/fcc_tiptr) to invalid offsets, with the result that
all the FCC will ever send and receive are 0xff-en.

See also "All-ones problem with FCC1 on MPC8541" ~October 2004 on
linuxppc-embedded.

Signed-off-by: Stefan Nickl <Stefan.Nickl@kontron.com>

-- 
Stefan Nickl
Kontron Modular Computers


--=-Nx3SdYs/ziFRUTmfVjP4
Content-Disposition: attachment; filename=cpm2_8555.patch
Content-Type: text/x-patch; name=cpm2_8555.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linux-2.5/include/asm-ppc/cpm2.h.old	2005-03-30 08:49:54.000000000 +0200
+++ linux-2.5/include/asm-ppc/cpm2.h	2005-03-30 08:56:07.000000000 +0200
@@ -86,7 +86,7 @@
  */
 #define CPM_DATAONLY_BASE	((uint)128)
 #define CPM_DP_NOSPACE		((uint)0x7fffffff)
-#ifdef CONFIG_8272
+#if defined(CONFIG_8272) || defined(CONFIG_MPC8555)
 #define CPM_DATAONLY_SIZE	((uint)(8 * 1024) - CPM_DATAONLY_BASE)
 #define CPM_FCC_SPECIAL_BASE	((uint)0x00009000)
 #else

--=-Nx3SdYs/ziFRUTmfVjP4--
