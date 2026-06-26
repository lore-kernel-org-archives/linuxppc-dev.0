Return-Path: <linuxppc-dev+bounces-23028-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E005C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 14:47:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmz6J6dMnz2yYd;
	Sat, 27 Jun 2026 00:47:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782485240;
	cv=none; b=nkkrjwbYSD1XB28v1FM4iSBP3Nv0MCA5O1HhraUr4Lr9pgqVNw0odjzBajQGpompqz8QuURmGA8F3fd4xqdBSIyauC1Y3ihDCSV46nTE5nVACxskwVYw62z4D1WBZa+b5sqjNhit8q+BhMgRxJLCCH3sFgDt8kPltNlbo6ySMd35MQiPboQ4JWWECVrKhTXDynv9T+HFXCdkeyAcAc39CAdbBy0KAaQRIJ3j601r8n5FOb1y6rN0O1CgmR4ghmhSgnq0aKpJ/Ogx5ZVkAwlfiump77lkgygcbK9Quc3YFxzQdkuLCBlAttz4AYUy72k2gGBN8e29hQN3qncnw2ncdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782485240; c=relaxed/relaxed;
	bh=KsD3Uuhb7V4xwmN32D9oiv/QfdIeYjME+PsD06WdL4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQpZDuuJB5SLe+c+K+nyEgFXIhQqQSjrSwZ5Vse0LMbK/N+zYG9iJH4kwrWrtRnXwWKHuHqOInJQFxGcLdVVyGjNvTGfR8ZhXGaz0uzm0hQl+RFwcpunISTL0fW0hFx8/iyHPp4ihD01ullkhIXJpcs5vybCuPHNhAxDjLE4LYZ51MQJSE7ytOjSFad40OAyAq4dsjozuO9ZKDUQGKW1xJ4l3MPRYL4nXcoevGpuLwshFu7L2PZ8ZyfCOuBZmHGxDpPVfgIInQR/KN+g9xko2vkWLkvo2Huip1gsDK20d02oFVjssWw0SIny7uDZFhPifBrI9CS6N0yGyD7aab23aQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=E2UJWNF+; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=E2UJWNF+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmz6H41vMz2yVv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2026 00:47:18 +1000 (AEST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-490ac357c55so9587525e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 07:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782485235; x=1783090035; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KsD3Uuhb7V4xwmN32D9oiv/QfdIeYjME+PsD06WdL4s=;
        b=E2UJWNF+wX0lLAGGqgaDPstVWi5TQnFmpuRI6QrCUvR5rlNAI+V79qNvWgjmdHAs/x
         9jRNRFj9Vi+5/qbhckT/tlCoumc/sW4Wt4qPaV0RdsogouG3UY1V8R5GYE76Lw2pb3W7
         iXi4Q6KZYBHVyj4/pds9v/20BmkkeK/IdQxoX8HsnW6WgaZPjrL5XN5se62LmVa8XXcw
         nMGg2z+FB7xTk6xV6LYSDK+QbD6XMHhnijiz/aRR+TW20kO974wBMOpcBY2s42f9niQo
         PTFx0KKUJXpkiB73uBbQAfqrjY3W/NU6RbcnL8vaMpADxlMoLg+PgidcAzv1r8iMU753
         /JNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782485235; x=1783090035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsD3Uuhb7V4xwmN32D9oiv/QfdIeYjME+PsD06WdL4s=;
        b=QnN0yZft6zQeFdOq7W8eB0poOxnZyA1usONnPT2OZJWzru3X9EH0AAnRQG5YRROsdK
         7ezU1AF2KL35zvG6PxvrbonAz7SKkticG0JnjzBVvJlVFNfcIQK2LXMw2Q69ePRlJVmr
         iJKtifrOwCz9CSsxpwf/rzXr7Igdybp3LRUa7cL0Tw3Ykfb4aEeBdL+TfJ+MR6nS2tKz
         6tM+8pS+G/WzuoHPtk2+kYae8mgJ701qS7n5cmavQ+vS9pKorywZCNKSFDz0VBQJ1My2
         TorKGE6IaRMLfLc/5L6ubU52f1VQDnGWQlf5JK6fnEhvv28RD9nunmwv2s589R2ZETtG
         7hqA==
X-Forwarded-Encrypted: i=1; AFNElJ8188TEHBdbRcsTN/TvlYyxFpzYTWZEvVqbO/JClJoGjnW0+IvUNyf5X+yHNCWxIzOF/fhdvI20kvxj94w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw3mDxBUW+wwggro2AFbS0yF5ib1PCBjmd483X8yTqFmdKs//+l
	ZlQbso6cCybJ9IRI9tcWUUQkLnx5SHBgjzHmOviomku+hPzRAIVL6NYxESErzBHXqcI=
X-Gm-Gg: AfdE7clJm+ELh/MLJafbZGYTEeWgEAnmh0sNuFt1Yy+W3doajejrpwOaPfPasqUh7ZR
	1GuZ+b1Ibd2kzcqOq1DN5phpES2TK0gEUVRoWm0kbsq/se3al3NomAq0Z04nWAIBEOa0zR49OJs
	FxzGSrQPdV/Nh20z9kT1COXP/cwk6y22iuw+B5ySnm73GVoZ0cDLH9Xqnyt+XKuluGPpIjmaXG/
	70pL5OpKWd3QCeQDn2rzlJzbEa2IvicQWU+1q0IkYvatxpFA91bftpgJnBmxJkMQHN/iZaefsYE
	XsphwKoxJuaqvwB6/qdpqGMfyORWGo0gT0uGZX7VSih6NQsc/4pDCS5QGtzdjXis+IF2UnQS3fs
	MXYoDoQPZ1PZ/+F2ULF8HeFRJ0Pm0QZ7q7cHJJ2kpaxR44QsBKPfly7k1wRriPpkopRI0S9c83T
	PGYmIlZcE+6OdHsUk=
X-Received: by 2002:a05:600c:4e55:b0:492:70af:1c35 with SMTP id 5b1f17b1804b1-49270af1d9emr2971675e9.35.1782485235337;
        Fri, 26 Jun 2026 07:47:15 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690a1a85sm145508505e9.15.2026.06.26.07.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 07:47:14 -0700 (PDT)
Date: Fri, 26 Jun 2026 16:47:12 +0200
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
Message-ID: <aj6Q8JcogaIaQit4@pathway.suse.cz>
References: <20260625152558.7450-1-include@grrlz.net>
 <20260625152558.7450-5-include@grrlz.net>
 <aj5TNB8cRtMNTtIT@pathway.suse.cz>
 <aj5tFiwhRqPkAkqU@pathway.suse.cz>
 <85F6E30C-EB1B-4BAF-9204-5174FD066EE0@grrlz.net>
 <4CF5AE3F-D7ED-47F8-A920-61D0AA078CF9@grrlz.net>
 <aj6MAxQKpLeK1Mp6@pathway.suse.cz>
 <688433ED-A478-43F7-9103-995398A6BF63@grrlz.net>
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
In-Reply-To: <688433ED-A478-43F7-9103-995398A6BF63@grrlz.net>

On Fri 2026-06-26 15:35:19, Bradley Morgan wrote:
> On June 26, 2026 3:26:11 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
> wrote:
> >On Fri 2026-06-26 13:32:38, Bradley Morgan wrote:
> >> On June 26, 2026 1:17:13 PM GMT+01:00, Bradley Morgan
> ><include@grrlz.net>
> >> wrote:
> >> >On June 26, 2026 1:14:14 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
> >> >wrote:
> >> >>On Fri 2026-06-26 12:23:50, Petr Mladek wrote:
> >> >>> On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
> >> >>> But it all becomes very hairy. We have several levels:
> >> >>> 
> >> >>>    + watchdog-all_bt-specific option, e.g.
> >> >>sysctl_hardlockup_all_cpu_backtrace
> >> >>> 
> >> >>>    + watchdog-specific si_info preferences, e.g. hardlockup_si_mask
> >> >>> 
> >> >>>    + panic-specific si_info: panic_print
> >> >>> 
> >> >>>    + universal fallback for any layer: kernel_si_info
> >> >>> 
> >> >>> Now, we try to check all these variables back and forth to
> >> >>> trigger all backtraces or to avoid triggering them.
> >> >>> And it clearly does not work well and the code is more and more
> >> >>> hairy.
> >> >>> 
> >> >>> I think about another approach. The word "waterfall" comes to my
> >mind.
> >> >>> Instead of checking all the settings back and forth, let's process
> >> >>> each setting one by one and just remember what has been done and
> >> >>> skip this in the next level.
> >> >>> 
> >> >>> All the si_info actions seems to dump a global system state.
> >> >>> So, it would make sense to remember the state in a global variable
> >> >>> even when it might be modified by more CPUs in parallel.
> >> >>> 
> >> Hmm.. new idea 
> >> 
> >> kernel/dump_filter.c ?
> >> 
> >> What this file could do is to handle a generic lockup state machine
> >> so any subsystem can log what it already dumped?
> >> 
> >> I know it may bloat, but it's better then cramming fixes in.
> >
> >I am not sure what exactly you would like to achieve but it sounds
> >a bit scary ;-)
> >
> >Anyway, we should not synchronize the watchdog reports against
> >each other, definitely. They are running in non-compatible contexts
> >(task vs interrupt vs NMI). Also we should not add any locking
> >because they usually print something when the system has enough
> >troubles.
> >
> >Also I think that it is not worth preventing duplicated backtraces
> >or reports from a single CPU. IMHO, it is not a big problem
> >in practice.
> >
> >So, we are down to large reports, like backtraces from all CPUs,
> >timers, locks, ... which are handled by sys_info(). So, I think
> >that it should be enough to handle this inside the sys_info() API.
> >
> >I do not want to say that my proposal was the best solution.
> >I am sure that there are better ones. But we need to consider
> >the gain vs. complexity.
> >
> >Honestly, I am already a bit scared by the complexity which
> >we the sys_info() API added. And it is hard to imagine that
> >adding another API would make it easier. But I might be wrong.
> >
> >Instead, it might make sense to integrate the conflicting
> >subsystem-specific calls under the sys_info() API.
> >I mean that, for example watchdog_hardlockup_check() won't
> >call trigger_allbutcpu_cpu_backtrace() directly but
> >it would call it via sys_info() API so that sys_info()
> >could keep track of it. Something like:
> >
> >void sys_info_allbutcpu_bt(int cpu)
> >{
> >	trigger_allbutcpu_cpu_backtrace(cpu);
> >	/*
> >	 * The caller likely printed backtrace of the given @cpu
> >	 * on its own. Prevent duplicate backtraces from all
> >	 * CPUs with potential next sys_info() call.
> >	 */
> >	sys_info_done(SYS_INFO_ALL_BT);
> >}
> >
> >But I am not sure if it is really easier to follow
> >than calling sys_info_done() from the watchdog code.
> >
> >Some watchdogs try to optimize the output and print backtraces
> >only from CPUs which are relevant for the given lockup.
> >We should keep the logic for selecting the set of CPUs
> >in the watchdog code. We just need to solve how to elegantly
> >make sys_info() aware of it or at least about the more massive
> >reports.
> >
> >Anyway, I would prefer to keep it simple until we see some problems
> >in practice.
> >
> >Best Regards,
> >Petr
> >
> 
> 
> I understand it's scary. To make a new file in the first place.
> 
> But I was a bit vague of what I wanted, and I'm sorry.
> 
> So, the reason why I'd suggest a new file, is because if any subsystem
> Theoretically bypasses sys_info to log a lockup, this completely misses
> the filter and duplicates the dump
> 
> My file would act as a generic lockless state machine that any
> subsystem can update regardless of how they dump logs.
> 
> If you have any questions, feel absolutely free to ask! :)
> 
> Discussion is a way to make everyone happy!

Honestly, I am more and more wondering whether your are a real person
or AI bot.

Best Regards,
Petr

