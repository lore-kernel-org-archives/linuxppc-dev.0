Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864D3C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 04:56:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C910F21780
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 04:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="mbh1hNIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C910F21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vsf93WsmzF3Pb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 15:56:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.b="mbh1hNIc";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::744; helo=mail-qk1-x744.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="mbh1hNIc"; 
 dkim-atps=neutral
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vsbZ1zNzzF3Pb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 15:54:18 +1100 (AEDT)
Received: by mail-qk1-x744.google.com with SMTP id o89so23692409qko.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 20:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b2dB5Vh21L1zrYCsYUDJT1XDKS4DmUxt5WOtc2TT1VE=;
 b=mbh1hNIc8lvzyuqEJ0GemOJgzn8f4zYs3kqiPKm9smJnHD7kKNDcty6VGSdjR5LBVx
 7r0CMCXfaZ/lU3Z47VkNuevURJqzTaDNlUQPBKo3V0I/IwmYo2rl/N+qgZgbaXLOHWLd
 BTWA7+x61MA5kFka/fuuuRlVgiyRzei/rJDAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b2dB5Vh21L1zrYCsYUDJT1XDKS4DmUxt5WOtc2TT1VE=;
 b=pePwyHqPFVB4UtyIVNjvQ0w2WzxFfElOWQWsU6d2yEWG6JpUnbvGRF2NIh5nDMYPXA
 Kf8Yuo4pbXcWjzeEs+eX1XD+NOhLxmtFpqdoi6EMiax9o/EetfX0gKz8UBltEY+AqMZ3
 3avhrHNfclKyNrJ4esWSo20C9v4LkEd7gtCesH0pzslQbP5OluPn/mkLKgzFrcVrJari
 857Db9bkze/oOpsBl6+ZfPBgaqOLq4zvmUFvP8x0ZIFWUqgcy8LmkMyZaRQ4FdBVzAmI
 L4IXnbpbYt0mWJaOD5VGOfojxuKBPgnBz4/9u2TiXcWxObX9JuPvSfhXk/jmYBzEJE9b
 CBCA==
X-Gm-Message-State: AGRZ1gKC7xQA6KQpq+exRP9SZ6sqY1/ImifJ8H4l2qIUkLpPbmnMiSFd
 HltnYSfmOPk56ZDl61KcFXi74nQ4l+lwEcQQ+44=
X-Google-Smtp-Source: AJdET5eaCimi1HgZghom7n4Mp30JfR5EERHJ2opqIhqa0pa97TJYB1GOxPqw6kRz2vUTWRM7iRj2nUS3hkgvXi63xVM=
X-Received: by 2002:ac8:7308:: with SMTP id x8mr352468qto.284.1542171255664;
 Tue, 13 Nov 2018 20:54:15 -0800 (PST)
MIME-Version: 1.0
References: <20180612081413.323d85b8@canb.auug.org.au>
In-Reply-To: <20180612081413.323d85b8@canb.auug.org.au>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 14 Nov 2018 15:24:04 +1030
Message-ID: <CACPK8XeDHt46rUJWQ1n=4fRWioogs9K0Z8dkxUa=E2ShfQ1Vdg@mail.gmail.com>
Subject: Re: linux-next: build warnings from Linus' tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Alan Modra <amodra@gmail.com>
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
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Alan,

On Tue, 12 Jun 2018 at 07:44, Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Building Linus' tree, today's linux-next build (powerpc ppc64_defconfig)
> produced these warning:
>
> ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
> ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
> ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
>
> This may just be because I have started building using the native Debian
> gcc for the powerpc builds ...

Do you know why we started creating these?

If it's intentional, should we be putting including them in the same
way as .hash sections?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kernel/vmlinux.lds.S#n282

  .hash : AT(ADDR(.hash) - LOAD_OFFSET) { *(.hash) }

Cheers,

Joel
