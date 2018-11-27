Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A255C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 17:50:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1494D205C9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 17:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n8Ig5tAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1494D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434BCP23m4zDqVC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 04:50:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n8Ig5tAb";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::e44; helo=mail-vs1-xe44.google.com;
 envelope-from=dianders@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="n8Ig5tAb";
 dkim-atps=neutral
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com
 [IPv6:2607:f8b0:4864:20::e44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4349yV6hq9zDqnT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 04:39:30 +1100 (AEDT)
Received: by mail-vs1-xe44.google.com with SMTP id h18so14277580vsj.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 09:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SxG22gKp3uE4WIbzN+Oih1tHSp7o6ihhKSzDyg1OL+k=;
 b=n8Ig5tAbA7o3/Ez/WMYwOM6FQ8Y7htlXMticvVSwbTd68NwdFgyL/WgOnsMP1ni1pW
 +STDRZ2AFIiJAy+B5Z9uUEyF+oxnMtVjLcHdm9Hmx/v9AvHS61VlBIbAUOani6h8lpAJ
 yz3zvL8AcXhbiLN04crZSzLzeHZC9ti8UKCIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SxG22gKp3uE4WIbzN+Oih1tHSp7o6ihhKSzDyg1OL+k=;
 b=CCKO8tREzOLy+PanBbEYCN3H9UDlPPcBFlTUB9XbA4C79jpO2ApHjqlEPIew+wpFyU
 uqvCdTBnmaHGt35UmfDknBlOk4IsB7/4SstxIIIQVG7DmSYfIlaV0ilLvkiQI8L7T2sh
 eXycHhFJ47TTnXba15+FZhRHNBo7LDogUcWFUqGKMH2lwn41sHa2AyFc3LoNiH6oCCtr
 beUWOFVxmDfp8A6j1NYnfmX8R8uGcywfQPTXlSRur8KLK4jUZTNTXgTTKr2F/p1GDLgK
 yTsmtEffJJdXSE9fL3Y6oMBIK5Uv91pfwr9PWEuSxDt9QqrsiqUOAMSiOnvVzj59GKhv
 KvoQ==
X-Gm-Message-State: AA+aEWYhMZAm/WR1fggBrtVd2AR1herLpmdgqcD/LG3caXJ1TQ++rh3l
 HIxcIAdF/XN3fVcGDtCKSohNnJXiGsE=
X-Google-Smtp-Source: AJdET5cQTPJSHZnX6Q308NYn6B9ja83tPFDFnjM0URkcQPy7ok3Jc3AJhk9pDdozzGV6SVJe0JTMlQ==
X-Received: by 2002:a67:2388:: with SMTP id j8mr14566540vsj.126.1543340368104; 
 Tue, 27 Nov 2018 09:39:28 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com.
 [209.85.217.43])
 by smtp.gmail.com with ESMTPSA id a137sm2783183vsd.24.2018.11.27.09.39.25
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Nov 2018 09:39:26 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id e7so14279476vsc.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 09:39:25 -0800 (PST)
X-Received: by 2002:a67:6cc1:: with SMTP id
 h184mr14355429vsc.149.1543340364044; 
 Tue, 27 Nov 2018 09:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20181127035133.225592-3-dianders@chromium.org>
 <201811271333.8ZTVxYUT%fengguang.wu@intel.com>
In-Reply-To: <201811271333.8ZTVxYUT%fengguang.wu@intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 27 Nov 2018 09:39:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V087x+56aWFtJxg31O09cFUm00grH7bq1rLSwoq68WdA@mail.gmail.com>
Message-ID: <CAD=FV=V087x+56aWFtJxg31O09cFUm00grH7bq1rLSwoq68WdA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
To: kbuild test robot <lkp@intel.com>
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
Cc: linux-mips@linux-mips.org, dalias@libc.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 paulus@samba.org, Daniel Thompson <daniel.thompson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 kgdb-bugreport@lists.sourceforge.net, jhogan@kernel.org,
 linux-snps-arc@lists.infradead.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Vineet Gupta <vgupta@synopsys.com>, LKML <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, rkuo@codeaurora.org, paul.burton@mips.com,
 kbuild-all@01.org, Jason Wessel <jason.wessel@windriver.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

On Mon, Nov 26, 2018 at 9:39 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Douglas,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on kgdb/kgdb-next]
> [also build test ERROR on v4.20-rc4 next-20181126]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Douglas-Anderson/kgdb-Fix-kgdb_roundup_cpus/20181127-115425
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jwessel/kgdb.git kgdb-next
> config: sparc64-allyesconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=sparc64
>
> Note: the linux-review/Douglas-Anderson/kgdb-Fix-kgdb_roundup_cpus/20181127-115425 HEAD b8d0502e65f2d7a2187baa69870146a6fbf18c9f builds fine.
>       It only hurts bisectibility.
>
> All errors (new ones prefixed by >>):
>
>    kernel/debug/debug_core.c: In function 'kgdb_roundup_cpus':
> >> kernel/debug/debug_core.c:261:18: error: 'struct debuggerinfo_struct' has no member named 'rounding_up'
>        kgdb_info[cpu].rounding_up = false;
>                      ^

Oops, I squashed this into the wrong patch.  It should have been in
patch #3.  Sorry about that.  I'll send out a quick v6.
