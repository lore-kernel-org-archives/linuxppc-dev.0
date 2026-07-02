Return-Path: <linuxppc-dev+bounces-23380-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402BCC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 09:35:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grWv83yxjz2xPb;
	Thu, 02 Jul 2026 19:35:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782984900;
	cv=none; b=fdeNlG4AVMfzt5rqpPn6bXYaFLs3V5IiAbO6xF3k4fHxxgsVmE6aU6Hbpu0kAsJ3oVdgkT2zhiWfGgmcQ5QO6trg8wV5sOevWJimv7wBZ71IiqO6olOrC984fVO7jIQ/2D5luXG6RRcACIlNtEz/+cwKxWfz6A7s68pZjQbP4ijXZK7Z0JEJ2mXMKlrYePJy0CwdD4CT0O4Lw/sGCC+OU9LffVV69Lk1+jkaahCuQIo/EPBHFxUkPC206WYwbLfRX8rtFAvsyTIVo4YB/vgCOGJu8s7nlSKnGlzzDZLzDQqLF8guZ9FMq9zVTD2R/tF8e+NzFurG8k+BYyTGhMsbYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782984900; c=relaxed/relaxed;
	bh=crECweoi6X3T5ijkfNfN3IqZbdbYDwOjdD5v/6wb6YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6KIRkNiRTNmlg36y4WvEVDln2BLB8IJQzNCteCMi5jFlWmHGYRUv+o00O1O1Kb9lYw1WzlYdP6+4ergkBANgzdcqxSdacKVowrMU1nFycV2qUGZcMZKIwdFitToKNjLlWvn0SNbzyXiA8cwEiT2kMVkINP6YzI2tHcTm1/ViXZ+HzAqqYZ1QFuFuQuAJW4uHDFSh5iVq6vPTtvXc7iCYJL6X7mIBN6wAY74hCg1Bqo9WTi4BoKyXPI6Yg9pLYeeLQELLs0euSyAvvNSufqbJkzjLjJHrFqAVq2F3RDolIu62nbsLNpTHHjl7ttam36Qmb47wVqfi/nnmu/K/iozpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grWv74ykqz2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 19:34:59 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0622B758AE;
	Thu,  2 Jul 2026 09:34:57 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Date: Thu, 2 Jul 2026 11:34:55 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	mkchauras@linux.ibm.com, ryan.roberts@arm.com,
	ruanjinjie@huawei.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] powerpc/syscall: Fix seccomp errno handling with
 GENERIC_ENTRY
Message-ID: <akYwv5niv-oX8mYv@kunlun.suse.cz>
References: <20260629182946.419552-1-mkchauras@gmail.com>
 <a58675e4-f5a6-4a21-9871-904aad33b683@linux.ibm.com>
 <akSyVOsraz9waBf4@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <akTExSO3ZT7iRtBa@kunlun.suse.cz>
 <akTJbfXPKc10Xemh@kunlun.suse.cz>
 <akTP_YJvGwln_xb_@kunlun.suse.cz>
 <akX6TL6v4aRPGdkk@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
In-Reply-To: <akX6TL6v4aRPGdkk@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 0622B758AE
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-2.00 / 50.00];
	REPLY(-4.00)[];
	RDNS_NONE(2.00)[]

On Thu, Jul 02, 2026 at 11:20:03AM +0530, Mukesh Kumar Chaurasiya wrote:
> On Wed, Jul 01, 2026 at 10:29:49AM +0200, Michal Suchánek wrote:
> > On Wed, Jul 01, 2026 at 10:01:49AM +0200, Michal Suchánek wrote:
> > > On Wed, Jul 01, 2026 at 09:41:57AM +0200, Michal Suchánek wrote:
> > > > On Wed, Jul 01, 2026 at 11:57:00AM +0530, Mukesh Kumar Chaurasiya wrote:
> > > > > On Wed, Jul 01, 2026 at 01:41:09AM +0530, Shrikanth Hegde wrote:
> > > > > > Hi Mukesh.
> > > > > > 
> > > > > > On 6/29/26 11:59 PM, Mukesh Kumar Chaurasiya (IBM) wrote:
> > 
> > > > > > > diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> > > > > > > index a9da2af6efa8..36d73933a311 100644
> > > > > > > --- a/arch/powerpc/kernel/syscall.c
> > > > > > > +++ b/arch/powerpc/kernel/syscall.c
> > > > > > > @@ -20,7 +20,6 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> > > > > > >   	syscall_fn f;
> > > > > > >   	add_random_kstack_offset();
> > > > > > > -	r0 = syscall_enter_from_user_mode(regs, r0);
> > > > > > >   	if (unlikely(r0 >= NR_syscalls)) {
> > > > > > >   		if (unlikely(trap_is_unsupported_scv(regs))) {
> > > > > > > @@ -31,6 +30,12 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> > > > > > >   		return -ENOSYS;
> > > > > > >   	}
> > > > > > > +	r0 = syscall_enter_from_user_mode(regs, r0);
> > > > > > > +
> > > > > > 
> > > > > > I see many arch first do syscall_enter_from_user_mode and then check for return value.
> > > > > > take x86 for example,
> > > > > > 
> > > > > > __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
> > > > > > {
> > > > > >         nr = syscall_enter_from_user_mode(regs, nr);
> > > > > > 
> > > > > >         if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
> > > > > >                 /* Invalid system call, but still a system call. */
> > > > > >                 regs->ax = __x64_sys_ni_syscall(regs);
> > > > > >         }
> > > > > > 
> > > > > > }
> > > > > > 
> > > > > > So seccomp fails silently there if initial nr was -1?
> > > > > > 
> > > > > Hey,
> > > > > 
> > > > > No the -1 syscall ignores the error silently and returns 0.
> > > > > 
> > > > 
> > > > There seems to be some inconsistency with the invalid syscalls.
> > > > 
> > > > Adapting the example from seccomp man page to ignore architecture I get
> > > > on x86_64 (presumably with GENERIC_ENTRY since long ago):
> > > > 
> > > > ./a.out -2 55 /usr/bin/perl -MPOSIX -e '$!=0; my $r = syscall(-2, 0); print "ret=$r errno=".($!+0)." ($!)\n"'
> > > > ret=-1 errno=55 (No anode)
> > > > 
> > > > but on ppc64le (with GENEREC_ENTRY):
> > > > 
> > > > ./a.out -2 55 /usr/bin/perl -MPOSIX -e '$!=0; my $r = syscall(-2, 0); print "ret=$r errno=".($!+0)." ($!)\n"'
> > > > ret=-1 errno=38 (Function not implemented)
> > > > 
> > > > That said, behavior of seccomp on invalid syscalls is not particularly
> > > > concerning. The tools that people typically use for constructing those
> > > > filters typically require a valid syscall number.
> > > > 
> > > > It would be nice to align, though.
> > > 
> > > It is more concerning for SECCOMP_SET_MODE_STRICT or similar. So it
> > > should be resolved to correctly execute seccomp even on invalid
> > > syscalls. The syscall_enter_from_user_mode API is not particularly
> > > well-suited for that, though.
> > 
> > In particular the fixup per
> > https://lore.kernel.org/linuxppc-dev/akJzuEJRLniHk4Fi@kunlun.suse.cz/
> > 
> > handles some cases
> > 
> > ./a.out -2 55 /usr/bin/perl -MPOSIX -e '$!=0; my $r = syscall(-2, 0); print "ret=$r errno=".($!+0)." ($!)\n"'
> > ret=-1 errno=55 (No anode)
> > 
> > but not -1
> > 
> > ./a.out -1 55 /usr/bin/perl -MPOSIX -e '$!=0; my $r = syscall(-1, 0); print "ret=$r errno=".($!+0)." ($!)\n"'
> > ret=-1 errno=38 (Function not implemented)
> > 
> > which is the direct result of the ambiguous return value of
> > syscall_enter_from_user_mode
> > 
> > Thanks
> > 
> > Michal
> Hey Michal,
> 
> Yeah this seems to be a more complex thing than anticipated.
> As per conversation on your another patch here
> https://lore.kernel.org/all/BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com/
> 
> This patch seems to be redundant at this point.

Hello,

while improving the entry API is a fine goal it will take time if
something can be even agreed on.

In the mantime we should provide a fix using the current API.

Inability to run container workloads is a significant regression.

Thanks

Michal

