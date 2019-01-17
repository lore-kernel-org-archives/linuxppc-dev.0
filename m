Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D9CC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 11:05:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF77620657
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 11:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="unknown key hash" (0-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="sgL9q/z4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF77620657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gLpF5vFHzDqrs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 22:05:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="sgL9q/z4"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gLgy23cyzDqkb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 21:59:58 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43gLgs5DSBz9v2C1;
 Thu, 17 Jan 2019 11:59:53 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=sgL9q/z4; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id dY3GDlVabaBu; Thu, 17 Jan 2019 11:59:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43gLgs41Psz9v2By;
 Thu, 17 Jan 2019 11:59:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1547722793; bh=bCzDoKXfQUOk8+dp/9F7V6/4S9bkDV/4QQa9kOcF0rw=;
 h=From:Subject:To:Cc:Date:From;
 b=sgL9q/z46bGcBiyFkBtl28Nz8YopNnn0jVHHpOnGTKRUeh4VUquSaNDw/qxUzN+iG
 3iPhL1pCbRcr/dX5eRF1OK7nxq5CkoBpTanQ5uFJlzDAmLEYOpvDqHDzpfifFIGPvy
 WK4u/BOY4jtnyQNCigB3FnecHhkSBg4W6paGtMvg=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B03DA8B858;
 Thu, 17 Jan 2019 11:59:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ZYyDY2pIAeGp; Thu, 17 Jan 2019 11:59:54 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 868008B75B;
 Thu, 17 Jan 2019 11:59:54 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 302B971884; Thu, 17 Jan 2019 10:59:54 +0000 (UTC)
Message-Id: <029eb2f45a8b964ce82118044912a39679fac592.1547680951.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/wii: properly disable use of BATs when requested.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 17 Jan 2019 10:59:54 +0000 (UTC)
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

'nobats' kernel parameter or some options like CONFIG_DEBUG_PAGEALLOC
deny the use of BATS for mapping memory.

This patch makes sure that the specific wii RAM mapping function
takes it into account as well.

Fixes: de32400dd26e ("wii: use both mem1 and mem2 as ram")
Cc: stable@vger.kernel.org
Reviewed-by: Jonathan Neuschafer <j.neuschaefer@gmx.net>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/embedded6xx/wii.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index ecf703ee3a76..ac4ee88efc80 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -83,6 +83,10 @@ unsigned long __init wii_mmu_mapin_mem2(unsigned long top)
 	/* MEM2 64MB@0x10000000 */
 	delta = wii_hole_start + wii_hole_size;
 	size = top - delta;
+
+	if (__map_without_bats)
+		return delta;
+
 	for (bl = 128<<10; bl < max_size; bl <<= 1) {
 		if (bl * 2 > size)
 			break;
-- 
2.13.3

