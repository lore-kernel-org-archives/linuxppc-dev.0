Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82019C64EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 08:04:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5AB0213A2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 08:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo/D3BHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AB0213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qllh4qt0zF3HY
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 18:04:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jo/D3BHu";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=raziebe@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jo/D3BHu"; 
 dkim-atps=neutral
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QlFP21YwzF3Dy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 17:41:28 +1000 (AEST)
Received: by mail-ed1-x52d.google.com with SMTP id h4-v6so7632567edi.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Oct 2018 00:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eatRBR1GuQRHC5k5JXoIdFNcl63R/qBH/dqfVf/lSoY=;
 b=Jo/D3BHuZ7evGO8RZkDqER0nH5GUCUJ3Qa9UoQSb0UpXUiyYCumCO4V7J0UMqPqfdS
 rNsq9bY2TnlXwb66X/VHDjU4M/7gKEoacka46lT1lReG6vbgwyGUnj0QKVbS0Hvt9IZW
 HjFVegBZNqeOLwhl95reZFHwfJkMF3tFt77Ql3pov86/ocoaMrErj/HE6S81CNm8nrrL
 fb+va25xkJNCGrP6dHibaj5YSqAMzCsoxScwc5FiJgALfYFZ/Ye/Kh5jlEgl09ea+sLW
 Gwjh2dbJFBklBqbl76L10bh/qIM9m0pKovobwMTVk1HajGctSmumbtE23DRUKIW0qfSD
 RoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eatRBR1GuQRHC5k5JXoIdFNcl63R/qBH/dqfVf/lSoY=;
 b=qaJXdujkuekEFttWO+ra7+mEkEn2qmvsExBb0UFNyQc5eCML+vWLG08XPHyHy92YUk
 ZNrVOr/zWnSLE6yrHiPPENmVBDiHyK2z6ZEaQE08fN/BDbwL+554484Ia11cGTu/G2Ze
 bhe82vu2NZtI7jWQnIzy0GhUB2PkcCIAq6CFPZq72/w2sIDHwB257h8FBo7arITKfMtY
 l72HAFN1Rt9yRRq8jKOLxz86zDetGjI1+J2+QkWmQckq/Hoz77ErrbQnVq2txIY8mJWU
 evh+poralcvnU47VRfRuyVGFpdKe6MlTecp6GChyDFYYytYV3KhRfklev8+tWMFHptaY
 4sWg==
X-Gm-Message-State: ABuFfoguXvwlV8wWXP4jmg+wlhD5HZFfT9+DD2ly23OaBB9BgFrv7IA5
 zJX5i04NdpcLqDcFkRPtvBfo+JChfYOP0v+ikcmH5WKu
X-Google-Smtp-Source: ACcGV61Z2VV4tOu+kLSUEoMKiWCHWLVgjHf+79E43ZKOqyepkF4OkEJDI/iB6RYZ4oVvvihrKCrpY7nDJho8ofo48Pk=
X-Received: by 2002:a17:906:fd4:: with SMTP id
 c20-v6mr5323542ejk.241.1538638885340; 
 Thu, 04 Oct 2018 00:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAPB=Z-rEoVWFFDBS_XhuOQyL+YxR8jScSAAQfO1X-n_Lbm=StA@mail.gmail.com>
 <87sh1nk70y.fsf@concordia.ellerman.id.au>
In-Reply-To: <87sh1nk70y.fsf@concordia.ellerman.id.au>
From: Raz <raziebe@gmail.com>
Date: Thu, 4 Oct 2018 10:41:13 +0300
Message-ID: <CAPB=Z-pLCkXcsAXD5YWt5pwPzFzJrdZsdDye_bZjE0-ea-Ur6A@mail.gmail.com>
Subject: Re: Looking for architecture papers
To: mpe@ellerman.id.au
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 04 Oct 2018 18:01:59 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Frankly, the more I read the more perplexed I get. For example,
according to BOOK III-S, chapter 3,
the MSR bits are differ from the ones described in
arch/powerpc/include/asm/reg.h.
Bit zero, is LE, but in the book it is 64-bit mode.

Would someone be kind to explain what I do not understand?

Thank you











On Wed, Oct 3, 2018 at 7:07 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Raz <raziebe@gmail.com> writes:
>
> > Hello
> >
> > I want to learn about powerpc architecture, mainly hypervisor and
> > partioning.  I download the books (1,2, and 3 ) but I feel it lacks
> > a lot of information. Are there other books ?
>
> The ISA describes how the CPU works to allow you to implement a
> hypervisor, but it doesn't describe any of the HV/Kernel APIs.
>
> That's mostly covered in "LoPAPR":
>
>   https://members.openpowerfoundation.org/document/dl/469
>
>
> Although that's not been updated for Power9.
>
> cheers
