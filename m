Return-Path: <SRS0=4kvs=MX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03826C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 01:37:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2972120658
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 01:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AtPS5jhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2972120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Vtrb6NgXzF31q
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 12:37:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AtPS5jhZ";
	dkim-atps=neutral
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Vtp073VXzF100
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 12:35:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="AtPS5jhZ";
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42Vtp06NVJz8w0H
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 12:35:36 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42Vtp063sTz9sBZ; Thu, 11 Oct 2018 12:35:36 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::c42; helo=mail-yw1-xc42.google.com;
 envelope-from=keescook@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="AtPS5jhZ";
 dkim-atps=neutral
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42Vtnz67Zcz9sB7
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2018 12:35:35 +1100 (AEDT)
Received: by mail-yw1-xc42.google.com with SMTP id s73-v6so2956872ywg.11
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2018 18:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=+G+rLIRHtNjQpCgoMc2xEYSQU+7o/9w1FBDV0V/rOz8=;
 b=AtPS5jhZs3gZoycBiRWgSf5acTprvslvsJ9rYn7chUSJ7qY7dqm48zetYazOLhoQ9C
 59Y4gvqelVgEgvdqDhJ7k2RxduOxawS7ykeEPZaHrGGwOeeScwpA5DHt/xL7KoOG6AFv
 nv9Du6nJNJWEoXXB5GRCIAlwoseENASKIF7W8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=+G+rLIRHtNjQpCgoMc2xEYSQU+7o/9w1FBDV0V/rOz8=;
 b=cZxloX04YwgMvErwp8RuNH9LkPQqYyc9VxGlE73lXZXcNieqliRV0hj7LMlAEKufxv
 3FrFd58kquhHbi0N90DFq9s4yVV302O0SkxcY3H4Wajeb2E8MEGccX1ue7O4Y8NqXJ0p
 yOtOlXo3s8XOfat2XxxD+1HzEk9/GUAQXT3mXUR77AlZx/h43cTcidsm/AoQg1FG6c8m
 7f5Qae0s1TaF6ZbcUPeOkxKIm3xOsJHODAcue/9vlZN/e9sDNu0VviKR2wnPcciuLRJJ
 LmyTDSffZFJvgtiWFCyAGthysz1NoUqqdtgJgrZS/v40OYg+DCGheYDFMvoc0ocb8ffH
 Ev2A==
X-Gm-Message-State: ABuFfoh9eiyZ6hFIzmo5kbCj/aV3Xpi7fBw0cejXxYCt3+d2ummfMtM3
 dIu1tNSRibUifbTF9DeSu9bIIof1QCU=
X-Google-Smtp-Source: ACcGV62kEJpV3+2eV4LjQKawUlEL3Nt3Iy6ITaStY4Cz6vSzGYDOty4xFl6Q205Q7bdyw4VvyW3y4A==
X-Received: by 2002:a81:d10a:: with SMTP id
 w10-v6mr17077590ywi.245.1539221733103; 
 Wed, 10 Oct 2018 18:35:33 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com.
 [209.85.161.45])
 by smtp.gmail.com with ESMTPSA id g126-v6sm8178701ywf.9.2018.10.10.18.35.31
 for <linuxppc-dev@ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Oct 2018 18:35:31 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id s73-v6so2956847ywg.11
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2018 18:35:31 -0700 (PDT)
X-Received: by 2002:a0d:fec6:: with SMTP id
 o189-v6mr20863188ywf.237.1539221730838; 
 Wed, 10 Oct 2018 18:35:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 18:35:29
 -0700 (PDT)
In-Reply-To: <874ldt2uhd.fsf@concordia.ellerman.id.au>
References: <20181010051308.25422-1-mpe@ellerman.id.au>
 <20181010051308.25422-4-mpe@ellerman.id.au>
 <CAGXu5jJqX6ogFgX1q9czwWtufK_nvzUnfN3Xf-74eOBOpcXWVg@mail.gmail.com>
 <874ldt2uhd.fsf@concordia.ellerman.id.au>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 10 Oct 2018 18:35:29 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+ShUkNdmE=FYoGcDv9eUJHv5PD3cmPdivxJK-9n1jr+A@mail.gmail.com>
Message-ID: <CAGXu5j+ShUkNdmE=FYoGcDv9eUJHv5PD3cmPdivxJK-9n1jr+A@mail.gmail.com>
Subject: Re: [PATCH 4/4] powerpc: Add -Wimplicit-fallthrough to arch CFLAGS
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org, maddy@linux.ibm.com,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 10, 2018 at 5:32 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Kees Cook <keescook@chromium.org> writes:
>> On Tue, Oct 9, 2018 at 10:13 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>> Warn whenever a switch statement has a fallthrough without a comment
>>> annotating it.
>>>
>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>
>> Yes please. :)
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Haha, thanks.
>
> It still pops a few errors, including in linux/signal.h & compat.h, so
> it's somewhat aspirational until we can get those fixed up :)

Gustavo, any chance you can target those two files? It could get us a
whole architecture using the flag. :)

-Kees

-- 
Kees Cook
Pixel Security
