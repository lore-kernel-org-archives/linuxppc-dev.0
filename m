Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A383AC64EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 17:33:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A6C2084D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 17:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A6C2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42R0N8007kzF3RN
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 03:33:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=embeddedor.com
 (client-ip=192.185.47.168; helo=gateway22.websitewelcome.com;
 envelope-from=gustavo@embeddedor.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=embeddedor.com
X-Greylist: delayed 1225 seconds by postgrey-1.36 at bilbo;
 Fri, 05 Oct 2018 03:31:16 AEST
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com
 [192.185.47.168])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42R0Kw6nRjzF3Lc
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 03:31:16 +1000 (AEST)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
 by gateway22.websitewelcome.com (Postfix) with ESMTP id 4A2B127B67
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 12:10:42 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id 8798gE6BlBcCX8798gYLsM; Thu, 04 Oct 2018 12:10:42 -0500
X-Authority-Reason: nr=8
Received: from 174.206.93.92.rev.sfr.net ([92.93.206.174]:54470
 helo=embeddedor) by gator4166.hostgator.com with esmtpa (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1g8796-000CXX-UB; Thu, 04 Oct 2018 12:10:41 -0500
Date: Thu, 4 Oct 2018 19:10:36 +0200
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/xmon/ppc-opc: Use ARRAY_SIZE macro
Message-ID: <20181004171036.GA1907@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.ozlabs.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 92.93.206.174
X-Source-L: No
X-Exim-ID: 1g8796-000CXX-UB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 174.206.93.92.rev.sfr.net (embeddedor) [92.93.206.174]:54470
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/powerpc/xmon/ppc-opc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/xmon/ppc-opc.c b/arch/powerpc/xmon/ppc-opc.c
index ac2b55b..f3f57a1 100644
--- a/arch/powerpc/xmon/ppc-opc.c
+++ b/arch/powerpc/xmon/ppc-opc.c
@@ -966,8 +966,7 @@ const struct powerpc_operand powerpc_operands[] =
   { 0xff, 11, NULL, NULL, PPC_OPERAND_SIGNOPT },
 };
 
-const unsigned int num_powerpc_operands = (sizeof (powerpc_operands)
-					   / sizeof (powerpc_operands[0]));
+const unsigned int num_powerpc_operands = ARRAY_SIZE(powerpc_operands);
 
 /* The functions used to insert and extract complicated operands.  */
 
@@ -6980,8 +6979,7 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 {"fcfidu.",	XRC(63,974,1),	XRA_MASK, POWER7|PPCA2,	PPCVLE,		{FRT, FRB}},
 };
 
-const int powerpc_num_opcodes =
-  sizeof (powerpc_opcodes) / sizeof (powerpc_opcodes[0]);
+const int powerpc_num_opcodes = ARRAY_SIZE(powerpc_opcodes);
 
 /* The VLE opcode table.
 
@@ -7219,8 +7217,7 @@ const struct powerpc_opcode vle_opcodes[] = {
 {"se_bl",	BD8(58,0,1),	BD8_MASK,	PPCVLE,	0,		{B8}},
 };
 
-const int vle_num_opcodes =
-  sizeof (vle_opcodes) / sizeof (vle_opcodes[0]);
+const int vle_num_opcodes = ARRAY_SIZE(vle_opcodes);
 
 /* The macro table.  This is only used by the assembler.  */
 
@@ -7288,5 +7285,4 @@ const struct powerpc_macro powerpc_macros[] = {
 {"e_clrlslwi",4, PPCVLE, "e_rlwinm %0,%1,%3,(%2)-(%3),31-(%3)"},
 };
 
-const int powerpc_num_macros =
-  sizeof (powerpc_macros) / sizeof (powerpc_macros[0]);
+const int powerpc_num_macros = ARRAY_SIZE(powerpc_macros);
-- 
2.7.4

