Return-Path: <gerhard_pircher@gmx.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7019BB7271
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Jun 2009 07:41:02 +1000 (EST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 3D9F6DDD1B
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2009 07:41:00 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 19 Jun 2009 23:40:57 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20090619214057.198360@gmx.net>
MIME-Version: 1.0
Subject: [PATCH] powerpc/amigaone: Convert amigaone_init() to a
	machine_device_initcall()
To: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This allows to remove the ppc_md.init() hook in the setup code.

Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
---
 arch/powerpc/platforms/amigaone/setup.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/amigaone/setup.c b/arch/powerpc/platforms/amigaone/setup.c
index e8bea5e..ca65d86 100644
--- a/arch/powerpc/platforms/amigaone/setup.c
+++ b/arch/powerpc/platforms/amigaone/setup.c
@@ -111,13 +111,16 @@ void __init amigaone_init_IRQ(void)
 	irq_set_default_host(i8259_get_host());
 }
 
-void __init amigaone_init(void)
+static int __init request_isa_regions(void)
 {
 	request_region(0x00, 0x20, "dma1");
 	request_region(0x40, 0x20, "timer");
 	request_region(0x80, 0x10, "dma page reg");
 	request_region(0xc0, 0x20, "dma2");
+
+	return 0;
 }
+machine_device_initcall(amigaone, request_isa_regions);
 
 void amigaone_restart(char *cmd)
 {
@@ -162,7 +165,6 @@ define_machine(amigaone) {
 	.name			= "AmigaOne",
 	.probe			= amigaone_probe,
 	.setup_arch		= amigaone_setup_arch,
-	.init			= amigaone_init,
 	.show_cpuinfo		= amigaone_show_cpuinfo,
 	.init_IRQ		= amigaone_init_IRQ,
 	.restart		= amigaone_restart,
-- 
1.5.6.5

-- 
GRATIS für alle GMX-Mitglieder: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01
