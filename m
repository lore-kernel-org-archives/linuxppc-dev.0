Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2E1D8DDEF3
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:33:19 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1XEQn027086
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:33:15 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1XE1B001213
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:33:14 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I18XPB007850
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:08:33 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 7267BAEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:33:13 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1XDjH015292
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:33:13 -0500
Date: Tue, 17 Jul 2007 20:33:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 13/61] bootwrapper: Search the entire compatible list for
	serial devices.
Message-ID: <20070718013313.GL15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The serial code previously did a simple strcmp on the compatible
node; this fails when the match string is not the first compatible
listed.  Use dt_is_compatible() instead.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/serial.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index eaa0d3a..c551bac 100644
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
-- 
1.5.0.3
