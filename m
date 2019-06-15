Return-Path: <SRS0=8zLz=UO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8C2C31E50
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jun 2019 12:49:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E3F21841
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jun 2019 12:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E3F21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Qy3q4bLhzDqQP
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jun 2019 22:49:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nefkom.net
 (client-ip=212.18.0.9; helo=mail-out.m-online.net;
 envelope-from=whitebox@nefkom.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Qy1N0YZwzDrcK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2019 22:47:35 +1000 (AEST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 45Qy1G5lFZz1rD9d;
 Sat, 15 Jun 2019 14:47:30 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 45Qy1G52mJz1qqkq;
 Sat, 15 Jun 2019 14:47:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id OuZhr5AH4Xcv; Sat, 15 Jun 2019 14:47:29 +0200 (CEST)
X-Auth-Info: lR6vEGEjQp+5pJ18oak+YQGQ7QwRBmFU2NVjtItvVEU28hsAjcy4lojTPelqUle0
Received: from igel.home (ppp-46-244-181-62.dynamic.mnet-online.de
 [46.244.181.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Sat, 15 Jun 2019 14:47:29 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
 id 0F8512C0C9A; Sat, 15 Jun 2019 14:47:29 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm/32s: only use MMU to mark initmem NX if
 STRICT_KERNEL_RWX
References: <cover.1550775950.git.christophe.leroy@c-s.fr>
 <1e412310cc18ea654fb2ce4c935654d8d1069f27.1550775950.git.christophe.leroy@c-s.fr>
X-Yow: ...It's REAL ROUND.. And it's got a POINTY PART right in the MIDDLE!!
 The shape is SMOOTH..  ..And COLD.. It feels very COMFORTABLE on my
 CHEEK..  I'm getting EMOTIONAL..
Date: Sat, 15 Jun 2019 14:47:29 +0200
In-Reply-To: <1e412310cc18ea654fb2ce4c935654d8d1069f27.1550775950.git.christophe.leroy@c-s.fr>
 (Christophe Leroy's message of "Thu, 21 Feb 2019 19:08:49 +0000
 (UTC)")
Message-ID: <8736kb9fry.fsf_-_@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

If STRICT_KERNEL_RWX is disabled, never use the MMU to mark initmen
nonexecutable.

Also move a misplaced paren that makes the condition always true.

Fixes: 63b2bc619565 ("powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX")
Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/powerpc/mm/pgtable_32.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index d53188dee18f..3935dc263d65 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -360,9 +360,11 @@ void mark_initmem_nx(void)
 	unsigned long numpages = PFN_UP((unsigned long)_einittext) -
 				 PFN_DOWN((unsigned long)_sinittext);
 
-	if (v_block_mapped((unsigned long)_stext) + 1)
+#ifdef CONFIG_STRICT_KERNEL_RWX
+	if (v_block_mapped((unsigned long)_stext + 1))
 		mmu_mark_initmem_nx();
 	else
+#endif
 		change_page_attr(page, numpages, PAGE_KERNEL);
 }
 
-- 
2.22.0

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
