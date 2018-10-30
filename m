Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACB7C2BC61
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 12:26:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B7592081B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 12:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IvqKv2ph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7592081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42krLQ3SFmzDrS2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 23:26:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IvqKv2ph";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com;
 envelope-from=daniel.thompson@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="IvqKv2ph"; 
 dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kqgl11CXzDrMp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 22:56:35 +1100 (AEDT)
Received: by mail-wr1-x442.google.com with SMTP id y16so12263833wrw.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 04:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=NDvJHuJEHcXrFbYGamseXrE+75OV340d/Bj4qXMmHmA=;
 b=IvqKv2phANn9ENDJoFpYpJnTnIt78SMmotjGy22aZB6VLJnn8qGyYGCtEBpZshx13H
 +6N0OREHQV7oJVEU7Gg1vvsTl6DwEFCO/IXnxLSPzn4jlsuLJfhBoykqF2at2ijT7PWg
 LrBIAA+5tRvzbUFrtPwbsOQDgHUNcuJcP5HjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NDvJHuJEHcXrFbYGamseXrE+75OV340d/Bj4qXMmHmA=;
 b=IIaC9O417CXr6KQQFwH5yJzoWeLAYcuVU2etutiM8/ikz4JMbd6sx4MkJlk4xJwvxv
 AkWSp5ZSpLthdXeT2S3+EM6rwISKheeR7HBeHf8DNLDSzNlpZ/FxtMttV0rGn5F4WozV
 FdLT4cfExg44pd4yc334WhnAkTD1/2HapgTYlLtmumO+QwjQFeKnk83j2FI7tHKfUrq+
 KCYogchAOR/ox4MdR3a15/RExttVaRc6CM8YOZ9k5MpotMNnERUim3f5ZX7tgaewtM8X
 i3LPzfZB7sotU1d0LKl9RxYrSju9L5yu0bioc8Yq4CQGUuw0oIx1ipzguHS3G6Ejug/L
 ahtQ==
X-Gm-Message-State: AGRZ1gLiGS6wSzOulhyOjr6UHJhJj+HoNzkLoUjJTIWqtvJVYuTbnAlW
 vExKo/xIGBbiR8BYrlz5WdR5Bw==
X-Google-Smtp-Source: AJdET5eZGsFu6G3mFMPCtbUyW6CvZgH0WXTK/3MFbGDeVoSlI0PsDmfsp/3V8yZAA19Dc83enfz3yg==
X-Received: by 2002:a5d:558b:: with SMTP id
 i11-v6mr16965334wrv.38.1540900592403; 
 Tue, 30 Oct 2018 04:56:32 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net.
 [86.9.19.6])
 by smtp.gmail.com with ESMTPSA id 82-v6sm29949173wms.17.2018.10.30.04.56.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 30 Oct 2018 04:56:31 -0700 (PDT)
Date: Tue, 30 Oct 2018 11:56:28 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 0/7] serial: Finish kgdb on qcom_geni; fix many lockdep
 splats w/ kgdb
Message-ID: <20181030115628.eqtyqdugkpkxvyr2@holly.lan>
References: <20181029180707.207546-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029180707.207546-1-dianders@chromium.org>
User-Agent: NeoMutt/20180716
X-Mailman-Approved-At: Tue, 30 Oct 2018 23:23:41 +1100
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
Cc: nm@ti.com, linux-mips@linux-mips.org, dalias@libc.org, vigneshr@ti.com,
 linux-aspeed@lists.ozlabs.org, linux-sh@vger.kernel.org, peterz@infradead.org,
 catalin.marinas@arm.com, will.deacon@arm.com, mhocko@suse.com,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, jslaby@suse.com,
 mingo@kernel.org, marex@denx.de, sfr@canb.auug.org.au,
 ysato@users.sourceforge.jp, linux-hexagon@vger.kernel.org, x86@kernel.org,
 linux@armlinux.org.uk, tony@atomide.com, mingo@redhat.com, joel@jms.id.au,
 linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 jhogan@kernel.org, rolf.evers.fischer@aptiv.com, asierra@xes-inc.com,
 linux-snps-arc@lists.infradead.org, dan.carpenter@oracle.com,
 ying.huang@intel.com, Jisheng.Zhang@synaptics.com, riel@surriel.com,
 linux-arm-msm@vger.kernel.org, frederic@kernel.org, pombredanne@nexb.com,
 rppt@linux.vnet.ibm.com, bp@alien8.de, luto@kernel.org, tglx@linutronix.de,
 andriy.shevchenko@linux.intel.com, linux-arm-kernel@lists.infradead.org,
 andrew@aj.id.au, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, rkuo@codeaurora.org, paul.burton@mips.com,
 vgupta@synopsys.com, jk@ozlabs.org, Jason Wessel <jason.wessel@windriver.com>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 kstewart@linuxfoundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 29, 2018 at 11:07:00AM -0700, Douglas Anderson wrote:
> Looking back, this is pretty much two series squashed that could be
> treated indepdently.  The first is a serial series and the second is a
> kgdb series.

Indeed.

I couldn't work out the link between the first 5 patches and the last 2
until I read this...

Is anything in the 01->05 patch set even related to kgdb? From the stack
traces it looks to me like the lock dep warning would trigger for any
sysrq. I think separating into two threads for v2 would be sensible.


Daniel.


> 
> For all serial patches I'd expect them to go through the tty tree once
> they've been reviewed.
> 
> If folks are OK w/ the 'smp' patch it probably should go in some core
> kernel tree.  The kgdb patch won't work without it, though, so to land
> that we'd need coordination between the folks landing that and the
> folks landing the 'smp' patch.
> 
> 
> Douglas Anderson (7):
>   serial: qcom_geni_serial: Finish supporting sysrq
>   serial: core: Allow processing sysrq at port unlock time
>   serial: qcom_geni_serial: Process sysrq at port unlock time
>   serial: core: Include console.h from serial_core.h
>   serial: 8250: Process sysrq at port unlock time
>   smp: Don't yell about IRQs disabled in kgdb_roundup_cpus()
>   kgdb: Remove irq flags and local_irq_enable/disable from roundup
> 
>  arch/arc/kernel/kgdb.c                      |  4 +--
>  arch/arm/kernel/kgdb.c                      |  4 +--
>  arch/arm64/kernel/kgdb.c                    |  4 +--
>  arch/hexagon/kernel/kgdb.c                  | 11 ++----
>  arch/mips/kernel/kgdb.c                     |  4 +--
>  arch/powerpc/kernel/kgdb.c                  |  2 +-
>  arch/sh/kernel/kgdb.c                       |  4 +--
>  arch/sparc/kernel/smp_64.c                  |  2 +-
>  arch/x86/kernel/kgdb.c                      |  9 ++---
>  drivers/tty/serial/8250/8250_aspeed_vuart.c |  6 +++-
>  drivers/tty/serial/8250/8250_fsl.c          |  6 +++-
>  drivers/tty/serial/8250/8250_omap.c         |  6 +++-
>  drivers/tty/serial/8250/8250_port.c         |  8 ++---
>  drivers/tty/serial/qcom_geni_serial.c       | 10 ++++--
>  include/linux/kgdb.h                        |  9 ++---
>  include/linux/serial_core.h                 | 38 ++++++++++++++++++++-
>  kernel/debug/debug_core.c                   |  2 +-
>  kernel/smp.c                                |  4 ++-
>  18 files changed, 80 insertions(+), 53 deletions(-)
> 
> -- 
> 2.19.1.568.g152ad8e336-goog
> 
