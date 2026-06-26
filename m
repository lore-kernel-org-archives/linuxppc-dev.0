Return-Path: <linuxppc-dev+bounces-23019-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA5FCD4F26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 12:06:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmvXy3qfHz2yYd;
	Fri, 26 Jun 2026 22:06:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782475602;
	cv=none; b=kPF27FbZ2j1JKlzux7dzJFexiLpMeZls1CSFnj8/OR1vTiNXBIJ8zbVAOC4BiwolhUkApMgXme/FS5dhmLp8Sj1IGveGwilqMSyw189QAHJdRHjTNBldJEEcTlqi37WdcPtPpEwL4UMgzvnpCGSGlC6CdgehewM95aK/gc3z+D76k9bMyvogLqZEsGqXkPHNOJ+FaaoP6iYzI283xLFc+9lDaK+nKUW53oz8XEQo79oH9nkuV2zb2S4B20xpeBds7qpoZgEx7cTJ02PJrfnug4oSAlF4lPbsxueLtIQlm70+qqo2Evn8vIAOtChKmj0q0mu8gI/xzq+8GcavWNJx/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782475602; c=relaxed/relaxed;
	bh=xh7XI+TiHLJYLAr/894grpqUh7uVtoi8+UIaxKwNZeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiOTvT+mHWOzoREY/56eFMb+affq5PQOqI60QADW7QLWZxtDY0dn3srSJ+z6V5wUeMDkXMeBdy9NnlidfD9Bu2iJZWu2P7dl7ZynptvSXPsNvJfaS722EWLXKdtNG1KbeL6PDixduL/V5rV0bvROdd5g3oeHv8qYiXVopK2o/MOXS5Z+r3irdbAiVOrUkBlpAgaAGOZFej7r5qajn479YXF/sEfpz6zNcg09gZwWMKvlIDoKo1XnR9defUXYKtdBrPx7eGVxGcfOKwHBeopGZQ4nrcKD/b8VLH0lnMmnhWlcEd6Ck4uIldD7qr/bEU6tow3q8QmuBSSIjH34yswY5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kgTg34on; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=feng.tang@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kgTg34on;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=feng.tang@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmvXw0rjxz2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 22:06:38 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782475593; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=xh7XI+TiHLJYLAr/894grpqUh7uVtoi8+UIaxKwNZeY=;
	b=kgTg34on1n4/iVtW/7HMWkSoZ1RyYc4+KWeX7kX7Pn1ktLDVUPQOSUUPJ6F3MyB5AhZ+Wt7ZJlpSSfgwi4rop0t/Kn9jXVHyzvfkS21O3VEyDU1AMiTfyAKaE9YiKJBkVqwEUycoLMTSVoMkYdnF4wcUqFsIuXl9ieHGfM/uegg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X5et9EI_1782475590;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X5et9EI_1782475590 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Jun 2026 20:06:31 +0800
Date: Fri, 26 Jun 2026 20:06:29 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Bradley Morgan <include@grrlz.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 4/4] panic: use sys_info_with_filter() to avoid
 duplicate backtraces
Message-ID: <aj5rRV14OQact38f@U-2FWC9VHC-2323.local>
References: <20260625152558.7450-1-include@grrlz.net>
 <20260625152558.7450-5-include@grrlz.net>
 <aj5TNB8cRtMNTtIT@pathway.suse.cz>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aj5TNB8cRtMNTtIT@pathway.suse.cz>

On Fri, Jun 26, 2026 at 12:23:48PM +0200, Petr Mladek wrote:
> On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
> > panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping the
> > other CPUs. Do not ask sys_info() to handle that bit again later in the
> > panic path.
> > 
> > Use sys_info_with_filter() so panic_print=all_bt does not request more
> > output after the CPUs are stopped.
> > 
> > Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Bradley Morgan <include@grrlz.net>
> > ---
> >  kernel/panic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index 213725b612aa..eb842823df61 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -680,7 +680,7 @@ void vpanic(const char *fmt, va_list args)
> >  	 */
> >  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> >  
> > -	sys_info(panic_print);
> > +	sys_info_with_filter(panic_print, SYS_INFO_ALL_BT);
> 
> Hmm, this prevents printing backtraces from all CPUs completely.
> But what if they were not printed?
> 
> They might be printed by:
> 
> static void panic_other_cpus_shutdown(bool crash_kexec)
> {
> 	if (panic_print & SYS_INFO_ALL_BT)
> 		panic_trigger_all_cpu_backtrace();
> 
> [...]
> }
> 
> But it checks only "panic_print" variable. It won't do anything
> when (panic_print == 0).
> 
> In this case, we might still want to print the backraces when
> SYS_INFO_ALL_BT is set in kernel_si_info.

Yep.

> 
> >  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
> 
> Of course, we might fix panic_other_cpus_shutdown() to check also
> kernel_si_info.
> 
> But it all becomes very hairy. We have several levels:
> 
>    + watchdog-all_bt-specific option, e.g. sysctl_hardlockup_all_cpu_backtrace
> 
>    + watchdog-specific si_info preferences, e.g. hardlockup_si_mask
> 
>    + panic-specific si_info: panic_print
> 
>    + universal fallback for any layer: kernel_si_info
> 
> Now, we try to check all these variables back and forth to
> trigger all backtraces or to avoid triggering them.
> And it clearly does not work well and the code is more and more
> hairy.

Agree :)
 
> I think about another approach. The word "waterfall" comes to my mind.
> Instead of checking all the settings back and forth, let's process
> each setting one by one and just remember what has been done and
> skip this in the next level.

When initially reviewing V2's 4th patch, I thought about the
'panic_this_cpu_backtrace_printed', but it's a local variable which
records the state.

> All the si_info actions seems to dump a global system state.
> So, it would make sense to remember the state in a global variable
> even when it might be modified by more CPUs in parallel.

IIUC, panic case is kind of special, as it has to separate the
'sys_info()' op in different stage. Can we do a merge in the start
of vpanic() by:

	panic_print = panic_print ?: kernel_si_mask;

 as a addon patch ?

Thanks,
Feng

> I am going to think more about it.
> 
> Please, do not send v4 until the discussion settles!
> 
> Best Regards,
> Petr

