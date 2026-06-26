Return-Path: <linuxppc-dev+bounces-23024-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465B4C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 14:26:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmyf54RkQz2yYd;
	Sat, 27 Jun 2026 00:26:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782483981;
	cv=none; b=XEx9Zg+cpAs6Oa7opGWP62xkXg7A36qVxUm2x57GMlotmyds5UmnF9bv3lH8jBPefi1AoSClzCATZsYWM7w60h651MJL5AhB2ueE0KEq755/qyXj4j4iRSZJuoU0Mk5Zdc/LmZYgypwKfYVB4aF/FOj/M7CN0oxGM3nnqvqsds2Q9sv8V4ZwT9MGTpGa5qKh7cg3LqgtPyB0l4xDIgdImejE/PlO95EZVX5Own+pHiOWPzM5B6ebzPafOCoQn7MymyXZoFdisrG5pgdmyRZeve7E87mNnM0/xUxbpgevq1Se4CMYM7dhkdeHhQDsA3tnYFibKIO+kup8Repwc0zw+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782483981; c=relaxed/relaxed;
	bh=93zgvkxuh49PA0NOJqu92O8AFgIa3mgcrkcaggpnEck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R11uFJ1PYPEyNvGoypAe346nbP5VctUnRxKi54yPyjKmaGsTdjCbQA98zuyPrePwMWTWWKZu1mJujlKkdi9aKYexnIWYyrjH1FfcxgeVYhoixQd3ybvi/il1AhvkZtv+HyVgTPaFy08LjUFVPlb50nEpDm6V1/OD25oEs16X3XFA+9W8Xh/KDpETkRBrnhMy4KUBdQ+8Damy1gb3vzIDGRTB04WKDhhAWMR3wPA4w70mSVuWWRQonrpd06Prd3FjiZXKAXxnGrfYdeFm0bSRaxuourMsvd5MiqFb8VDssJD44uNLSwMX6nNpNZAR2OwYrE8SreeeDwvIvqwyak5JSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=PVntTT67; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=PVntTT67;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmyf41dJ7z2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2026 00:26:18 +1000 (AEST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-46f27bd4c45so661628f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782483974; x=1783088774; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=93zgvkxuh49PA0NOJqu92O8AFgIa3mgcrkcaggpnEck=;
        b=PVntTT67JBUWPNxa4T68+SsMZ1vsXB2QaOLN0MQXhGl2N+F251lgB6I53+KIJFI6kC
         rv4gJ27lwaDH+hkVBRmlHera+RcTipJCRWeR3N6q9w1cRYKRPmXdFHy5ovlfsdlcyhoY
         xz0MeunVNDeiONfHeZSvOpuGJQE2LjJnzl7MOxefS4Guof720uf3hqPY0/dPB0dsVQjO
         isAmoUnYfV7tKQ9Gzh3FHp6xon1UCWToE/RrQtw1rdr9KKOy2V5Z3maI12tQSaN3n0nH
         aqQM/7h5rlUfZItUBkCqf/toYF8b4GrtXNW5l17fj1ZjPa0HODgKCnwQ05nM//mCuApt
         YIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782483974; x=1783088774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93zgvkxuh49PA0NOJqu92O8AFgIa3mgcrkcaggpnEck=;
        b=dC5NurPd1V4kHb7qFbMQANY0DxZc4tXWMsY7QZ8omxYingEALGcLDM8x+NzVM4vHQI
         UuHe6RHKZr0TQfSg6y7TtPu0la3FJukijT+tdb1oiO4fe2lpTOssGvhHlA6BlO9A6DAq
         /5wn7yfxGQ0MAH7sPN9nyCX3FejhPsDURjIE7j8lCye9uoMFZCchfW/PW09sKoY43O7j
         w4LiEhroXyHUUTYAv/oVljSi/YgCdKEx/YANH4YqXKiuE/XZF3olFEbcn68XTWB3UtuA
         XWbl+/zyqREj48QFZLMGvZb/JC0M1exnjeYjCdptqgAsXCIHAPfEXee4Zx4GBY8SKaU7
         RAlQ==
X-Forwarded-Encrypted: i=1; AFNElJ8FfDLcrDxCKXLdB8biOKz09yU1q2f1YmTcgteb4Osu0QL09LhO7VVZ9XjGI95yYTKTA8rF9HZ/W9Q+6Bo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxsVmEW85jZeYCyTKCM0eUGCUpNh1wy4uhoGFsB8CPkR5Sn164L
	kghr247++PCyU0G9ePg/XoG/TTI0xMAkogxtTupGT8NRYFYy8WRwoHgaAT+FMoMsIBc=
X-Gm-Gg: AfdE7cnsgY3tlee1+rT0IotW/p+f6bVBn+26+zCOCCDkfnbmvZpqWKml/5TaqjcHojQ
	JrrYYhxPDB0iqFtvmNYiu5BgYLuRtZWtbjq4ycytQRn7gvp3XPEOwE1zAnTQFOqmj2ZCk0aJzUF
	aSSMUKYrOnI5H/nqd4FoFzGAFmv+/KQWDkhT6Gkkd3KVcdxqXmTJuXQdaL/zH2ixDP/O7auQefv
	E6z/8NK7gVbrdSbmW1LJ42a5/AzLGtTpa+aGkMnyaO/qCnQg8L3XKDaK3TMOXcOVHALZMXd0AnS
	FrIFSXG7uXXpM0tr3mqdSuXjc6K4T2AvtHhTR52a5l6EArd59lbwx3lz10N9VmglLmhboZuOHRF
	7L91ZRGTYlN2Fh9ic/Oqggy1oFet204ABbDjV5WMIZLV8HPJrb6qscyTXRx+UL1fBS9eMm33OP8
	0Z/Zj5XXQ7iIuEJco=
X-Received: by 2002:a05:600c:8114:b0:492:7024:11c8 with SMTP id 5b1f17b1804b1-492702411d5mr10254015e9.32.1782483974505;
        Fri, 26 Jun 2026 07:26:14 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c02081bsm44449055e9.0.2026.06.26.07.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 07:26:14 -0700 (PDT)
Date: Fri, 26 Jun 2026 16:26:11 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 4/4] panic: use sys_info_with_filter() to avoid
 duplicate backtraces
Message-ID: <aj6MAxQKpLeK1Mp6@pathway.suse.cz>
References: <20260625152558.7450-1-include@grrlz.net>
 <20260625152558.7450-5-include@grrlz.net>
 <aj5TNB8cRtMNTtIT@pathway.suse.cz>
 <aj5tFiwhRqPkAkqU@pathway.suse.cz>
 <85F6E30C-EB1B-4BAF-9204-5174FD066EE0@grrlz.net>
 <4CF5AE3F-D7ED-47F8-A920-61D0AA078CF9@grrlz.net>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CF5AE3F-D7ED-47F8-A920-61D0AA078CF9@grrlz.net>

On Fri 2026-06-26 13:32:38, Bradley Morgan wrote:
> On June 26, 2026 1:17:13 PM GMT+01:00, Bradley Morgan <include@grrlz.net>
> wrote:
> >On June 26, 2026 1:14:14 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
> >wrote:
> >>On Fri 2026-06-26 12:23:50, Petr Mladek wrote:
> >>> On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
> >>> But it all becomes very hairy. We have several levels:
> >>> 
> >>>    + watchdog-all_bt-specific option, e.g.
> >>sysctl_hardlockup_all_cpu_backtrace
> >>> 
> >>>    + watchdog-specific si_info preferences, e.g. hardlockup_si_mask
> >>> 
> >>>    + panic-specific si_info: panic_print
> >>> 
> >>>    + universal fallback for any layer: kernel_si_info
> >>> 
> >>> Now, we try to check all these variables back and forth to
> >>> trigger all backtraces or to avoid triggering them.
> >>> And it clearly does not work well and the code is more and more
> >>> hairy.
> >>> 
> >>> I think about another approach. The word "waterfall" comes to my mind.
> >>> Instead of checking all the settings back and forth, let's process
> >>> each setting one by one and just remember what has been done and
> >>> skip this in the next level.
> >>> 
> >>> All the si_info actions seems to dump a global system state.
> >>> So, it would make sense to remember the state in a global variable
> >>> even when it might be modified by more CPUs in parallel.
> >>> 
> Hmm.. new idea 
> 
> kernel/dump_filter.c ?
> 
> What this file could do is to handle a generic lockup state machine
> so any subsystem can log what it already dumped?
> 
> I know it may bloat, but it's better then cramming fixes in.

I am not sure what exactly you would like to achieve but it sounds
a bit scary ;-)

Anyway, we should not synchronize the watchdog reports against
each other, definitely. They are running in non-compatible contexts
(task vs interrupt vs NMI). Also we should not add any locking
because they usually print something when the system has enough
troubles.

Also I think that it is not worth preventing duplicated backtraces
or reports from a single CPU. IMHO, it is not a big problem
in practice.

So, we are down to large reports, like backtraces from all CPUs,
timers, locks, ... which are handled by sys_info(). So, I think
that it should be enough to handle this inside the sys_info() API.

I do not want to say that my proposal was the best solution.
I am sure that there are better ones. But we need to consider
the gain vs. complexity.

Honestly, I am already a bit scared by the complexity which
we the sys_info() API added. And it is hard to imagine that
adding another API would make it easier. But I might be wrong.

Instead, it might make sense to integrate the conflicting
subsystem-specific calls under the sys_info() API.
I mean that, for example watchdog_hardlockup_check() won't
call trigger_allbutcpu_cpu_backtrace() directly but
it would call it via sys_info() API so that sys_info()
could keep track of it. Something like:

void sys_info_allbutcpu_bt(int cpu)
{
	trigger_allbutcpu_cpu_backtrace(cpu);
	/*
	 * The caller likely printed backtrace of the given @cpu
	 * on its own. Prevent duplicate backtraces from all
	 * CPUs with potential next sys_info() call.
	 */
	sys_info_done(SYS_INFO_ALL_BT);
}

But I am not sure if it is really easier to follow
than calling sys_info_done() from the watchdog code.

Some watchdogs try to optimize the output and print backtraces
only from CPUs which are relevant for the given lockup.
We should keep the logic for selecting the set of CPUs
in the watchdog code. We just need to solve how to elegantly
make sys_info() aware of it or at least about the more massive
reports.

Anyway, I would prefer to keep it simple until we see some problems
in practice.

Best Regards,
Petr

