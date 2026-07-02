Return-Path: <linuxppc-dev+bounces-23381-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CB5C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 09:39:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grX0X3Gt8z2xLk;
	Thu, 02 Jul 2026 19:39:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782985180;
	cv=none; b=OSrz+YldlHOwiivnWEvZtovzGwMx3wWe4UuuEiCpnncP8982LmhsnIySs2+AjH2/8psozRz/IY09Ln9WVtPhOHX+77Gft84VETnbJuzu6SpO/SNDn65lCfuKrPgPNtQKJnMaYM2vqup/LcvDbMbuzgBp3XJ/gebMIAOiy8mfcTR4D41W59KOZMWu+0v3Ba3uOMuuqQb3khdRucN5oafB1b6BPk+xMdckI80xGqE0P2SVkOLxswjTvTdaIbADO/Wg/+vl4lPSzKgNtgxgweTgXkZZvrHvDKFbvEq2aEKDebsE1+ErT5Dkexj6PNju1BMLX9bpmE7UJx2gvWF3uSOSDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782985180; c=relaxed/relaxed;
	bh=ZgRP16KUeE+dWv0+aKvooEttdeKCnCminXtIpQ9AT8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SU/3V1XlA6NxS/4OzpbAfNj1Xo2nFiZlIYy7w3PY0C3dOMIZ7I4ufofUJEODlNujY2OTKLjVDmvD54OPnoRzVPf4uRawwP5Hspw/mtCu4NFFPh3Nfd181vxYG2EVZcEPwiwS+0UjiKPWqXy2aM44Tvh+QVAUgkCiamgUP3TNFseKpk8tiG5+UuOZ1pm8l2EMa4hilp++OETrZyiB2IudkJYf2dePmdMWSn1xTUF0Mrgm61oK81gmF+XmJ/JXXbuUZjW961TS/KCcSapmPp5UwvuUfxixowz8hTvZ7RYIcltHTILQIWWR9H5MsoO4SkHJokRvNLOHPjqfne6OaHlP0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lSY++60q; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lSY++60q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grX0T6jJ2z2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 19:39:37 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-37cab825ec9so1568308a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 02:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782985175; x=1783589975; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZgRP16KUeE+dWv0+aKvooEttdeKCnCminXtIpQ9AT8o=;
        b=lSY++60qWaYWi6RCi7l8y/f2AWS7yHGqnsPX7JKN5RFsuN2mB8fhDNJaZr08IN3BgE
         VXvdrX9CvYhhabUjSvV5uzRKWaDQFdsHlkA9Ia1o55/rePeomJ0zhZ+td6AD7+eTnq+A
         MGvl/gsSiZnw34b9bYFpQnDx/4Y3ZwzxwOYvR7g2t3WCI8NcsdSWWJgCxps/Ejr2KGHM
         M6HoyZqFuYvxMixaSGXz8KMwVT31qLoTdIYawjo+rdNEacfmCNbxtyR7hhv8qDfISsLL
         kwQIEaRLK06PdQySJQRrabbTVwmPGCy4irOjLJG2xFYJPTrfIR51Xw1NEVZksFeST4Mv
         z5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985175; x=1783589975;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgRP16KUeE+dWv0+aKvooEttdeKCnCminXtIpQ9AT8o=;
        b=dFi14LAzexm+tPcsVkRDCcHO/tVI6HJGKRGutQbgClwF6Vj3hjUy7bsYfqQWssALJZ
         yUco5Qz/cUWXJuIEFRVgvdAaOA+WFqF1ypuOlJM53xiAQSCNw28QcRmQg91Jntb2GyO2
         P0bMSnsEROZse+0Zk2SO9D8X6U9EvWZELeYo78ZWXbE/zV7Uub0NJNFIQ0YnGj7eMnlo
         sOe5B72damip8QHhZaQSfW0QeAJcKhvXEudnripw/qJ/EGepMZYso3lQp2p+4V39YJ1b
         2b+Uws9HaMlhDQR7vwWl04OBOHV576mXrqpCSVTE5WyhB+tS6N9pqrF7+D9+vgj8tzC6
         3X5g==
X-Forwarded-Encrypted: i=1; AHgh+Ro5GmXTucIR0PJ7RXUBpNwpKCx64Co+ae3e3F3cse1uzu1pxZVFWkjA3cYq5PBE7kGOJyCqAbxfHEEo4w8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyEtPepb3EGwYof/6srh1lGynFRsxM42d5exBpkgI9/PL9jrzoZ
	2VtxuJVNZXihQgBS//nB+lMg1A7cPaSevS3CYfbbs7sNa9kO4V3YVahe
X-Gm-Gg: AfdE7clTSeZ1n2qvmK6GyNXkoVxdFW9cmOq6mBpVJaBr6kLO/3D3WvWbnNh+8uHu6m+
	CztiSdJw0g8lToMpCFy6jk+TEYuSjJviEDYcxKtoQwAANyTtgXwHE5tac/A+NKbRcO8va0vUwN0
	ehvCizkuaELE48XJ7PA5LfFC+JzTvDrXKQU5v+N8SMD5tz13A9vSISI+/yGtQTG4iMDVx+GwkF4
	2QF6nPHxhhnir8UBG2ZiLLT/UHOSkX0dU3CF91wwy2UsU6qgpXhBY/slkOKuNx/QI7x9/l7ujsz
	HBDhLTSyxKYsrIfLRjcPRF7yQ/DFrq/zuuEkM2ZLVO4tmP+uo7VtWHPQOBZ5/amTIxOnuxNOI7A
	2CSK0u6IXRM3RYOg8Q8rLymi4zvIzAqJ5OLKIXAajHZGylr74PvTzUbHPb7iAe8ycXOhh5JP/4k
	lbJZ8KY3A7itu2J6fo6+0rOTJyCsoL9/Eyg8CKKn6J488IA6w9HLfG8KRpqOm6
X-Received: by 2002:a17:90b:2249:b0:37f:d265:18c5 with SMTP id 98e67ed59e1d1-380aa18be9dmr5305981a91.18.1782985174822;
        Thu, 02 Jul 2026 02:39:34 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380e15c362asm774246a91.1.2026.07.02.02.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:39:34 -0700 (PDT)
Date: Thu, 2 Jul 2026 15:09:28 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, mkchauras@linux.ibm.com, 
	ryan.roberts@arm.com, ruanjinjie@huawei.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] powerpc/syscall: Fix seccomp errno handling with
 GENERIC_ENTRY
Message-ID: <akYxo34AUcCSwWx7@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260629182946.419552-1-mkchauras@gmail.com>
 <a58675e4-f5a6-4a21-9871-904aad33b683@linux.ibm.com>
 <akSyVOsraz9waBf4@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <akTExSO3ZT7iRtBa@kunlun.suse.cz>
 <akTJbfXPKc10Xemh@kunlun.suse.cz>
 <akTP_YJvGwln_xb_@kunlun.suse.cz>
 <akX6TL6v4aRPGdkk@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <akYwv5niv-oX8mYv@kunlun.suse.cz>
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
In-Reply-To: <akYwv5niv-oX8mYv@kunlun.suse.cz>

On Thu, Jul 02, 2026 at 11:34:55AM +0200, Michal Suchánek wrote:
> On Thu, Jul 02, 2026 at 11:20:03AM +0530, Mukesh Kumar Chaurasiya wrote:
> > On Wed, Jul 01, 2026 at 10:29:49AM +0200, Michal Suchánek wrote:
> > > On Wed, Jul 01, 2026 at 10:01:49AM +0200, Michal Suchánek wrote:
> > > > On Wed, Jul 01, 2026 at 09:41:57AM +0200, Michal Suchánek wrote:
> > > > > On Wed, Jul 01, 2026 at 11:57:00AM +0530, Mukesh Kumar Chaurasiya wrote:
> > > > > > On Wed, Jul 01, 2026 at 01:41:09AM +0530, Shrikanth Hegde wrote:
> > > > > > > Hi Mukesh.
> > > > > > > 
> > > > > > > On 6/29/26 11:59 PM, Mukesh Kumar Chaurasiya (IBM) wrote:
> > > 
> > > > > > > > diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> > > > > > > > index a9da2af6efa8..36d73933a311 100644
> > > > > > > > --- a/arch/powerpc/kernel/syscall.c
> > > > > > > > +++ b/arch/powerpc/kernel/syscall.c
> > > > > > > > @@ -20,7 +20,6 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> > > > > > > >   	syscall_fn f;
> > > > > > > >   	add_random_kstack_offset();
> > > > > > > > -	r0 = syscall_enter_from_user_mode(regs, r0);
> > > > > > > >   	if (unlikely(r0 >= NR_syscalls)) {
> > > > > > > >   		if (unlikely(trap_is_unsupported_scv(regs))) {
> > > > > > > > @@ -31,6 +30,12 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> > > > > > > >   		return -ENOSYS;
> > > > > > > >   	}
> > > > > > > > +	r0 = syscall_enter_from_user_mode(regs, r0);
> > > > > > > > +
> > > > > > > 
> > > > > > > I see many arch first do syscall_enter_from_user_mode and then check for return value.
> > > > > > > take x86 for example,
> > > > > > > 
> > > > > > > __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
> > > > > > > {
> > > > > > >         nr = syscall_enter_from_user_mode(regs, nr);
> > > > > > > 
> > > > > > >         if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
> > > > > > >                 /* Invalid system call, but still a system call. */
> > > > > > >                 regs->ax = __x64_sys_ni_syscall(regs);
> > > > > > >         }
> > > > > > > 
> > > > > > > }
> > > > > > > 
> > > > > > > So seccomp fails silently there if initial nr was -1?
> > > > > > > 
> > > > > > Hey,
> > > > > > 
> > > > > > No the -1 syscall ignores the error silently and returns 0.
> > > > > > 
> > > > > 
> > > > > There seems to be some inconsistency with the invalid syscalls.
> > > > > 
> > > > > Adapting the example from seccomp man page to ignore architecture I get
> > > > > on x86_64 (presumably with GENERIC_ENTRY since long ago):
> > > > > 
> > > > > ./a.out -2 55 /usr/bin/perl -MPOSIX -e '$!=0; my $r = syscall(-2, 0); print "ret=$r errno=".($!+0)." ($!)\n"'
> > > > > ret=-1 errno=55 (No anode)
> > > > > 
> > > > > but on ppc64le (with GENEREC_ENTRY):
> > > > > 
> > > > > ./a.out -2 55 /usr/bin/perl -MPOSIX -e '$!=0; my $r = syscall(-2, 0); print "ret=$r errno=".($!+0)." ($!)\n"'
> > > > > ret=-1 errno=38 (Function not implemented)
> > > > > 
> > > > > That said, behavior of seccomp on invalid syscalls is not particularly
> > > > > concerning. The tools that people typically use for constructing those
> > > > > filters typically require a valid syscall number.
> > > > > 
> > > > > It would be nice to align, though.
> > > > 
> > > > It is more concerning for SECCOMP_SET_MODE_STRICT or similar. So it
> > > > should be resolved to correctly execute seccomp even on invalid
> > > > syscalls. The syscall_enter_from_user_mode API is not particularly
> > > > well-suited for that, though.
> > > 
> > > In particular the fixup per
> > > https://lore.kernel.org/linuxppc-dev/akJzuEJRLniHk4Fi@kunlun.suse.cz/
> > > 
> > > handles some cases
> > > 
> > > ./a.out -2 55 /usr/bin/perl -MPOSIX -e '$!=0; my $r = syscall(-2, 0); print "ret=$r errno=".($!+0)." ($!)\n"'
> > > ret=-1 errno=55 (No anode)
> > > 
> > > but not -1
> > > 
> > > ./a.out -1 55 /usr/bin/perl -MPOSIX -e '$!=0; my $r = syscall(-1, 0); print "ret=$r errno=".($!+0)." ($!)\n"'
> > > ret=-1 errno=38 (Function not implemented)
> > > 
> > > which is the direct result of the ambiguous return value of
> > > syscall_enter_from_user_mode
> > > 
> > > Thanks
> > > 
> > > Michal
> > Hey Michal,
> > 
> > Yeah this seems to be a more complex thing than anticipated.
> > As per conversation on your another patch here
> > https://lore.kernel.org/all/BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com/
> > 
> > This patch seems to be redundant at this point.
> 
> Hello,
> 
> while improving the entry API is a fine goal it will take time if
> something can be even agreed on.
> 
> In the mantime we should provide a fix using the current API.
> 
> Inability to run container workloads is a significant regression.
> 
> Thanks
> 
> Michal

Yeah, i am working on a fix for now. Will post out a new version.

Regards,
Mukesh

