Return-Path: <tnt@246tNt.com>
Received: from outmx006.isp.belgacom.be (outmx006.isp.belgacom.be
	[195.238.4.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 992C9DDF33
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 09:14:32 +1100 (EST)
Received: from outmx006.isp.belgacom.be (localhost [127.0.0.1])
	by outmx006.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1CMEKET013491
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 23:14:21 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 10/10] powerpc: Add uevent handler for ibmebus
Date: Mon, 12 Feb 2007 23:13:28 +0100
Message-Id: <11713184211154-git-send-email-tnt@246tNt.com>
In-Reply-To: <1171318420572-git-send-email-tnt@246tNt.com>
References: <11713184081457-git-send-email-tnt@246tNt.com>
	<11713184091057-git-send-email-tnt@246tNt.com>
	<11713184101239-git-send-email-tnt@246tNt.com>
	<11713184112187-git-send-email-tnt@246tNt.com>
	<11713184132161-git-send-email-tnt@246tNt.com>
	<11713184141191-git-send-email-tnt@246tNt.com>
	<11713184152189-git-send-email-tnt@246tNt.com>
	<11713184171985-git-send-email-tnt@246tNt.com>
	<11713184182928-git-send-email-tnt@246tNt.com>
	<1171318420572-git-send-email-tnt@246tNt.com>
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

But we still need a small wrapper to filter out the dummy root
device node used by this bus.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 arch/powerpc/kernel/ibmebus.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index 82bd2f1..2e8d9fd 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -361,9 +361,25 @@ static int ibmebus_bus_match(struct devi
 	return 0;
 }
 
+static int ibmebus_bus_uevent(struct device *dev,
+		char **envp, int num_envp, char *buffer, int buffer_size)
+{
+	struct ibmebus_dev *ebus_dev;
+
+	if (!dev)
+		return -ENODEV;
+
+	ebus_dev = to_ibmebus_dev(dev);
+	if (ebus_dev==ibmebus_bus_device)	/* filter dummy root device */
+		return -ENODEV;
+
+	return of_device_uevent(dev, envp, num_envp, buffer, buffer_size);
+}
+
 struct bus_type ibmebus_bus_type = {
 	.name = "ibmebus",
 	.match = ibmebus_bus_match,
+	.uevent = ibmebus_bus_uevent,
 };
 EXPORT_SYMBOL(ibmebus_bus_type);
 
-- 
1.4.2
