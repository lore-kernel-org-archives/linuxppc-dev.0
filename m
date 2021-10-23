Return-Path: <SRS0=6Lu7=PL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A04C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Oct 2021 11:50:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4854360FDA
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Oct 2021 11:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4854360FDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hc00G717Mz3dwH
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Oct 2021 22:50:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hbzx82JwBz3cSg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Oct 2021 22:47:56 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4HbzwY58JPz9s32;
 Sat, 23 Oct 2021 13:47:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4OlYzj21t9Ap; Sat, 23 Oct 2021 13:47:25 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.87])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by pegase1.c-s.fr (Postfix) with ESMTPS id 4HbzwS5Y0Hz9s33;
 Sat, 23 Oct 2021 13:47:20 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19NBlKoJ441188
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 23 Oct 2021 13:47:20 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19NBlKSF441186;
 Sat, 23 Oct 2021 13:47:20 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 08/10] powerpc/fsl_booke: Allocate separate TLBCAMs for
 readonly memory
Date: Sat, 23 Oct 2021 13:47:13 +0200
Message-Id: <51af24eb6763808bb416f1fbe48c53b6a746b82d.1634983809.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <33e7fe0f6134c58e044eb63d3925cd34aa120104.1634983809.git.christophe.leroy@csgroup.eu>
References: <33e7fe0f6134c58e044eb63d3925cd34aa120104.1634983809.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634989633; l=1810; s=20211009;
 h=from:subject:message-id; bh=IZVmpk+ZsJNljxpYZuQ+NEVa4/sMGVjLDzHgMgTYhVg=;
 b=GOIXle/Q/SJd52bWLX/Ae4riqQGWNgDYb9Y7LAc1yoMtx0OrTJR6Fg4OSBjHynd4UFnazG4xycYl
 7aytz/dRAG7/BCYYo7s4dOVOV4CcJ9A1DLDcoqnAaun+SlEvdqMs
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519;
 pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Reorganise TLBCAM allocation so that when STRICT_KERNEL_RWX is
enabled, TLBCAMs are allocated such that readonly memory uses
different TLBCAMs.

This results in an allocation looking like:

Memory CAM mapping: 4/4/4/1/1/1/1/16/16/16/64/64/64/256/256 Mb, residual: 256Mb

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: No change
---
 arch/powerpc/mm/nohash/fsl_book3e.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/nohash/fsl_book3e.c b/arch/powerpc/mm/nohash/fsl_book3e.c
index 8ae1ba7985df..88132cab3442 100644
--- a/arch/powerpc/mm/nohash/fsl_book3e.c
+++ b/arch/powerpc/mm/nohash/fsl_book3e.c
@@ -172,15 +172,34 @@ static unsigned long map_mem_in_cams_addr(phys_addr_t phys, unsigned long virt,
 {
 	int i;
 	unsigned long amount_mapped = 0;
+	unsigned long boundary;
+
+	if (strict_kernel_rwx_enabled())
+		boundary = (unsigned long)(_sinittext - _stext);
+	else
+		boundary = ram;
 
 	/* Calculate CAM values */
-	for (i = 0; ram && i < max_cam_idx; i++) {
+	for (i = 0; boundary && i < max_cam_idx; i++) {
+		unsigned long cam_sz;
+		pgprot_t prot = PAGE_KERNEL_X;
+
+		cam_sz = calc_cam_sz(boundary, virt, phys);
+		if (!dryrun)
+			settlbcam(i, virt, phys, cam_sz, pgprot_val(prot), 0);
+
+		boundary -= cam_sz;
+		amount_mapped += cam_sz;
+		virt += cam_sz;
+		phys += cam_sz;
+	}
+	for (ram -= amount_mapped; ram && i < max_cam_idx; i++) {
 		unsigned long cam_sz;
+		pgprot_t prot = PAGE_KERNEL_X;
 
 		cam_sz = calc_cam_sz(ram, virt, phys);
 		if (!dryrun)
-			settlbcam(i, virt, phys, cam_sz,
-				  pgprot_val(PAGE_KERNEL_X), 0);
+			settlbcam(i, virt, phys, cam_sz, pgprot_val(prot), 0);
 
 		ram -= cam_sz;
 		amount_mapped += cam_sz;
-- 
2.31.1

