Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F80C43612
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 16:46:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C7312054F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 16:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="unknown key hash" (0-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="o8e3a8Xq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7312054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fGSh35LMzDqcp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 03:46:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="unknown key hash" (0-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="o8e3a8Xq"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fGP84wBWzDqYY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 03:43:24 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43fGP26dNgz9v32Z;
 Tue, 15 Jan 2019 17:43:18 +0100 (CET)
Authentication-Results: localhost; dkim=permerror reason="key not found"
 header.d=c-s.fr header.i=@c-s.fr header.b=o8e3a8Xq;
 dkim-adsp=none (insecure policy); dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ile8fyrvyRzt; Tue, 15 Jan 2019 17:43:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43fGP25PlBz9v31t;
 Tue, 15 Jan 2019 17:43:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1547570598; bh=5QyCPAYAmEi2GyrPtZZsKMC5EzZwEenGzCQF0xDMLWY=;
 h=From:Subject:To:Cc:Date:From;
 b=o8e3a8XqXlZ7hK93MIyku66Ncx/8/8SqrPIpcbjQ6jSNb06bCbLyz3VAYyLjoIuR4
 SrLv71Rq3r5iumWGUpQztzFGnhdlOSS/Ovr+GcL08Qtl24qi5z1bpL2VqScEqePW1+
 vneZMiUYB2qaN3uhr8flkVRsHFie7qHEmj/EqUCnrDtIHppAdkfRj8PzI6tEcMkGbf
 ObAzjKfRHGZktNy7IobDc2H+lOxgEyzFesqNCrNLIHGijviBkVDa27DAoB/La2dNYD
 tVQfkRyGdUbx4fftOKbtiQ/fGDSvSb2pi/CYsK88nEyMUvlULwTZcBhOrsNTUPghYZ
 9l8JZQhyJudPzKiCIGXsGGjCj2GXmha7QWDnhEB2jNgxa0R5ENf1VfHMY6SVpBmRqA
 EanvOlmQYhMCdIwSlZRJhnw6anNFHvZhHW/0BXz2Yy2V0bv1xPAGmlhq6h/X+2j9+6
 MGYxSgqmFMqtkqqbUSUr3BmdYIo35WWO1Qma/iqzU1r26sahSWHp4rBtD1DcH+hxSz
 8FSb18vXN4dSZj01JayVDsgUAqYIVpNl0bLizrM018G4ydkQ7R7IZDrsUifRm6OzgM
 y5ihRTC2ZO96K5tsDsPJQ7hlRgowkRNgyIoW2xDv5D+M4HOO7KE408YOmLoNjF9vC5
 JEPY/r7nGUc6N4bjBXIYZGhg=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DBFE08B7FC;
 Tue, 15 Jan 2019 17:43:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id fMV1USwImGwU; Tue, 15 Jan 2019 17:43:20 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id ACF378B7EE;
 Tue, 15 Jan 2019 17:43:20 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 602D771877; Tue, 15 Jan 2019 16:43:20 +0000 (UTC)
Message-Id:
 <7e6748349978f4f177b6a1f3f1c773da98ae3b59.1547570012.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RESENDING PATCH] powerpc/wii: properly disable use of BATs when
 requested.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Jonathan Neuschafer" <j.neuschaefer@gmx.net>
Date: Tue, 15 Jan 2019 16:43:20 +0000 (UTC)
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
 stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
Message-ID: <20190115164320.pTxSfNyIGP4XyNsIjfj8Y8mwvtXoitY1sR9IKWFFlQc@z>

'nobats' kernel parameter or some options like CONFIG_DEBUG_PAGEALLOC
deny the use of BATS for mapping memory.

This patch makes sure that the specific wii RAM mapping function
takes it into account as well.

Fixes: de32400dd26e ("wii: use both mem1 and mem2 as ram")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 Resending due to some servers not accepting 'umlaut' on Jonathan's family name. Sorry Jonathan.

<linux-kernel@vger.kernel.org>: host vger.kernel.org[209.132.180.67] said: 550
    5.7.1 Content-Policy reject msg: Message headers can not have 8-bit
    non-ASCII characters in it; Use MIME encodings if such are needed!  BF:<H
    1.16368e-10>; S1729557AbfAOQgb (in reply to end of DATA command)

<stable@vger.kernel.org>: host vger.kernel.org[209.132.180.67] said: 550 5.7.1
    Content-Policy reject msg: Message headers can not have 8-bit non-ASCII
    characters in it; Use MIME encodings if such are needed!  BF:<H
    1.16368e-10>; S1729557AbfAOQgb (in reply to end of DATA command)

 arch/powerpc/platforms/embedded6xx/wii.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index ecf703ee3a76..bae843e32ae7 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -82,6 +82,9 @@ unsigned long __init wii_mmu_mapin_mem2(unsigned long top)
 
 	/* MEM2 64MB@0x10000000 */
 	delta = wii_hole_start + wii_hole_size;
+	if (__map_without_bats)
+		return delta;
+
 	size = top - delta;
 	for (bl = 128<<10; bl < max_size; bl <<= 1) {
 		if (bl * 2 > size)
-- 
2.13.3

