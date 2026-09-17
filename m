Return-Path: <linuxppc-dev+bounces-27562-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0DBC88E72
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 10:14:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hls7N1l4zz2xLf;
	Thu, 17 Sep 2026 20:14:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789640080;
	cv=none; b=nnCSc9/+dTPefGvKsK9yp/XvJDZfr8JGhgQxv3DjyWZWzwwOICwisjlHqWGAfctpTGI9BRy7gcdcysZkmFHFQCKq/+xelQNwMYvdhv9+3xRJCl2W2NqWJIFCgeEBJ7rv6HqonIDGjmD52gqtZyAB3FggduDHNdh2u3qO8gS7tG6pa7fShOGmTkijpXkFzUwkZNwoQthlo7QWcC2vpKVzwrF6QrgPZibPsAPjioN6BVuytAwFYfdukXGKtqO0LIL3LegwntaF52N6dIQHfLtDqRfa537R2M4dtOooFnK7ilho1Yb4f55j70ubDtpygU4l7z5N8w7CmMwkBsQk+a0o5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789640080; c=relaxed/relaxed;
	bh=QIjTT/MtXFqDcGDsSxZe1T7+BQLISYLbkb8dMbAoqTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/GK8VOtJK/uQWsKKkjkYwdwbThivAb4ZfJwrpRIO3KvPSbgiEOc8pbkRN/1blKPkRcr7QRhij9bnUcmv2Yq6fSo79ecZogrdZWkK/eTY7E8a8IghcX20mqy3HExJV6z0cyewvDyIeGoI20T4FZ/DCcS3hBei05vQEuJ/lG1B5uiLi9RNPf6WLeSHFXfYarWjHS7L69Cytx6dorlgM74+bYG9bn4UCOwus25LZ7vCKu7Mip97QT2ihS7oAIIK6af1fdCYNfvd2NmhYDlwzOXBxmQEO1/xD3P4LZYTWiM46R6zcWYiAT5uslxW3DIMMhjANTuTSyI8ckzOz8s2nWpLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hls7L58yLz2xJJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 20:14:38 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B6B811F78E;
	Thu, 17 Sep 2026 10:14:29 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Date: Thu, 17 Sep 2026 12:14:28 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>, harshpb@linux.ibm.com,
	Gautam Menghani <gautam@linux.ibm.com>, amachhiw@linux.ibm.com,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
	mad skateman <madskateman@gmail.com>,
	Christian Zigotzky <info@xenosoft.de>,
	Samir M <samir@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Narayana Murty N <nnmlinux@linux.ibm.com>
Subject: Re: [Linux PPC] Disable PREEMPT
Message-ID: <aqu9hA1Bq58GFrVw@kunlun.suse.cz>
References: <aqJxcWC1dWKITCav@kunlun.suse.cz>
 <393117bc-094e-4c47-b061-f255f5bff937@linux.ibm.com>
 <aqKUhHb9UTfVq4As@kunlun.suse.cz>
 <aqKfsVArHHaIK6M9@kunlun.suse.cz>
 <baeb1ae4-7c0f-4e4e-8fc5-09367cb7c4e9@linux.ibm.com>
 <aqfTU79SlNB3ykDi@kunlun.suse.cz>
 <25cf64ab-2a32-4d4c-a0c7-2e9007c276d4@linux.ibm.com>
 <aqj1KxZttNgY5ZVR@kunlun.suse.cz>
 <ba9759d0-b1f2-4b33-aff5-769cf89bd584@linux.ibm.com>
 <9b58bd58-d0e4-463e-bff9-e33b153b2987@linux.ibm.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b58bd58-d0e4-463e-bff9-e33b153b2987@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: B6B811F78E
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.00 / 50.00];
	REPLY(-4.00)[];
	RDNS_NONE(2.00)[]

Hello,

On Wed, Sep 16, 2026 at 11:41:38PM +0530, Shrikanth Hegde wrote:
> Hi Michal,
> 
> > 
> > It seems easy to re-create.
> > The key is running bcc/bpf program in parallel to kernel build.
> > 
> > For example, these two in parallal, leads to stack corruption panic.
> > Stacktrace does differ sometimes.
> > 
> > ./funccount  rcu* -d 100
> > make -j 32
> > 
> > Boom. Will try to debug this further.
> 
> A bit more debugging.
> 
> 1. A few functions seems to crash, specially ones that call schedule.
>    So picked schedule itself for tracing
> 2. Used plain ftrace. No crash.
> 3. Used kprobes. Boom. Crash appears. But this helped to avoid BPF JIT, or BCC part of it.
> 4. Did some preempt count validation with annotations. Seems to be holding fine.
> 5. Since unlock can call schedule while tracing schedule, there is possible looping.
>    Need to see further why it happens to be crashing there. Maybe regs or paca
>    handling needs a closer look.
> 
> For now, below patch helps to keep the system stable under kprobes, bcc tools.
> I will look further into see why exactly it is crashing and below one is going to
> be the proper fix or not.
> 
> Feel free to give it a try.

thanks for the patch.

While it is mangled by the e-mail client in different way compared to
the previous patch it does seem to mitigate the issue.

As it is unlikely the board where KVM lockup was originally observed is
running kpbobes it will probably not address the original problem.

Thanks

Michal

> 
> ---
>  arch/powerpc/kernel/kprobes-ftrace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
> index f8208c027148..bcb1e8a8995d 100644
> --- a/arch/powerpc/kernel/kprobes-ftrace.c
> +++ b/arch/powerpc/kernel/kprobes-ftrace.c
> @@ -63,7 +63,9 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
>  		__this_cpu_write(current_kprobe, NULL);
>  	}
>  out:
> +	preempt_disable_notrace();
>  	ftrace_test_recursion_unlock(bit);
> +	preempt_enable_no_resched_notrace();
>  }
>  NOKPROBE_SYMBOL(kprobe_ftrace_handler);
> -- 
> 2.52.0

