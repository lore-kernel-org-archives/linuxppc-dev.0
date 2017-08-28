Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgh8P3KZxzDq7q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 16:05:41 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id t3so5597633pgt.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Aug 2017 23:05:41 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: agust@denx.de, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/512x: clk: constify clk_div_table
Date: Mon, 28 Aug 2017 11:35:15 +0530
Message-Id: <90eacc5c9ff738176330dd53e128c945a88ead9f.1503900231.git.arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

clk_div_table are not supposed to change at runtime.
mpc512x_clk_divtable function working with const
clk_div_table. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 arch/powerpc/platforms/512x/clock-commonclk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index add5a53..b3097fe 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -363,7 +363,7 @@ static int get_cpmf_mult_x2(void)
  */
 
 /* applies to the IPS_DIV, and PCI_DIV values */
-static struct clk_div_table divtab_2346[] = {
+static const struct clk_div_table divtab_2346[] = {
 	{ .val = 2, .div = 2, },
 	{ .val = 3, .div = 3, },
 	{ .val = 4, .div = 4, },
@@ -372,7 +372,7 @@ static int get_cpmf_mult_x2(void)
 };
 
 /* applies to the MBX_DIV, LPC_DIV, and NFC_DIV values */
-static struct clk_div_table divtab_1234[] = {
+static const struct clk_div_table divtab_1234[] = {
 	{ .val = 1, .div = 1, },
 	{ .val = 2, .div = 2, },
 	{ .val = 3, .div = 3, },
-- 
1.9.1
