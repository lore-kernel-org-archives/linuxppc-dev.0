Return-Path: <linuxppc-dev+bounces-23027-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0803C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 14:35:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmyrb1nHwz2yYf;
	Sat, 27 Jun 2026 00:35:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a12:4180:dc1:929::42"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782484527;
	cv=none; b=ARLePCihm2wp54YE8VtxIEIDjYKsUn815IoVlXIyBLH57EtAOFadW+06qJbtWDi7SPj8+K1if4bn3y+K/FBk2WqaRZM7EVgFM9/IYwyjblrS1QWI8NfJbP227DhFjpwibvE2oWupFStnGfPD3f4oaCxkA5hfzyOVvVwFu257QBdsBHAT28TA+U4ixHi9vBLBjCSvnr24JtAToAxVFsVxdTpuKq58/BQu53XjzR2xcz7EJnh9s5p3W/A0MezHq1zpNG0OpZlcxOvvh3hQvzEX2Cv2exOS1O+yH2LxhcjqrF9xBjFhm31nCsytLWRYnfVGYnH5TtMh9ul5/z06sIOuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782484527; c=relaxed/relaxed;
	bh=1WouP7coA/xMC5AsCpYgMU/VQAQ2GZ2Lo/C5DGW3ELY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FhE+TdgNNFdiWDAl5DCf1Is+vfPRS+EKicjRt9f2cC40hnCHHBWmggbydchfRk8F5M5lTYlcWRdsFSmLGmnstCcEAPiQnQ/GCVd66B2ihNpVgU2JIrtlDB2nPTmPryrePHXQcUvWcxL8YIKspOO/6HcfxpaAEfjhzyDK73pEAWyHebOYzq2JypDW3itoBsyyR2Aso+goKOLLvTCy7TzfjzH3/vsaJOoIBaCGTAI7Bn6vDtK+8Hkt6Dzl+ELunIQ5WmUXNDup9REqNwnHC+Nh4eQBrMOYL94TjGhiAn3fDPQDWkgXUq2A31cgcymTa6IwuoXFOVXAWCPd/oq0bhYzAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=PP6sQgSr; dkim-atps=neutral; spf=pass (client-ip=2a12:4180:dc1:929::42; helo=latitanza.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org) smtp.mailfrom=grrlz.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=PP6sQgSr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=grrlz.net (client-ip=2a12:4180:dc1:929::42; helo=latitanza.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org)
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2a12:4180:dc1:929::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmyrX2c2zz2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2026 00:35:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782484518;
	bh=1WouP7coA/xMC5AsCpYgMU/VQAQ2GZ2Lo/C5DGW3ELY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PP6sQgSreAsE1hqONJ5G+8E2mrXCmCx8e1NwpUBo7JSXiXZCuqCHnKKrRVs+QYylB
	 RJrCjh3509vuP5MQTp0kRtNvy2hYbfy6h2q57CLz/h9gGucSNLpYZJm+bWLKBXC0YU
	 AGCilvAY9852EWXfK+r8wrBZ7+YOqqz4xrED0ALo=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4gmyrQ1pkYzGpDk;
	Fri, 26 Jun 2026 14:35:18 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4gmyrP6K8QzGpDg;
	Fri, 26 Jun 2026 14:35:17 +0000 (UTC)
Date: Fri, 26 Jun 2026 15:35:19 +0100
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
In-Reply-To: <aj6MAxQKpLeK1Mp6@pathway.suse.cz>
References: <20260625152558.7450-1-include@grrlz.net> <20260625152558.7450-5-include@grrlz.net> <aj5TNB8cRtMNTtIT@pathway.suse.cz> <aj5tFiwhRqPkAkqU@pathway.suse.cz> <85F6E30C-EB1B-4BAF-9204-5174FD066EE0@grrlz.net> <4CF5AE3F-D7ED-47F8-A920-61D0AA078CF9@grrlz.net> <aj6MAxQKpLeK1Mp6@pathway.suse.cz>
Message-ID: <688433ED-A478-43F7-9103-995398A6BF63@grrlz.net>
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

On June 26, 2026 3:26:11 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
wrote:
>On Fri 2026-06-26 13:32:38, Bradley Morgan wrote:
>> On June 26, 2026 1:17:13 PM GMT+01:00, Bradley Morgan
><include@grrlz.net>
>> wrote:
>> >On June 26, 2026 1:14:14 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
>> >wrote:
>> >>On Fri 2026-06-26 12:23:50, Petr Mladek wrote:
>> >>> On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
>> >>> But it all becomes very hairy. We have several levels:
>> >>> 
>> >>>    + watchdog-all_bt-specific option, e.g.
>> >>sysctl_hardlockup_all_cpu_backtrace
>> >>> 
>> >>>    + watchdog-specific si_info preferences, e.g. hardlockup_si_mask
>> >>> 
>> >>>    + panic-specific si_info: panic_print
>> >>> 
>> >>>    + universal fallback for any layer: kernel_si_info
>> >>> 
>> >>> Now, we try to check all these variables back and forth to
>> >>> trigger all backtraces or to avoid triggering them.
>> >>> And it clearly does not work well and the code is more and more
>> >>> hairy.
>> >>> 
>> >>> I think about another approach. The word "waterfall" comes to my
>mind.
>> >>> Instead of checking all the settings back and forth, let's process
>> >>> each setting one by one and just remember what has been done and
>> >>> skip this in the next level.
>> >>> 
>> >>> All the si_info actions seems to dump a global system state.
>> >>> So, it would make sense to remember the state in a global variable
>> >>> even when it might be modified by more CPUs in parallel.
>> >>> 
>> Hmm.. new idea 
>> 
>> kernel/dump_filter.c ?
>> 
>> What this file could do is to handle a generic lockup state machine
>> so any subsystem can log what it already dumped?
>> 
>> I know it may bloat, but it's better then cramming fixes in.
>
>I am not sure what exactly you would like to achieve but it sounds
>a bit scary ;-)
>
>Anyway, we should not synchronize the watchdog reports against
>each other, definitely. They are running in non-compatible contexts
>(task vs interrupt vs NMI). Also we should not add any locking
>because they usually print something when the system has enough
>troubles.
>
>Also I think that it is not worth preventing duplicated backtraces
>or reports from a single CPU. IMHO, it is not a big problem
>in practice.
>
>So, we are down to large reports, like backtraces from all CPUs,
>timers, locks, ... which are handled by sys_info(). So, I think
>that it should be enough to handle this inside the sys_info() API.
>
>I do not want to say that my proposal was the best solution.
>I am sure that there are better ones. But we need to consider
>the gain vs. complexity.
>
>Honestly, I am already a bit scared by the complexity which
>we the sys_info() API added. And it is hard to imagine that
>adding another API would make it easier. But I might be wrong.
>
>Instead, it might make sense to integrate the conflicting
>subsystem-specific calls under the sys_info() API.
>I mean that, for example watchdog_hardlockup_check() won't
>call trigger_allbutcpu_cpu_backtrace() directly but
>it would call it via sys_info() API so that sys_info()
>could keep track of it. Something like:
>
>void sys_info_allbutcpu_bt(int cpu)
>{
>	trigger_allbutcpu_cpu_backtrace(cpu);
>	/*
>	 * The caller likely printed backtrace of the given @cpu
>	 * on its own. Prevent duplicate backtraces from all
>	 * CPUs with potential next sys_info() call.
>	 */
>	sys_info_done(SYS_INFO_ALL_BT);
>}
>
>But I am not sure if it is really easier to follow
>than calling sys_info_done() from the watchdog code.
>
>Some watchdogs try to optimize the output and print backtraces
>only from CPUs which are relevant for the given lockup.
>We should keep the logic for selecting the set of CPUs
>in the watchdog code. We just need to solve how to elegantly
>make sys_info() aware of it or at least about the more massive
>reports.
>
>Anyway, I would prefer to keep it simple until we see some problems
>in practice.
>
>Best Regards,
>Petr
>


I understand it's scary. To make a new file in the first place.

But I was a bit vague of what I wanted, and I'm sorry.

So, the reason why I'd suggest a new file, is because if any subsystem
Theoretically bypasses sys_info to log a lockup, this completely misses
the filter and duplicates the dump

My file would act as a generic lockless state machine that any
subsystem can update regardless of how they dump logs.

If you have any questions, feel absolutely free to ask! :)

Discussion is a way to make everyone happy!

Thanks!

