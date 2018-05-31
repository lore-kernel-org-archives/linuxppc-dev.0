Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xF3q5pF4zDr30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 14:34:31 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 08/11] powerpc/prom_init: Move const structures to
 __initconst
Date: Thu, 31 May 2018 14:33:46 +1000
Message-Id: <20180531043349.24783-9-benh@kernel.crashing.org>
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

As they are no longer used past the end of prom_init

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom_init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 8bb6740e3262..67df2758a4e2 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -763,7 +763,7 @@ struct ibm_arch_vec {
 	struct option_vector6 vec6;
 } __packed;
 
-static const struct ibm_arch_vec ibm_architecture_vec_template = {
+static const struct ibm_arch_vec ibm_architecture_vec_template __initconst = {
 	.pvrs = {
 		{
 			.mask = cpu_to_be32(0xfffe0000), /* POWER5/POWER5+ */
@@ -938,7 +938,7 @@ static const struct fake_elf {
 			u32	ignore_me;
 		} rpadesc;
 	} rpanote;
-} fake_elf = {
+} fake_elf __initconst = {
 	.elfhdr = {
 		.e_ident = { 0x7f, 'E', 'L', 'F',
 			     ELFCLASS32, ELFDATA2MSB, EV_CURRENT },
@@ -2099,7 +2099,7 @@ static void __init prom_check_displays(void)
 	ihandle ih;
 	int i;
 
-	static const unsigned char default_colors[] = {
+	static const unsigned char default_colors[] __initconst = {
 		0x00, 0x00, 0x00,
 		0x00, 0x00, 0xaa,
 		0x00, 0xaa, 0x00,
-- 
2.17.0
