Return-Path: <SRS0=ex+5=VV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72597C7618B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jul 2019 05:43:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D177218DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jul 2019 05:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="I55v5zkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D177218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45tklT36y7zDqNy
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jul 2019 15:43:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=alliedtelesis.co.nz
 (client-ip=2001:df5:b000:5::4; helo=gate2.alliedtelesis.co.nz;
 envelope-from=chrisp@alliedtelesis.co.nz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz
 header.b="I55v5zkK"; dkim-atps=neutral
X-Greylist: delayed 487 seconds by postgrey-1.36 at bilbo;
 Wed, 24 Jul 2019 15:41:24 AEST
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45tkjc19hKzDq9n
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2019 15:41:23 +1000 (AEST)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E69EB886BF;
 Wed, 24 Jul 2019 17:33:09 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1563946389;
 bh=71Rx6cCCs7qwdXOcWJ2dX8HzbvMLtmT5IE+C0SKNRpM=;
 h=From:To:Cc:Subject:Date;
 b=I55v5zkKt8WmSCKGYp7dbfii+9DNNJ86YwZb+AaKe4W2vfEvmJCaIG04aYXMCQ6Bg
 bXOADORYfzY+5EmwrIpVVyDLo847rlXNwYp0BxoNkwYI6g1aA+CjNmc3CJd7cVlDPg
 XyDth2LADhGxgVH+/HVmBf9J6rC6d+bqg1s/47C9dQ422N5Qx8H7lQKhg7US/ax3Fv
 JCyTrGoYLEUeMb3/LxXEHE/R1cxFQIm3V5lvj0vG2KPgJvUbug94i/T2iKQLTPzm5F
 aYeebnyHLK5PbzTzdb/Ok5GRYIfJHwjb8UN6fGBcu4xHDN/kSss0fi44qW+Z6x6AOk
 N/xUQd27v0WLA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with
 Trustwave SEG (v7, 5, 8, 10121)
 id <B5d37ed910000>; Wed, 24 Jul 2019 17:33:09 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
 by smtp (Postfix) with ESMTP id 76A6713EECE;
 Wed, 24 Jul 2019 17:33:07 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
 id 605181E04FD; Wed, 24 Jul 2019 17:33:05 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH] powerpc: Support CMDLINE_EXTEND
Date: Wed, 24 Jul 2019 17:33:03 +1200
Message-Id: <20190724053303.24317-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
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
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Device tree aware platforms can make use of CMDLINE_EXTEND to extend the
kernel command line provided by the bootloader. This is particularly
useful to set parameters for built-in modules that would otherwise be
done at module insertion. Add support for this in the powerpc
architecture.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/powerpc/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d8dcd8820369..cd9b3974aa36 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -851,6 +851,11 @@ config CMDLINE
 	  some command-line options at build time by entering them here.  In
 	  most cases you will need to specify the root device here.
=20
+choice
+	prompt "Kernel command line type" if CMDLINE !=3D ""
+	default CMDLINE_FORCE
+	depends on CMDLINE_BOOL
+
 config CMDLINE_FORCE
 	bool "Always use the default kernel command string"
 	depends on CMDLINE_BOOL
@@ -860,6 +865,13 @@ config CMDLINE_FORCE
 	  This is useful if you cannot or don't want to change the
 	  command-line options your boot loader passes to the kernel.
=20
+config CMDLINE_EXTEND
+	bool "Extend bootloader kernel arguments"
+	help
+	  The command-line arguments provided by the boot loader will be
+	  appended to the default kernel command string.
+endchoice
+
 config EXTRA_TARGETS
 	string "Additional default image types"
 	help
--=20
2.22.0

