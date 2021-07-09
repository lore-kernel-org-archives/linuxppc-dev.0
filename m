Return-Path: <SRS0=Utub=MB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25407C07E99
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Jul 2021 18:47:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CC7360238
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Jul 2021 18:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC7360238
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GM2Fy3P5Sz3bnR
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Jul 2021 04:47:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
X-Greylist: delayed 1178 seconds by postgrey-1.36 at boromir;
 Sat, 10 Jul 2021 04:46:56 AEST
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GM2FX0wRvz2xdM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Jul 2021 04:46:55 +1000 (AEST)
Received: from [2601:449:8480:af0::97c7]
 by baldur.buserror.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <oss@buserror.net>)
 id 1m1vCw-0005iy-9K; Fri, 09 Jul 2021 13:26:38 -0500
Message-ID: <3a17e91259b4f7538530ab652eb2a72fddbbc170.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Paul Gortmaker <paul.gortmaker@windriver.com>, 
 linuxppc-dev@lists.ozlabs.org
Date: Fri, 09 Jul 2021 13:26:36 -0500
In-Reply-To: <20210111082823.99562-1-paul.gortmaker@windriver.com>
References: <20210111082823.99562-1-paul.gortmaker@windriver.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0::97c7
X-SA-Exim-Rcpt-To: paul.gortmaker@windriver.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 paulus@samba.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH 0/3] Retire remaining WindRiver embedded SBC BSPs
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
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2021-01-11 at 03:28 -0500, Paul Gortmaker wrote:
> In v2.6.27 (2008, 917f0af9e5a9) the sbc8260 support was implicitly
> retired by not being carried forward through the ppc --> powerpc
> device tree transition.
> 
> Then, in v3.6 (2012, b048b4e17cbb) we retired the support for the
> sbc8560 boards.
> 
> Next, in v4.18 (2017, 3bc6cf5a86e5) we retired the support for the
> 2006 vintage sbc834x boards.
> 
> The sbc8548 and sbc8641d boards were maybe 1-2 years newer than the
> sbc834x boards, but it is also 3+ years later, so it makes sense to
> now retire them as well - which is what is done here.
> 
> These two remaining WR boards were based on the Freescale MPC8548-CDS
> and the MPC8641D-HPCN reference board implementations.  Having had the
> chance to use these and many other Fsl ref boards, I know this:  The
> Freescale reference boards were typically produced in limited quantity
> and primarily available to BSP developers and hardware designers, and
> not likely to have found a 2nd life with hobbyists and/or collectors.
> 
> It was good to have that BSP code subjected to mainline review and
> hence also widely available back in the day. But given the above, we
> should probably also be giving serious consideration to retiring
> additional similar age/type reference board platforms as well.
> 
> I've always felt it is important for us to be proactive in retiring
> old code, since it has a genuine non-zero carrying cost, as described
> in the 930d52c012b8 merge log.  But for the here and now, we just
> clean up the remaining BSP code that I had added for SBC platforms.

Acked-by: Scott Wood <oss@buserror.net>

-Scott


