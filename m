Return-Path: <linuxppc-dev+bounces-23377-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE14BC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 09:09:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grWL731Fkz2xPb;
	Thu, 02 Jul 2026 19:09:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782983391;
	cv=none; b=YmP2xATxfOzAdcOCjzTR9VVGbt+Q8eXBYk7Po7IBAP3GHJGn7qiWIDlPTyIe9JRrMAU/UyfM5/17UrGuTvk78Wr74kveoB5qmre8/PzWVeFHr61SHOgbXblm0tOK9124dseYig0fIRjEk/qYPyo6I1Y1rjGz8sz8vZ4AL2IRXb3zFxOypy9nSMADK35hJnpxiwsu40Lb0waNp5WQst/n8rv8RRvX7/sS6sGjiWmfgQAGg4eYEXv/7ZhOCqTLXiY16yg0wrzXaUKoU0c4OyKU8EwI9qfTvirCHxfC9ILvnhfo7blnhBzJWBIeiGN0XnMa3/MHbl3wfgNq0uEPUZSSAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782983391; c=relaxed/relaxed;
	bh=2Ptox+JjM03OhvllsW2x9tH05PMT5+Q6t7YaDrA539A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AB8/Ths8csxObMdaegB6dLdc/POygYwgyGDIwwkssqSM8YYEQdFedYqAKAqqRCv8g2aKsFWuPUprFMMwobx6yoo7jVqECnmA+UKEmX/kKinH7AnW7oFt/Hja+Iyz1QLjYHdqY1rU0bHzXSP0T+kaLgMSWgjsFut3X6YEba/dSTmASsKKQwZ0cnkY8tVRqSddKil7eyGYR8U0/kktmAmZYIAylRljKUhhF/LDUld60S2gz82hb/lbg7JGFbNL6v/NAQlr92sRnwZ6NeSo9uhl1fUFIx5ESPYn+DQU/fBoeTFUPbpbeALQ1FaZwIwCywcsjLPRO/6I3N6zcBaQ8UfHbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=UTIoc8M0; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=UTIoc8M0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grWL504hWz2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 19:09:47 +1000 (AEST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso7152405e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 02:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782983384; x=1783588184; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ptox+JjM03OhvllsW2x9tH05PMT5+Q6t7YaDrA539A=;
        b=UTIoc8M0h5zixZ3XMZ+FKXsu9YjzgqSiXoo52FJZ7YmzKxPni7KPmZwhe1Xv1bYXIR
         zdQOiLQ77attBlMlQ23SkMDRWDl4DebLYoXsMCu7S/9wcXFGTCv0XI8kBO6QnR9STop9
         HxyubJ4N2caiB2XLQ5Ec2wWQHcQggXUr5yrZ2gOzuEwWlxDjL5Y9GQNgRvDY0xR7W9cw
         /RCDbanXiBIkT0qFILsflpnvMZVDrscMZ83q8vNeHakREOCw/jG35EwWHgF/xIFDRQ6C
         ZpdF9X9gDQe7enDIik61moELj7JrzHp7bgmo2qJT+oNF/ItFSokkZ35s4g9ygESb/4Nx
         j0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782983384; x=1783588184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ptox+JjM03OhvllsW2x9tH05PMT5+Q6t7YaDrA539A=;
        b=rlT4O8KFVsyKQ1GBGCCqKncbi1D8WYp5zkHuJeAvMrq/LQ+v2lwQTUHfhjBBT+sTym
         VzQm83jGkFFc2YCSzJM4ybKtTxQkG2ENC7OUtfyieOXCnGI3nJ0YbA1+ZsnAzwJkG5YP
         vCXR6HNZt1QlosvU3M7arY42NUUM8n43NCiJkGELMPfJLaXovsdX8t5RsUyuC4+/836z
         Axb/glDhpfqaUMcQjllCMgO3zLAxT2j93f17dz8TC2SEB1AGTY1UWvjqQIRK/KnMAUs3
         2DPeuZz0nIC/gwLXIE+ryIefwbzPRMycHhQ0k25Luqzz3meBrdg0zesM3Hqx1b/jkF2A
         q0ug==
X-Forwarded-Encrypted: i=1; AFNElJ9AKWeUZepNf14Sfjw+U9tr89oirXmNKKMKPPJHxp48HkYnneAKRmNbsPbwYhlcUhGkWz6G8YAH1IrTUqA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzK2JB9nkjzGB7fnoKZTuWz0Asv5eJu8ZCWKwduhJbrwQc9b9zs
	qI2gL+GnPEXRCj+pEZ9eumJvmMiDvvuBoCNcTGR7fhWiAkZLhrfJKEBfNmhAJBTmEFI=
X-Gm-Gg: AfdE7cnT+LTUSCSXQwmM0VeMfKnhi02dOmXrd0aNI+a1pJtUH1py0PigeyadKtkGFrD
	L8iAQu3AaZieZGPEL5i7qVg5770QnUw2xq5+ub+p61biB3c9Dep3wwV3Ldq7cQmZBi76qD6YGtl
	zfUuHUHwq/mGReo0EwX/rOtq/FScBAxiLZUmSB1CjRuJsuV9nsPH6TzYagXqXsT42PUK7qBPfEM
	RiwdQQI9rxinpC0kNZq/tjeM/dKRV5ZeuhstWYPSm+1js0omakQdwSea0JWnjn2mmlgm5hJkR9i
	SjKKtoIVX7NezAef/Oxxn+38ponH6f6W5SneCeumfSk9mOU2nqoRiOpAq7RoyCybTJr9eLq7ke0
	Oe8T9nTM3Y/ToV18M/a2xLBAt8uvA+ZTsthxuhghWhJsg53Ha3IO3ES+DrLfR6afe8awgWslGja
	qedFGbmmuDZV1LAYo=
X-Received: by 2002:a05:600d:8649:10b0:492:6eff:7d02 with SMTP id 5b1f17b1804b1-493c2b974bamr64853005e9.30.1782983383910;
        Thu, 02 Jul 2026 02:09:43 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477de3dd0b1sm6982567f8f.35.2026.07.02.02.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:09:43 -0700 (PDT)
Date: Thu, 2 Jul 2026 11:09:41 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Feng Tang <feng.tang@linux.alibaba.com>,
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
Message-ID: <akYq1YaCpZ0b4SBS@pathway.suse.cz>
References: <20260625152558.7450-1-include@grrlz.net>
 <20260625152558.7450-5-include@grrlz.net>
 <aj5TNB8cRtMNTtIT@pathway.suse.cz>
 <aj5tFiwhRqPkAkqU@pathway.suse.cz>
 <akJZxCTlLcwubqi2@U-2FWC9VHC-2323.local>
 <E482A23D-4E1C-42C0-9D07-83C6CDFD1546@grrlz.net>
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
In-Reply-To: <E482A23D-4E1C-42C0-9D07-83C6CDFD1546@grrlz.net>

On Mon 2026-06-29 13:54:18, Bradley Morgan wrote:
> On 29 June 2026 12:40:52 BST, Feng Tang <feng.tang@linux.alibaba.com>
> wrote:
> >On Fri, Jun 26, 2026 at 02:14:14PM +0200, Petr Mladek wrote:
> >> On Fri 2026-06-26 12:23:50, Petr Mladek wrote:
> >> > On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
> >> > > panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping
> >the
> >> > > other CPUs. Do not ask sys_info() to handle that bit again later in
> >the
> >> > > panic path.
> >> > > 
> >> > > Use sys_info_with_filter() so panic_print=all_bt does not request
> >more
> >> > > output after the CPUs are stopped.
> >> > > 
> >> > > Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys
> >info on system lockup")
> >> > > Cc: stable@vger.kernel.org
> >> > > Signed-off-by: Bradley Morgan <include@grrlz.net>
> >> > > ---
> >> > >  kernel/panic.c | 2 +-
> >> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> > > 
> >> > > diff --git a/kernel/panic.c b/kernel/panic.c
> >> > > index 213725b612aa..eb842823df61 100644
> >> > > --- a/kernel/panic.c
> >> > > +++ b/kernel/panic.c
> >> > > @@ -680,7 +680,7 @@ void vpanic(const char *fmt, va_list args)
> >> > >  	 */
> >> > >  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> >> > >  
> >> > > -	sys_info(panic_print);
> >> > > +	sys_info_with_filter(panic_print, SYS_INFO_ALL_BT);
> >> > 
> >> > Hmm, this prevents printing backtraces from all CPUs completely.
> >> > But what if they were not printed?
> >> > 
> >> > They might be printed by:
> >> > 
> >> > static void panic_other_cpus_shutdown(bool crash_kexec)
> >> > {
> >> > 	if (panic_print & SYS_INFO_ALL_BT)
> >> > 		panic_trigger_all_cpu_backtrace();
> >> > 
> >> > [...]
> >> > }
> >> > 
> >> > But it checks only "panic_print" variable. It won't do anything
> >> > when (panic_print == 0).
> >> > 
> >> > In this case, we might still want to print the backraces when
> >> > SYS_INFO_ALL_BT is set in kernel_si_info.
> >> > 
> >> > >  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
> >> > 
> >> > Of course, we might fix panic_other_cpus_shutdown() to check also
> >> > kernel_si_info.
> >> > 
> >> > But it all becomes very hairy. We have several levels:
> >> > 
> >> >    + watchdog-all_bt-specific option, e.g.
> >sysctl_hardlockup_all_cpu_backtrace
> >> > 
> >> >    + watchdog-specific si_info preferences, e.g. hardlockup_si_mask
> >> > 
> >> >    + panic-specific si_info: panic_print
> >> > 
> >> >    + universal fallback for any layer: kernel_si_info
> >> > 
> >> > Now, we try to check all these variables back and forth to
> >> > trigger all backtraces or to avoid triggering them.
> >> > And it clearly does not work well and the code is more and more
> >> > hairy.
> >> > 
> >> > I think about another approach. The word "waterfall" comes to my mind.
> >> > Instead of checking all the settings back and forth, let's process
> >> > each setting one by one and just remember what has been done and
> >> > skip this in the next level.
> >> > 
> >> > All the si_info actions seems to dump a global system state.
> >> > So, it would make sense to remember the state in a global variable
> >> > even when it might be modified by more CPUs in parallel.
> >> > 
> >> > I am going to think more about it.
> >> 
> >> I have created a POC using Gemini. I haven't tested it.
> >> But it looks acceptable. And the logic seems to be more
> >> straightforward.
> >> 
> >> One drawback is that it requires adding the _reset()
> >> call for all sys_info() callers. It is fine in principle
> >> but it might complicate back-porting because all changes
> >> have to be done in one patch.
> >> 
> >> But honestly, this is a nice to have fix. Most people could
> >> live happily without it.
> >> 
> >> From 3c66436d9978030845a96bfaedd6b914536e2ac4 Mon Sep 17 00:00:00 2001
> >> From: Petr Mladek <pmladek@suse.com>
> >> Date: Fri, 26 Jun 2026 13:55:41 +0200
> >> Subject: [POC] sys_info: Introduce state-tracking APIs to prevent
> >duplicate
> >>  backtraces
> >> 
> >> In watchdog, panic, and hung task detection scenarios, sys_info() can
> >> be called multiple times or alongside direct backtrace triggers like
> >> trigger_allbutcpu_cpu_backtrace(). This results in identical backtraces
> >> being dumped repeatedly from all CPUs, cluttering the kernel log and
> >> delaying or obscuring critical debug details.
> >> 
> >> Introduce a state tracking bitmask and associated helpers:
> >> - sys_info_done(mask): Marks specific sys_info bits as already printed.
> >> - sys_info_reset(): Resets the tracking state.
> >> - sys_info_is_done(mask): Checks if all bits in the mask have been
> >printed.
> >> 
> >> Update sys_info() to automatically filter out already printed bits
> >> using this state. Integrate these APIs with the generic hardlockup
> >> and softlockup watchdogs, the PowerPC watchdog, the hung task detector,
> >> and the panic core. This ensures that each piece of system information
> >> and backtrace output is printed at most once per lockup/panic event,
> >> and the state is reset cleanly when a lockup does not trigger a panic.
> >> 
> >> Races between sys_info() callers are ignored. It should be acceptable
> >> because the output from various watchdogs has never been synchronized.
> >> And panic() never returns.
> >> 
> >> Assisted-by: gemini-1.5-flash
> >> Signed-off-by: Petr Mladek <pmladek@suse.com>
> >
> >Yep. There are cases that people want panic on task-hung or sw/hw lockup,
> >and this could remove much duplication of sys info dump, thanks!
> >
> >Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>
> 
> Thanks,
> 
> im feeling a new file to do all the force panic jazz, but putting tape
> on sys_info.c isn't bd either.

I wonder how to move forward with this.

Honestly, I am not sure what exactly you mean by creating another
API for tracking the reports so I could not judge it. Feel free
to sent some POC.

Otherwise, I would go with my proposal to remember the printed states
by the sys_info API. I am not sure whether I should send a proper
patch or you would like to somehow improve it.

Best Regards,
Petr

