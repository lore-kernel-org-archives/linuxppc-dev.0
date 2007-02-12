Return-Path: <tnt@246tNt.com>
Received: from outmx006.isp.belgacom.be (outmx006.isp.belgacom.be
	[195.238.4.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31C2EDDE2B
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 09:14:29 +1100 (EST)
Received: from outmx006.isp.belgacom.be (localhost [127.0.0.1])
	by outmx006.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1CMEL82013498
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 23:14:22 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 09/10] powerpc: Add uevent handler for of_platform_bus
Date: Mon, 12 Feb 2007 23:13:27 +0100
Message-Id: <1171318420572-git-send-email-tnt@246tNt.com>
In-Reply-To: <11713184182928-git-send-email-tnt@246tNt.com>
References: <11713184081457-git-send-email-tnt@246tNt.com>
	<11713184091057-git-send-email-tnt@246tNt.com>
	<11713184101239-git-send-email-tnt@246tNt.com>
	<11713184112187-git-send-email-tnt@246tNt.com>
	<11713184132161-git-send-email-tnt@246tNt.com>
	<11713184141191-git-send-email-tnt@246tNt.com>
	<11713184152189-git-send-email-tnt@246tNt.com>
	<11713184171985-git-send-email-tnt@246tNt.com>
	<11713184182928-git-send-email-tnt@246tNt.com>
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adding this handler allow userspace to properly handle the module
autoloading. The generation of the uevent itself is now common to
all bus using of_device, so not much code here.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 arch/powerpc/kernel/of_platform.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index b734517..da78e44 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -133,6 +133,7 @@ static int of_platform_device_resume(str
 struct bus_type of_platform_bus_type = {
        .name	= "of_platform",
        .match	= of_platform_bus_match,
+       .uevent	= of_device_uevent,
        .probe	= of_platform_device_probe,
        .remove	= of_platform_device_remove,
        .suspend	= of_platform_device_suspend,
-- 
1.4.2
