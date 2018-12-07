Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EA1C07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 18:43:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D58A2082D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 18:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xmck1bS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D58A2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BLvj0nVXzDrMc
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 05:43:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xmck1bS0";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::a43; helo=mail-vk1-xa43.google.com;
 envelope-from=dianders@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xmck1bS0";
 dkim-atps=neutral
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com
 [IPv6:2607:f8b0:4864:20::a43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43BLrX66qhzDqRK
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 05:40:43 +1100 (AEDT)
Received: by mail-vk1-xa43.google.com with SMTP id v70so1162245vkv.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Dec 2018 10:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SRCkAV/rwwCb6G1s504cXx97lfWxm12ZTF5AciiY020=;
 b=Xmck1bS0DtZaa+WeJixKR5fKXvJ0b/KkgVumJ+cB+BRhf2dA1IB3yHuUry37zHpQs6
 zaxAXd4KG8ZJT1/0HnMFp9V5QWu3sIojUVz3n8BmfxYYfJvsAIizcUxSgPQrz5Rov1t2
 CbtwE330HXlFJIaGEy1i92cSc9oRewduTt9lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SRCkAV/rwwCb6G1s504cXx97lfWxm12ZTF5AciiY020=;
 b=k7TdNA1LyIcRgOckMnFnh1EHx5lnMqiEcQ6AVZqB8fcESm4BbGGQLAgfSfWzKKfJeG
 hgw5MHQeloCJSuec7jYYnUliTZ6Oed60rGQStIhQtdZgD2nkuq9O38gTpcFyL5jfVlA5
 IoaGRO+kZAvykclzYVNA8xJEa0rApJM6f4XA/yg+KE75RF2IUdaXzGzTyFyxiX2bOmQ4
 aiCA6LDbPqdb8h6vBOTnFKFN0qVWdpxn+R5ogbENFiL3YBDYce34hbM+YoGGUeFfU46z
 TWxS0K+TttBiYNRbTrRY6eoXFsScDeznTbsVj6iD5JN3Eh3JOKt/ezsou5wwStSN8BzJ
 d3Kg==
X-Gm-Message-State: AA+aEWYIRz14L1/MzKdv+XHr/erJBmSMeimkhp3n3wGoMn4sWEkygDhO
 9eR4h6CMBpDbMH0UjH3QGy7KKHxTVbE=
X-Google-Smtp-Source: AFSGD/VNfc3klFLYxLV4/+MIHBa9p+u3VxSjNLbkTmsqqkopsfoqjXM96+9Y0E2i1hQiVL5nMCWE6Q==
X-Received: by 2002:a1f:a8c5:: with SMTP id r188mr1352086vke.44.1544208041112; 
 Fri, 07 Dec 2018 10:40:41 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com.
 [209.85.217.49])
 by smtp.gmail.com with ESMTPSA id p8sm1515838vke.27.2018.12.07.10.40.39
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 10:40:40 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id y27so3046982vsi.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Dec 2018 10:40:39 -0800 (PST)
X-Received: by 2002:a67:dd11:: with SMTP id y17mr1406802vsj.111.1544208038051; 
 Fri, 07 Dec 2018 10:40:38 -0800 (PST)
MIME-Version: 1.0
References: <20181205033828.6156-1-dianders@chromium.org>
 <20181207174231.GD11961@arrakis.emea.arm.com>
In-Reply-To: <20181207174231.GD11961@arrakis.emea.arm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 7 Dec 2018 10:40:24 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WO2xMojkEqKCMkufwihUvnow3yEH4GZPh7hh8noNZ+=A@mail.gmail.com>
Message-ID: <CAD=FV=WO2xMojkEqKCMkufwihUvnow3yEH4GZPh7hh8noNZ+=A@mail.gmail.com>
Subject: Re: [REPOST PATCH v6 0/4] kgdb: Fix kgdb_roundup_cpus()
To: Catalin Marinas <catalin.marinas@arm.com>
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
Cc: mhocko@suse.com, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, kgdb-bugreport@lists.sourceforge.net,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 dalias@libc.org, paulus@samba.org, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org,
 x86@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, ying.huang@intel.com, jhogan@kernel.org,
 linux-snps-arc@lists.infradead.org, rppt@linux.vnet.ibm.com, bp@alien8.de,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Vineet Gupta <vgupta@synopsys.com>, linux-mips@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, rkuo@codeaurora.org, paul.burton@mips.com,
 Jason Wessel <jason.wessel@windriver.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

On Fri, Dec 7, 2018 at 9:42 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Dec 04, 2018 at 07:38:24PM -0800, Douglas Anderson wrote:
> > Douglas Anderson (4):
> >   kgdb: Remove irq flags from roundup
> >   kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
> >   kgdb: Don't round up a CPU that failed rounding up before
> >   kdb: Don't back trace on a cpu that didn't round up
>
> FWIW, trying these on arm64 (ThunderX2) with CONFIG_KGDB_TESTS_ON_BOOT=y
> on top of 4.20-rc5 doesn't boot. It looks like they leave interrupts
> disabled when they shouldn't and it trips over the BUG at
> mm/vmalloc.c:1380 (called via do_fork -> copy_process).
>
> Now, I don't think these patches make things worse on arm64 since prior
> to them the kgdb boot tests on arm64 were stuck in a loop (RUN
> singlestep).

Thanks for the report!  ...actually, I'd never tried CONFIG_KGDB_TESTS
before.  ...so I tried them now:

A) chromeos-4.19 tree on qcom-sdm845 without this series: booted up OK
B) chromeos-4.19 tree on qcom-sdm845 with this series: booted up OK
C) v4.20-rc5-90-g30002dd008ed on rockchip-rk3399 (kevin) with this
series: booted up OK

Example output from B) above:

localhost ~ # dmesg | grep kgdbts
[    2.139814] KGDB: Registered I/O driver kgdbts
[    2.144582] kgdbts:RUN plant and detach test
[    2.165333] kgdbts:RUN sw breakpoint test
[    2.172990] kgdbts:RUN bad memory access test
[    2.178640] kgdbts:RUN singlestep test 1000 iterations
[    2.187765] kgdbts:RUN singlestep [0/1000]
[    2.559596] kgdbts:RUN singlestep [100/1000]
[    2.931419] kgdbts:RUN singlestep [200/1000]
[    3.303474] kgdbts:RUN singlestep [300/1000]
[    3.675121] kgdbts:RUN singlestep [400/1000]
[    4.046867] kgdbts:RUN singlestep [500/1000]
[    4.418920] kgdbts:RUN singlestep [600/1000]
[    4.790824] kgdbts:RUN singlestep [700/1000]
[    5.162479] kgdbts:RUN singlestep [800/1000]
[    5.534103] kgdbts:RUN singlestep [900/1000]
[    5.902299] kgdbts:RUN do_fork for 100 breakpoints
[    8.463900] KGDB: Unregistered I/O driver kgdbts, debugger disabled

...so I guess I'm a little confused.  Either I have a different config
than you do or something is special about your machine?


NOTE: In general I've never considered "single step" as reliable in
kgdb.  I mostly use kgdb as "after the fact" crash debugging to
analyze local variables / memory / other tasks.  If it worked that'd
actually be kinda great, but at least when I started using kgdb years
ago I learned that it didn't work and stopped trying...


-Doug
