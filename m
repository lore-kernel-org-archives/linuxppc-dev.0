Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B08C43612
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 22:56:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB56214D8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 22:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1js63LF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB56214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Q7cP5FSnzDqLs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 09:56:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="1js63LF4";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="1js63LF4"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Q7Fs2HdszDqLG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2018 09:40:01 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F0C8320651;
 Wed, 26 Dec 2018 22:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545863999;
 bh=RRNvBnYpys4EAY+rpxxBRXnGKnbxB0RqhrmWp3JAn9A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=1js63LF4pv9FHJGZWCX7SZKlvZYOB18x7DlgFkqWdNBCx8Vr8scOXmkTE989EQ5eq
 bHlJEKwFWO0CAwHwHT4RQm7GFGaTXyz/tGcFgVH9s5zCQSTl46u05IQami5SGZCrn3
 Oo2w8y9TGP7mnCrRZEKxZ/nKVn3AmSZVa3bZQUIY=
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 02/59] powerpc: Fix COFF zImage booting on old
 powermacs
Date: Wed, 26 Dec 2018 17:37:42 -0500
Message-Id: <20181226223839.150262-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
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
Cc: linuxppc-dev@lists.ozlabs.org, Sasha Levin <sashal@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Paul Mackerras <paulus@ozlabs.org>

[ Upstream commit 5564597d51c8ff5b88d95c76255e18b13b760879 ]

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
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/boot/crt0.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
index 32dfe6d083f3..9b9d17437373 100644
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
2.19.1

