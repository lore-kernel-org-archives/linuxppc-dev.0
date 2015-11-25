Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 37FB41A033E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 10:45:18 +1100 (AEDT)
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7207E1402ED
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2015 10:45:17 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Wed, 25 Nov 2015 16:45:15 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B09911FF0041
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2015 16:33:22 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAPNjBcg25690318
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2015 16:45:11 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAPNjATV022383
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2015 16:45:11 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH v2 1/9] powerpc/smp: Support more IPI messages
Date: Wed, 25 Nov 2015 17:44:48 -0600
Message-Id: <1448495096-24759-2-git-send-email-warrier@linux.vnet.ibm.com>
In-Reply-To: <1448495096-24759-1-git-send-email-warrier@linux.vnet.ibm.com>
References: <1448495096-24759-1-git-send-email-warrier@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch increases the number of demuxed messages for a
controller with a single ipi to 8 for 64-bit systems

This is required because we want to use the IPI mechanism
to send messages from a CPU running in KVM real mode in a
guest to a CPU in the host to take some action. Currently,
we only support 4 messages and all 4 are already taken.

Define a fifth message PPC_MSG_RM_HOST_ACTION for this
purpose.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/smp.h | 3 +++
 arch/powerpc/kernel/smp.c      | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 825663c..9ef9c37 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -114,6 +114,9 @@ extern int cpu_to_core_id(int cpu);
 #define PPC_MSG_TICK_BROADCAST	2
 #define PPC_MSG_DEBUGGER_BREAK  3
 
+/* This is only used by the powernv kernel */
+#define PPC_MSG_RM_HOST_ACTION	4
+
 /* for irq controllers that have dedicated ipis per message (4) */
 extern int smp_request_message_ipi(int virq, int message);
 extern const char *smp_ipi_name[];
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index ec9ec20..a53a130 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -206,7 +206,7 @@ int smp_request_message_ipi(int virq, int msg)
 
 #ifdef CONFIG_PPC_SMP_MUXED_IPI
 struct cpu_messages {
-	int messages;			/* current messages */
+	long messages;			/* current messages */
 	unsigned long data;		/* data for cause ipi */
 };
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct cpu_messages, ipi_message);
@@ -236,15 +236,15 @@ void smp_muxed_ipi_message_pass(int cpu, int msg)
 }
 
 #ifdef __BIG_ENDIAN__
-#define IPI_MESSAGE(A) (1 << (24 - 8 * (A)))
+#define IPI_MESSAGE(A) (1uL << ((BITS_PER_LONG - 8) - 8 * (A)))
 #else
-#define IPI_MESSAGE(A) (1 << (8 * (A)))
+#define IPI_MESSAGE(A) (1uL << (8 * (A)))
 #endif
 
 irqreturn_t smp_ipi_demux(void)
 {
 	struct cpu_messages *info = this_cpu_ptr(&ipi_message);
-	unsigned int all;
+	unsigned long all;
 
 	mb();	/* order any irq clear */
 
-- 
1.8.3.4
