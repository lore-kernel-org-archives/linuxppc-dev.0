Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKxm46MnnzDw3Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 23:15:48 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/prom: Define structs for client architecture
 vectors
Date: Fri, 18 Nov 2016 23:15:41 +1100
Message-Id: <1479471342-24195-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The "client architecture vectors" are a series of structures we pass to
firmware to define various things, such as what processors we support
and many other options.

Each structure is entirely different so we have to define a different
struct for each one, but that's OK.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom_init.c | 53 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 88ac964f4858..b41ac76029cd 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -740,6 +740,59 @@ unsigned char ibm_architecture_vec[] = {
 	OV6_LINUX,
 };
 
+struct option_vector1 {
+	u8 byte1;
+	u8 arch_versions;
+} __packed;
+
+struct option_vector2 {
+	u8 byte1;
+	__be16 reserved;
+	__be32 real_base;
+	__be32 real_size;
+	__be32 virt_base;
+	__be32 virt_size;
+	__be32 load_base;
+	__be32 min_rma;
+	__be32 min_load;
+	u8 min_rma_percent;
+	u8 max_pft_size;
+} __packed;
+
+struct option_vector3 {
+	u8 byte1;
+	u8 byte2;
+} __packed;
+
+struct option_vector4 {
+	u8 byte1;
+	u8 min_vp_cap;
+} __packed;
+
+struct option_vector5 {
+	u8 byte1;
+	u8 byte2;
+	u8 byte3;
+	u8 cmo;
+	u8 associativity;
+	u8 bin_opts;
+	u8 micro_checkpoint;
+	u8 reserved0;
+	__be32 max_cpus;
+	__be16 papr_level;
+	__be16 reserved1;
+	u8 platform_facilities;
+	u8 reserved2;
+	__be16 reserved3;
+	u8 subprocessors;
+} __packed;
+
+struct option_vector6 {
+	u8 reserved;
+	u8 secondary_pteg;
+	u8 os_name;
+} __packed;
+
 /* Old method - ELF header with PT_NOTE sections only works on BE */
 #ifdef __BIG_ENDIAN__
 static struct fake_elf {
-- 
2.7.4
