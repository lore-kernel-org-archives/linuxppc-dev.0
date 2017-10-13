Return-Path: <bhumirks@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yD7GH2w8pzDr4T
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Oct 2017 00:04:23 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id u138so21779367wmu.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 06:04:23 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, ruscur@russell.cc, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] powerpc/eeh: make eeh_ops structures _ro_after_init
Date: Fri, 13 Oct 2017 15:04:10 +0200
Message-Id: <1507899850-22296-1-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These structures are passed to the eeh_ops_register function during the
initialization phase. There they get stored in a structure variable
which only makes function calls through function pointers. There is no
other usage of these eeh_ops structures and their fields are never
modified after init phase. So, make them __ro_after_init.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 2 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 4650fb2..d2a53df 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1731,7 +1731,7 @@ static int pnv_eeh_restore_config(struct pci_dn *pdn)
 	return 0;
 }
 
-static struct eeh_ops pnv_eeh_ops = {
+static struct eeh_ops pnv_eeh_ops __ro_after_init = {
 	.name                   = "powernv",
 	.init                   = pnv_eeh_init,
 	.probe			= pnv_eeh_probe,
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 6b812ad..6fedfc9 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -684,7 +684,7 @@ static int pseries_eeh_write_config(struct pci_dn *pdn, int where, int size, u32
 	return rtas_write_config(pdn, where, size, val);
 }
 
-static struct eeh_ops pseries_eeh_ops = {
+static struct eeh_ops pseries_eeh_ops __ro_after_init = {
 	.name			= "pseries",
 	.init			= pseries_eeh_init,
 	.probe			= pseries_eeh_probe,
-- 
1.9.1
