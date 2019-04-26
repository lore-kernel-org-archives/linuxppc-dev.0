Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5819CC43218
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 04:34:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178AB206C1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 04:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxxQ4rEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178AB206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44r1Rf46DDzDqgB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 14:34:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="lxxQ4rEM"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44r1Pv3Fg5zDqc8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 14:33:07 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id w25so1027971pfi.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 21:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=9hkrdUZwWqTiPriAP4+hzIlVI3ze7sEIgtQrzRmmKw8=;
 b=lxxQ4rEM5pzoAujII8IvdS/DcKe58Pmct9RjpVMGLiz9xlGTxl3/ww611iMfOQQiet
 QTzTHit37Qn04vT0dya+oHuTv3LUSb3d8hmgyUI+d1mbQk/MLPyeDPCPi8npSRyVYeOu
 Xzb6UxDo9SpMWaOMUDeojvGHMSZGO8cClSzMtREdVUrle9w9nrNBiVWHUfHCfTXL7hPk
 wgKvwPgEhB0OZmlaBrKv/RT5bG9H/ghVjFwzH7smHk8VglTeW2tQKG48JzPtKZLP+dom
 VGlhkT7E3Va9CIYMi67VNjusNZDPqJPgVPPTnEJUaZ5dW7DRhvymxARRybM2Xfo3qXMg
 c4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=9hkrdUZwWqTiPriAP4+hzIlVI3ze7sEIgtQrzRmmKw8=;
 b=siD3OhJ12nCiBuFrFSm/tILQmx7YzzggRcLP5/aqjl5eVCuenZWOGUuX+8VRD94DBB
 gTHRkr+83a6WVRHuR47MmFZ05jlB0y6Y0UCQlFAIj2y2MOkJiXOdG2srv22zfS053JDe
 +CieweYvvG72QMoQECVlT2jfN6wKviBDg1w9tmFwIcx7diDo6JOpfyzE5qAd1q9j5y79
 +FLd1a1gsFmZVNXJyuf/0uk2lnEdMo4UGfMZRRfmUX+FS66W82EApSAf7RcbiYHfk5kH
 mMXp5AsCIQkwZSbYquWMA5m4op+voKAw2q6TB2cLZ8jWF6/wf7zXOiFDxgFdtRfhQqVI
 TbAw==
X-Gm-Message-State: APjAAAWiW8BFSGSpFc5G+R05+6Mn3MkqcksEYlTTv+I0lna4wWVhoGVA
 WBGhSMyFpCG1fxM5yebvRds=
X-Google-Smtp-Source: APXvYqxWJwSV34YiqjYhJ4T4cYqioPlTB9FvF3G0vXhjr4CH46GNbMVzpO9OF1VcyFxPWr5gDV0XrA==
X-Received: by 2002:a63:1e12:: with SMTP id e18mr10712817pge.87.1556253184913; 
 Thu, 25 Apr 2019 21:33:04 -0700 (PDT)
Received: from localhost ([203.63.161.26])
 by smtp.gmail.com with ESMTPSA id t82sm62440023pfa.153.2019.04.25.21.33.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 25 Apr 2019 21:33:03 -0700 (PDT)
Date: Fri, 26 Apr 2019 14:32:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 3/5] kernel/cpu: Allow non-zero CPU to be primary for
 suspend / kexec freeze
To: Peter Zijlstra <peterz@infradead.org>
References: <20190411033448.20842-1-npiggin@gmail.com>
 <20190411033448.20842-4-npiggin@gmail.com>
 <20190425120221.GR4038@hirez.programming.kicks-ass.net>
In-Reply-To: <20190425120221.GR4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1556252469.19vbob4hqp.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
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
Cc: linux-arch@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Peter Zijlstra's on April 25, 2019 10:02 pm:
> On Thu, Apr 11, 2019 at 01:34:46PM +1000, Nicholas Piggin wrote:
>> This patch provides an arch option, ARCH_SUSPEND_NONZERO_CPU, to
>> opt-in to allowing suspend to occur on one of the housekeeping CPUs
>> rather than hardcoded CPU0.
>>=20
>> This will allow CPU0 to be a nohz_full CPU with a later change.
>>=20
>> It may be possible for platforms with hardware/firmware restrictions
>> on suspend/wake effectively support this by handing off the final
>> stage to CPU0 when kernel housekeeping is no longer required. Another
>> option is to make housekeeping / nohz_full mask dynamic at runtime,
>> but the complexity could not be justified at this time.
>=20
> Should we not tie this into whatever already allows an achitecture to
> hotplug CPU-0? For instance, x86 default disallows this but has
> cpu0_hotpluggable to allow this.
=20
I didn't know about that option, but I see it still has the suspend
/ hibernate restriction though, which is what this patch is breaking
from.

If we are to prevent suspend completely at boot time, then it's no
problem to run cpu0 with nohz_full, but TPTB decided that's a bad
thing.

But I have no problem with an arch adding another boot time option
or hook into cpu0_hotpluggable that allows you to force nohz_full.

> Presumably POWER already allows hotplugging CPU-0 ?

Yeah it does. Suspend in pseries is actually really just used for
some proprietary hypervisor partition migration scheme where you
suspend, image gets saved, then resume it somewhere else. So that's
easy, it's just a hypercall that appears to return exactly as it was
called. No restriction on CPU number.

Thanks,
Nick
=
