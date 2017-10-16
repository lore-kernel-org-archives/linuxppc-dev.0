Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com
 [IPv6:2607:f8b0:400e:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFms44snbzDrFt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 16:21:44 +1100 (AEDT)
Received: by mail-pf0-x230.google.com with SMTP id p87so14977414pfj.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2017 22:21:44 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/64s: Fix crashes on Power9 DD1 with radix MMU and
 STRICT_RWX
Date: Mon, 16 Oct 2017 16:21:35 +1100
Message-Id: <20171016052135.24738-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When using the radix MMU on Power9 DD1, to work around a hardware
problem, radix__pte_update() is required to do a two stage update of
the PTE. First we write a zero value into the PTE, then we flush the
TLB, and then we write the new PTE value.

In the normal case that works OK, but it does not work if we're
updating the PTE that maps the code we're executing, because the
mapping is removed by the TLB flush and we can no longer execute from
it. Unfortunately the STRICT_RWX code needs to do exactly that.

The exact symptoms when we hit this case vary, sometimes we print an
oops and then get stuck after that, but I've also seen a machine just
get stuck continually page faulting with no oops printed. The variance
is presumably due to the exact layout of the text and the page size
used for the mappings. In all cases we are unable to boot to a shell.

There are possible solutions such as creating a second mapping of the
TLB flush code, executing from that, and then jumping back to the
original. However we don't want to add that level of complexity for a
DD1 work around.

So just detect that we're running on Power9 DD1 and refrain from
changing the permissions, effectively disabling STRICT_RWX on Power9
DD1.

Fixes: 7614ff3 ("powerpc/mm/radix: Implement STRICT_RWX/mark_rodata_ro() for Radix")

Cc: stable@vger.kernel.org

Reported-by: Andrew Jeffery <andrew@aj.id.au>
[Changelog as suggested by Michael Ellerman <mpe@ellerman.id.au>]
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---

 Changelog v2
 - Rephrase the comments and changelog as suggested by mpe

 arch/powerpc/mm/pgtable-radix.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 39c252b54d16..cfbbee941a76 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -169,6 +169,16 @@ void radix__mark_rodata_ro(void)
 {
 	unsigned long start, end;
 
+	/*
+	 * mark_rodata_ro() will mark itself as !writable at some point.
+	 * Due to DD1 workaround in radix__pte_update(), we'll end up with
+	 * an invalid pte and the system will crash quite severly.
+	 */
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+		pr_warn("Warning: Unable to mark rodata read only on P9 DD1\n");
+		return;
+	}
+
 	start = (unsigned long)_stext;
 	end = (unsigned long)__init_begin;
 
-- 
2.13.6
