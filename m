Return-Path: <linuxppc-dev+bounces-23044-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD8FC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 04:51:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpYkx4B28z2ySS;
	Mon, 29 Jun 2026 14:51:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782708665;
	cv=none; b=Zjikui3sbmij9j7W1LiZ1CA9BhBul1iYqZvNiKylLb0k84nLsyRv3QkEydl1hXeTiTeg7LGwP1S+yQyyDqJN1mz5MJO1srVs2vIWQM2hoaBONiALty/cTshab4gg+8yVvqgTTygg6vlGzr4h0JQB6Ee+5QtkulUMkP1gJJ25nIcWTzy0RWzFXRvk342YwR5ldR+PVZfL9mLnVKLfXHNUny09YtEDuqpYT9Z9lkWD4pVneN4U0/u2Xnwuq6P5zz8RnwolZUNOiKZhbIGalUD3wEZo1mHu2GhDkDPf4ugn8KfLQq+ipfMEGuPapfSr3OrkhBxPAiiRvP2E+48U9tAXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782708665; c=relaxed/relaxed;
	bh=ccuvdN8L0aJ/Gx84Ib9fQDmUsyHlzlIITFHN5TW6Ow0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OE6O7N/tQUNjvZj3Vq2uPQtBCXp1v70PevoQNYK/ypqVBy71EbsaaqhDSdTTIaNXKq03Oykk5uF0JnLEvXZvCjNVHN7So3hnNJOBexv3A1OHizXJBaLMbKd9bBhhTHn9NcVzJJ3PIfvMDUIEsI3VzfS3tTMUKlOrRQMgIY82+CwbBogz7sSAgCC44OuudWVakzGlNmKz1W4rdtW1w9cLMvg9OE6jdW7cOgCx0b1gQA4JcMhj5BA6RxPCec5c3jbNc3kMDiXRFJJs3F03gwfhRFFtSFLk2vMJbS1KSC5jsdfX8bNyUe6Cms3cqapTIcqCLeVTdziWeKYZep58lRi9ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y+updfuc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122b; helo=mail-dl1-x122b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y+updfuc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122b; helo=mail-dl1-x122b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com [IPv6:2607:f8b0:4864:20::122b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpYkw3RX6z2yFc
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 14:51:04 +1000 (AEST)
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-13810b63a1aso6651364c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jun 2026 21:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782708662; x=1783313462; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ccuvdN8L0aJ/Gx84Ib9fQDmUsyHlzlIITFHN5TW6Ow0=;
        b=Y+updfucOR0cUAz9P/U7E/R6t5RzNdnrZjJKgj2WJ90R3vFNhFwFbTEvHeIjiEABEP
         2cY6ArZR/hHy15sBoh1b0ihE5ODXMmaXY6y36HQoG15KGTF4Tcj2PkPFLfTRWQzmxMme
         wRjzE3M130bjMwavb1BAbTiYbsDOrbwF9EezP85jVmvTI7SsmxmRCq1aVFdTatoHsg6K
         CdS+a+d7dYynuKBVFszVktZCyAGWMnDGsIHUli4KNidCAWQo58F8Veg77SWEP1vpcz3G
         dmxRY+d96uvPMyNfSgEbVl+8WQEp1gTurfcacTwRC6dGg3+iMi3REz3TSuhdFP3hFfMy
         SMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782708662; x=1783313462;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccuvdN8L0aJ/Gx84Ib9fQDmUsyHlzlIITFHN5TW6Ow0=;
        b=KSmtf0jsO9/6X5H9Kjp2e8uZdgUKebrc5IRnodiLunRfbi6Rd6KIM6sOLE38V26pQG
         Q2EjKQTuiTw//ZF4A80GXFDS6/DmQMi1e0QHe1kMfKVe8Kn3iDQxojMKS5r+ugUVeQaq
         powtvrQ5Q74q8DPtJVKi7AUYVbsNxAA94Qj/v2gj9fI9TQ1MjcurYElH7CNRK6hR2LO8
         crkXCXa0rA4IYtew/GEIFfNKeJwwtyClzL2YdLAn6Mhfi9Lmp0h8DLxiYnfOMNUvxD7y
         fYOBveCksQUoEqGNaB4Zkspz8Bj0+vO79+Hl2D69/Ut2uj/ZHMdKrXT5JSMArN7rGXc+
         8TdQ==
X-Forwarded-Encrypted: i=1; AHgh+RqXfPh4Y257f9Sc/gZ+HtFIbDfcnkI8ji6FAk7ed3EqO5EKjrce1GBoWtJuLYQV41xdA+zYL1eiJCZm7xk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwclPJN5bwE4hIwoH29ll/jRYKxYlOzZ7toGsuUG5+/TKtTo7BQ
	sRlhcCEygiLvIpuYFVdKqe2daqQekjC1uvLg2Kv2r41wdqOkDA8gjjuD
X-Gm-Gg: AfdE7ckHWFIpKYmdO3Xb71quUrn//aE04uuOfAK1d+a13ks4YFWZ82kK8mR1KSvn8BI
	sDj5/BxnH1aGkqP8KyOJWovoZ0pf2rbjE5oeGpAu83lAQgEum1MmkmEWXsLlLa0T9ksGjg0P5nV
	j/GyeX71xaYV4Ny7GWiF53CmTrtP7desc/HsTRE9NCk8/4aSO1GYzRb7bWGaukLKHYVw3Z3vHY9
	01aXcGoWYc/V3f7NLK90glbnzMGp1216RasuMqY12CEOGx2MgLdybam5cZhq2S7uLkYM8EOEwjS
	kcm/tLZMl82Skez6LphXbJIdk5yxlhtWNfOyghW8gjKb8k1/BINdnNn+llpz7K31T8aNntSCQJ8
	2R5EMMgqos1CRMkMIIkQ09V2ZO6UKlCUQvmynK53c1kYqRvDdXxVWe3rft1J9qYHKgpd7p1shu2
	J2kjyb7KlOpONv6yEunYJp7cuiFtN3ebXL/m5DQQBOrDNoC4tlKIyOigB/0INI
X-Received: by 2002:a05:7301:3c8b:b0:30c:ab97:d7ae with SMTP id 5a478bee46e88-30cab97dc0amr8190273eec.40.1782708661388;
        Sun, 28 Jun 2026 21:51:01 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ed3af8c35sm2492887eec.29.2026.06.28.21.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 21:51:01 -0700 (PDT)
Date: Mon, 29 Jun 2026 10:20:53 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, sshegde@linux.ibm.com, mkchauras@linux.ibm.com, kees@kernel.org, 
	mark.rutland@arm.com, ryan.roberts@arm.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/syscall: Fix seccomp errno handling with
 GENERIC_ENTRY
Message-ID: <akH5ijpCYlCJWWgM@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260624171520.772408-1-mkchauras@gmail.com>
 <aj4UAGaPdaI1wEED@kunlun.suse.cz>
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
In-Reply-To: <aj4UAGaPdaI1wEED@kunlun.suse.cz>

On Fri, Jun 26, 2026 at 07:54:08AM +0200, Michal Suchánek wrote:
> Hello,
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
> >  	add_random_kstack_offset();
> >  	r0 = syscall_enter_from_user_mode(regs, r0);
> >  
> > +	/* Seccomp or ptrace may have set return value, skip syscall */
> > +	if (unlikely(r0 == -1L))
> > +		return regs->gpr[3];
> 
> this should use syscall_get_error instead of accessing the register
> value directly. The error is represented differently in the scv and
> non-scv case, and for non-scv case this will return wrong value.
> 
> Thanks
> 
> Michal
> 
Yeah, Thanks.

Will send out a new version.

Regards,
Mukesh
> > +
> >  	if (unlikely(r0 >= NR_syscalls)) {
> >  		if (unlikely(trap_is_unsupported_scv(regs))) {
> >  			/* Unsupported scv vector */
> > -- 
> > 2.54.0
> > 

