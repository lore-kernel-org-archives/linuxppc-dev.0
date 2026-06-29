Return-Path: <linuxppc-dev+bounces-23095-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF762C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 12:54:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpmSn2mDxz2yT0;
	Mon, 29 Jun 2026 22:54:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a11:7980:1::2:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782737673;
	cv=none; b=E8vG7+gmqCJIGwgPwyT+x4X1SYLogfggjUWyd2qwBAL9flCFS+mwixmzo3AafRnWEIgLRZADVtpX/gJ8fm6lwj/Ga+9s3gyW35Hv+SSkIzjLx2Qb908xSNxQ6vTmttANJ8Ffvs7y4w03BxeE/kl9RHr3rnmHyqVjKT/28BRT4dSys2ezqr4rOOKxgtUA8xF/VOp2ejnq+GlfmAYEXHjkkLNuFzY5YW2J2AlQ/iQ/5z4zdLdIbkKYzRhxM5/03nfY1GN94QpFiAaEkzvsJPDYFDbXYo2OZh76RTl0SIkXy9mhBsEcxNPRp5pPUjjPYLk6yEYRzlvqidzQlytmseaRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782737673; c=relaxed/relaxed;
	bh=UHUQRvDxYITmVwJqOWXIA6FbFpYX5crfejyYhqfNw4I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RmnN5x6k51P/oLtxJVh/eif2p9rrdNxcbHvAp1yqfVIC9jy/CcNYPWDTMhMCIzN2zav23WeGxbkJDT7dohm9SnyWEgOQU3eDhWUtNnit8ZXunAh4tC+J16x4y1ruiaJtax6xeEeUZNYRXYC79+NWysfUu+7KML2/3OO2C5Bt1b0JIvxcgdFs6GwnCIH71J1URgfsQjPPLOk0/GZ1BTqsRIsygbXCl295szeq1LFUuwZ9C9UUuwtln+TDD4QwOfMJT19hwc+76ICEeGYBI0Gw3Dh/xH5qTq21nSQA3XPbktgJtltjeSxcggWjISWXqZpAmfF+Qf4lknC55P64lb1P7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=WDetH3qX; dkim-atps=neutral; spf=pass (client-ip=2a11:7980:1::2:0; helo=confino.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org) smtp.mailfrom=grrlz.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=WDetH3qX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=grrlz.net (client-ip=2a11:7980:1::2:0; helo=confino.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org)
Received: from confino.investici.org (confino.investici.org [IPv6:2a11:7980:1::2:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpmSk32lMz2ySS
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 22:54:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782737660;
	bh=UHUQRvDxYITmVwJqOWXIA6FbFpYX5crfejyYhqfNw4I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=WDetH3qXTPfYUMMVLgKKdgLCjJGFOGE1hzMktByZ01Y6g2pLwMGDqIOWJWebNLGm9
	 82z4IAsviEKmPgjYzNAIaix1+rB/YoHBQlVLZFpKBms2BKk/HjzcBgbvgyDi3z9pbw
	 Z7zg4HxqRbVZl1AfxIy7SVjU67evtbCAhg+xPeQk=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gpmSX3Q7bz110G;
	Mon, 29 Jun 2026 12:54:20 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gpmSX0XQWz110B;
	Mon, 29 Jun 2026 12:54:20 +0000 (UTC)
Date: Mon, 29 Jun 2026 13:54:18 +0100
From: Bradley Morgan <include@grrlz.net>
To: Feng Tang <feng.tang@linux.alibaba.com>, Petr Mladek <pmladek@suse.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_4/4=5D_panic=3A_use_sys=5Finfo=5Fwi?=
 =?US-ASCII?Q?th=5Ffilter=28=29_to_avoid_duplicate_backtraces?=
In-Reply-To: <akJZxCTlLcwubqi2@U-2FWC9VHC-2323.local>
References: <20260625152558.7450-1-include@grrlz.net> <20260625152558.7450-5-include@grrlz.net> <aj5TNB8cRtMNTtIT@pathway.suse.cz> <aj5tFiwhRqPkAkqU@pathway.suse.cz> <akJZxCTlLcwubqi2@U-2FWC9VHC-2323.local>
Message-ID: <E482A23D-4E1C-42C0-9D07-83C6CDFD1546@grrlz.net>
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

On 29 June 2026 12:40:52 BST, Feng Tang <feng.tang@linux.alibaba.com>
wrote:
>On Fri, Jun 26, 2026 at 02:14:14PM +0200, Petr Mladek wrote:
>> On Fri 2026-06-26 12:23:50, Petr Mladek wrote:
>> > On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
>> > > panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping
>the
>> > > other CPUs. Do not ask sys_info() to handle that bit again later in
>the
>> > > panic path.
>> > > 
>> > > Use sys_info_with_filter() so panic_print=all_bt does not request
>more
>> > > output after the CPUs are stopped.
>> > > 
>> > > Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys
>info on system lockup")
>> > > Cc: stable@vger.kernel.org
>> > > Signed-off-by: Bradley Morgan <include@grrlz.net>
>> > > ---
>> > >  kernel/panic.c | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > > 
>> > > diff --git a/kernel/panic.c b/kernel/panic.c
>> > > index 213725b612aa..eb842823df61 100644
>> > > --- a/kernel/panic.c
>> > > +++ b/kernel/panic.c
>> > > @@ -680,7 +680,7 @@ void vpanic(const char *fmt, va_list args)
>> > >  	 */
>> > >  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>> > >  
>> > > -	sys_info(panic_print);
>> > > +	sys_info_with_filter(panic_print, SYS_INFO_ALL_BT);
>> > 
>> > Hmm, this prevents printing backtraces from all CPUs completely.
>> > But what if they were not printed?
>> > 
>> > They might be printed by:
>> > 
>> > static void panic_other_cpus_shutdown(bool crash_kexec)
>> > {
>> > 	if (panic_print & SYS_INFO_ALL_BT)
>> > 		panic_trigger_all_cpu_backtrace();
>> > 
>> > [...]
>> > }
>> > 
>> > But it checks only "panic_print" variable. It won't do anything
>> > when (panic_print == 0).
>> > 
>> > In this case, we might still want to print the backraces when
>> > SYS_INFO_ALL_BT is set in kernel_si_info.
>> > 
>> > >  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
>> > 
>> > Of course, we might fix panic_other_cpus_shutdown() to check also
>> > kernel_si_info.
>> > 
>> > But it all becomes very hairy. We have several levels:
>> > 
>> >    + watchdog-all_bt-specific option, e.g.
>sysctl_hardlockup_all_cpu_backtrace
>> > 
>> >    + watchdog-specific si_info preferences, e.g. hardlockup_si_mask
>> > 
>> >    + panic-specific si_info: panic_print
>> > 
>> >    + universal fallback for any layer: kernel_si_info
>> > 
>> > Now, we try to check all these variables back and forth to
>> > trigger all backtraces or to avoid triggering them.
>> > And it clearly does not work well and the code is more and more
>> > hairy.
>> > 
>> > I think about another approach. The word "waterfall" comes to my mind.
>> > Instead of checking all the settings back and forth, let's process
>> > each setting one by one and just remember what has been done and
>> > skip this in the next level.
>> > 
>> > All the si_info actions seems to dump a global system state.
>> > So, it would make sense to remember the state in a global variable
>> > even when it might be modified by more CPUs in parallel.
>> > 
>> > I am going to think more about it.
>> 
>> I have created a POC using Gemini. I haven't tested it.
>> But it looks acceptable. And the logic seems to be more
>> straightforward.
>> 
>> One drawback is that it requires adding the _reset()
>> call for all sys_info() callers. It is fine in principle
>> but it might complicate back-porting because all changes
>> have to be done in one patch.
>> 
>> But honestly, this is a nice to have fix. Most people could
>> live happily without it.
>> 
>> From 3c66436d9978030845a96bfaedd6b914536e2ac4 Mon Sep 17 00:00:00 2001
>> From: Petr Mladek <pmladek@suse.com>
>> Date: Fri, 26 Jun 2026 13:55:41 +0200
>> Subject: [POC] sys_info: Introduce state-tracking APIs to prevent
>duplicate
>>  backtraces
>> 
>> In watchdog, panic, and hung task detection scenarios, sys_info() can
>> be called multiple times or alongside direct backtrace triggers like
>> trigger_allbutcpu_cpu_backtrace(). This results in identical backtraces
>> being dumped repeatedly from all CPUs, cluttering the kernel log and
>> delaying or obscuring critical debug details.
>> 
>> Introduce a state tracking bitmask and associated helpers:
>> - sys_info_done(mask): Marks specific sys_info bits as already printed.
>> - sys_info_reset(): Resets the tracking state.
>> - sys_info_is_done(mask): Checks if all bits in the mask have been
>printed.
>> 
>> Update sys_info() to automatically filter out already printed bits
>> using this state. Integrate these APIs with the generic hardlockup
>> and softlockup watchdogs, the PowerPC watchdog, the hung task detector,
>> and the panic core. This ensures that each piece of system information
>> and backtrace output is printed at most once per lockup/panic event,
>> and the state is reset cleanly when a lockup does not trigger a panic.
>> 
>> Races between sys_info() callers are ignored. It should be acceptable
>> because the output from various watchdogs has never been synchronized.
>> And panic() never returns.
>> 
>> Assisted-by: gemini-1.5-flash
>> Signed-off-by: Petr Mladek <pmladek@suse.com>
>
>Yep. There are cases that people want panic on task-hung or sw/hw lockup,
>and this could remove much duplication of sys info dump, thanks!
>
>Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>

Thanks,

im feeling a new file to do all the force panic jazz, but putting tape
on sys_info.c isn't bd either.

>> ---
>>  arch/powerpc/kernel/watchdog.c | 13 ++++++++++---
>>  include/linux/sys_info.h       |  3 +++
>>  kernel/hung_task.c             |  2 ++
>>  kernel/panic.c                 |  4 +++-
>>  kernel/watchdog.c              | 10 ++++++++--
>>  lib/sys_info.c                 | 30 +++++++++++++++++++++++++++++-
>>  6 files changed, 55 insertions(+), 7 deletions(-)
>

Thanks!

