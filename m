Return-Path: <linuxppc-dev+bounces-27572-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751C0C982CF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 13:12:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlx4c6c2Bz2y2W;
	Thu, 17 Sep 2026 23:12:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789650752;
	cv=none; b=HQ/bdNmP1hh1cKBi1ZO17mw4pDX4dsaY8jQs+Obv7WNt3AnPrUSP/yTqSHppckrnsOImC/afdCC3odX9cb6Rp4snsfVp13y0uivhwwJjnIQOBdDXLIu+nKXAbGjsfw3+lBzIqVaFtEGuVUebXua90+JVKEuId3ZAYu0yNIOUCwgMHaGadxzcgK3+QaxBBFGg8bzp+6qzliU8t+buuS/LO8Z8Ie9DBb1UhXciwsa2F+fCwmy2/YwOyyYs2sjHHMve9AIGmMy6i29IarBZnaYjETeZzRCtUsig0vuRXMpwyKtu2kxOmaLL43rcEI/fGhKNpFoCuyFsVbSOOKev3t8sbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789650752; c=relaxed/relaxed;
	bh=uWdx2xw236k6i8/OGgPQIhkjLT4pCnZCIOdttmQ2gHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OA/fNK+dTQqsxG6/1RkAn1jYFoh3iwytmDc8IsXncqxfPQEFvvEea29y+8Jnb+7uy/Q6PwrkSXs1bJ5yB8zjGvTGsfdBeQ5lK0hsGb0ZkqX6DPE+1cLTl7dCJqQyYzWLEqzHJDicfAS7zQ8LUDirM+zpVVTn6gIVXQY3tsG8PNA/mZr96flsZBydqj19Vw9FS+U9rJxhOkKITDZuWlLNtAkEpAZbF0YwQ4iyRZ3Yi1X4saPQKnO5msW5HbTFLZNmXhS3BI569QJdTbn1AAs0tyn+ctQ2YzTvpsryhiOxnL9qT1sgN0V4dH2BnkK3t/BT4sjLoImMdCFs4Q6ojCkS+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlx4c0Xntz2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 23:12:31 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38584220CE;
	Thu, 17 Sep 2026 13:12:27 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Date: Thu, 17 Sep 2026 15:12:26 +0200
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
	Narayana Murty N <nnmlinux@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [Linux PPC] Disable PREEMPT
Message-ID: <aqvnOg9JfkM2k0TX@kunlun.suse.cz>
References: <aqKUhHb9UTfVq4As@kunlun.suse.cz>
 <aqKfsVArHHaIK6M9@kunlun.suse.cz>
 <baeb1ae4-7c0f-4e4e-8fc5-09367cb7c4e9@linux.ibm.com>
 <aqfTU79SlNB3ykDi@kunlun.suse.cz>
 <25cf64ab-2a32-4d4c-a0c7-2e9007c276d4@linux.ibm.com>
 <aqj1KxZttNgY5ZVR@kunlun.suse.cz>
 <ba9759d0-b1f2-4b33-aff5-769cf89bd584@linux.ibm.com>
 <9b58bd58-d0e4-463e-bff9-e33b153b2987@linux.ibm.com>
 <aqu9hA1Bq58GFrVw@kunlun.suse.cz>
 <b2a5d53f-05e8-48ae-adb7-12fc74523b4e@linux.ibm.com>
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
In-Reply-To: <b2a5d53f-05e8-48ae-adb7-12fc74523b4e@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 38584220CE
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-2.00 / 50.00];
	REPLY(-4.00)[];
	RDNS_NONE(2.00)[]
X-Rspamd-Action: no action

On Thu, Sep 17, 2026 at 03:58:42PM +0530, Shrikanth Hegde wrote:
> Hi Michal,
> 
> On 9/17/26 3:44 PM, Michal Suchánek wrote:
> > Hello,
> > 
> > On Wed, Sep 16, 2026 at 11:41:38PM +0530, Shrikanth Hegde wrote:
> > > Hi Michal,
> > > 
> > > > 
> > > > It seems easy to re-create.
> > > > The key is running bcc/bpf program in parallel to kernel build.
> > > > 
> > > > For example, these two in parallal, leads to stack corruption panic.
> > > > Stacktrace does differ sometimes.
> > > > 
> > > > ./funccount  rcu* -d 100
> > > > make -j 32
> > > > 
> > > > Boom. Will try to debug this further.
> > > 
> > > A bit more debugging.
> > > 
> > > 1. A few functions seems to crash, specially ones that call schedule.
> > >     So picked schedule itself for tracing
> > > 2. Used plain ftrace. No crash.
> > > 3. Used kprobes. Boom. Crash appears. But this helped to avoid BPF JIT, or BCC part of it.
> > > 4. Did some preempt count validation with annotations. Seems to be holding fine.
> > > 5. Since unlock can call schedule while tracing schedule, there is possible looping.
> > >     Need to see further why it happens to be crashing there. Maybe regs or paca
> > >     handling needs a closer look.
> > > 
> > > For now, below patch helps to keep the system stable under kprobes, bcc tools.
> > > I will look further into see why exactly it is crashing and below one is going to
> > > be the proper fix or not.
> > > 
> > > Feel free to give it a try.
> > 
> > thanks for the patch.
> > 
> > While it is mangled by the e-mail client in different way compared to
> > the previous patch it does seem to mitigate the issue.
> 
> Thanks for trying.
> 
> > 
> > As it is unlikely the board where KVM lockup was originally observed is
> > running kpbobes it will probably not address the original problem.
> > 
> 
> Give it a try.
> 
> I am suspecting both lockup, stack corruptions are secondary symptoms here.
> While recreate, I have different type of traces.

Yes, it does work for the crash I see. However, we hijacked the report
of KVM locking up on FSL Cyrus+, and that is likely a different problem
still not addressed.

Thanks

Michal

> 
> > Thanks
> > 
> > Michal
> > 
> > > 
> > > ---
> > >   arch/powerpc/kernel/kprobes-ftrace.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
> > > index f8208c027148..bcb1e8a8995d 100644
> > > --- a/arch/powerpc/kernel/kprobes-ftrace.c
> > > +++ b/arch/powerpc/kernel/kprobes-ftrace.c
> > > @@ -63,7 +63,9 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
> > >   		__this_cpu_write(current_kprobe, NULL);
> > >   	}
> > >   out:
> > > +	preempt_disable_notrace();
> > >   	ftrace_test_recursion_unlock(bit);
> > > +	preempt_enable_no_resched_notrace();
> > >   }
> > >   NOKPROBE_SYMBOL(kprobe_ftrace_handler);
> > > -- 
> > > 2.52.0
> 

