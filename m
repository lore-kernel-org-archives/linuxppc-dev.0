Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BB9E1A1A24
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2015 07:59:49 +1100 (AEDT)
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 209BB140B9A
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2015 07:59:47 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Thu, 17 Dec 2015 13:59:46 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 54D103E4003E
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 13:59:26 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBHKxQYj27787408
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 13:59:26 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBHKxPcq014627
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 13:59:26 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH v3 2/9] powerpc/smp: Add smp_muxed_ipi_set_message
Date: Thu, 17 Dec 2015 14:59:04 -0600
Message-Id: <1450385951-25128-3-git-send-email-warrier@linux.vnet.ibm.com>
In-Reply-To: <1450385951-25128-1-git-send-email-warrier@linux.vnet.ibm.com>
References: <1450385951-25128-1-git-send-email-warrier@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

smp_muxed_ipi_message_pass() invokes smp_ops->cause_ipi, which
uses an ioremapped address to access registers on the XICS
interrupt controller to cause the IPI. Because of this real
mode callers cannot call smp_muxed_ipi_message_pass() for IPI
messaging.

This patch creates a separate function smp_muxed_ipi_set_message
just to set the IPI message without the cause_ipi routine.
After calling this function to set the IPI message, real
mode callers must cause the IPI by writing to the XICS registers
directly.

As part of this, we also change smp_muxed_ipi_message_pass
to call smp_muxed_ipi_set_message to set the message instead
of doing it directly inside the routine.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/smp.h | 1 +
 arch/powerpc/kernel/smp.c      | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 9ef9c37..78083ed 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -124,6 +124,7 @@ extern const char *smp_ipi_name[];
 /* for irq controllers with only a single ipi */
 extern void smp_muxed_ipi_set_data(int cpu, unsigned long data);
 extern void smp_muxed_ipi_message_pass(int cpu, int msg);
+extern void smp_muxed_ipi_set_message(int cpu, int msg);
 extern irqreturn_t smp_ipi_demux(void);
 
 void smp_init_pSeries(void);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index a53a130..e222efc 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -218,7 +218,7 @@ void smp_muxed_ipi_set_data(int cpu, unsigned long data)
 	info->data = data;
 }
 
-void smp_muxed_ipi_message_pass(int cpu, int msg)
+void smp_muxed_ipi_set_message(int cpu, int msg)
 {
 	struct cpu_messages *info = &per_cpu(ipi_message, cpu);
 	char *message = (char *)&info->messages;
@@ -228,6 +228,13 @@ void smp_muxed_ipi_message_pass(int cpu, int msg)
 	 */
 	smp_mb();
 	message[msg] = 1;
+}
+
+void smp_muxed_ipi_message_pass(int cpu, int msg)
+{
+	struct cpu_messages *info = &per_cpu(ipi_message, cpu);
+
+	smp_muxed_ipi_set_message(cpu, msg);
 	/*
 	 * cause_ipi functions are required to include a full barrier
 	 * before doing whatever causes the IPI.
-- 
1.8.3.4
