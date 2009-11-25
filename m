Return-Path: <mohan@in.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A8B10B7BBE
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2009 00:17:59 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp05.in.ibm.com (8.14.3/8.13.1) with ESMTP id nAPDHuvV008452
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 18:47:56 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAPDHuZt3313690
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 18:47:56 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAPDHtHZ006069
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 18:47:56 +0530
Date: Wed, 25 Nov 2009 18:47:47 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
To: benh@kernel.crashing.org, ppcdev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Reserve memory for kdump kernel within RMO region
Message-ID: <20091125131747.GA28857@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kexec@lists.infradead.org
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reserve memory for kdump kernel within RMO region

When the kernel size exceeds 32MB(observed with some distros), memory
for kdump kernel can not be reserved as kdump kernel base is assumed to
be 32MB always. When the kernel has CONFIG_RELOCATABLE option enabled,
provide the feature to reserve the memory for kdump kernel anywhere in
the RMO region.

Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>
---
 arch/powerpc/kernel/machine_kexec.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index baf1af0..99b2f9f 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -140,10 +140,29 @@ void __init reserve_crashkernel(void)
 
 	/* The crash region must not overlap the current kernel */
 	if (overlaps_crashkernel(__pa(_stext), _end - _stext)) {
+#ifdef CONFIG_RELOCATABLE
+		do {
+			/* Align kdump kernel to 16MB (size of large page) */
+			crashk_res.start = ALIGN(crashk_res.start +
+						(16 * 1024 * 1024), 0x1000000);
+			if (crashk_res.start + (_stext - _end) > lmb.rmo_size) {
+				printk(KERN_WARNING
+					"Not enough memory for crash kernel\n");
+				crashk_res.start = crashk_res.end = 0;
+				return;
+			}
+		} while (overlaps_crashkernel(__pa(_stext), _end - _stext));
+
+		crashk_res.end = crashk_res.start + crash_size - 1;
+		printk(KERN_INFO
+			"crash kernel memory overlaps with kernel memory\n"
+			"Moving it to %lx\n", (unsigned long)crashk_res.start);
+#else
 		printk(KERN_WARNING
 			"Crash kernel can not overlap current kernel\n");
 		crashk_res.start = crashk_res.end = 0;
 		return;
+#endif
 	}
 
 	/* Crash kernel trumps memory limit */
-- 
1.5.4
