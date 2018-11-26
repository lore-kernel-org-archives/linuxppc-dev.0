Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D338CC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 22:04:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B9620873
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 22:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="nwJmCDkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B9620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433gtc5KxszDqc8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 09:04:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="nwJmCDkZ";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433gqp3cMzzDqbk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 09:01:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="nwJmCDkZ"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 433gqp29dpz9s3C; Tue, 27 Nov 2018 09:01:58 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 433gqp1Cznz9s3l; Tue, 27 Nov 2018 09:01:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1543269718; bh=+L3eMjyB4UIEb4sysLWKuotwJnuF7j+4eZRcjem15w0=;
 h=Date:From:To:Subject:From;
 b=nwJmCDkZ+1FCv7oJ42hLU/fOtO4DAYD5X0KrzH0KGu2FS4uLSTE7En+Iu7yFPHSNt
 lXcVl1i4wRlGwc2zLsHpiR1KM1LuOMX9YOGyiBZa0Dcj+VMI/U176iIVJCnDxqXgkg
 fZ2ysnGvYyqI997eDevwBXNId7+N5XWnbSoWngm8UYuR9gw0BII7exZJnEuXcVwTsG
 ltHuFK4sOguWQBPpdURcv03D022QfVVCGm41+9NnH/Xqo5/qi6Ojuza11DD3qt9MgG
 h2hBFzIHat67txzw1HDpWEqLU0/+AeR8d4IK9QoOYSZeHbhHapbBXcp2LPndgR2u90
 BXmlBdPf99SiQ==
Date: Tue, 27 Nov 2018 09:01:54 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix COFF zImage booting on old powermacs
Message-ID: <20181126220154.GA17244@blackberry>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit 6975a783d7b4 ("powerpc/boot: Allow building the zImage wrapper
as a relocatable ET_DYN", 2011-04-12) changed the procedure descriptor
at the start of crt0.S to have a hard-coded start address of 0x500000
rather than a reference to _zimage_start, presumably because having
a reference to a symbol introduced a relocation which is awkward to
handle in a position-independent executable.  Unfortunately, what is
at 0x500000 in the COFF image is not the first instruction, but the
procedure descriptor itself, that is, a word containing 0x500000,
which is not a valid instruction.  Hence, booting a COFF zImage
results in a "DEFAULT CATCH!, code=FFF00700" message from Open
Firmware.

This fixes the problem by (a) putting the procedure descriptor in the
data section and (b) adding a branch to _zimage_start as the first
instruction in the program.

Fixes: 6975a783d7b4 ("powerpc/boot: Allow building the zImage wrapper as a relocatable ET_DYN")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/boot/crt0.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
index 32dfe6d..9b9d174 100644
--- a/arch/powerpc/boot/crt0.S
+++ b/arch/powerpc/boot/crt0.S
@@ -15,7 +15,7 @@
 RELA = 7
 RELACOUNT = 0x6ffffff9
 
-	.text
+	.data
 	/* A procedure descriptor used when booting this as a COFF file.
 	 * When making COFF, this comes first in the link and we're
 	 * linked at 0x500000.
@@ -23,6 +23,8 @@ RELACOUNT = 0x6ffffff9
 	.globl	_zimage_start_opd
 _zimage_start_opd:
 	.long	0x500000, 0, 0, 0
+	.text
+	b	_zimage_start
 
 #ifdef __powerpc64__
 .balign 8
-- 
2.7.4

