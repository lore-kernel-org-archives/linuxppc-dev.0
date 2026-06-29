Return-Path: <linuxppc-dev+bounces-23121-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA07C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 17:03:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpszR6mYcz2yH4;
	Tue, 30 Jun 2026 03:02:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782752579;
	cv=none; b=Ktm1WOTPSBZqpTMOuHWpeY7YMGJJACDEghHIvK/P1Lzgi66DDkU0zLv0dZoL4FF+2fuIJlGnkfCYymwjwiLfz2At5JpTdqzllfoUuMfOoI+uhIe0NKPJrNF5LxoxWuzj9HSpVvSWOHy7QwSKJuggYc7NN63equelXZJaJ/iLVWgscew9qt9JRoqd9iuMzlH15EmkaN8piddLlDBcMtS4Q5KOqEQzhV0+L3vCIJMN8zt5lZwPGNeW7Kszmpxj/YDQGlba0Yf7vKGNTJ2gQt2QQSShfuhzr4qZUdtQ6u2kH105N1NrQX5JE/75eOA1EjSB9outiA7BAICV9/66BkFbjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782752579; c=relaxed/relaxed;
	bh=7pxf2OoaUIybzoovXUga+9ZL7SNkE8e+Vjz2qilX3lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbH1rpEj+vxwZPCQp2d5VYwBUvSqSG5ZnbtRURSmHir1eg8nvKU7tRG13jg88NiX7ZcEfT6oNIHN9UQkmIsZIKKhn3Gi2/ttfG0mkYxTOS/Mh/EsjaEX8SGfB/OHGmL8dOvf/ddADyMHXIYHXOF0WAWIBQVe2E2jRdojJinqWKsFukPynH4orNYIemgxcalodJnxd/tjVPUmKZ7/bmy+36Fi7pZd71blM1TCtLSkYvuaXBG1Uxqmm+pgb7Ud/MnlcWNfSyoAsHKfmVD996ZVDx5LLgVszO0UP31Dx82ah480a2oPZHDub515DAUiUF5pH7Y4VzkDVl0tSuKWXaznYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mskltsFN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mskltsFN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com [IPv6:2607:f8b0:4864:20::1335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpszQ6S06z2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 03:02:58 +1000 (AEST)
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-30c591fb1cbso5608106eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 10:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782752575; x=1783357375; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7pxf2OoaUIybzoovXUga+9ZL7SNkE8e+Vjz2qilX3lk=;
        b=mskltsFNwWMEyE+cz3xL3sDpP5rIjwEUDq9NhqMWAb5qrpm+bWF4yLCcV+gysrBWq9
         S1Ot8OcdZ8ESnkIvRl561ZM2AaDeszHz5W19mnR+Qfi/FSag4ueGr9/Utrv87gK6bumL
         QVYMAuFQ1V5SrvJzvHP73BlqXXmz2kfqGV4XbTmyJhXv8eAsfNO32ng2Oh1tqwn662BV
         j6SYas8tl5ItXRpLVIhEqDq0Se1o/Q+6h3f6zZILAPHDdXMKuZUsQwyp//xvHugkpwO1
         ZCqQncHhA/8NxI0lvwKohaPM2GozDZobNwDjhkAh1qcp674WbWkDadWsgbfaKZhSwNMq
         P7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782752575; x=1783357375;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7pxf2OoaUIybzoovXUga+9ZL7SNkE8e+Vjz2qilX3lk=;
        b=l3YaCTr3cTgY1gPSjadWDVUU/ETP32hI5tf4qznGN8PGXbEH0K+VRJJ6fM8CnzLfnd
         J6mPfagdv8qwF7zilqewitZf125XJ+PjBtcgksg9WNKeqMWysFHAme5w3Il3cVR3PGyn
         igHZroXXgmxi1CmGxo/F/cPDki/p2eP/QLs3eRpQkQZcfHmgyoDwNTdnjaTGYx7YXnPZ
         L5za8XIMKYVk1+h1oSXT7PE2U4V5B5kdvcMvEBvzFKId5fG+vyLUZZMdOYg1E4Qop1gg
         vpy5rEo01j8UaloYF79GJ0ZYW42PRiHvjZvtPm1vNNpTbR1tqf5E+5KaHYZOioLnLK3B
         +Tpw==
X-Forwarded-Encrypted: i=1; AHgh+RoXVQy52EGyKOLSITAY0Alt8zSNVOWt7gBuvK+kR1O5RKeCKhQABSWOQdrM9Om9tjMmf8qBwvKnsTv3zEQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyHNLidynS38XYhW+2z5bWB+i7odlPPMyeVCqOoEsYcu/1+h4By
	22LteiFkDkHzhhZwWPoCzjoZhhYD+B8YUXsKFbEWsdFkg4yqOYSaLwx+
X-Gm-Gg: AfdE7cniSa9MJZHOZ2mUnVB6QIKUYh0evcj1nc9C63O8ICrjXgpBWutHWU7+GRzNztA
	xHySsNc0Ya9fl+CPA2V6MJHualCl8EesA3tT8ydMKIyhmc7qR8urvSjc1Oyh+LnBD+J0XcHAYek
	VQ2nAaBoItGcoBsIKovAntUvPevr4hdSXqzrYUgYC/8ZlOHKMZo1u6ouGz/NrWnaVPTPKVVqC0E
	i94nxzdDYcdMVXuCpj3zX2bKwr/Df2x2THk68avBZ7d8i7j/GQhhTCpniU+1z0TCzDKsTE09o6+
	/P8xfL/lWlfFD+EltxHk7E2wj3rfMbtqW9+hl8UFCYE+gvgRTuxCc6R9jxlONKh7eXnWpHkgMhj
	zwlFmG7NXIyqpcHsydkT1dM9q5INvI1fZB85QGMWRgjBWx8Zwz4+U5zMydRXT9GOqBR9vSebGZk
	G8KrOhp0Di8IJhKyk3NwsmMIlS/HSrT1i1UvrbaxA4OlCtNaOzDtC9RyLfmIaebRRKnrat98s=
X-Received: by 2002:a05:7301:434b:b0:2ea:c085:44b1 with SMTP id 5a478bee46e88-30ee13c1236mr190093eec.19.1782752574839;
        Mon, 29 Jun 2026 10:02:54 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c199561sm56501176eec.0.2026.06.29.10.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:02:54 -0700 (PDT)
Date: Mon, 29 Jun 2026 22:32:47 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, sshegde@linux.ibm.com, mkchauras@linux.ibm.com, kees@kernel.org, 
	mark.rutland@arm.com, ryan.roberts@arm.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/syscall: Fix seccomp errno handling with
 GENERIC_ENTRY
Message-ID: <akKkdd7i6oZ2o5A5@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260624171520.772408-1-mkchauras@gmail.com>
 <akJzuEJRLniHk4Fi@kunlun.suse.cz>
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
In-Reply-To: <akJzuEJRLniHk4Fi@kunlun.suse.cz>

On Mon, Jun 29, 2026 at 03:31:36PM +0200, Michal Suchánek wrote:
> Hello,
> 
> there is yet another bug identified.
> 
> When the initial syscall number is -1 the new condition bypasses setting
> the ENOSYS below in if (unlikely(r0 >= NR_syscalls)) and returns 0.
> 
> perl -MPOSIX -e '$!=0; my $r = syscall(-1, 0); print "ret=$r errno=".($!+0)." ($!)\n"'
> 
> Normally the result is
> 
> ret=-1 errno=38 (Function not implemented)
> 
> but with this patch the result is
> 
> ret=0 errno=0 ()
> 
> fixup below.
> 
> On Wed, Jun 24, 2026 at 10:45:20PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > After enabling GENERIC_ENTRY on PowerPC, seccomp filters using
> > SCMP_ACT_ERRNO without an explicit errnoRet value return ENOSYS
> > (Function not implemented) instead of the expected EPERM (Operation
> > not permitted).
> > 
> > The issue occurs in system_call_exception() when syscall_enter_from_user_mode()
> > returns -1 to indicate the syscall should be skipped (e.g., blocked by seccomp).
> > The current code treats this -1 as a syscall number and compares it against
> > NR_syscalls. Since -1 (when cast to unsigned long) is greater than NR_syscalls,
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
> > This aligns PowerPC's behavior with other architectures using GENERIC_ENTRY
> > and restores correct seccomp errno handling.
> > 
> > Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> > Reported-by: Michal Suchánek <msuchanek@suse.de>
> > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > ---
> >  arch/powerpc/kernel/syscall.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> > index a9da2af6efa8..5b58c8d396c8 100644
> > --- a/arch/powerpc/kernel/syscall.c
> > +++ b/arch/powerpc/kernel/syscall.c
> > @@ -22,6 +22,10 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> 	unsigned long r0_initial = r0;
> >  	add_random_kstack_offset();
> >  	r0 = syscall_enter_from_user_mode(regs, r0);
> >  
> > +	/* Seccomp or ptrace may have set return value, skip syscall */
> > +	if (unlikely(r0 == -1L)
> 				&& (r0_initial != -1L))
> > +		return regs->gpr[3];
> > +
> >  	if (unlikely(r0 >= NR_syscalls)) {
> >  		if (unlikely(trap_is_unsupported_scv(regs))) {
> >  			/* Unsupported scv vector */
> 
> Thanks
> 
> Michal

What do you think about this diff?
This seems much cleaner.

diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index a9da2af6efa8..a6c89052e8c5 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -20,8 +20,6 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
        syscall_fn f;
 
        add_random_kstack_offset();
-       r0 = syscall_enter_from_user_mode(regs, r0);
-
        if (unlikely(r0 >= NR_syscalls)) {
                if (unlikely(trap_is_unsupported_scv(regs))) {
                        /* Unsupported scv vector */
@@ -30,6 +28,11 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
                }
                return -ENOSYS;
        }
+       r0 = syscall_enter_from_user_mode(regs, r0);
+
+       /* Seccomp or ptrace may have set return value, skip syscall */
+       if (unlikely(r0 == -1L))
+               return syscall_get_error(current, regs);
 
        /* May be faster to do array_index_nospec? */
        barrier_nospec();

Regards,
Mukesh

