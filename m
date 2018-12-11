Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECF6C67839
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 15:24:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F292C20849
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 15:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJesZVlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F292C20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DkHg6WqCzDqhS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 02:23:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OJesZVlS";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="OJesZVlS"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DkDh2H6JzDqjb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 02:21:23 +1100 (AEDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E020620855
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 15:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544541682;
 bh=MN+FVvQINETTAzbt/6M6OzA7pw/8ygRELcMtNjRkSNE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=OJesZVlS4er7UhlJCLUyoV9gIhNSFBtJ71flK1utj007ehBSezBa7tS3LBzE0p4ZL
 3h3hyjIehcxG2XLEFsI1PNoKlO95FVhQ5kg+ZlUmWKaFTYEfRAHsA/pY+FY62liViP
 X+E5YxM362nwmlnl97kE2y8gzgOcsmTCdikQKdW8=
Received: by mail-qt1-f180.google.com with SMTP id l11so16806913qtp.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 07:21:21 -0800 (PST)
X-Gm-Message-State: AA+aEWZ0MJOnoMRhCPr1cFb2Wb/ajxgJ8BmrOoIaeCIkGEUzaNDGtzo5
 39UMTnjYRDkah4uYRKBuMSbpwJCvNQ/Qeno5pw==
X-Google-Smtp-Source: AFSGD/XFaIYHDTZFTa8PfVID46pmbMMnOQVY1369UWTWxpKlWlUEEIGBsIS7bfvqXeFJzeuGgja/q0HJkT/ANyFJ4gc=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr15996574qtd.257.1544541681127; 
 Tue, 11 Dec 2018 07:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org> <2386212.ILKoqq0Ivo@phil>
 <CAL_JsqL9PyD=0jy+GF5g8ee-FO_ijvArnzEohuvqK5Od3yr7fg@mail.gmail.com>
 <30286035.tdc4tAKEPf@phil>
In-Reply-To: <30286035.tdc4tAKEPf@phil>
From: Rob Herring <robh@kernel.org>
Date: Tue, 11 Dec 2018 09:21:09 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+0+-yzB8mAodaK75Es6RPn=L5SCkFD7wgC-ZxaJtb3mg@mail.gmail.com>
Message-ID: <CAL_Jsq+0+-yzB8mAodaK75Es6RPn=L5SCkFD7wgC-ZxaJtb3mg@mail.gmail.com>
Subject: Re: [PATCH v2.2 24/34] dt-bindings: arm: Convert Rockchip board/soc
 bindings to json-schema
To: "heiko@sntech.de" <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Sean Hudson <darknighte@darknighte.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Grant Likely <grant.likely@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Dec 10, 2018 at 4:45 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> From: Rob Herring <robh@kernel.org>
>
> Convert Rockchip SoC bindings to DT schema format using json-schema.
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> [move to per-board entries and added recently added boards]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Hi Rob,
>
> thanks for the libyaml hint, now dtc does check my dts nicely and
> emits quite a number of little complaints ;-) .
>
> Also that suggestion to move the original firefly release+beta boards
> together was great and I just did that.
>
> Should look ok now, if so I'll apply it tomorrow.

LGTM
