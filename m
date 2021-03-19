Return-Path: <SRS0=qtcn=IR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BBBC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 02:06:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F20BC64F11
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 02:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20BC64F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F1nLd3nzMz3c1J
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 13:06:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=jgUs1aJY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f;
 helo=mail-pj1-x102f.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=jgUs1aJY; dkim-atps=neutral
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F1nLB63NMz2yyy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Mar 2021 13:05:53 +1100 (AEDT)
Received: by mail-pj1-x102f.google.com with SMTP id w8so3874276pjf.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Mar 2021 19:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=za8Z6LZuzMiGUXRElhl+bbuBTVa87RgHnTn3PfoVrAg=;
 b=jgUs1aJYxNnSqP4DELtBykGitNAn20TE7bcBW0/CwhDk1U4kXLRndNso0/GIy2/xn2
 IPnNdyV/Q4Lwfm2HN8OPBSu4Wmr0TFWz+TxFcg9kbgfn9YBR5M0e9Xb9PLAzZfQv4L3I
 CLMMV74P6JJGaAVFeAQioR9MCslc67mts5amTzwX2vVWcmoRR4GP4txgFfSMZibkOJkg
 vEyBsI5XhEH+7+Gjv3m1pzDE+Vw9i2oznTzYXD/QDJ2oMiblXhsR7WN/xJLKmoqLh2ml
 bB+02UHy15wjndunXmwmIZFcOzvqNn75vioSF7ajrkjB8qwNzhEwhLJadrFb/sle93Oo
 PtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=za8Z6LZuzMiGUXRElhl+bbuBTVa87RgHnTn3PfoVrAg=;
 b=VIFrNQmfX10sp+0WJnUzGsHkwZvjM2b5GZY0ooFxLnCqqk1OcihRqBLE7qm1CIy2e5
 xV2b7cCwmrzbrWWDov2iKpuvbG/hMlHskjagIsCrNPTke++UmmUV5pzjRoEuW2SlmR0o
 ++Pl1IoLoigu4GMrgb1KCdm9Ni81Cu1oi8C/dtGYxR0Sl25ox9guyw/2IuTAgX+GqKrh
 +jgH7zDujtiLp+X0sHyQIGw/mfr1wJDAUFNGZRQToqEUgnxU9BALwi4GKaMoRqYIHj99
 n5RsQ2IfHa9K3W7IdDll2Nf0Ct//U6LHKh1+IhywDH7UVK4L6c67Q4X1VQhC1ZS5WUBe
 s7yw==
X-Gm-Message-State: AOAM5310KwPBSwePNlrsmifhwobyBBcIabiLM9HJlMoAxkhI/Q/Yw3WS
 VZm1maNyyt+4X/bIvCa3MvzO+dJ2nGM=
X-Google-Smtp-Source: ABdhPJwvKIhCCjg2eDINAXYBoRJg8/3e+h+SJM69OhP8ZSpXGolA3u2NxjXKlHjYaQkdQaL/y7NbtQ==
X-Received: by 2002:a17:90a:b10a:: with SMTP id
 z10mr7450327pjq.125.1616119550265; 
 Thu, 18 Mar 2021 19:05:50 -0700 (PDT)
Received: from localhost ([58.84.78.96])
 by smtp.gmail.com with ESMTPSA id t22sm3709670pjw.54.2021.03.18.19.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Mar 2021 19:05:49 -0700 (PDT)
Date: Fri, 19 Mar 2021 12:05:43 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 7/8] powerpc/purgatory: drop .machine specifier
To: Daniel Axtens <dja@axtens.net>, Segher Boessenkool
 <segher@kernel.crashing.org>
References: <20210225031006.1204774-1-dja@axtens.net>
 <20210225031006.1204774-8-dja@axtens.net>
 <20210225155836.GG28121@gate.crashing.org>
In-Reply-To: <20210225155836.GG28121@gate.crashing.org>
MIME-Version: 1.0
Message-Id: <1616119361.tyoejtbh8j.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: llvmlinux@lists.linuxfoundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Segher Boessenkool's message of February 26, 2021 1:58 am:
> On Thu, Feb 25, 2021 at 02:10:05PM +1100, Daniel Axtens wrote:
>> It's ignored by future versions of llvm's integrated assembler (by not -=
11).
>> I'm not sure what it does for us in gas.
>=20
> It enables all insns that exist on 620 (the first 64-bit PowerPC CPU).

Same question for this, why do we have it at all?

Thanks,
Nick
