Return-Path: <tnt@246tNt.com>
Received: from outmx033.isp.belgacom.be (outmx033.isp.belgacom.be
	[195.238.6.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C794EDDE44
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 01:39:11 +1000 (EST)
Received: from outmx033.isp.belgacom.be (localhost.localdomain [127.0.0.1])
	by outmx033.isp.belgacom.be (8.13.4/8.13.4/Debian-3sarge3) with ESMTP
	id l46Fd5JS027559
	for <linuxppc-dev@ozlabs.org>; Sun, 6 May 2007 17:39:06 +0200
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/8] powerpc: export of_device_get_modalias
Date: Sun,  6 May 2007 17:38:46 +0200
Message-Id: <1178465935138-git-send-email-tnt@246tNt.com>
In-Reply-To: <11784659351487-git-send-email-tnt@246tNt.com>
References: <11784659324066-git-send-email-tnt@246tNt.com>
	<11784659351487-git-send-email-tnt@246tNt.com>
Cc: PPC dev ML <linuxppc-dev@ozlabs.org>, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Apparently other parts of the kernel need to know the
modalias internally (like the sysfs code in macintosh driver).

To avoid consistency issues, we export this code and use it
everywhere it's needed rather than repeat it ...

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 arch/powerpc/kernel/of_device.c |    5 +++--
 include/asm-powerpc/of_device.h |    2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/of_device.c b/arch/powerpc/kernel/of_device.c
index 0c8ea76..38a0ef2 100644
--- a/arch/powerpc/kernel/of_device.c
+++ b/arch/powerpc/kernel/of_device.c
@@ -120,8 +120,8 @@ void of_device_unregister(struct of_device *ofdev)
 }
 
 
-static ssize_t of_device_get_modalias(struct of_device *ofdev,
-					char *str, ssize_t len)
+ssize_t of_device_get_modalias(struct of_device *ofdev,
+				char *str, ssize_t len)
 {
 	const char *compat;
 	int cplen, i;
@@ -239,3 +239,4 @@ EXPORT_SYMBOL(of_dev_get);
 EXPORT_SYMBOL(of_dev_put);
 EXPORT_SYMBOL(of_release_dev);
 EXPORT_SYMBOL(of_device_uevent);
+EXPORT_SYMBOL(of_device_get_modalias);
diff --git a/include/asm-powerpc/of_device.h b/include/asm-powerpc/of_device.h
index 4f1aabe..e9af49e 100644
--- a/include/asm-powerpc/of_device.h
+++ b/include/asm-powerpc/of_device.h
@@ -32,6 +32,8 @@ extern int of_device_register(struct of_device *ofdev);
 extern void of_device_unregister(struct of_device *ofdev);
 extern void of_release_dev(struct device *dev);
 
+extern ssize_t of_device_get_modalias(struct of_device *ofdev,
+					char *str, ssize_t len);
 extern int of_device_uevent(struct device *dev,
 	char **envp, int num_envp, char *buffer, int buffer_size);
 
-- 
1.5.1.2
