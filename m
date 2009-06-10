Return-Path: <geert@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5F9DEB7192
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 00:39:23 +1000 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 25/33] drivers/ps3: Add missing annotations
Date: Wed, 10 Jun 2009 16:39:00 +0200
Message-Id: <1244644748-24211-26-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-25-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-12-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-13-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-14-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-15-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-16-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-17-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-18-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-19-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-20-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-21-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-22-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-23-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-24-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-25-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

probe functions should be __devinit
initialization functions should be __init

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Geoff Levand <geoffrey.levand@am.sony.com>
---
 drivers/ps3/ps3-sys-manager.c |    2 +-
 drivers/ps3/ps3av.c           |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ps3/ps3-sys-manager.c b/drivers/ps3/ps3-sys-manager.c
index f17513d..88cb740 100644
--- a/drivers/ps3/ps3-sys-manager.c
+++ b/drivers/ps3/ps3-sys-manager.c
@@ -706,7 +706,7 @@ static void ps3_sys_manager_work(struct ps3_system_bus_device *dev)
 	ps3_vuart_read_async(dev, PS3_SM_RX_MSG_LEN_MIN);
 }
 
-static int ps3_sys_manager_probe(struct ps3_system_bus_device *dev)
+static int __devinit ps3_sys_manager_probe(struct ps3_system_bus_device *dev)
 {
 	int result;
 	struct ps3_sys_manager_ops ops;
diff --git a/drivers/ps3/ps3av.c b/drivers/ps3/ps3av.c
index 4e4611e..e82d8c9 100644
--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -937,7 +937,7 @@ int ps3av_audio_mute(int mute)
 
 EXPORT_SYMBOL_GPL(ps3av_audio_mute);
 
-static int ps3av_probe(struct ps3_system_bus_device *dev)
+static int __devinit ps3av_probe(struct ps3_system_bus_device *dev)
 {
 	int res;
 	int id;
@@ -1048,7 +1048,7 @@ static struct ps3_vuart_port_driver ps3av_driver = {
 	.shutdown = ps3av_shutdown,
 };
 
-static int ps3av_module_init(void)
+static int __init ps3av_module_init(void)
 {
 	int error;
 
-- 
1.6.2.4
