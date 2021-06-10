Return-Path: <SRS0=PqB2=LE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1A2C47094
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jun 2021 11:54:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A280A61278
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jun 2021 11:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A280A61278
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G12TT3Gczz3c0J
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jun 2021 21:54:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qjDH5fNA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::530;
 helo=mail-ed1-x530.google.com; envelope-from=naresh.kamboju@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=qjDH5fNA; dkim-atps=neutral
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G12Sz5hzKz2xfx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jun 2021 21:54:25 +1000 (AEST)
Received: by mail-ed1-x530.google.com with SMTP id u24so32640809edy.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jun 2021 04:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=4qMF7JTBYZPTkfoUxEfMGRS4U/sbmt/HerhagcW9ih0=;
 b=qjDH5fNAAD/GL8f2FHXw0a4WQ6sXYZqGrOngMavri12bD0g2O1AbUtbrHSDAFS5jxZ
 fOZ5ezHtaekWcZiJ7qGKF4zUHxAj9BKOL/OSsjr1Oyc3+2V2F8apg8YVJM3hCo9Cu2zq
 X3f8kGIBWH+X3Uj5jKeCaAWlJpMLKIIMITqP4Mt1PuUJMWqJRG1UG8UOEBbn06+lZWLe
 UBO5pEdDm8633nCe+wHkwGRUELq1h4w8/24hrIoviSWdQkFByVH6G93MNcQfHSJhRb64
 Cc7q6g5URQGxTGvCk6bhXA6V49V+9/L2phISlmRC4Y0e6TPRwCBVOI52JY4pVN0l5BnW
 qkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=4qMF7JTBYZPTkfoUxEfMGRS4U/sbmt/HerhagcW9ih0=;
 b=BUGXfh+GBn+L3LkoISIAD2IXW3yYWQAechW0fAEdModsu+Hdct/gcT8DbfHV1/vZHa
 gvTRHsqf8+9cdBEHIzImfqgdZELCUSLzhmKm7PmKxvgtzYgLDotYuGhuiT5oIU3Zl7ed
 U2/L4j8C4Fimxb29SOOHrGluCn4luP1Yi+qeu02h/Y257ao6wyw8bCHPxFv34YIR0E7+
 eeiytHdnGmi8/GRwAx2/GoXZKCZsOEHHcdqBndw+exdwXpzAO5SyOpqkR3OeBS4tHLcz
 w+SpKCrgyoR2zz5dhTAwujsLllHPbHiqaTeB0KLySvWv4Wf4nGcwBPKndbSaflVGdXgz
 ocdg==
X-Gm-Message-State: AOAM5323hnR8elEgmVOeyKCNJu0NPHLHgiwVu2gMiFp1C9Kwegn/lK/g
 MUdZ9atSL06vtNBmw919vp6wcDMZYWFPLixwL1r5nw==
X-Google-Smtp-Source: ABdhPJwtN6NoyIb4L2vLWKIfPE3/jQBKdgkBzeOLxBsZHAtOgsVSYnxhhF9W+zndQH3ut6My+wgfWkcKf56ObmZlevY=
X-Received: by 2002:a05:6402:152:: with SMTP id
 s18mr4197413edu.221.1623326057184; 
 Thu, 10 Jun 2021 04:54:17 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 10 Jun 2021 17:24:06 +0530
Message-ID: <CA+G9fYtNjffuSTiRa_=0V14nvFSnOJXbXZnMuNORGeDHfedKGw@mail.gmail.com>
Subject: [next] [powerpc] tau_6xx.c:204:30: error: too many arguments for
 format [-Werror=format-extra-args]
To: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, 
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, lkft-triage@lists.linaro.org
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Finn Thain <fthain@linux-m68k.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

While building Linux next-20210610 following builds failed due to
these warnings / errors.

 - powerpc (ppc6xx_defconfig) with gcc-8
 - powerpc (ppc6xx_defconfig) with gcc-9
 - powerpc (ppc6xx_defconfig) with gcc-10


arch/powerpc/kernel/tau_6xx.c: In function 'TAU_init':
arch/powerpc/kernel/tau_6xx.c:204:30: error: too many arguments for
format [-Werror=format-extra-args]
  tau_workq = alloc_workqueue("tau", WQ_UNBOUND, 1, 0);
                              ^~~~~
cc1: all warnings being treated as errors

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

steps to reproduce:

# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.


tuxmake --runtime podman --target-arch powerpc --toolchain gcc-9
--kconfig ppc6xx_defconfig

ref:
https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/jobs/1334701929#L116

--
Linaro LKFT
https://lkft.linaro.org
