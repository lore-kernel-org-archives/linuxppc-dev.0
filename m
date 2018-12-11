Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D38CC07E85
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 09:39:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBED220811
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 09:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETMPSNBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBED220811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DZfR498VzDqTC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 20:39:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ETMPSNBl";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::92a; helo=mail-ua1-x92a.google.com;
 envelope-from=rsalvaterra@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ETMPSNBl"; 
 dkim-atps=neutral
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DZbc20wlzDqq0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 20:37:16 +1100 (AEDT)
Received: by mail-ua1-x92a.google.com with SMTP id p9so4890932uaa.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 01:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bfu37XvicU8GOJunSNdquvYomfpuT3hN3SAggWjLB98=;
 b=ETMPSNBlvml7wFYO6tgjpExr0YIg9GL5/413ehIRg5zTej2kkpqA1na2u0J/dUQe7Y
 59tT99eFM7+fkYqlCA4iESfs4p+QpkfFZ8Cvkwgt/oZmR70uOEeKDK4wPar7L7IzmY4V
 asl7P05TB7XkwrbkNjVt+qGlO64b4M+ul90VC5iSZe+kG+GmHGLy/FdGCxTCB7GWhX7a
 yEnAZqM3S0OpSDXLflcsSQdkyjDiUayZnwJjiqiacqknrN3DOCMEplmCQ+F+M4QL8w07
 w+RGWCskK9DKp/aVZwUnFQpvjtY/xrJbBwLyN7I8tDsxraq1l8BDNc8DblSeeNW/89it
 fIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bfu37XvicU8GOJunSNdquvYomfpuT3hN3SAggWjLB98=;
 b=SYJpty5F46uEVY4DUT3V3TvsPMYoXnA9e3dhh+JSktxVqQ3q/v2bbl5mMTq0zVpVm4
 6ACulyENzgZ0yhjCCN8dLohy9T+n5Z87QVg5iWOzQeuMjroLBlDd5KNpLrjLkdTyWaNc
 OXZJXxoDvU2r/sF/FheU8ARiqIXQKJQNQGK2UGfvN657vxEOppZ3XkjKwgUkDlSGGDCZ
 xG+SVsQcYPROnsqYFAHP8wwWAz09dbLFJAf3WuH8POXt8LzOpVX9GjKrwrM+EhThUvct
 +HwK83oldX1pApwFMlwmhtE1wu73P6i8EFhvZgxf78ya+ixrQ3V7zl9mFAG9dfxnqReq
 1/GQ==
X-Gm-Message-State: AA+aEWbpFuNhp1ha8LPkYU94pkZtvQkxhemoLXjCqqgedoQemHaTUKy2
 Hn9lklQQsPRKqt0JB/ssEIWuyOXsDzOdNjikTg==
X-Google-Smtp-Source: AFSGD/VOHTabmVzki91hN+mm4gt6FH3uwSmE7/GjmS6dV5WAmjUrJUUNsjfRY4y5axGxKy5sDZQmhU0zoHBqROplhDc=
X-Received: by 2002:ab0:14f2:: with SMTP id f47mr6817465uae.27.1544521033581; 
 Tue, 11 Dec 2018 01:37:13 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZzHSZ=s0W0Pd-MVd7OA0hYxu0LzsZ+GxYybXKoUQQR6Q@mail.gmail.com>
 <20181130103222.GA23393@lst.de>
 <CALjTZvZsk0qA+Yxu7S+8pfa5y6rpihnThrHiAKkZMWsdyC-tVg@mail.gmail.com>
 <42b1408cafe77ebac1b1ad909db237fe34e4d177.camel@kernel.crashing.org>
 <20181208171746.GB15228@lst.de>
 <CALjTZvb4+Ox5Jdm-xwQuxMDz_ub=mHAgPLA4NgrVNZTmUZwhnQ@mail.gmail.com>
 <20181210193317.GA31514@lst.de>
 <8a2e104a6c5b745adca8e7f3310af564f3b8a75d.camel@kernel.crashing.org>
In-Reply-To: <8a2e104a6c5b745adca8e7f3310af564f3b8a75d.camel@kernel.crashing.org>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Tue, 11 Dec 2018 09:37:02 +0000
Message-ID: <CALjTZvZ1Ud4P_XqB23Yq=815VyF=UbbT8YCFjTaPN=5tORWrtQ@mail.gmail.com>
Subject: Re: use generic DMA mapping code in powerpc V4
To: benh@kernel.crashing.org
Content-Type: text/plain; charset="UTF-8"
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, hch@lst.de,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 10 Dec 2018 at 20:49, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>

[snip]

>
> AGP is a gigantic nightmare :-) It's not just cache coherency issues
> (some implementations are coherent, some aren't, Apple's is ... weird).
>
> Apple has all sort of bugs, and Darwin source code only sheds light on
> some of them. Some implementation can only read, not write I think, for
> example. There are issues with transfers crossing some boundaries I
> beleive, but it's all unclear.
>
> Apple makes this work with a combination of hacks in the AGP "driver"
> and the closed source GPU driver, which we don't see.
>
> I have given up trying to make that stuff work reliably a decade ago :)
>
> Cheers,
> Ben.

That's what I was afraid of=E2=80=A6 what a mess. At least now I have a
definitive answer from one of the original authors of the code, thanks
a lot, Ben. :)
I have an unresearched belief that AGP support was hacked in the Mac
series as an afterthought (weren't they supposed to be PCI/PCI-X
only?), and your explanation surely seems to corroborate. :/
