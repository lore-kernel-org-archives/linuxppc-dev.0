Return-Path: <tnt@246tNt.com>
Received: from outmx020.isp.belgacom.be (outmx020.isp.belgacom.be
	[195.238.4.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D2EE3DDEBB
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 09:32:05 +1100 (EST)
Received: from outmx020.isp.belgacom.be (localhost [127.0.0.1])
	by outmx020.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l02MVtEg002689
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Jan 2007 23:31:56 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/4] powerpc: Restore 'proper' link order in platform
Date: Tue,  2 Jan 2007 23:29:55 +0100
Message-Id: <11677769992439-git-send-email-tnt@246tNt.com>
In-Reply-To: <11677769981995-git-send-email-tnt@246tNt.com>
References: <1167776995690-git-send-email-tnt@246tNt.com>
	<116777699771-git-send-email-tnt@246tNt.com>
	<11677769982640-git-send-email-tnt@246tNt.com>
	<11677769981995-git-send-email-tnt@246tNt.com>
Cc: Linux PPC DEV <linuxppc-dev@ozlabs.org>, Sylvain Munaut <tnt@246tNt.com>
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
---
 arch/powerpc/platforms/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index 507d1b9..44d95ea 100644
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
 obj-$(CONFIG_PPC_83xx)		+= 83xx/
 obj-$(CONFIG_PPC_85xx)		+= 85xx/
 obj-$(CONFIG_PPC_86xx)		+= 86xx/
-- 
1.4.2
