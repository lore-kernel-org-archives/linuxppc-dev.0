Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3BEC0DDE17
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 03:40:05 +1000 (EST)
Date: Mon, 20 Aug 2007 12:39:54 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 08/20] bootwrapper: serial_console_init() fixes.
Message-ID: <20070820173954.GG30562@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

1. Search the entire compatible list for serial devices.

The serial code previously did a simple strcmp on the compatible
node; this fails when the match string is not the first compatible
listed.  Use dt_is_compatible() instead.

2. Don't call serial_edit_cmdline if getc isn't defined.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/serial.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index eaa0d3a..3ce7f65 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -114,18 +114,14 @@ int serial_console_init(void)
 {
 	void *devp;
 	int rc = -1;
-	char compat[MAX_PROP_LEN];
 
 	devp = serial_get_stdout_devp();
 	if (devp == NULL)
 		goto err_out;
 
-	if (getprop(devp, "compatible", compat, sizeof(compat)) < 0)
-		goto err_out;
-
-	if (!strcmp(compat, "ns16550"))
+	if (dt_is_compatible(devp, "ns16550"))
 		rc = ns16550_console_init(devp, &serial_cd);
-	else if (!strcmp(compat, "marvell,mpsc"))
+	else if (dt_is_compatible(devp, "marvell,mpsc"))
 		rc = mpsc_console_init(devp, &serial_cd);
 
 	/* Add other serial console driver calls here */
@@ -133,10 +129,12 @@ int serial_console_init(void)
 	if (!rc) {
 		console_ops.open = serial_open;
 		console_ops.write = serial_write;
-		console_ops.edit_cmdline = serial_edit_cmdline;
 		console_ops.close = serial_close;
 		console_ops.data = &serial_cd;
 
+		if (serial_cd.getc)
+			console_ops.edit_cmdline = serial_edit_cmdline;
+
 		return 0;
 	}
 err_out:
-- 
1.5.0.3
