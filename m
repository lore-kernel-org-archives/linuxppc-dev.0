Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ytdGz1lB3zF067
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Dec 2017 03:34:34 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32: book3s - fix compile error with CONFIG_PPC_PTDUMP
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20171208163430.1B20C6B864@localhost.localdomain>
Date: Fri,  8 Dec 2017 17:34:29 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch remove CONFIG_PPC_HTDUMP if not PPC_BOOK3S_64 to avoid
below compile failure on BOOK3S_32:

  CC      arch/powerpc/mm/dump_linuxpagetables.o
  CC      arch/powerpc/mm/dump_hashpagetable.o
In file included from arch/powerpc/mm/dump_hashpagetable.c:27:0:
./arch/powerpc/include/asm/plpar_wrappers.h: In function 'get_cede_latency_hint':
./arch/powerpc/include/asm/plpar_wrappers.h:27:2: error: implicit declaration of function 'get_lppaca' [-Werror=implicit-function-declaration]
./arch/powerpc/include/asm/plpar_wrappers.h:27:21: error: invalid type argument of '->' (have 'int')
./arch/powerpc/include/asm/plpar_wrappers.h: In function 'set_cede_latency_hint':
./arch/powerpc/include/asm/plpar_wrappers.h:32:14: error: invalid type argument of '->' (have 'int')
./arch/powerpc/include/asm/plpar_wrappers.h: In function 'vpa_call':
./arch/powerpc/include/asm/plpar_wrappers.h:62:2: error: left shift count >= width of type [-Werror]
./arch/powerpc/include/asm/plpar_wrappers.h: In function 'plpar_pte_read_4':
./arch/powerpc/include/asm/plpar_wrappers.h:183:2: error: left shift count >= width of type [-Werror]
./arch/powerpc/include/asm/plpar_wrappers.h: In function 'plpar_pte_read_4_raw':
./arch/powerpc/include/asm/plpar_wrappers.h:201:2: error: left shift count >= width of type [-Werror]
arch/powerpc/mm/dump_hashpagetable.c: At top level:
arch/powerpc/mm/dump_hashpagetable.c:69:13: error: 'SLB_VSID_B' undeclared here (not in a function)
arch/powerpc/mm/dump_hashpagetable.c:70:13: error: 'SLB_VSID_B_256M' undeclared here (not in a function)
arch/powerpc/mm/dump_hashpagetable.c:74:11: error: 'HPTE_V_SECONDARY' undeclared here (not in a function)
arch/powerpc/mm/dump_hashpagetable.c:79:11: error: 'HPTE_V_VALID' undeclared here (not in a function)
arch/powerpc/mm/dump_hashpagetable.c:84:11: error: 'HPTE_V_BOLTED' undeclared here (not in a function)
arch/powerpc/mm/dump_hashpagetable.c:93:11: error: 'HPTE_R_PP0' undeclared here (not in a function)
arch/powerpc/mm/dump_hashpagetable.c:93:24: error: 'HPTE_R_PP' undeclared here (not in a function)
arch/powerpc/mm/dump_hashpagetable.c:93:22: error: invalid operands to binary | (have 'const struct flag_info *' and 'const struct flag_info *')
arch/powerpc/mm/dump_hashpagetable.c:93:3: error: initializer element is not constant
arch/powerpc/mm/dump_hashpagetable.c:93:3: error: (near initialization for 'r_flag_array[0].mask')
arch/powerpc/mm/dump_hashpagetable.c:97:22: error: invalid operands to binary | (have 'const struct flag_info *' and 'const struct flag_info *')
arch/powerpc/mm/dump_hashpagetable.c:97:3: error: initializer element is not constant
arch/powerpc/mm/dump_hashpagetable.c:97:3: error: (near initialization for 'r_flag_array[1].mask')
arch/powerpc/mm/dump_hashpagetable.c:101:22: error: invalid operands to binary | (have 'const struct flag_info *' and 'const struct flag_info *')
arch/powerpc/mm/dump_hashpagetable.c:101:3: error: initializer element is not constant
arch/powerpc/mm/dump_hashpagetable.c:101:3: error: (near initialization for 'r_flag_array[2].mask')
arch/powerpc/mm/dump_hashpagetable.c:105:22: error: invalid operands to binary | (have 'const struct flag_info *' and 'const struct flag_info *')
arch/powerpc/mm/dump_hashpagetable.c:105:3: error: initializer element is not constant
arch/powerpc/mm/dump_hashpagetable.c:105:3: error: (near initialization for 'r_flag_array[3].mask')
arch/powerpc/mm/dump_hashpagetable.c:109:22: error: invalid operands to binary | (have 'const struct flag_info *' and 'const struct flag_info *')
arch/powerpc/mm/dump_hashpagetable.c:109:3: error: initializer element is not constant
arch/powerpc/mm/dump_hashpagetable.c:109:3: error: (near initialization for 'r_flag_array[4].mask')
arch/powerpc/mm/dump_hashpagetable.c:110:10: error: 'PP_RXXX' undeclared here (not in a function)
arch/powerpc/mm/dump_hashpagetable.c:110:3: error: initializer element is not constant
arch/powerpc/mm/dump_hashpagetable.c:110:3: error: (near initialization for 'r_flag_array[4].val')
arch/powerpc/mm/dump_hashpagetable.c:113:11: error: 'HPTE_R_KEY_HI' undeclared here (not in a function)
arch/powerpc/mm/dump_hashpagetable.c:113:27: error: 'HPTE_R_KEY_LO' undeclared here (not in a function)
arch/powerpc/mm/dump_hashpagetable.c:113:25: error: invalid operands to binary | (have 'const struct flag_info *' and 'const struct flag_info *')
arch/powerpc/mm/dump_hashpagetable.c:113:3: error: initializer element is not constant
arch/powerpc/mm/dump_hashpagetable.c:113:3: error: (near initialization for 'r_flag_array[5].mask')
arch/powerpc/mm/dump_hashpagetable.c:114:24: error: invalid operands to binary | (have 'const struct flag_info *' and 'const struct flag_info *')
arch/powerpc/mm/dump_hashpagetable.c:114:3: error: initializer element is not constant
arch/powerpc/mm/dump_hashpagetable.c:114:3: error: (near initialization for 'r_flag_array[5].val')
arch/powerpc/mm/dump_hashpagetable.c:119:11: error: 'HPTE_R_R' undeclared here (not in a function)
arch/powerpc/mm/dump_hashpagetable.c:119:3: error: initializer element is not constant
arch/powerpc/mm/dump_hashpagetable.c:119:3: error: (near initialization for 'r_flag_array[6].mask')
arch/powerpc/mm/dump_hashpagetable.c:120:3: error: initializer element is not constant
arch/powerpc/mm/dump_hashpagetable.c:120:3: error: (near initialization for 'r_flag_array[6].val')
arch/powerpc/mm/dump_hashpagetable.c:124:11: error: 'HPTE_R_C' undeclared here (not in a function)
arch/powerpc/mm/dump_hashpagetable.c:124:3: error: initializer element is not constant
arch/powerpc/mm/dump_hashpagetable.c:124:3: error: (near initialization for 'r_flag_array[7].mask')
arch/powerpc/mm/dump_hashpagetable.c:125:3: error: initializer element is not constant
arch/powerpc/mm/dump_hashpagetable.c:125:3: error: (near initialization for 'r_flag_array[7].val')
arch/powerpc/mm/dump_hashpagetable.c:129:11: error: 'HPTE_R_N' undeclared here (not in a function)
arch/powerpc/mm/dump_hashpagetable.c:129:3: error: initializer element is not constant
arch/powerpc/mm/dump_hashpagetable.c:129:3: error: (near initialization for 'r_flag_array[8].mask')
arch/powerpc/mm/dump_hashpagetable.c:130:3: error: initializer element is not constant
arch/powerpc/mm/dump_hashpagetable.c:130:3: error: (near initialization for 'r_flag_array[8].val')
arch/powerpc/mm/dump_hashpagetable.c:133:11: error: 'HPTE_R_WIMG' undeclared here (not in a function)
arch/powerpc/mm/dump_hashpagetable.c:133:3: error: initializer element is not constant
arch/powerpc/mm/dump_hashpagetable.c:133:3: error: (near initialization for 'r_flag_array[9].mask')
arch/powerpc/mm/dump_hashpagetable.c:134:10: error: 'HPTE_R_W' undeclared here (not in a function)
arch/powerpc/mm/dump_hashpagetable.c:134:3: error: initializer element is not constant
arch/powerpc/mm/dump_hashpagetable.c:134:3: error: (near initialization for 'r_flag_array[9].val')
arch/powerpc/mm/dump_hashpagetable.c:137:3: error: initializer element is not constant
arch/powerpc/mm/dump_hashpagetable.c:137:3: error: (near initialization for 'r_flag_array[10].mask')
arch/powerpc/mm/dump_hashpagetable.c:138:10: error: 'HPTE_R_I' undeclared here (not in a function)
arch/powerpc/mm/dump_hashpagetable.c:138:3: error: initializer element is not constant
arch/powerpc/mm/dump_hashpagetable.c:138:3: error: (near initialization for 'r_flag_array[10].val')
arch/powerpc/mm/dump_hashpagetable.c:141:3: error: initializer element is not constant
arch/powerpc/mm/dump_hashpagetable.c:141:3: error: (near initialization for 'r_flag_array[11].mask')
arch/powerpc/mm/dump_hashpagetable.c:142:10: error: 'HPTE_R_G' undeclared here (not in a function)
arch/powerpc/mm/dump_hashpagetable.c:142:3: error: initializer element is not constant
arch/powerpc/mm/dump_hashpagetable.c:142:3: error: (near initialization for 'r_flag_array[11].val')
arch/powerpc/mm/dump_hashpagetable.c: In function 'dump_hpte_info':
arch/powerpc/mm/dump_hashpagetable.c:199:2: error: implicit declaration of function 'HPTE_V_AVPN_VAL' [-Werror=implicit-function-declaration]
arch/powerpc/mm/dump_hashpagetable.c:199:2: error: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'int' [-Werror=format]
arch/powerpc/mm/dump_hashpagetable.c: In function 'native_find':
arch/powerpc/mm/dump_hashpagetable.c:217:17: error: 'mmu_kernel_ssize' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:217:17: note: each undeclared identifier is reported only once for each function it appears in
arch/powerpc/mm/dump_hashpagetable.c:217:17: error: initialization makes integer from pointer without a cast [-Werror]
arch/powerpc/mm/dump_hashpagetable.c:218:24: error: 'mmu_psize_defs' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:221:2: error: implicit declaration of function 'get_kernel_vsid' [-Werror=implicit-function-declaration]
arch/powerpc/mm/dump_hashpagetable.c:222:2: error: implicit declaration of function 'hpt_vpn' [-Werror=implicit-function-declaration]
arch/powerpc/mm/dump_hashpagetable.c:223:2: error: implicit declaration of function 'hpt_hash' [-Werror=implicit-function-declaration]
arch/powerpc/mm/dump_hashpagetable.c:224:2: error: implicit declaration of function 'hpte_encode_avpn' [-Werror=implicit-function-declaration]
arch/powerpc/mm/dump_hashpagetable.c:229:23: error: 'htab_hash_mask' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:229:21: error: invalid operands to binary & (have 'long unsigned int' and 'const struct flag_info *')
arch/powerpc/mm/dump_hashpagetable.c:229:41: error: 'HPTES_PER_GROUP' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:229:39: error: invalid operands to binary * (have 'const struct flag_info *' and 'const struct flag_info *')
arch/powerpc/mm/dump_hashpagetable.c:229:13: error: assignment makes integer from pointer without a cast [-Werror]
arch/powerpc/mm/dump_hashpagetable.c:230:16: error: comparison between pointer and integer [-Werror]
arch/powerpc/mm/dump_hashpagetable.c:231:11: error: 'htab_address' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:231:9: error: assignment from incompatible pointer type [-Werror]
arch/powerpc/mm/dump_hashpagetable.c:234:3: error: implicit declaration of function 'HPTE_V_COMPARE' [-Werror=implicit-function-declaration]
arch/powerpc/mm/dump_hashpagetable.c:234:49: error: invalid operands to binary & (have 'long unsigned int' and 'const struct flag_info *')
arch/powerpc/mm/dump_hashpagetable.c: In function 'decode_r':
arch/powerpc/mm/dump_hashpagetable.c:287:23: error: storage size of 'entry' isn't known
arch/powerpc/mm/dump_hashpagetable.c:301:14: error: 'HPTE_R_RPN' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:301:12: error: invalid operands to binary & (have 'long unsigned int' and 'const struct flag_info *')
arch/powerpc/mm/dump_hashpagetable.c:301:29: error: 'HPTE_R_RPN_SHIFT' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:301:26: error: invalid operands to binary >> (have 'const struct flag_info *' and 'const struct flag_info *')
arch/powerpc/mm/dump_hashpagetable.c:301:7: error: assignment makes integer from pointer without a cast [-Werror]
arch/powerpc/mm/dump_hashpagetable.c:304:10: error: 'mmu_psize_defs' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:304:2: error: statement with no effect [-Werror=unused-value]
arch/powerpc/mm/dump_hashpagetable.c:306:15: error: request for member 'penc' in something not a structure or union
arch/powerpc/mm/dump_hashpagetable.c:306:8: error: incompatible types when assigning to type 'int' from type 'const struct flag_info'
arch/powerpc/mm/dump_hashpagetable.c:306:3: error: statement with no effect [-Werror=unused-value]
arch/powerpc/mm/dump_hashpagetable.c:308:38: error: invalid operands to binary - (have 'int' and 'const struct flag_info *')
arch/powerpc/mm/dump_hashpagetable.c:308:10: error: assignment makes integer from pointer without a cast [-Werror]
arch/powerpc/mm/dump_hashpagetable.c:311:5: error: implicit declaration of function 'mmu_psize_to_shift' [-Werror=implicit-function-declaration]
arch/powerpc/mm/dump_hashpagetable.c:287:23: error: unused variable 'entry' [-Werror=unused-variable]
arch/powerpc/mm/dump_hashpagetable.c: In function 'hpte_find':
arch/powerpc/mm/dump_hashpagetable.c:360:11: error: 'HPTE_V_LARGE' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:360:9: error: invalid operands to binary & (have 'u64' and 'const struct flag_info *')
arch/powerpc/mm/dump_hashpagetable.c:365:14: error: 'HPTE_R_RPN' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:365:12: error: invalid operands to binary & (have 'u64' and 'const struct flag_info *')
arch/powerpc/mm/dump_hashpagetable.c:365:29: error: 'HPTE_R_RPN_SHIFT' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:365:26: error: invalid operands to binary >> (have 'const struct flag_info *' and 'const struct flag_info *')
arch/powerpc/mm/dump_hashpagetable.c:365:7: error: assignment makes integer from pointer without a cast [-Werror]
arch/powerpc/mm/dump_hashpagetable.c: In function 'walk_pte':
arch/powerpc/mm/dump_hashpagetable.c:391:12: error: 'mmu_vmalloc_psize' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:391:10: error: assignment makes integer from pointer without a cast [-Werror]
arch/powerpc/mm/dump_hashpagetable.c:393:12: error: 'mmu_io_psize' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:393:10: error: assignment makes integer from pointer without a cast [-Werror]
arch/powerpc/mm/dump_hashpagetable.c:403:18: error: 'H_PAGE_HASHPTE' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:403:16: error: invalid operands to binary & (have 'long unsigned int' and 'const struct flag_info *')
arch/powerpc/mm/dump_hashpagetable.c: In function 'walk_pagetables':
arch/powerpc/mm/dump_hashpagetable.c:452:10: error: 'KERN_VIRT_START' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:452:8: error: assignment makes integer from pointer without a cast [-Werror]
arch/powerpc/mm/dump_hashpagetable.c: In function 'walk_linearmapping':
arch/powerpc/mm/dump_hashpagetable.c:468:29: error: 'mmu_psize_defs' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c: In function 'populate_markers':
arch/powerpc/mm/dump_hashpagetable.c:497:37: error: 'ISA_IO_BASE' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:497:35: error: assignment makes integer from pointer without a cast [-Werror]
arch/powerpc/mm/dump_hashpagetable.c:498:37: error: 'ISA_IO_END' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:498:35: error: assignment makes integer from pointer without a cast [-Werror]
arch/powerpc/mm/dump_hashpagetable.c:499:37: error: 'PHB_IO_BASE' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:499:35: error: assignment makes integer from pointer without a cast [-Werror]
arch/powerpc/mm/dump_hashpagetable.c:500:37: error: 'PHB_IO_END' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:500:35: error: assignment makes integer from pointer without a cast [-Werror]
arch/powerpc/mm/dump_hashpagetable.c:501:37: error: 'IOREMAP_BASE' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:501:35: error: assignment makes integer from pointer without a cast [-Werror]
arch/powerpc/mm/dump_hashpagetable.c:502:37: error: 'IOREMAP_END' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:502:35: error: assignment makes integer from pointer without a cast [-Werror]
arch/powerpc/mm/dump_hashpagetable.c:506:38: error: 'VMEMMAP_BASE' undeclared (first use in this function)
arch/powerpc/mm/dump_hashpagetable.c:506:35: error: assignment makes integer from pointer without a cast [-Werror]
cc1: all warnings being treated as errors
make[1]: *** [arch/powerpc/mm/dump_hashpagetable.o] Error 1
make: *** [arch/powerpc/mm] Error 2

Fixes: dd5ac03e09554 ("powerpc/mm: Fix page table dump build
on non-Book3S")

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index be1c8c5beb61..2c5e4559349a 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -368,6 +368,6 @@ config PPC_PTDUMP
 
 config PPC_HTDUMP
 	def_bool y
-	depends on PPC_PTDUMP && PPC_BOOK3S
+	depends on PPC_PTDUMP && PPC_BOOK3S_64
 
 endmenu
-- 
2.13.3
