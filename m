Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BB8DFDDEE3
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 12:17:12 +1100 (EST)
Received: from outbound3-fra.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound3-fra-R.bigfish.com (Postfix) with ESMTP id 00484113154
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 01:17:08 +0000 (UTC)
Received: from mail39-fra-R.bigfish.com (unknown [10.4.252.3])
	by outbound3-fra.bigfish.com (Postfix) with ESMTP id F2A9F9B8051
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 01:17:07 +0000 (UTC)
Received: from mail39-fra (localhost.localdomain [127.0.0.1])
	by mail39-fra-R.bigfish.com (Postfix) with ESMTP id E743614041A
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 01:17:07 +0000 (UTC)
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail39-fra.bigfish.com (Postfix) with ESMTP id A9202720070
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 01:17:07 +0000 (UTC)
Received: from mail1.sgo.in.sel.sony.com (mail1.sgo.in.sel.sony.com
	[43.130.1.111])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id l1I1H6wO017335
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 01:17:06 GMT
Received: from USSDIXIM02.am.sony.com (ussdixim02.am.sony.com [43.130.140.34])
	by mail1.sgo.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id
	l1I1H53x001203
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 01:17:05 GMT
Message-ID: <45D7A910.60702@am.sony.com>
Date: Sat, 17 Feb 2007 17:17:04 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [RFC 2/3] zImage: SMP hold
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add SMP secondary hold helper routines to the powerpc zImage bootwrapper.  For
platforms which are entered with multiple cpus.  These routines can be used to
hold the secondary cpus until the kernel is ready for entry.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/boot/main.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+)

--- ps3-linux-dev.orig/arch/powerpc/boot/main.c
+++ ps3-linux-dev/arch/powerpc/boot/main.c
@@ -290,6 +290,44 @@ static void set_cmdline(char *buf)
 		setprop(devp, "bootargs", buf, strlen(buf) + 1);
 }
 
+static volatile kernel_entry_t smp_secondary_entry = 0;
+
+/**
+ * smp_secondary_hold - Hold any secondary cpus until kernel is ready to enter.
+ * @cpu_id: Hardware cpu id.
+ *
+ * Called from the early entry code.
+ */
+
+void smp_secondary_hold(unsigned int cpu_id)
+{
+	while(!smp_secondary_entry)
+		(void)0;
+
+	printf("%s:%d: released cpu (%u)\n", __func__, __LINE__, cpu_id);
+
+	smp_secondary_entry(0, 0, NULL);
+
+	printf("Error: secondary cpu (%u) returned to bootwrapper!\n",
+		cpu_id);
+	exit();
+}
+
+/**
+ * smp_secondary_release - Release any secondary cpus.
+ * @kentry: The kernel entry for secondary cpus.
+ *
+ * Typically called by the primary cpu after the kernel is ready for entry.
+ */
+
+static void smp_secondary_release(kernel_entry_t kentry)
+{
+	printf("%s:%d\n", __func__, __LINE__);
+	smp_secondary_entry = kentry;
+
+	/* Do we need to yield to the secondary cpus here??? */
+}
+
 struct platform_ops platform_ops;
 struct dt_ops dt_ops;
 struct console_ops console_ops;
@@ -340,7 +378,10 @@ void start(unsigned long a1, unsigned lo
 	if (console_ops.close)
 		console_ops.close();
 
 	kentry = (kernel_entry_t) vmlinux.addr;
+
+	smp_secondary_release(kentry);
+
 	if (ft_addr)
 		kentry(ft_addr, 0, NULL);
 	else
