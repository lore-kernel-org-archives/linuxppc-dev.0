Return-Path: <linuxppc-dev+bounces-23030-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65368C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 14:59:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmzMq6RHdz2yYd;
	Sat, 27 Jun 2026 00:59:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.167.222.108
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782485943;
	cv=none; b=K7XGbcgpTep73rsPitgeVZQ1HWzSlkAGnUQW0FGROKAT2Q88G7TeCut5RwyjnT8mxnQMbbnkUZRbADmxFaHEKJQOql81jemUwB9m5WPAeClNBSVjunKWhHM5odY5BOg5ic8+687ax5uybM6lkBjxbbVs0tLPqj701gvrUf1KTAw8ES1jlSMf7NdF9FWh4exY3GsEE0GaZcfKP+pyj9BbVXaHQ0luC33HIrxVNhKXqXEp6alO6/7yvBONdJpOWmgrHu8qHsPtYTLa6ywKC7vCYKJYxgcR39J1mfZALZPkz8wvYz3R9ol69aJcvz760ASsHI0NMNFchbZTr41XIewy5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782485943; c=relaxed/relaxed;
	bh=qwtFANDyCgGd4fu1Y4yzO6yO2Mco8QTEc/2pzxC6z20=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TOy7rNBkmc41Ug/gTf1xOE24nYUYqcRmpet4F0olUWI+VbIH+KNkV8JYehJ/x0aIHdleinUZCGdURR5CbP5Whz3w8FRf1sJsIZHeNvXMOjh7n3OLHxbuxiqGfg0cC53aLnsQszHxD/o86E5t18DPTMjIw9e3JMw1M+cviwepgX90VugmxA6iBSW1lCiPaMUKjPBKzNZunikXowrf+7y/ucIEykSKdY7ZHU5m9RsiqUPG6p3+xZOFg4BOYX9gOxpSULrM2gyFrGYVGBh1An/mijx98suopm5WFoj9/W/LVYmF0IX44vJTs8W0flHFBWl/sxaqWaAVoPrzv27I/QK8CQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=hgRbxt/Q; dkim-atps=neutral; spf=pass (client-ip=198.167.222.108; helo=devianza.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org) smtp.mailfrom=grrlz.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=hgRbxt/Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=grrlz.net (client-ip=198.167.222.108; helo=devianza.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org)
Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmzMp1sWrz2yVv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2026 00:59:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782485938;
	bh=qwtFANDyCgGd4fu1Y4yzO6yO2Mco8QTEc/2pzxC6z20=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hgRbxt/QTju9ZiWOuA9mwQVb+tgD1LO26f2iL0ZAGVy9gjILfXzGzZnOUEFkQW+Gq
	 qtuFtPZUGlYt2kik+zFURyKUdyibcotDz/utoUYFXxLqQahspOJbnRRmTSs8f5IESb
	 44ul3PhuqudzDlVkwXSNrXklqk3cVSTz9QIuzV2s=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4gmzMk2JHsz6vfC;
	Fri, 26 Jun 2026 14:58:58 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4gmzMj655lz4y2q;
	Fri, 26 Jun 2026 14:58:57 +0000 (UTC)
Date: Fri, 26 Jun 2026 15:58:55 +0100
From: Bradley Morgan <include@grrlz.net>
To: Petr Mladek <pmladek@suse.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
 Feng Tang <feng.tang@linux.alibaba.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_4/4=5D_panic=3A_use_sys=5Finfo=5Fwi?=
 =?US-ASCII?Q?th=5Ffilter=28=29_to_avoid_duplicate_backtraces?=
In-Reply-To: <aj6Q8JcogaIaQit4@pathway.suse.cz>
References: <20260625152558.7450-1-include@grrlz.net> <20260625152558.7450-5-include@grrlz.net> <aj5TNB8cRtMNTtIT@pathway.suse.cz> <aj5tFiwhRqPkAkqU@pathway.suse.cz> <85F6E30C-EB1B-4BAF-9204-5174FD066EE0@grrlz.net> <4CF5AE3F-D7ED-47F8-A920-61D0AA078CF9@grrlz.net> <aj6MAxQKpLeK1Mp6@pathway.suse.cz> <688433ED-A478-43F7-9103-995398A6BF63@grrlz.net> <aj6Q8JcogaIaQit4@pathway.suse.cz>
Message-ID: <A0A9AAFD-E954-463F-8D9F-61DDBCFDDA5A@grrlz.net>
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
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On June 26, 2026 3:47:12 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
wrote:
>On Fri 2026-06-26 15:35:19, Bradley Morgan wrote:
>> On June 26, 2026 3:26:11 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
>> wrote:
>> >On Fri 2026-06-26 13:32:38, Bradley Morgan wrote:
>> >> On June 26, 2026 1:17:13 PM GMT+01:00, Bradley Morgan
>> ><include@grrlz.net>
>> >> wrote:
>> >> >On June 26, 2026 1:14:14 PM GMT+01:00, Petr Mladek
><pmladek@suse.com>
>> >> >wrote:
>> >> >>On Fri 2026-06-26 12:23:50, Petr Mladek wrote:
>> >> >>> On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
>> >> >>> But it all becomes very hairy. We have several levels:
>> >> >>> 
>> >> >>>    + watchdog-all_bt-specific option, e.g.
>> >> >>sysctl_hardlockup_all_cpu_backtrace
>> >> >>> 
>> >> >>>    + watchdog-specific si_info preferences, e.g.
>hardlockup_si_mask
>> >> >>> 
>> >> >>>    + panic-specific si_info: panic_print
>> >> >>> 
>> >> >>>    + universal fallback for any layer: kernel_si_info
>> >> >>> 
>> >> >>> Now, we try to check all these variables back and forth to
>> >> >>> trigger all backtraces or to avoid triggering them.
>> >> >>> And it clearly does not work well and the code is more and more
>> >> >>> hairy.
>> >> >>> 
>> >> >>> I think about another approach. The word "waterfall" comes to my
>> >mind.
>> >> >>> Instead of checking all the settings back and forth, let's
>process
>> >> >>> each setting one by one and just remember what has been done and
>> >> >>> skip this in the next level.
>> >> >>> 
>> >> >>> All the si_info actions seems to dump a global system state.
>> >> >>> So, it would make sense to remember the state in a global
>variable
>> >> >>> even when it might be modified by more CPUs in parallel.
>> >> >>> 
>> >> Hmm.. new idea 
>> >> 
>> >> kernel/dump_filter.c ?
>> >> 
>> >> What this file could do is to handle a generic lockup state machine
>> >> so any subsystem can log what it already dumped?
>> >> 
>> >> I know it may bloat, but it's better then cramming fixes in.
>> >
>> >I am not sure what exactly you would like to achieve but it sounds
>> >a bit scary ;-)
>> >
>> >Anyway, we should not synchronize the watchdog reports against
>> >each other, definitely. They are running in non-compatible contexts
>> >(task vs interrupt vs NMI). Also we should not add any locking
>> >because they usually print something when the system has enough
>> >troubles.
>> >
>> >Also I think that it is not worth preventing duplicated backtraces
>> >or reports from a single CPU. IMHO, it is not a big problem
>> >in practice.
>> >
>> >So, we are down to large reports, like backtraces from all CPUs,
>> >timers, locks, ... which are handled by sys_info(). So, I think
>> >that it should be enough to handle this inside the sys_info() API.
>> >
>> >I do not want to say that my proposal was the best solution.
>> >I am sure that there are better ones. But we need to consider
>> >the gain vs. complexity.
>> >
>> >Honestly, I am already a bit scared by the complexity which
>> >we the sys_info() API added. And it is hard to imagine that
>> >adding another API would make it easier. But I might be wrong.
>> >
>> >Instead, it might make sense to integrate the conflicting
>> >subsystem-specific calls under the sys_info() API.
>> >I mean that, for example watchdog_hardlockup_check() won't
>> >call trigger_allbutcpu_cpu_backtrace() directly but
>> >it would call it via sys_info() API so that sys_info()
>> >could keep track of it. Something like:
>> >
>> >void sys_info_allbutcpu_bt(int cpu)
>> >{
>> >	trigger_allbutcpu_cpu_backtrace(cpu);
>> >	/*
>> >	 * The caller likely printed backtrace of the given @cpu
>> >	 * on its own. Prevent duplicate backtraces from all
>> >	 * CPUs with potential next sys_info() call.
>> >	 */
>> >	sys_info_done(SYS_INFO_ALL_BT);
>> >}
>> >
>> >But I am not sure if it is really easier to follow
>> >than calling sys_info_done() from the watchdog code.
>> >
>> >Some watchdogs try to optimize the output and print backtraces
>> >only from CPUs which are relevant for the given lockup.
>> >We should keep the logic for selecting the set of CPUs
>> >in the watchdog code. We just need to solve how to elegantly
>> >make sys_info() aware of it or at least about the more massive
>> >reports.
>> >
>> >Anyway, I would prefer to keep it simple until we see some problems
>> >in practice.
>> >
>> >Best Regards,
>> >Petr
>> >
>> 
>> 
>> I understand it's scary. To make a new file in the first place.
>> 
>> But I was a bit vague of what I wanted, and I'm sorry.
>> 
>> So, the reason why I'd suggest a new file, is because if any subsystem
>> Theoretically bypasses sys_info to log a lockup, this completely misses
>> the filter and duplicates the dump
>> 
>> My file would act as a generic lockless state machine that any
>> subsystem can update regardless of how they dump logs.
>> 
>> If you have any questions, feel absolutely free to ask! :)
>> 
>> Discussion is a way to make everyone happy!
>
>Honestly, I am more and more wondering whether your are a real person
>or AI bot.

Sigh..

I can verify myself through video call if you don't believe I am human :)

why I suggested a new file is because AI said it would be a good idea.

I told it what I should do, and it told me to do a new file.

I knew it was over engineering slightly, but I was a bit stressed, 
and I wanted some sort of just new API which is less buggy imho

I should've told you that I used AI to figure the whole new file idea, 


Really sorry petr..

>Best Regards,
>Petr
>

Thanks!

