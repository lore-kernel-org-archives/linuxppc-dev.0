Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 96A07B7A4F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Feb 2011 10:10:45 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p19Innuk032166
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 13:52:34 -0500
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 2511E7281A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Feb 2011 18:09:34 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p19N8Gfj2212030
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 18:08:16 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p19N8Gph027410
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 18:08:16 -0500
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 2/6] powerpc/44x: allow override to hard-coded uart address
Date: Wed,  9 Feb 2011 17:08:09 -0600
Message-Id: <1297292893-30241-3-git-send-email-shaggy@linux.vnet.ibm.com>
In-Reply-To: <1297292893-30241-1-git-send-email-shaggy@linux.vnet.ibm.com>
References: <1297292893-30241-1-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allow the early debug uart address to be overridden from the kernel
command line.

I would have preferred use the uart's virtual-reg property, but the device
tree hasn't been unflatted yet, and I don't know a reliable way to find it.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/udbg_16550.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/udbg_16550.c b/arch/powerpc/kernel/udbg_16550.c
index b4b167b..d36021a 100644
--- a/arch/powerpc/kernel/udbg_16550.c
+++ b/arch/powerpc/kernel/udbg_16550.c
@@ -219,6 +219,19 @@ void udbg_init_pas_realmode(void)
 #ifdef CONFIG_PPC_EARLY_DEBUG_44x
 #include <platforms/44x/44x.h>
 
+static unsigned long udbg_44x_comport = PPC44x_EARLY_DEBUG_VIRTADDR;
+
+static int __init early_parse_comport(char *p)
+{
+	if (!p || !(*p))
+		return 0;
+
+	udbg_44x_comport = simple_strtoul(p, 0, 16);
+
+	return 0;
+}
+early_param("uart_addr", early_parse_comport);
+
 static void udbg_44x_as1_flush(void)
 {
 	if (udbg_comport) {
@@ -249,9 +262,7 @@ static int udbg_44x_as1_getc(void)
 
 void __init udbg_init_44x_as1(void)
 {
-	udbg_comport =
-		(struct NS16550 __iomem *)PPC44x_EARLY_DEBUG_VIRTADDR;
-
+	udbg_comport = (struct NS16550 __iomem *)udbg_44x_comport;
 	udbg_putc = udbg_44x_as1_putc;
 	udbg_flush = udbg_44x_as1_flush;
 	udbg_getc = udbg_44x_as1_getc;
-- 
1.7.3.4
