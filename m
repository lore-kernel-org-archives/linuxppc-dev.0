Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD0BC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 00:56:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25E720659
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 00:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AWbsrqSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25E720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dsNS28KdzDqXG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 11:56:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zx2c4.com
 (client-ip=192.95.5.64; helo=frisell.zx2c4.com; envelope-from=jason@zx2c4.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=zx2c4.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.b="AWbsrqSC"; 
 dkim-atps=neutral
X-Greylist: delayed 397 seconds by postgrey-1.36 at bilbo;
 Tue, 15 Jan 2019 11:54:41 AEDT
Received: from frisell.zx2c4.com (frisell.zx2c4.com [192.95.5.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dsLT2Rr2zDqTm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 11:54:41 +1100 (AEDT)
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 09d0ecfe;
 Tue, 15 Jan 2019 00:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
 :subject:date:message-id:mime-version:content-transfer-encoding;
 s=mail; bh=672UyKEKNu6gN3BZ012tnuPoaAQ=; b=AWbsrqSCvzOY7MG+3xOi
 md7pIUY6hB1/IqC42IAqe3ZNlc8sd4Cmc4/B2Lef9bbxCxcYd+1O1YkZ47HWY12A
 JckiVlccXUGofm35pt77WA6GJOYiohKGyrebfioVF8IOcaUSyKm0F5Ntjfn0Fj+T
 EbRxLjjzpBallNOsMcTGKSyC6+fhe/FBgGpO/aZZHDFzunWRvjExLcf2/wcI5bc/
 AF31t9tknfqXXJfA983ptNX5uFHagE+fNi+0FJerYhnfs1MJJTfBw0dgw9ECdEeO
 XGZyGRNemGP7XTI0+q9PaZBWOeymNfZ4XaCjTYwTO6FB1iQF5KJKHAPKzD66UIdw
 9Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e163c3bc
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO); 
 Tue, 15 Jan 2019 00:34:44 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: PCI does not require PowerNV
Date: Mon, 14 Jan 2019 16:47:45 -0800
Message-Id: <20190115004745.9996-1-Jason@zx2c4.com>
MIME-Version: 1.0
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit 0e759bd75285 moved around the declaration of pnv_npu2_init, but
did not conditionalize it inside of the PCI pSeries driver. This meant
that CONFIG_PCI && CONFIG_PPC_PSERIES && !CONFIG_PPC_POWERNV resulted
in:

powerpc64le-pc-linux-gnu-ld: arch/powerpc/platforms/pseries/pci.o: in function `pSeries_final_fixup':
pci.c:(.init.text+0x1b0): undefined reference to `pnv_npu2_init'

This commit therefore wraps that line in an ifdef, so that PCI works
without PowerNV.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Fixes: 0e759bd75285 ("powerpc/powernv/npu: Move OPAL calls away from context manipulation")
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 7725825d887d..37a77e57893e 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -264,7 +264,9 @@ void __init pSeries_final_fixup(void)
 			if (!of_device_is_compatible(nvdn->parent,
 						"ibm,power9-npu"))
 				continue;
+#ifdef CONFIG_PPC_POWERNV
 			WARN_ON_ONCE(pnv_npu2_init(hose));
+#endif
 			break;
 		}
 	}
-- 
2.20.1

