Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xF453vVJzDrbm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 14:34:45 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 07/11] powerpc/prom_init: Move ibm_arch_vec to __prombss
Date: Thu, 31 May 2018 14:33:45 +1000
Message-Id: <20180531043349.24783-8-benh@kernel.crashing.org>
In-Reply-To: <20180531043349.24783-1-benh@kernel.crashing.org>
References: <20180531043349.24783-1-benh@kernel.crashing.org>
Reply-To: [RFC.PATCH.00/11]prom_init.cleanups.and.sanitization@gate.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make the existing initialized definition constant and copy
it to a __prombss copy

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom_init.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 6a7549f64e28..8bb6740e3262 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -763,7 +763,7 @@ struct ibm_arch_vec {
 	struct option_vector6 vec6;
 } __packed;
 
-struct ibm_arch_vec __cacheline_aligned ibm_architecture_vec = {
+static const struct ibm_arch_vec ibm_architecture_vec_template = {
 	.pvrs = {
 		{
 			.mask = cpu_to_be32(0xfffe0000), /* POWER5/POWER5+ */
@@ -901,6 +901,8 @@ struct ibm_arch_vec __cacheline_aligned ibm_architecture_vec = {
 	},
 };
 
+static struct ibm_arch_vec __prombss ibm_architecture_vec  ____cacheline_aligned;
+
 /* Old method - ELF header with PT_NOTE sections only works on BE */
 #ifdef __BIG_ENDIAN__
 static const struct fake_elf {
@@ -1110,6 +1112,10 @@ static void __init prom_check_platform_support(void)
 	};
 	int prop_len = prom_getproplen(prom.chosen,
 				       "ibm,arch-vec-5-platform-support");
+
+	/* First copy the architecture vec template */
+	ibm_architecture_vec = ibm_architecture_vec_template;
+
 	if (prop_len > 1) {
 		int i;
 		u8 vec[prop_len];
-- 
2.17.0
