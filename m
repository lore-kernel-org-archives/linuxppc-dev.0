Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews01.kpnxchange.com (cpsmtpb-ews01.kpnxchange.com
 [213.75.39.4]) by ozlabs.org (Postfix) with ESMTP id 8B76F2C0094
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 08:49:16 +1100 (EST)
Message-ID: <1363124951.3137.156.camel@x61.thuisdomein>
Subject: [PATCH] powerpc/qe: remove useless Kconfig default
From: Paul Bolle <pebolle@tiscali.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Date: Tue, 12 Mar 2013 22:49:11 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Kconfig entry for QE_USB contains
	default y if USB_GADGET_FSL_QE

But USB_GADGET_FSL_QE got removed in commit
193ab2a6070039e7ee2b9b9bebea754a7c52fd1b ("usb: gadget: allow multiple
gadgets to be built"). This default will therefor never be set and can
be removed.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Tested with "make ARCH=powerpc menuconfig" and "make ARCH=powerpc
oldconfig" (before and after the patch). Enough to see this patch didn't
obviously break stuff.

1) I don't really understand commit
193ab2a6070039e7ee2b9b9bebea754a7c52fd1b. Was its point that we replace
USB_GADGET_FSL_QE with USB_FSL_QE? I couldn't tell and chose not to
actually change any behavior.

 arch/powerpc/sysdev/qe_lib/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/arch/powerpc/sysdev/qe_lib/Kconfig
index 41ac3df..33caf44 100644
--- a/arch/powerpc/sysdev/qe_lib/Kconfig
+++ b/arch/powerpc/sysdev/qe_lib/Kconfig
@@ -22,6 +22,5 @@ config UCC
 
 config QE_USB
 	bool
-	default y if USB_GADGET_FSL_QE
 	help
 	  QE USB Controller support
-- 
1.7.11.7
