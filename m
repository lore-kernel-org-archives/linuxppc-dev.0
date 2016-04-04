Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qdq7F4XhwzDqTC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Apr 2016 21:11:37 +1000 (AEST)
Date: Mon, 4 Apr 2016 21:11:12 +1000
From: Anton Blanchard <anton@samba.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Michael Neuling
 <mikey@neuling.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander
 Graf <agraf@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: [PATCH] powerpc: Clear user CPU feature bits if TM is disabled at
 runtime
Message-ID: <20160404211112.66b0756f@kryten>
In-Reply-To: <20160404204346.1cf44df8@kryten>
References: <20160404164457.539a55f0@kryten> <57021123.6050506@ozlabs.ru>
 <20160404204346.1cf44df8@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In check_cpu_pa_features() we check a number of bits in the
ibm,pa-features array and set and clear CPU features based on what
we find. One of these bits is CPU_FTR_TM, the transactional memory
feature bit.

If this does disable TM at runtime, then we need to tell userspace
about it by clearing the user CPU feature bits.

Without this patch userspace processes will think they can execute
TM instructions and get killed when they try.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: stable@vger.kernel.org
---

Michael I've added stable here because I'm seeing this on a number
of distros and would like to get it backported, but I'll leave it up
to you if it should go there.

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index f98be83..98c6c86 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -822,4 +822,18 @@ static int __init disable_hardlockup_detector(void)
 	return 0;
 }
 early_initcall(disable_hardlockup_detector);
+
+static int __init update_cpu_user_features(void)
+{
+	/*
+	 * Firmware might have disabled TM by clearing the relevant
+	 * bit in the ibm,pa-features array. In this case we need to
+	 * tell userspace.
+	 */
+	if (!cpu_has_feature(CPU_FTR_TM))
+		cur_cpu_spec->cpu_user_features2 &= ~(PPC_FEATURE2_HTM|PPC_FEATURE2_HTM_NOSC);
+
+	return 0;
+}
+early_initcall(update_cpu_user_features);
 #endif
