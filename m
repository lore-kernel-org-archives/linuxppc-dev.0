Return-Path: <SRS0=3GPV=CK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A19C433E2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 01:58:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF4A02098B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 01:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4A02098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BgVb95tCZzDqCl
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 11:58:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gondor.apana.org.au (client-ip=216.24.177.18;
 helo=fornost.hmeau.com; envelope-from=herbert@gondor.apana.org.au;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gondor.apana.org.au
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BgVYM5rzNzDqVK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2020 11:56:39 +1000 (AEST)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
 by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
 id 1kCvXC-0000rP-Eo; Tue, 01 Sep 2020 11:56:31 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation);
 Tue, 01 Sep 2020 11:56:30 +1000
Date: Tue, 1 Sep 2020 11:56:30 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH] soc: fsl: Remove bogus packed attributes from qman.h
Message-ID: <20200901015630.GA9065@gondor.apana.org.au>
References: <20200730125259.GA8948@gondor.apana.org.au>
 <VE1PR04MB6687FB075B9A6A0923F576978F2E0@VE1PR04MB6687.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VE1PR04MB6687FB075B9A6A0923F576978F2E0@VE1PR04MB6687.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Sep 01, 2020 at 01:50:38AM +0000, Leo Li wrote:
>
> Sorry for the late response.  I missed this email previously.
> 
> These structures are descriptors used by hardware, we cannot have _ANY_ padding from the compiler.  The compiled result might be the same with or without the __packed attribute for now, but I think keep it there probably is safer for dealing with unexpected alignment requirements from the compiler in the future.
> 
> Having conflicting alignment requirements warning might means something is wrong with the structure in certain scenario.  I just tried a ARM64 build but didn't see the warnings.  Could you share the warning you got and the build setup?  Thanks.

Just do a COMPILE_TEST build on x86-64:

In file included from ../drivers/crypto/caam/qi.c:12:
../include/soc/fsl/qman.h:259:1: warning: alignment 1 of ‘struct qm_dqrr_entry’ is less than 8 [-Wpacked-not-aligned]
 } __packed;
 ^
../include/soc/fsl/qman.h:292:2: warning: alignment 1 of ‘struct <anonymous>’ is less than 8 [-Wpacked-not-aligned]
  } __packed ern;
  ^

In any case, those packed markers are completely unnecessary because
those structs contain no holes.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
