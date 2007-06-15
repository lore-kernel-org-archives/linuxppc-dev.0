Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8C1D2DEDFE
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 08:18:53 +1000 (EST)
Message-ID: <467301EC.8090201@am.sony.com>
Date: Fri, 15 Jun 2007 14:17:32 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 01/33] Cell: Add spu shutdown method
References: <20070615204749.629571012@am.sony.com>>
In-Reply-To: <20070615204749.629571012@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a shutdown method to spu_sysdev_class to allow proper spu resource
cleanup on system shutdown.  This is needed to support kexec on the PS3
platform.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/cell/spu_base.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -462,8 +462,18 @@ void spu_free(struct spu *spu)
 }
 EXPORT_SYMBOL_GPL(spu_free);
 
+static int spu_shutdown(struct sys_device *sysdev)
+{
+	struct spu *spu = container_of(sysdev, struct spu, sysdev);
+
+	spu_free_irqs(spu);
+	spu_destroy_spu(spu);
+	return 0;
+}
+
 struct sysdev_class spu_sysdev_class = {
-	set_kset_name("spu")
+	set_kset_name("spu"),
+	.shutdown = spu_shutdown,
 };
 
 int spu_add_sysdev_attr(struct sysdev_attribute *attr)

-- 
