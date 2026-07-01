Return-Path: <linuxppc-dev+bounces-23272-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967F1C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 06:27:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqqmv22NGz2yQG;
	Wed, 01 Jul 2026 16:27:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782887231;
	cv=none; b=cz2CGononS+pUwcOqqJg/fcEq2dJZ55fbUEta59JirADKgpr7opWgvyube7Xkh6rXzP8pRM+PRGyJaMc6uPAvVKmh4puAHB+PaUYNNXN7aWU1drbaOBEhtBWvfW3ts2E/RPDd8NSPkcV5BkOGDG8oOHRvTTkegUju2SB2bJPmiyO9BWKcSAv5EmxW4FX81LCh7ZVO3ILKSltG7m64dk8ccsfVHSKyMtyuKv5L4yheH3gXFwX/DVplkT3iJm6zUQFdI07gtfdRrETLXjtqexmCKsf9IpSsZSzwPjWzjE4+iuyZprXcr9+AqWgJOw+/Ata8zxuDVYs45EwPQTu9CcI3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782887231; c=relaxed/relaxed;
	bh=hGCYkMeEnlJrRDst3rahvnHckTLy5Ax6DIursNnfCig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAo0KA7/DC2HyKjR2X64tj0hBq9eokqPsqa+tOfbW5QWnL75P9SE6EaF2fT7gmrr1GdGrBwN/yWOGKMJteBX+H++G/Q53lvU4vozPj/ZPvvu02mXnH0TEHLc7LSEi/Vojh70KLudQBXR+TiZ8UlU249YLCMqV7B4QaWfGC5hwFsFyC746L8F9cdo7VPqGEALwp1fQs5FJ16ZQIcQQGDqg7+mMTQJxCIYCX4HliItOKNatwosmwlA0qPw7i+9iemyOFxO7LYYdbuPqhcl51NcHxM6qrrlua9VmI5hCG7fwhiek89bjbQizK1o/zFDlBc1W/xQZzvWGpyL13u7mLk6hA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Txtag8FS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Txtag8FS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqqms6ZKZz2yN8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 16:27:09 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-37fc01881f2so304819a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 23:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782887226; x=1783492026; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hGCYkMeEnlJrRDst3rahvnHckTLy5Ax6DIursNnfCig=;
        b=Txtag8FS7ULeHy5CDvnJ/WKbckqS9xOaxxUV0gn915LDni8EvzOw2cbNKsYmfyRnwu
         H3uGADuJglcMrmLOSahXd4/Jhy3OW2ildNsdJ/9Bj5W9rtZZmp93kag/1XCPscLRwqcR
         fiEZoMifPOmcXlMIEn8Ly/OxzGifyF4WRXWei+71Fg1lqP3qfyr+QMjU9Az2xkOb5fRS
         MqRIAO83+I5Pctsv1hwa4ctV9s1q+3LaI59s1MzstpmUP7IrSw1UcRy42cOEjPLrFm9q
         lcM/83EVfnDYXX8ce0fL8NYdxE9Srk/EOYYvjFkq8Baa0fzppp4wczJ40RBW3w2qf6tN
         yz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782887226; x=1783492026;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGCYkMeEnlJrRDst3rahvnHckTLy5Ax6DIursNnfCig=;
        b=cRTx32S5hallZT8fKKjqLpfCdyILtrtQJvqvytwELV6ebxwmNRbNCvbsrP8RP4gJn2
         xdUMb84teiThxud1oInstl3/+rBQbqe8y8NYqYW6a/O8jnRKQYV+du5Kqcv8AGOxVEbQ
         rDZYHpIqyd/QPP0i136+08G07yoTuJWhJBHBENvn9pcH6joST0UOSkD9ad0tL7MngyJQ
         outB6aUbcTZ9zVxhb3k8WedwwCcRMsXn2K1ij2ZgaB37xJzXZTAVmIlOY7pnKRT961bE
         tu/JbZrpgZk0J4GW5EWs+IBPMv99hUpdwJ1a0zPITGqYXIsWY0+ZKNqDFMOsNaAEXAAe
         Zs5A==
X-Forwarded-Encrypted: i=1; AHgh+Rr3mxr7IoRmZ3A9kthq61u301N3QcPauJk5vKKyXX8+h/LDU2s557Uo+3gr/6BvJGZdZmPq7Ou4NMDxh0E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzQZQNy/uNYmC92EuCu4906CzFry3InjkbdFZSY5kQJVhVxGX1Z
	uESRF+6mXdv5nDDE+F6NN170ozdjXurfETgAh6pfv9dbmynvMR392Xqa
X-Gm-Gg: AfdE7cn4sLQZmLWlHpeFmhB6li75W3V532MJVAS7cyEsZiza8sykCK3w/gQfcvPabdd
	s+TE5cusYV+K5HRnOFBeqf5b0RJk0oUVB7PG4sXYJEqjx+byhggNJQh7/snk7TbDg73d1ZeDQLh
	0JZ7Gdc7TmuawYGKytQd16D3dJgnf0GpDwDrXZrQWHq/Ke5wdBSrJsw2YRQXhqzplFdot4BUXkI
	w53jjTN2jAH2ttpSc9fkx4pC8Ma85x6A0o/hubeAfyU2Y3h1HdRojcBqeN9bRnN4rF7iheMMmo2
	PKbzMVvgRljQLfKH8TRfPcR5JesDIbhqOdUnNLte+YlLqQwyvfnoargLcuZ3LbQefEtR7QDJ+2n
	iWZqlJqwg2ES8KF1aL30p4hbk052yLxu3MeG5J+RNrcK8RcN5MNYYVRbr2ILN6aZxzJLyS2xjnn
	eyam6H02ZxRoKd/L8y4ZQdJSlLKY8kgqFrdg4JO0O9tvDs4KCy499hyvcs
X-Received: by 2002:a17:90b:1850:b0:36b:a4c6:da96 with SMTP id 98e67ed59e1d1-380aa1a5f3bmr417571a91.25.1782887226298;
        Tue, 30 Jun 2026 23:27:06 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095ea9ef3sm1233117a91.17.2026.06.30.23.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 23:27:06 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:57:00 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, mkchauras@linux.ibm.com, ryan.roberts@arm.com, 
	ruanjinjie@huawei.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH V2] powerpc/syscall: Fix seccomp errno handling with
 GENERIC_ENTRY
Message-ID: <akSyVOsraz9waBf4@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260629182946.419552-1-mkchauras@gmail.com>
 <a58675e4-f5a6-4a21-9871-904aad33b683@linux.ibm.com>
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
In-Reply-To: <a58675e4-f5a6-4a21-9871-904aad33b683@linux.ibm.com>

On Wed, Jul 01, 2026 at 01:41:09AM +0530, Shrikanth Hegde wrote:
> Hi Mukesh.
> 
> On 6/29/26 11:59 PM, Mukesh Kumar Chaurasiya (IBM) wrote:
> > After enabling GENERIC_ENTRY on PowerPC, seccomp filters using
> > SCMP_ACT_ERRNO without an explicit errnoRet value return ENOSYS
> > (Function not implemented) instead of the expected EPERM (Operation
> > not permitted).
> > 
> > The issue occurs in system_call_exception() when syscall_enter_from_user_mode()
> > returns -1 to indicate the syscall should be skipped (e.g., blocked by seccomp).
> > The current code treats this -1 as a syscall number and compares it against
> > NR_syscalls. Since -1 is greater than NR_syscalls,
> > the code incorrectly returns -ENOSYS, overwriting the errno that seccomp
> > already set via syscall_set_return_value().
> > 
> > The generic entry code in syscall_trace_enter() calls __secure_computing(),
> > which sets the appropriate errno in regs->gpr[3] and returns -1 to signal
> > that the syscall should be skipped. However, the PowerPC syscall handler
> > was not checking for this -1 return value before validating the syscall
> > number.
> > 
> > Fix this by explicitly checking if syscall_enter_from_user_mode() returns
> > -1 and returning the value already set in regs->gpr[3] (the errno from
> > seccomp) before performing the syscall number validation.
> > 
> > Also Move the syscall_enter_from_user_mode() call and the seccomp/ptrace
> > skip check to after the NR_syscalls bounds check.
> > 
> > When syscall -1 was passed, the r0 == -1L check would trigger before
> > the NR_syscalls check, causing syscall_get_error() to return 0 instead
> > of -ENOSYS. This resulted in a silent success (ret=0, errno=0) instead
> > of the expected ENOSYS error.
> > 
> > By moving syscall_enter_from_user_mode() after the bounds check, an
> > initial syscall number of -1 is correctly rejected with -ENOSYS first.
> > The seccomp/ptrace skip path still works correctly for valid syscall
> > numbers that get overridden to -1 by seccomp or ptrace.
> > 
> > This aligns PowerPC's behavior with other architectures using GENERIC_ENTRY
> > and restores correct seccomp errno handling.
> > 
> > Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> > Reported-by: Michal Suchánek <msuchanek@suse.de>
> > Closes: https://lore.kernel.org/all/ajpp-_XnbF3UTM_E@kunlun.suse.cz/
> > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > ---
> > 
> > v1 -> v2:
> >   - Fix issues in the previous fix (Michal)
> > v1: https://lore.kernel.org/all/20260624171520.772408-1-mkchauras@gmail.com
> > 
> >   arch/powerpc/kernel/syscall.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> > index a9da2af6efa8..36d73933a311 100644
> > --- a/arch/powerpc/kernel/syscall.c
> > +++ b/arch/powerpc/kernel/syscall.c
> > @@ -20,7 +20,6 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> >   	syscall_fn f;
> >   	add_random_kstack_offset();
> > -	r0 = syscall_enter_from_user_mode(regs, r0);
> >   	if (unlikely(r0 >= NR_syscalls)) {
> >   		if (unlikely(trap_is_unsupported_scv(regs))) {
> > @@ -31,6 +30,12 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> >   		return -ENOSYS;
> >   	}
> > +	r0 = syscall_enter_from_user_mode(regs, r0);
> > +
> 
> I see many arch first do syscall_enter_from_user_mode and then check for return value.
> take x86 for example,
> 
> __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
> {
>         nr = syscall_enter_from_user_mode(regs, nr);
> 
>         if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
>                 /* Invalid system call, but still a system call. */
>                 regs->ax = __x64_sys_ni_syscall(regs);
>         }
> 
> }
> 
> So seccomp fails silently there if initial nr was -1?
> 
Hey,

No the -1 syscall ignores the error silently and returns 0.

From the above snippet from x86. Out behaviour also will remain same.
The reasoning for that i have given here
https://lore.kernel.org/all/akKnSqGUeFIGOfHb@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com/

Regards,
Mukesh
> 
> 
> > +	/* Seccomp or ptrace may have set return value, skip syscall */
> > +	if (unlikely(r0 == -1L))
> > +		return syscall_get_error(current, regs);
> > +
> >   	/* May be faster to do array_index_nospec? */
> >   	barrier_nospec();
> 
> Code per se, looks okay to me.

