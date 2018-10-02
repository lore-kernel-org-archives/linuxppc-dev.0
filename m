Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248E4C64EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 22:35:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E372082A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 22:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E372082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PvBL6MyVzF39h
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 08:35:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=nefkom.net
 (client-ip=212.18.0.10; helo=mail-out.m-online.net;
 envelope-from=whitebox@nefkom.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Pv894Bz6zF38k
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 08:34:01 +1000 (AEST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 42Pv8032WVz1qvP2;
 Wed,  3 Oct 2018 00:33:52 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 42Pv802Vb1z1qr2S;
 Wed,  3 Oct 2018 00:33:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id WMSSTt_iXL9X; Wed,  3 Oct 2018 00:33:51 +0200 (CEST)
X-Auth-Info: JH6ix0ag7TxVuWVGzXImrsHIpauu2X50qC+QE7r/RWqaF+WH5NrrWAC4EQR6VTGM
Received: from igel.home (ppp-188-174-146-232.dynamic.mnet-online.de
 [188.174.146.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Wed,  3 Oct 2018 00:33:51 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
 id 206E22C1291; Wed,  3 Oct 2018 00:33:51 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michael Neuling <mikey@neuling.org>
Subject: [PATCH] powerpc: use PTRRELOC during early init
References: <20180914011411.3184-1-mikey__14553.8904158913$1536887645$gmane$org@neuling.org>
 <871s98av6p.fsf__4781.35763337395$1538516654$gmane$org@igel.home>
X-Yow: You must be a CUB SCOUT!!  Have you made your MONEY-DROP today??
Date: Wed, 03 Oct 2018 00:33:51 +0200
In-Reply-To: <871s98av6p.fsf__4781.35763337395$1538516654$gmane$org@igel.home>
 (Andreas Schwab's message of "Tue, 02 Oct 2018 23:35:26 +0200")
Message-ID: <87wor09dww.fsf_-_@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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
Cc: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Haren Myneni <haren@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This fixes a crash on powerpc32 when using global data during early init
without relocating its address.

Fixes: 51c3c62b58 (powerpc: Avoid code patching freed init sections)
Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/powerpc/lib/code-patching.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 6ae2777c22..6192fdae36 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -29,7 +29,7 @@ static int __patch_instruction(unsigned int *exec_addr, unsigned int instr,
 	int err;
 
 	/* Make sure we aren't patching a freed init section */
-	if (init_mem_is_free && init_section_contains(exec_addr, 4)) {
+	if (*PTRRELOC(&init_mem_is_free) && init_section_contains(exec_addr, 4)) {
 		pr_debug("Skipping init section patching addr: 0x%px\n", exec_addr);
 		return 0;
 	}
-- 
2.19.0

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
