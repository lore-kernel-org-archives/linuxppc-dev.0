Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A24C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 17:04:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4B520657
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 17:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LcTmkgLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4B520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lZS51fs0zF3H4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 04:04:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LcTmkgLa";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::441; helo=mail-wr1-x441.google.com;
 envelope-from=daniel.thompson@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="LcTmkgLa"; 
 dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lZPM2MzlzDrVx
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 04:01:43 +1100 (AEDT)
Received: by mail-wr1-x441.google.com with SMTP id r10-v6so17325352wrv.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 10:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=w7PRsslQ+AmlGw6ESJEAEIN3Ju+lMTMOAAXzG79p0Hk=;
 b=LcTmkgLaTJl5aqBKxMqvydqj6P3/DffuXvVPbAUygeibeDLzwTIQqXfR4uds2rIZYM
 XhmMGb7KngDWan146d22FCM9UQ9Ko/QDf54C0Fdt16LXoigKyLTLkNkKnhAaTuALlKv5
 25xBM+L683GMsxPWlmbZaDfh6fxO/3dRfQFIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=w7PRsslQ+AmlGw6ESJEAEIN3Ju+lMTMOAAXzG79p0Hk=;
 b=MqIgcaBDwe6QKdn/RHzTkDoAeQEYcj5HZfZ43fln96Di/Oq0Y3T52iYfFjAqXFmIUc
 NxOoaIMvSKkgB0hic2+Fl2GT7HcLd+6cSwTRTEOa5qUr4ATMgkiV7crukGCqJDP9m7zv
 jY8BXbIXShNRI+nd6ewfEWStvV0NDm4BtkJ5Qx9Lvtn8vfse7Yl8ClrXdopJJxSbo2Jq
 OkxlrOPFRORXCJzP+moYXf1kbZSGcE3imKjJObgb37AT9XntW8kXUKNxY/vOfT7JwOSv
 BqEniIIHo3SkbpNle7oHas8bE5Gcqv6bs05047i3BSCe4Ezau+zYv8cl8K4Gwh9EysX+
 JFvw==
X-Gm-Message-State: AGRZ1gKUMznkj6h09rhQU1GG+9LXKQ+i3u+ywWiH68Po6tOlKFXYZHMQ
 /yBv4kHj3r3nwxXpfRbzHQkXDA==
X-Google-Smtp-Source: AJdET5fF9/fl4K36p+e42OouXFrTlfI2G2yyDuiZgaKxA4I7kOc22/Zb6DjVFjwUnDDuT1saAKtLCQ==
X-Received: by 2002:adf:aa05:: with SMTP id p5-v6mr3828856wrd.56.1541005300354; 
 Wed, 31 Oct 2018 10:01:40 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net.
 [86.9.19.6])
 by smtp.gmail.com with ESMTPSA id t77-v6sm39633264wme.18.2018.10.31.10.01.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 31 Oct 2018 10:01:39 -0700 (PDT)
Date: Wed, 31 Oct 2018 17:01:36 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
Message-ID: <20181031170136.s3ids6tm4rxxlpma@holly.lan>
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org>
 <20181031134926.GB13237@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031134926.GB13237@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-mips@linux-mips.org,
 Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, kgdb-bugreport@lists.sourceforge.net,
 James Hogan <jhogan@kernel.org>, linux-snps-arc@lists.infradead.org,
 Jason Wessel <jason.wessel@windriver.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Vineet Gupta <vgupta@synopsys.com>, Douglas Anderson <dianders@chromium.org>,
 Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>,
 Paul Burton <paul.burton@mips.com>, Philippe Ombredanne <pombredanne@nexb.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 31, 2018 at 02:49:26PM +0100, Peter Zijlstra wrote:
> On Tue, Oct 30, 2018 at 03:18:43PM -0700, Douglas Anderson wrote:
> > Looking closely at it, it seems like a really bad idea to be calling
> > local_irq_enable() in kgdb_roundup_cpus().  If nothing else that seems
> > like it could violate spinlock semantics and cause a deadlock.
> > 
> > Instead, let's use a private csd alongside
> > smp_call_function_single_async() to round up the other CPUs.  Using
> > smp_call_function_single_async() doesn't require interrupts to be
> > enabled so we can remove the offending bit of code.
> 
> You might want to mention that the only reason this isn't a deadlock
> itself is because there is a timeout on waiting for the slaves to
> check-in.

dbg_master_lock must be owned to call kgdb_roundup_cpus() so
the calls to smp_call_function_single_async() should never deadlock the
calling CPU unless there has been a previous failure to round up (e.g.
cores that cannot react to the round up signal).

When there is a failure to round up when we resume, there is a window (before
whatever locks that prevented the IPI being serviced are released) during which
the system will deadlock if the debugger is re entered.

I don't think there is any point trying to round up a CPU that did not
previously respond... it should still have an IPI pending. The deadlock
can be eliminated by getting the round up code to avoid CPUs whose csd->flags
are non-zero either by checking the flag in the kgdb code or adding something
like smp_trycall_function_single_async().


Daniel.
