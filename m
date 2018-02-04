Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zYz8k57brzDqYx
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 16:01:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	greg@kroah.com
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH v4.4 backport 15/16] powerpc/64s: Wire up cpu_show_meltdown()
Date: Sun,  4 Feb 2018 16:00:09 +1100
Message-Id: <20180204050010.13669-16-mpe@ellerman.id.au>
In-Reply-To: <20180204050010.13669-1-mpe@ellerman.id.au>
References: <20180204050010.13669-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit fd6e440f20b1a4304553775fc55938848ff617c9 upstream.

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
index 0c26025e18f9..e23e555adc3a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -135,6 +135,7 @@ config PPC
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_CMOS_UPDATE
+	select GENERIC_CPU_VULNERABILITIES	if PPC_BOOK3S_64
 	select GENERIC_TIME_VSYSCALL_OLD
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 7db464c2b129..cd7bfec17654 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -934,5 +934,13 @@ void __init setup_rfi_flush(enum l1d_flush_type types, bool enable)
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
 #endif
-- 
2.14.1
