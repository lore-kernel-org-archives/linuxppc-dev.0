Return-Path: <tnt@246tNt.com>
Received: from outmx012.isp.belgacom.be (outmx012.isp.belgacom.be
	[195.238.5.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 63BFD67C52
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 09:48:13 +1100 (EST)
Received: from outmx012.isp.belgacom.be (localhost [127.0.0.1])
	by outmx012.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kBIMm0XI006322
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Dec 2006 23:48:01 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/4] powerpc: Add uevent handler for ibmebus
Date: Mon, 18 Dec 2006 23:46:39 +0100
Message-Id: <11664820011861-git-send-email-tnt@246tNt.com>
In-Reply-To: <11664820013460-git-send-email-tnt@246tNt.com>
References: <1166481999359-git-send-email-tnt@246tNt.com>
	<1166482000535-git-send-email-tnt@246tNt.com>
	<11664820003098-git-send-email-tnt@246tNt.com>
	<11664820013460-git-send-email-tnt@246tNt.com>
Cc: Sylvain Munaut <tnt@246tNt.com>, Arnd Bergmann <arnd@arndb.de>,
	Linux PPC Devel <linuxppc-dev@ozlabs.org>
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
 arch/powerpc/kernel/ibmebus.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index 82bd2f1..5a42100 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -361,9 +361,27 @@ static int ibmebus_bus_match(struct devi
 	return 0;
 }
 
+static int ibmebus_bus_uevent(struct device *dev,
+		char **envp, int num_envp, char *buffer, int buffer_size)
+{
+	struct ibmebus_dev *ebus_dev;
+	struct of_device *of;
+
+	if (!dev)
+		return -ENODEV;
+
+	ebus_dev = to_ibmebus_dev(dev);
+	if (!ebus_dev)
+		return -ENODEV;
+
+	of = &ebus_dev->ofdev;
+	return of_device_uevent(of, envp, num_envp, buffer, buffer_size);
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
