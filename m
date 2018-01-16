Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLSXv4g17zF0WF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 22:24:15 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/64s: Wire up cpu_show_meltdown()
Date: Tue, 16 Jan 2018 22:24:01 +1100
Message-Id: <20180116112401.942-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recent commit 87590ce6e373 ("sysfs/cpu: Add vulnerability folder")
added a generic folder and set of files for reporting information on
CPU vulnerabilities. One of those was for meltdown:

  /sys/devices/system/cpu/vulnerabilities/meltdown

This commit wires up that file for 64-bit Book3S powerpc.

For now we default to "Vulnerable" unless the RFI flush is enabled.
That may not actually be true on all hardware, further patches will
refine the reporting based on the CPU/platform etc. But for now we
default to being pessimists.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig           | 1 +
 arch/powerpc/kernel/setup_64.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c51e6ce42e7a..2ed525a44734 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -166,6 +166,7 @@ config PPC
 	select GENERIC_CLOCKEVENTS_BROADCAST	if SMP
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_CPU_VULNERABILITIES	if PPC_BOOK3S_64
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 491be4179ddd..624d2a62d05d 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -901,4 +901,12 @@ void __init setup_rfi_flush(enum l1d_flush_type types, bool enable)
 	if (!no_rfi_flush)
 		rfi_flush_enable(enable);
 }
+
+ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	if (rfi_flush)
+		return sprintf(buf, "Mitigation: RFI Flush\n");
+
+	return sprintf(buf, "Vulnerable\n");
+}
 #endif /* CONFIG_PPC_BOOK3S_64 */
-- 
2.14.3
