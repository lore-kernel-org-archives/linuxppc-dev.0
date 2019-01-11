Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E38C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 03:27:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3AA2084C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 03:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qnptbl+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3AA2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bSx44YQ8zDr0P
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 14:27:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.74; helo=conuserg-07.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="qnptbl+C"; 
 dkim-atps=neutral
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bSqy4X4hzDqyc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 14:23:26 +1100 (AEDT)
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id x0B3MdXb025916;
 Fri, 11 Jan 2019 12:22:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x0B3MdXb025916
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1547176960;
 bh=dHVdZkiaMCF0q2pQX0sg3OgZLXbLHfQrNIEcJS2+HS4=;
 h=From:To:Cc:Subject:Date:From;
 b=qnptbl+C1jaGrWvepQmh+NmhMRCUtbfFF6zUx4HcBIGJjrkXLqxe7U+AC0m0hXKMx
 LbaVO+dn1JclfM15kkRvwJOyx4sGBiJnN6VUKQlT5X3bb6DRGfDR/Rf/DWInKgEIIH
 EG8unbM4W1QacNMCNwvZWjoKnes5cnNDQBd57nRPHlhNWhCbrtc8yTyj4Eju7hSL7T
 YAWSDi1HT1orjal/Z5J877vNp4PAeSYIinFKUcoR56+7VZH6KZfuj1Eq8mxyzMtK66
 VFT+bL/MeFcku0JiWks8yvTc1OlTqkW9VwGuPwjMh3rvjy2d913K2cSfK608cr57cf
 d0CFFlGLuHtPw==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 0/3] powerpc: some header search path cleanups
Date: Fri, 11 Jan 2019 12:22:30 +0900
Message-Id: <1547176954-17739-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
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
Cc: linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

I am trying to get rid of crappy magic from Kbuild core makefiles.

Before that, I want to drop as many useless paths as possible.
Actually, many Makefiles are adding around pointless options.

This series cleans some powerpc Makefiles.
(only compile-tested by 0day bot)



Masahiro Yamada (3):
  KVM: powerpc: remove -I. header search paths
  powerpc: remove redundant header search path additions
  powerpc: math-emu: remove unneeded header search paths

 arch/powerpc/Makefile          | 4 ++--
 arch/powerpc/kvm/Makefile      | 5 -----
 arch/powerpc/math-emu/Makefile | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)

-- 
2.7.4

