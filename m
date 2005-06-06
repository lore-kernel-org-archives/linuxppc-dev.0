Return-Path: <mporter@kernel.crashing.org>
Received: from zipcode.az.mvista.com (rav-az.mvista.com [65.200.49.157])
	by ozlabs.org (Postfix) with ESMTP id 87BC4679F2
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Jun 2005 09:52:27 +1000 (EST)
In-Reply-To: <1118101941657@foobar.com>
Date: Mon, 6 Jun 2005 16:52:24 -0700
Message-Id: <11181019441461@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: akpm@osdl.org
From: Matt Porter <mporter@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][RIO] -mm: Convert EXPORT_SYMBOL -> EXPORT_SYMBOL_GPL
Reply-To: Matt Porter <mporter@kernel.crashing.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Convert all core exports to EXPORT_SYMBOL_GPL.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

commit d45c2d2fedcafd50a860267ff1d517c3071ab585
tree f8ae6a1fbb746cd112ece56ec429a0f71a408afc
parent 87ff3372a005e4cf927b1b62c23e1c2339d46507
author Matt Porter <mporter@kernel.crashing.org> Mon, 06 Jun 2005 09:29:21 =
-0700
committer Matt Porter <mporter@kernel.crashing.org> Mon, 06 Jun 2005 09:29:=
21 -0700

 drivers/rio/rio-access.c |   26 +++++++++++++-------------
 drivers/rio/rio-driver.c |   10 +++++-----
 drivers/rio/rio.c        |   22 +++++++++++-----------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/rio/rio-access.c b/drivers/rio/rio-access.c
--- a/drivers/rio/rio-access.c
+++ b/drivers/rio/rio-access.c
@@ -83,12 +83,12 @@ RIO_LOP_WRITE(8, u8, 1)
 RIO_LOP_WRITE(16, u16, 2)
 RIO_LOP_WRITE(32, u32, 4)
=20
-EXPORT_SYMBOL(__rio_local_read_config_8);
-EXPORT_SYMBOL(__rio_local_read_config_16);
-EXPORT_SYMBOL(__rio_local_read_config_32);
-EXPORT_SYMBOL(__rio_local_write_config_8);
-EXPORT_SYMBOL(__rio_local_write_config_16);
-EXPORT_SYMBOL(__rio_local_write_config_32);
+EXPORT_SYMBOL_GPL(__rio_local_read_config_8);
+EXPORT_SYMBOL_GPL(__rio_local_read_config_16);
+EXPORT_SYMBOL_GPL(__rio_local_read_config_32);
+EXPORT_SYMBOL_GPL(__rio_local_write_config_8);
+EXPORT_SYMBOL_GPL(__rio_local_write_config_16);
+EXPORT_SYMBOL_GPL(__rio_local_write_config_32);
=20
 /**
  * RIO_OP_READ - Generate rio_mport_read_config_* functions
@@ -143,12 +143,12 @@ RIO_OP_WRITE(8, u8, 1)
 RIO_OP_WRITE(16, u16, 2)
 RIO_OP_WRITE(32, u32, 4)
=20
-EXPORT_SYMBOL(rio_mport_read_config_8);
-EXPORT_SYMBOL(rio_mport_read_config_16);
-EXPORT_SYMBOL(rio_mport_read_config_32);
-EXPORT_SYMBOL(rio_mport_write_config_8);
-EXPORT_SYMBOL(rio_mport_write_config_16);
-EXPORT_SYMBOL(rio_mport_write_config_32);
+EXPORT_SYMBOL_GPL(rio_mport_read_config_8);
+EXPORT_SYMBOL_GPL(rio_mport_read_config_16);
+EXPORT_SYMBOL_GPL(rio_mport_read_config_32);
+EXPORT_SYMBOL_GPL(rio_mport_write_config_8);
+EXPORT_SYMBOL_GPL(rio_mport_write_config_16);
+EXPORT_SYMBOL_GPL(rio_mport_write_config_32);
=20
 /**
  * rio_mport_send_doorbell - Send a doorbell message
@@ -172,4 +172,4 @@ int rio_mport_send_doorbell(struct rio_m
 	return res;
 }
=20
-EXPORT_SYMBOL(rio_mport_send_doorbell);
+EXPORT_SYMBOL_GPL(rio_mport_send_doorbell);
diff --git a/drivers/rio/rio-driver.c b/drivers/rio/rio-driver.c
--- a/drivers/rio/rio-driver.c
+++ b/drivers/rio/rio-driver.c
@@ -222,8 +222,8 @@ static int __init rio_bus_init(void)
=20
 postcore_initcall(rio_bus_init);
=20
-EXPORT_SYMBOL(rio_register_driver);
-EXPORT_SYMBOL(rio_unregister_driver);
-EXPORT_SYMBOL(rio_bus_type);
-EXPORT_SYMBOL(rio_dev_get);
-EXPORT_SYMBOL(rio_dev_put);
+EXPORT_SYMBOL_GPL(rio_register_driver);
+EXPORT_SYMBOL_GPL(rio_unregister_driver);
+EXPORT_SYMBOL_GPL(rio_bus_type);
+EXPORT_SYMBOL_GPL(rio_dev_get);
+EXPORT_SYMBOL_GPL(rio_dev_put);
diff --git a/drivers/rio/rio.c b/drivers/rio/rio.c
--- a/drivers/rio/rio.c
+++ b/drivers/rio/rio.c
@@ -490,14 +490,14 @@ void rio_register_mport(struct rio_mport
 	list_add_tail(&port->node, &rio_mports);
 }
=20
-EXPORT_SYMBOL(rio_local_get_device_id);
-EXPORT_SYMBOL(rio_get_device);
-EXPORT_SYMBOL(rio_get_asm);
-EXPORT_SYMBOL(rio_request_inb_dbell);
-EXPORT_SYMBOL(rio_release_inb_dbell);
-EXPORT_SYMBOL(rio_request_outb_dbell);
-EXPORT_SYMBOL(rio_release_outb_dbell);
-EXPORT_SYMBOL(rio_request_inb_mbox);
-EXPORT_SYMBOL(rio_release_inb_mbox);
-EXPORT_SYMBOL(rio_request_outb_mbox);
-EXPORT_SYMBOL(rio_release_outb_mbox);
+EXPORT_SYMBOL_GPL(rio_local_get_device_id);
+EXPORT_SYMBOL_GPL(rio_get_device);
+EXPORT_SYMBOL_GPL(rio_get_asm);
+EXPORT_SYMBOL_GPL(rio_request_inb_dbell);
+EXPORT_SYMBOL_GPL(rio_release_inb_dbell);
+EXPORT_SYMBOL_GPL(rio_request_outb_dbell);
+EXPORT_SYMBOL_GPL(rio_release_outb_dbell);
+EXPORT_SYMBOL_GPL(rio_request_inb_mbox);
+EXPORT_SYMBOL_GPL(rio_release_inb_mbox);
+EXPORT_SYMBOL_GPL(rio_request_outb_mbox);
+EXPORT_SYMBOL_GPL(rio_release_outb_mbox);
