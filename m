Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B443C64EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:48:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8FC02084D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FC02084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QvNN5PnKzF3MN
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 23:48:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.217.67; helo=mail-vs1-f67.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vs1-f67.google.com (mail-vs1-f67.google.com
 [209.85.217.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QtRL6rK5zDr2j
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 23:05:34 +1000 (AEST)
Received: by mail-vs1-f67.google.com with SMTP id a202so2120736vsd.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Oct 2018 06:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fgAFcsqmUdDZPswJ7PWWrvK7N/zPPnmFVWzJCMfQHpM=;
 b=oPZ2ZsO7+hxFzIhtF5tyYOEZpUN/gyuF9sjq7Q8dxYkIBZOUVurobb/MofajCfvSfx
 H5YMe3Mwr1217W4fCfSDtQSkt45S84sEZR8PrXvTcni5A1EtnyRmaVnIBAg1QROElGxG
 0rSRXH5xvlGgpxu5pvvvfZ9qDCgRlDj76GA7m0Qc7EEj6K9GOZ6/HSAr6Rg3d/wPKWa6
 4i8h6ObT+lkOP38qPIymEkk85jOpgRzQg0EK7KNIJQ7YR0wwOY+5gpGQVS2kBbmZ+luO
 xMugGPL3VWfzQxkC5Ch2TCT3xRXovAV7aEXStXE6aTcnm7sRKrQxpANP2yC9osqj4GxS
 49dA==
X-Gm-Message-State: ABuFfohlt4Gvy2ppiDB2xgE/455PW1MTAeYcLf2HtfBqP5DlbNqrgWeU
 FUon78Xpwxt0bPTpBJonPiAxcmUw7j2fhhXmL9k=
X-Google-Smtp-Source: ACcGV63AnI4JW5Cf6kDcAd4RwIpjDmNoCi4IQwQKFeGQFzF53APjsEzOkmFMVo2R5NI4r9gXyGSzAmS9VBDu7oK3KQE=
X-Received: by 2002:a67:f3cc:: with SMTP id j12mr1820590vsn.96.1538658332130; 
 Thu, 04 Oct 2018 06:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536709753.git.fthain@telegraphics.com.au>
 <7a0748d8cd97964a99879a0b9f1c0243c677c7c3.1536709753.git.fthain@telegraphics.com.au>
In-Reply-To: <7a0748d8cd97964a99879a0b9f1c0243c677c7c3.1536709753.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 4 Oct 2018 15:05:20 +0200
Message-ID: <CAMuHMdVRgo7LCubwXUtv9s8e4U8ROdOWqSWeaKigS9QLPtYX8A@mail.gmail.com>
Subject: Re: [PATCH 1/7] macintosh: Use common code to access RTC
To: Finn Thain <fthain@telegraphics.com.au>
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
Cc: Arnd Bergmann <arnd@arndb.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Sep 12, 2018 at 2:18 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> Now that the 68k Mac port has adopted the via-pmu driver, the same RTC
> code can be shared between m68k and powerpc. Replace duplicated code in
> arch/powerpc and arch/m68k with common RTC accessors for Cuda and PMU.
>
> Drop the problematic WARN_ON which was introduced in commit 22db552b50fa
> ("powerpc/powermac: Fix rtc read/write functions").
>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
