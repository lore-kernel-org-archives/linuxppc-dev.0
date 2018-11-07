Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0F7C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 19:10:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239DC20837
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 19:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/T8JXuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239DC20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qwxC6DFszF3L2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 06:10:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X/T8JXuE";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="X/T8JXuE"; 
 dkim-atps=neutral
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qwtg3zjZzF3Fx
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 06:08:40 +1100 (AEDT)
Received: by mail-ot1-x341.google.com with SMTP id f24so15797502otl.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Nov 2018 11:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uRN91ZbCBAOCJszsLQvkCl+4ufByNRJk7q4qv3voVxU=;
 b=X/T8JXuEYlTh/KrhQ1i6ohr1rkweju6mkXCEZ0dbcNyUtzX2G9y2OlZloqanHe63TR
 GGAq0a/EPGr7ymtvo3XvGYtquESNfROK+SVM2zIymbKGIDh8YpcB+PJB7LWfoapQqyR7
 Kzz4QSrK1yOTy+43WSaOfDajuRAdRies9QyMfQEptaNA1SU214YpmBGFBTVEsNArjxFe
 No3lm0tcpzzUym5ESO2XCnAmxBmV2QRDz+tMkVZU9phH+KUh638NY3JUkTSa/krEKOwV
 FPIXEEyYXUNj8+8eeA7rbWcSMFZNjPfarPAAH06AzHRTm5Jq0CnfBsJquJN9zI9x0beg
 o2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uRN91ZbCBAOCJszsLQvkCl+4ufByNRJk7q4qv3voVxU=;
 b=l9TUgq6BFX29Sdb1bht6xSi5EzBZOU++MsOAJgskzDqXQX47A0niThN2FXEGWRZWBH
 pBbgahIdUtkagvIBbluxut09jSVy76ObQqzKnT2PbAgu+TB/PvZPxCwRWVJi1TKq7G4s
 aZIJx/MF03Yp8HPpFi4COIUVd2cGOrJ/2l8Sy5lZmKo0UdtzRDFYTZxgU01Z7SI9ewlN
 7CMzD2FJUaUfxA8Jwg25jPcAA4eXj856DEeDnKlToOsAcMgFlkLAcVhH9wKv3blltVe7
 Fxm3CJjqAxDjpPErQUs6UV2t/zL8xfNW7JArw8oMFRP6MWLKnHpSAqdFHbBWHxo4fmbT
 74lA==
X-Gm-Message-State: AGRZ1gLxevvwoafvBWvE++z7AjZEyXC4FYhrDLdVT3koePILw+IfztO3
 goMGvllBu6oKKHkwLuBB+n4UBx8sypaEFqniD/Y=
X-Google-Smtp-Source: AJdET5cC7OADQ1n5J7/6GgO7+8k9M7exFR8LTaEffv3CwpQ4zrFnRAQeIvfCsAjeMWPQR0WOCFpHJd5/Jls9Z/HOdL0=
X-Received: by 2002:a9d:7285:: with SMTP id t5mr966703otj.228.1541617718129;
 Wed, 07 Nov 2018 11:08:38 -0800 (PST)
MIME-Version: 1.0
References: <20181105143730.6071-1-tiny.windzz@gmail.com>
In-Reply-To: <20181105143730.6071-1-tiny.windzz@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 7 Nov 2018 17:08:28 -0200
Message-ID: <CAOMZO5C+TSGY4wJmZbMW7rVSp4RKcXLH90Em3D5LxZTP-W00Xw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: Change to use
 DEFINE_SHOW_ATTRIBUTE macro
To: tiny.windzz@gmail.com
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, timur@kernel.org,
 Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 7, 2018 at 4:57 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
