Return-Path: <linuxppc-dev+bounces-23123-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB12C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 17:14:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gptDl3jBNz2yH4;
	Tue, 30 Jun 2026 03:14:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782753271;
	cv=none; b=Uv35vOkIiofOuFJizQWfnC3SU13MzCyM6o37pT/74443+X/c+MisiyV07RqpG/Fafu8i/F5nOBNUARbevfGyo9hgcVGeCeuv/jxQR4NA9jcV8o46T62amoS1Igh4OwpVAbJba87f8XtI9RcGYw05FJtPxgPUDgJv4GEgPUbuXpifa4502NSYAph2uDIRgj0CrRL9MC/MII2ZtEmRzPHrOPaIEcGcku/rKUgtc6I9wqV2UVw3W4keMsszelh6n+/kT4ePeijBsqQU6I98uvlAyqLjoBOC/rdpjUL75Yx9OrOWIeaq7Go91q51W4z5QFhIsBN3tETTADxTCTd/oXoykA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782753271; c=relaxed/relaxed;
	bh=ASkDOhag4oKmgKsavbd/afvvyGMXwFiE+YAXeoDy0x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbJGaSxmbQrRobgcyvDZff8lR6NOhHk9X6/hru0y9WxK1eGlM8UcH9XOKUcSoVfQJYtAYWKOo1Oo8GulV9So/ytuqPzDu2DYIywswKOI5AyMONvBBpTqoF3jSKZp+0x4ivK+xWtotgXjbXQBSydi+BnGaZ04uFLw1m5ndm1yB4h3JrvvchEEzl11Ttr/m/rT8dzrglYTJZtB5hkBSq+jYW/vxAZ1igdesOx8POj2DS0C0R07ynVHsXYhFJvdZ1fOpaM9vFbqCShylzjwwPFgBeIyw8mi5mWaQFSB7n35hrtHTiKjPMjyKu3Kv1RKKhuRd6NoB9wc/oOm68pOARxqhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C8go4ISO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C8go4ISO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com [IPv6:2607:f8b0:4864:20::1332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gptDk3nmWz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 03:14:29 +1000 (AEST)
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-30df5854e1eso1143871eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 10:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782753267; x=1783358067; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ASkDOhag4oKmgKsavbd/afvvyGMXwFiE+YAXeoDy0x8=;
        b=C8go4ISOY5zKpU7edbOiWfJNj+dH1XZfjhASp0xymUHeg/WMJ+oHaTOCQecB7ldlFv
         dyYXDLQsJOAWemRwm2TBOgXrWa7WoIIJBr1s42RHVSLQ/TmMvtVxg8VZAv+54zV4c+O7
         PhqR+VmcbVxKSWaWhmfuahfD8e/jeSlFSve1f7C42pBJjf75yWQxyvOfIqfW7eMHTUFl
         1DSqgwZWr0pxFsuLAB5DSXF/X51fjfjo1dn0XCPzcyYjt7Ip+cO32q1p0WBnmwQpRDhi
         DFeHMfwIig5QQbvat/Fmezylj+Ktp2GelpzddXLjqov3MVTUopw4EIHOE0ten9940H6J
         4PYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782753267; x=1783358067;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ASkDOhag4oKmgKsavbd/afvvyGMXwFiE+YAXeoDy0x8=;
        b=E48F7u+FDNO0gz8KGCQXOH6nXwt4ifLJ++WsqVwVAPTIBpf+zIR55Np4HtWyq7J8JC
         h8nC6/iwj79mN4iiNclyAbTMjKotDXoev2Z2KdSDrCaojehKL4Ge+w4QLeCnCR5/v1v8
         7pXfCKbIGtJI0s25wGK3pXwFZsDHJqqf7In786jWVe5/ijex1baYScsIcjkHXIj6dClc
         lL2twSWFySI8/enZWdPpiFhZvYzXvOOYZermHJE0CiodjcWn4+TN/TWaDiyzaJfBO99S
         7dXHf29Ub4dLKnRGNLU1N5lgFj0HmEo1NvEO/OX0LodEIAYgOYowRYPF3xhBnQ+CuFoQ
         ZRxw==
X-Forwarded-Encrypted: i=1; AHgh+RqyC+aQ1VRQV5EV6A00HQnUjfya0J78WHi6LDlMXxPf0GDpzb9ufVNhv67yTJ4qVUXB4/Ps8mh5/pRXjoU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzoOMsQ2yKuGE9+ZRvIF4QJn0bfrJemIyzOJ+AVQmjuW0ioXMIu
	IFXxtxuClTAOraBgNViz4uSt29vsFkhuNl/U7GE4uwr7gPiBoQasrnqO
X-Gm-Gg: AfdE7ck/pTjh0S0zrdIXuVlRDuiil+mViOXUBH+5rU3No5ap2/kvyYXaWiNBGrkgNOo
	PRm2iG7no7DZSPKfhjgKAmEmMcZHmuR/mQAv8Pz2f/rVMHd03yhV5iq8psY7n3D8z8h9IFN4AR5
	lbySC7AZNZH7IBgSo5X/bm0+xeZxh+tahmqdm4Djj4KVTP0SCFNfFuV2CNhJdkDd6aBmu5onaoe
	R78VNP8+gBqsaKLWE+fSEBWEofwGi7EiMNegdcz13KUv4qJyDKymi9RCdpYbLWWFlhK1QVcjIcQ
	YKpum4/t4fsEGYBekTu9119M3SmswKfDibGDIqFSsPV0j6vAMhvW0tEw+20YCbSFJ1A1o9uveAR
	cN4TJ+T6qd5hQRvc3n3i7+eJ3H/swtfBcYF9i4+IDAbYbNt66tEv4/gTBnnKIEpRf3iUW1fBNh/
	cYAYEboyasuRjSVzqz1k3WvqAheDmX7GUxTQ1cuYWuI5Xrn0bfJfth6JELefaC
X-Received: by 2002:a05:7301:3aaa:b0:30c:c365:4814 with SMTP id 5a478bee46e88-30ee1815d7dmr92628eec.15.1782753267297;
        Mon, 29 Jun 2026 10:14:27 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ed3af8c35sm8909882eec.29.2026.06.29.10.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:14:26 -0700 (PDT)
Date: Mon, 29 Jun 2026 22:44:19 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, sshegde@linux.ibm.com, mkchauras@linux.ibm.com, kees@kernel.org, 
	mark.rutland@arm.com, ryan.roberts@arm.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/syscall: Fix seccomp errno handling with
 GENERIC_ENTRY
Message-ID: <akKnSqGUeFIGOfHb@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260624171520.772408-1-mkchauras@gmail.com>
 <akJzuEJRLniHk4Fi@kunlun.suse.cz>
 <akKkdd7i6oZ2o5A5@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <akKmSblIh_xNcHHp@kunlun.suse.cz>
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
In-Reply-To: <akKmSblIh_xNcHHp@kunlun.suse.cz>

On Mon, Jun 29, 2026 at 07:07:21PM +0200, Michal Suchánek wrote:
> On Mon, Jun 29, 2026 at 10:32:47PM +0530, Mukesh Kumar Chaurasiya wrote:
> > On Mon, Jun 29, 2026 at 03:31:36PM +0200, Michal Suchánek wrote:
> > > Hello,
> > > 
> > > there is yet another bug identified.
> > > 
> > > When the initial syscall number is -1 the new condition bypasses setting
> > > the ENOSYS below in if (unlikely(r0 >= NR_syscalls)) and returns 0.
> > > 
> > > perl -MPOSIX -e '$!=0; my $r = syscall(-1, 0); print "ret=$r errno=".($!+0)." ($!)\n"'
> > > 
> > > Normally the result is
> > > 
> > > ret=-1 errno=38 (Function not implemented)
> > > 
> > > but with this patch the result is
> > > 
> > > ret=0 errno=0 ()
> > > 
> > > fixup below.
> > > 
> > > On Wed, Jun 24, 2026 at 10:45:20PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > > > After enabling GENERIC_ENTRY on PowerPC, seccomp filters using
> > > > SCMP_ACT_ERRNO without an explicit errnoRet value return ENOSYS
> > > > (Function not implemented) instead of the expected EPERM (Operation
> > > > not permitted).
> > > > 
> > > > The issue occurs in system_call_exception() when syscall_enter_from_user_mode()
> > > > returns -1 to indicate the syscall should be skipped (e.g., blocked by seccomp).
> > > > The current code treats this -1 as a syscall number and compares it against
> > > > NR_syscalls. Since -1 (when cast to unsigned long) is greater than NR_syscalls,
> > > > the code incorrectly returns -ENOSYS, overwriting the errno that seccomp
> > > > already set via syscall_set_return_value().
> > > > 
> > > > The generic entry code in syscall_trace_enter() calls __secure_computing(),
> > > > which sets the appropriate errno in regs->gpr[3] and returns -1 to signal
> > > > that the syscall should be skipped. However, the PowerPC syscall handler
> > > > was not checking for this -1 return value before validating the syscall
> > > > number.
> > > > 
> > > > Fix this by explicitly checking if syscall_enter_from_user_mode() returns
> > > > -1 and returning the value already set in regs->gpr[3] (the errno from
> > > > seccomp) before performing the syscall number validation.
> > > > 
> > > > This aligns PowerPC's behavior with other architectures using GENERIC_ENTRY
> > > > and restores correct seccomp errno handling.
> > > > 
> > > > Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> > > > Reported-by: Michal Suchánek <msuchanek@suse.de>
> > > > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > > > ---
> > > >  arch/powerpc/kernel/syscall.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > > 
> > > > diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> > > > index a9da2af6efa8..5b58c8d396c8 100644
> > > > --- a/arch/powerpc/kernel/syscall.c
> > > > +++ b/arch/powerpc/kernel/syscall.c
> > > > @@ -22,6 +22,10 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> > > 	unsigned long r0_initial = r0;
> > > >  	add_random_kstack_offset();
> > > >  	r0 = syscall_enter_from_user_mode(regs, r0);
> > > >  
> > > > +	/* Seccomp or ptrace may have set return value, skip syscall */
> > > > +	if (unlikely(r0 == -1L)
> > > 				&& (r0_initial != -1L))
> > > > +		return regs->gpr[3];
> > > > +
> > > >  	if (unlikely(r0 >= NR_syscalls)) {
> > > >  		if (unlikely(trap_is_unsupported_scv(regs))) {
> > > >  			/* Unsupported scv vector */
> > > 
> > > Thanks
> > > 
> > > Michal
> > 
> > What do you think about this diff?
> > This seems much cleaner.
> > 
> > diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> > index a9da2af6efa8..a6c89052e8c5 100644
> > --- a/arch/powerpc/kernel/syscall.c
> > +++ b/arch/powerpc/kernel/syscall.c
> > @@ -20,8 +20,6 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> >         syscall_fn f;
> >  
> >         add_random_kstack_offset();
> > -       r0 = syscall_enter_from_user_mode(regs, r0);
> > -
> >         if (unlikely(r0 >= NR_syscalls)) {
> >                 if (unlikely(trap_is_unsupported_scv(regs))) {
> >                         /* Unsupported scv vector */
> > @@ -30,6 +28,11 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> >                 }
> >                 return -ENOSYS;
> >         }
> > +       r0 = syscall_enter_from_user_mode(regs, r0);
> > +
> > +       /* Seccomp or ptrace may have set return value, skip syscall */
> > +       if (unlikely(r0 == -1L))
> > +               return syscall_get_error(current, regs);
> >  
> 
> This will skip the check for NR_syscalls for whatever is returned from
> syscall_enter_from_user_mode other than -1. To me it is not clear if
> invalid syscall can be generated by one of the modifications done in
> syscall_enter_from_user_mode.
> 
> Thanks
> 
> Michal

The possible return values for syscall_enter_from_user_mode are either
`gpr[0]` or -1. If we have an invalid syscall it'll be handled by the
`r0 >= NR_syscalls` check. I think functionally there should be no
issues.

Regards,
Mukesh

