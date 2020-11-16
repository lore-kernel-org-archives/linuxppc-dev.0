Return-Path: <SRS0=L4jv=EW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BD6C4742C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2020 20:46:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56AE2222E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2020 20:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56AE2222E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CZh1w0sc9zDqQQ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2020 07:46:28 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CZgzG4DxfzDqFS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2020 07:44:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4CZgzG2lcJz8tVv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2020 07:44:10 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4CZgzG2Kw4z9sT6; Tue, 17 Nov 2020 07:44:10 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
X-Greylist: delayed 1009 seconds by postgrey-1.36 at bilbo;
 Tue, 17 Nov 2020 07:44:10 AEDT
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4CZgzG0cjWz9sSs;
 Tue, 17 Nov 2020 07:44:09 +1100 (AEDT)
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <oss@buserror.net>)
 id 1kel5G-0005re-V4; Mon, 16 Nov 2020 14:26:44 -0600
Message-ID: <8b23cec8b7b490ec8ef578cbd2fe4316288d4e13.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Date: Mon, 16 Nov 2020 14:26:40 -0600
In-Reply-To: <20201116120913.165317-1-mpe@ellerman.id.au>
References: <20201116120913.165317-1-mpe@ellerman.id.au>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: mpe@ellerman.id.au, linuxppc-dev@ozlabs.org,
 christophe.leroy@csgroup.eu, segher@kernel.crashing.org,
 linux-kernel@vger.kernel.org, ndesaulniers@google.com,
 natechancellor@gmail.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH] powerpc: Drop -me200 addition to build flags
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
Cc: natechancellor@gmail.com, ndesaulniers@google.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2020-11-16 at 23:09 +1100, Michael Ellerman wrote:
> Currently a build with CONFIG_E200=y will fail with:
> 
>   Error: invalid switch -me200
>   Error: unrecognized option -me200
> 
> Upstream binutils has never supported an -me200 option. Presumably it
> was supported at some point by either a fork or Freescale internal
> binutils.
> 
> We can't support code that we can't even build test, so drop the
> addition of -me200 to the build flags, so we can at least build with
> CONFIG_E200=y.
> 
> Reported-by: Németh Márton <nm127@freemail.hu>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
> 
> More discussion: 
> https://lore.kernel.org/lkml/202011131146.g8dPLQDD-lkp@intel.com
> ---
>  arch/powerpc/Makefile | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Scott Wood <oss@buserror.net>

I'd go further and remove E200 code entirely, unless someone with the hardware
can claim that it actually works.  There doesn't appear to be any actual
platform support for an e200-based system.  It seems to be a long-abandoned
work in progress.

-Scott


