Return-Path: <linuxppc-dev+bounces-23015-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64817CDE00C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 10:27:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmsLr6WfCz2yYd;
	Fri, 26 Jun 2026 20:27:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a12:4180:dc1:929::42"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782469668;
	cv=none; b=gj1C6rC59geKTGrwfAGl5SOoQ3lh76nRc4k/denJHgak7aM0QkSar59GG6Fu/nJk1JQxO4vbm6oXhL8/fgLT8SlKYZ9HOUYpcURMsqbz5teXQQowCRfHLkLSXeVoc20k9tyMDLRw3MTnP4vRxTWsMWFDK0svMiJ4IzNwZAlzO3UWhOvrMcjZOWczpqe2Z8NiUSMFqA0sL7ylPNaTRvWzlLuxVd1c62qvktZYhS+DGXsLTLyCezY1V1XcxQixheoZidjLalcsVAGwYvJDmv2r1vYb02g38EK7G1ZbAO3VVQOhb0ZP3q3uv0IZRV4kuMZwgysp/Tk1K6v45FamkaibBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782469668; c=relaxed/relaxed;
	bh=e8nmnh3d5BbttwiwzGI22NcsfM8b00MokXdzihs8LZ8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=X34lJZEDSYIbSq1lDm9gFJZgYDRdNX5E5WwXb2fFEaRNPXhkiRG2zxptfRYMe0wMbLaZnNHW69wiJFpDDHHuYi4nTJuUu2umcMqf6rX1xWBnvYl9+yVGCzwnENk9CiecOX7XSnxtnPmg/QjrQ42NFMXQE28cCqXBJGp1TiFmHJmC7JR1D5M0/BmZM0lJEz9y7D0MsRs5DFKGDDyMg6UDjg0jAN3o1hRe3rpbYIWd7MQ5gJpv4BycccX71rqIyqLeZRm2vwKBGLWgLTMQRhCRRH3iofpq68ZKHtxCH3t4+M8s/hswIrhcjJyzQW8USt4xKOIYlCG//noqaL+TASw8pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=ohGumFxj; dkim-atps=neutral; spf=pass (client-ip=2a12:4180:dc1:929::42; helo=latitanza.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org) smtp.mailfrom=grrlz.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=ohGumFxj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=grrlz.net (client-ip=2a12:4180:dc1:929::42; helo=latitanza.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org)
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2a12:4180:dc1:929::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmsLp2bytz2yVv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 20:27:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782469659;
	bh=e8nmnh3d5BbttwiwzGI22NcsfM8b00MokXdzihs8LZ8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ohGumFxjjf0Raf9wsB+UZCbWDBoG8tHgnZ39bzDb+ibVEV0BmmGEqboD/yxIOeP8V
	 VnUzCDftXgMJNkufSCHcP0DTaGL8scUIdtaUqulvdHyPdMYl+9R/iNvbVxjFFdXCp1
	 49tN0YOLb4i+eztSVXFERQFSpV3k/YW6H0ZnxMSg=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4gmsLg257mzGpDM;
	Fri, 26 Jun 2026 10:27:39 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4gmsLf6jxlzGp8j;
	Fri, 26 Jun 2026 10:27:38 +0000 (UTC)
Date: Fri, 26 Jun 2026 11:27:40 +0100
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
In-Reply-To: <aj5TNB8cRtMNTtIT@pathway.suse.cz>
References: <20260625152558.7450-1-include@grrlz.net> <20260625152558.7450-5-include@grrlz.net> <aj5TNB8cRtMNTtIT@pathway.suse.cz>
Message-ID: <747CB5A4-119B-424F-84C4-5B06FF290C89@grrlz.net>
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

On June 26, 2026 11:23:48 AM GMT+01:00, Petr Mladek <pmladek@suse.com>
wrote:
>On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
>> panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping the
>> other CPUs. Do not ask sys_info() to handle that bit again later in the
>> panic path.
>> 
>> Use sys_info_with_filter() so panic_print=all_bt does not request more
>> output after the CPUs are stopped.
>> 
>> Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on
>system lockup")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bradley Morgan <include@grrlz.net>
>> ---
>>  kernel/panic.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/kernel/panic.c b/kernel/panic.c
>> index 213725b612aa..eb842823df61 100644
>> --- a/kernel/panic.c
>> +++ b/kernel/panic.c
>> @@ -680,7 +680,7 @@ void vpanic(const char *fmt, va_list args)
>>  	 */
>>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>>  
>> -	sys_info(panic_print);
>> +	sys_info_with_filter(panic_print, SYS_INFO_ALL_BT);
>
>Hmm, this prevents printing backtraces from all CPUs completely.
>But what if they were not printed?
>
>They might be printed by:
>
>static void panic_other_cpus_shutdown(bool crash_kexec)
>{
>	if (panic_print & SYS_INFO_ALL_BT)
>		panic_trigger_all_cpu_backtrace();
>
>[...]
>}
>
>But it checks only "panic_print" variable. It won't do anything
>when (panic_print == 0).
>
>In this case, we might still want to print the backraces when
>SYS_INFO_ALL_BT is set in kernel_si_info.
>
>>  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
>
>Of course, we might fix panic_other_cpus_shutdown() to check also
>kernel_si_info.
>
>But it all becomes very hairy. We have several levels:
>
>   + watchdog-all_bt-specific option, e.g. sysctl_hardlockup_all_cpu_backtrace
>
>   + watchdog-specific si_info preferences, e.g. hardlockup_si_mask
>
>   + panic-specific si_info: panic_print
>
>   + universal fallback for any layer: kernel_si_info
>
>Now, we try to check all these variables back and forth to
>trigger all backtraces or to avoid triggering them.
>And it clearly does not work well and the code is more and more
>hairy.
>
>I think about another approach. The word "waterfall" comes to my mind.
>Instead of checking all the settings back and forth, let's process
>each setting one by one and just remember what has been done and
>skip this in the next level.
>
>All the si_info actions seems to dump a global system state.
>So, it would make sense to remember the state in a global variable
>even when it might be modified by more CPUs in parallel.

Not a bad idea.

>I am going to think more about it.
>
>Please, do not send v4 until the discussion settles!

I'll hold on V4.

When you've finished discussing, could I have your suggested patch?
if I think there is issues. I'll fix it.

>Best Regards,
>Petr
>

Thanks!

