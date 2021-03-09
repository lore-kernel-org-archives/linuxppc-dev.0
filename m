Return-Path: <SRS0=gB3U=IH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE764C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Mar 2021 06:20:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD8D65287
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Mar 2021 06:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD8D65287
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DvlRy4Kpvz3cSM
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Mar 2021 17:19:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DvlRc59d8z30Nj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Mar 2021 17:19:36 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DvlRQ4ptCz9v0dM;
 Tue,  9 Mar 2021 07:19:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id pjmTOPqa6zt6; Tue,  9 Mar 2021 07:19:30 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DvlRQ40nmz9v0dJ;
 Tue,  9 Mar 2021 07:19:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 816318B773;
 Tue,  9 Mar 2021 07:19:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id hxiPNV4Vfjbe; Tue,  9 Mar 2021 07:19:31 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 43E098B7CE;
 Tue,  9 Mar 2021 07:19:31 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id ED32167551; Tue,  9 Mar 2021 06:19:30 +0000 (UTC)
Message-Id: <a7aa198a88bcd33c6e35e99f70f86c7b7f2f9440.1615270757.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/vdso32: Add missing _restgpr_31_x to fix build failure
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 segher@kernel.crashing.org
Date: Tue,  9 Mar 2021 06:19:30 +0000 (UTC)
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

With some defconfig including CONFIG_CC_OPTIMIZE_FOR_SIZE,
(for instance mvme5100_defconfig and ps3_defconfig), gcc 5
generates a call to _restgpr_31_x.

Until recently it went unnoticed, but
commit 42ed6d56ade2 ("powerpc/vdso: Block R_PPC_REL24 relocations")
made it rise to the surface.

Provide that function (copied from lib/crtsavres.S) in
gettimeofday.S

Fixes: ab037dd87a2f ("powerpc/vdso: Switch VDSO to generic C implementation.")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
I don't know if there is a way to tell GCC not to emit that call, because at the end we get more instructions than needed.
---
 arch/powerpc/kernel/vdso32/gettimeofday.S | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index a6e29f880e0e..d21d08140a5e 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -65,3 +65,14 @@ V_FUNCTION_END(__kernel_clock_getres)
 V_FUNCTION_BEGIN(__kernel_time)
 	cvdso_call_time __c_kernel_time
 V_FUNCTION_END(__kernel_time)
+
+/* Routines for restoring integer registers, called by the compiler.  */
+/* Called with r11 pointing to the stack header word of the caller of the */
+/* function, just beyond the end of the integer restore area.  */
+_GLOBAL(_restgpr_31_x)
+_GLOBAL(_rest32gpr_31_x)
+	lwz	r0,4(r11)
+	lwz	r31,-4(r11)
+	mtlr	r0
+	mr	r1,r11
+	blr
-- 
2.25.0

