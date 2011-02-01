Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9628DB70EE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Feb 2011 05:49:15 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p11ITGkE005752
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Feb 2011 13:29:51 -0500
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 2F4E24DE8042
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Feb 2011 13:48:38 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p11InBsN192844
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Feb 2011 13:49:11 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p11In94b004033
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Feb 2011 16:49:09 -0200
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH V2 2/6] powerpc/44x: allow override to hard-coded uart address
Date: Tue,  1 Feb 2011 12:48:42 -0600
Message-Id: <1296586126-32765-3-git-send-email-shaggy@linux.vnet.ibm.com>
In-Reply-To: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
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
