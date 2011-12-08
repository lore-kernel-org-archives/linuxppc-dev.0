Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp04.br.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 91D3A1007D1
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 22:23:50 +1100 (EST)
Received: from /spool/local
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <prasad@linux.vnet.ibm.com>;
 Thu, 8 Dec 2011 09:23:40 -0200
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by mailhub3.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id pB8BOPlv3596314
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Dec 2011 09:24:25 -0200
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB8BNccb030307
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Dec 2011 09:23:38 -0200
Date: Thu, 8 Dec 2011 16:53:30 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: dwg@au1.ibm.com
Subject: [PATCH 2/2] [PowerPC Book3E] Introduce new ptrace debug feature flag
Message-ID: <20111208112330.GB24484@in.ibm.com>
References: <20111208111212.GB3720@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111208111212.GB3720@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Thiago Jung Bauermann <bauerman@br.ibm.com>,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While PPC_PTRACE_SETHWDEBUG ptrace flag in PowerPC accepts
PPC_BREAKPOINT_MODE_EXACT mode of breakpoint, the same is not intimated to the
user-space debuggers (like GDB) who may want to use it. Hence we introduce a
new PPC_DEBUG_FEATURE_DATA_BP_EXACT flag which will be populated on the
"features" member of "struct ppc_debug_info" to advertise support for the
same on Book3E PowerPC processors.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ptrace.h |    1 +
 arch/powerpc/kernel/ptrace.c      |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 48223f9..cf014f9 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -380,6 +380,7 @@ struct ppc_debug_info {
 #define PPC_DEBUG_FEATURE_INSN_BP_MASK		0x0000000000000002
 #define PPC_DEBUG_FEATURE_DATA_BP_RANGE		0x0000000000000004
 #define PPC_DEBUG_FEATURE_DATA_BP_MASK		0x0000000000000008
+#define PPC_DEBUG_FEATURE_DATA_BP_EXACT		0x0000000000000010
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 18d28b6..71db5a6 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1636,6 +1636,7 @@ long arch_ptrace(struct task_struct *child, long request,
 #ifdef CONFIG_PPC_ADV_DEBUG_DAC_RANGE
 		dbginfo.features |=
 				   PPC_DEBUG_FEATURE_DATA_BP_RANGE |
+				   PPC_DEBUG_FEATURE_DATA_BP_EXACT |
 				   PPC_DEBUG_FEATURE_DATA_BP_MASK;
 #endif
 #else /* !CONFIG_PPC_ADV_DEBUG_REGS */
