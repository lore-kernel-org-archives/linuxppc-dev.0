Return-Path: <tnt@246tNt.com>
Received: from outmx006.isp.belgacom.be (outmx006.isp.belgacom.be
	[195.238.4.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5B08FDDEBE
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 09:14:29 +1100 (EST)
Received: from outmx006.isp.belgacom.be (localhost [127.0.0.1])
	by outmx006.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1CMEGPb013444
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 23:14:17 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 03/10] powerpc: Restore 'proper' link order in platform
Date: Mon, 12 Feb 2007 23:13:21 +0100
Message-Id: <11713184112187-git-send-email-tnt@246tNt.com>
In-Reply-To: <11713184101239-git-send-email-tnt@246tNt.com>
References: <11713184081457-git-send-email-tnt@246tNt.com>
	<11713184091057-git-send-email-tnt@246tNt.com>
	<11713184101239-git-send-email-tnt@246tNt.com>
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 52xx was put before CHRP to allow EFIKA to be recognized
properly. Now the efika tree is fixed up in prom_init so
no need for this ugly hack. So we restore the 'normal'
order.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/platforms/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index 65e6123..4520042 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -5,9 +5,9 @@ ifeq ($(CONFIG_PPC64),y)
 obj-$(CONFIG_PPC_PMAC)		+= powermac/
 endif
 endif
-obj-$(CONFIG_PPC_MPC52xx)	+= 52xx/
 obj-$(CONFIG_PPC_CHRP)		+= chrp/
 obj-$(CONFIG_4xx)		+= 4xx/
+obj-$(CONFIG_PPC_MPC52xx)	+= 52xx/
 obj-$(CONFIG_PPC_8xx)		+= 8xx/
 obj-$(CONFIG_PPC_82xx)		+= 82xx/
 obj-$(CONFIG_PPC_83xx)		+= 83xx/
-- 
1.4.2
