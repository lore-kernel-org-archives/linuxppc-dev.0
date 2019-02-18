Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89D0C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 08:05:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9032070D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 08:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOgb3gNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9032070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 442xHh0CsmzDqJX
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 19:05:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=7u7d=qz=linuxfoundation.org=gregkh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="NOgb3gNf"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 442xFy5DdWzDq63
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 19:03:50 +1100 (AEDT)
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 615F1208E4;
 Mon, 18 Feb 2019 08:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550477027;
 bh=UFFNvEjQe5Mm9bYLU/zLEHwbFkDQItQS2xnR4t/LxiA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NOgb3gNfzJ0arVg+jSCFHtBYqsgF7vHtfT42AGZQXiA0GILSpYvygynY4I4t+69fK
 eoHFS6SjISifMpaVLIV0WeO40RwrrAk0mzQK7bPamKQcrL89GLZpL1W3oglEOuT6y6
 4RCCgnEPq2MEzJ2xO4YtV4FaGJL5W7/8zKgGD1kM=
Date: Mon, 18 Feb 2019 09:03:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V2] ASoC: fsl_esai: fix register setting issue in RIGHT_J
 mode
Message-ID: <20190218080345.GA27289@kroah.com>
References: <2a1997c2cd213ebfde70a2b325644de51e77d159.1550455620.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a1997c2cd213ebfde70a2b325644de51e77d159.1550455620.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 18, 2019 at 02:08:52AM +0000, S.j. Wang wrote:
> Fixes commit 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
> 
> The ESAI_xCR_xWA is xCR's bit, not the xCCR's bit, driver set it to
> wrong register, correct it.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Ackedy-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Changes in v2
> - add Fixes tag and cc stable kernel.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
