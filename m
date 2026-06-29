Return-Path: <linuxppc-dev+bounces-23045-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0582C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 04:54:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpYqJ0CnNz2yT0;
	Mon, 29 Jun 2026 14:54:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782708891;
	cv=none; b=Lx8weT0d4TT86n40dD4KAeKpNBUpy7FCoy7uWSTU76gwjyLLIeNqGU9vVwlgKMDQaE1zBAezsXx1GaEGyJ4CuG7/blb3zPnTn4VL3ET092U8ZMzknV7DKoeFo4fqlhZoawJoKqZWx8S92AMJuMrvDFl8sL8CUjO1TU7Lg4i+QtQwZ+KwrJBbniyk8b1O12KZlpgrCHC1uqfUI+V67COUyzJJkTpTdGgAgQtdHLG/lNrThk4sckFo1TmBEM0i7KmCcK7IeLAmxf5hdLtnqLq0IOPpeSyjzyXJ71zmAj3nOnH+hUXav5hxJn6WTLCaDJbPsYZnaf5/bZBBIA+Cw2YSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782708891; c=relaxed/relaxed;
	bh=xelqBObbyshoMTI8e/i+QalKkFMy66EdgFOZ66d0qzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeG8S4+l5HyZD/hR/vT/oRit9fP+UQbCiD5iAHXabzG5BWQWcSaOV/VcHXhnDqUlrhUHwr1p8+pcDF6Z5t5MZNgw2KKcceVZOmZr8RQXtsJnjMViCXLkIkLqRNuA8Y33RQmx4Gir9ro8ZBwUnxKlqwrauYCGHRSEQtGeKZFJNaJUUcrmEYMVrlEfF4w7nnqJfCDEGUyhNhXMvWfg5CNdhXgv57jCZBeHC6IStMCgaH8dV847zAcbeFLKn0bq/sFb0UW5QlsA/S8YTw22NiO413mnQcQ3UjIrNSSAuc6cH7jMjBzyt+MUNtR50gOIxhaG83XtkKP55BmmMPAa6y77mQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=drcamGiI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=drcamGiI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com [IPv6:2607:f8b0:4864:20::122f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpYqH0YDLz2ySS
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 14:54:50 +1000 (AEST)
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-139f71a5201so344499c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jun 2026 21:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782708888; x=1783313688; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xelqBObbyshoMTI8e/i+QalKkFMy66EdgFOZ66d0qzk=;
        b=drcamGiI7pcT//jipn/k/6e8MyZ6jB1aoqR6Gew1sNXKYM7O8bKjm2Rvgh+2omz5fH
         RFijCx5U6b8jAjtFJOlj6YtUkomQoJi9x5t0gPh2eA9hBXfXa6pGmjsfmNoGA/0YS34h
         GPwBUagBwdlw6itNOPHOjLknAPbjyss7nekar47yc5bLtkmsIuFt3OP84D+dCgm6twbe
         G/rF6WzPN6kPBc6hO1yufvgtT2CCv5i21LH5KzLp5bBvz5gIkPuhme03jxyppxvbQmsA
         szc7oMLlXxxNaM8ww+X0D0wHyxBx/hJqITBztqqAm3CvyYGO4DRgs02AxxpLAFCvKoSy
         OYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782708888; x=1783313688;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xelqBObbyshoMTI8e/i+QalKkFMy66EdgFOZ66d0qzk=;
        b=REBO9YyiWdossebvbgwkTqgE7TRbH968SGZrPBP3VAmX7HLBzaH1WC3wEBkFxgtzKI
         aMsM++LeW6gr5UYe8CMawjW3JOSS5PLwB78m8ZJ5TkiM5RcJ2bptSACvb6fKAvVYgzDd
         ypBuYyA/83PWPtvdXJZ/ZtHpZKK5LT5jMICX7ZZedlMfE38g3GsqsUVTqDWB0udaqKKJ
         qwuqBQx6oDJHeQC9qvCyIBhIm/LP4jNjpdYswl+X3ZMH41Jwm2yuH3jqFTztCB2PXfk1
         r3d8gD3jEJuaCvamYHM3aqPxZh5UrD/nDbSW/FQsd/UdUeOkOCoLkJNEJTdaGpKo2fm7
         RIKg==
X-Forwarded-Encrypted: i=1; AFNElJ+yZzOIOUX8t9XrXO2fK50pVHDXGCoV1dzuLIm3gzka66evoZO3+JvdD5++kXaf3bgm+dMlPnybuNoPvs0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxNh5zuPiNnOAOCPcUBf68J14E2bjqJm1fsPA2WeqYvDJicyDyR
	limangJQrp6QHayFWmLSSkZjuxIrG0FYkswcOi8qc6dyj6wm+XellUIC
X-Gm-Gg: AfdE7cmV4kUoIcXiybid0nLnSnfo+skKZ6nVDdFWzamBxitrZYaTlGiZpJvpuKfKiS/
	KHNYUsg8UcdWFUC+cPGJx2dBS52zkxpJ1lqY2R/1YzpHu8FDJtTNvRYhb9vaFHDKY1VTPsojXib
	/wsQigjMlbJU1Lr0iPAL3yn8xpEdV6qKfKeoLx3bhx2irVQYgwqGfffcpb5LKP7NFDYTm9d6ng7
	aQxRVQi+JE9QR4wfcAGM96G1hgTaweSfM499W8YSkcMkDu64fcF4BsxhLbkV76GgOu/8zxo81XB
	sAkESRbpeRI+IPijy8eitXix5o2NpRwmwc0qJk+U9CuPlUyWGYUeDLX76OYaRC+kLgUMilLZuHi
	6VrOnNdWKBglLiAir+rQg5Z+J6dQbquU8KFB1m7MYo629U1FQJbgDIIs9LEA8kl1EXLdgLjJone
	92x69Pl+ES6FQX4hPTTD6yqZPEVv/HK6nOZ7TniRFHgOYFjfZRSeyibzwqqDCq
X-Received: by 2002:a05:7022:61e:b0:138:59d:e1 with SMTP id a92af1059eb24-139c3d145c3mr20794117c88.24.1782708888373;
        Sun, 28 Jun 2026 21:54:48 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139eac62642sm22462259c88.10.2026.06.28.21.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 21:54:48 -0700 (PDT)
Date: Mon, 29 Jun 2026 10:24:40 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	sshegde@linux.ibm.com, mkchauras@linux.ibm.com, kees@kernel.org, mark.rutland@arm.com, 
	ryan.roberts@arm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH] powerpc/syscall: Fix seccomp errno handling with
 GENERIC_ENTRY
Message-ID: <akH6JooVWvTVIgpK@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260624171520.772408-1-mkchauras@gmail.com>
 <17eecc4d-ae7b-4c32-9edc-d3b8e131549c@kernel.org>
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
In-Reply-To: <17eecc4d-ae7b-4c32-9edc-d3b8e131549c@kernel.org>

On Fri, Jun 26, 2026 at 04:31:47PM +0200, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 24/06/2026 à 19:15, Mukesh Kumar Chaurasiya (IBM) a écrit :
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
> 
> Closes: https://lore.kernel.org/all/ajpp-_XnbF3UTM_E@kunlun.suse.cz/
> 
> > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > ---
> >   arch/powerpc/kernel/syscall.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> > index a9da2af6efa8..5b58c8d396c8 100644
> > --- a/arch/powerpc/kernel/syscall.c
> > +++ b/arch/powerpc/kernel/syscall.c
> > @@ -22,6 +22,10 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> >   	add_random_kstack_offset();
> >   	r0 = syscall_enter_from_user_mode(regs, r0);
> > +	/* Seccomp or ptrace may have set return value, skip syscall */
> > +	if (unlikely(r0 == -1L))
> 
> Is it really needed to add the L after 1 ?
> 
I guess it's not needed, but syscall_trace_enter is returning -1L, and i
wanted to keep it consistent to that.

Regards,
Mukesh
> > +		return regs->gpr[3];
> > +
> >   	if (unlikely(r0 >= NR_syscalls)) {
> >   		if (unlikely(trap_is_unsupported_scv(regs))) {
> >   			/* Unsupported scv vector */
> 

