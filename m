Return-Path: <linuxppc-dev+bounces-27304-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8199EC88E73
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 09:15:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkbwQ00csz2yFW;
	Tue, 15 Sep 2026 19:15:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789463749;
	cv=none; b=k+lNde0prFasVEdVu+gukkJN+N+Amp/s4OhHNLMr0vNLsarcuIkUVQV9BrKIbzyP3H9BvoDLSBKmQmax6CKPmUjxoWAeUnTZqH5ywfb+QH1P5cvpydTmvl8Vzjo3FsFi/DEDraEwLIE0fx9/LkdvgjHmOvVSeF8szf4jZskYGD5RRL58TE83VoHKo0nyyXIi/L1/pzgRnwl/APIIcYrXH4Vp3gfIzRcAeHi8BDwh/baXA208HUcZtGaYCmTs7cmv/52zT2aUkdX/N66yBMNQF5je/BVs6WzfygXMPXLY1nTNLC3Dxw9YeoOt9FJNHBQqGT3Vi27AZ7em/73JJXn7xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789463749; c=relaxed/relaxed;
	bh=KyTzZj9bu9m6y51EDmw17tS/R3K9wAgV1FMAvLd0wJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igYxLMra3Y6WpZ6OLHA6VmLCjsRm71+cXGr8p8G+mG7y9A2gDoKLdNP2J7+20Mgbai/uIBI5xb8IhM2itrBlRANb/TWdpC+MJuPRtP9rEbCSNhcSzVLGdodHp4ly7kqiDK69JE0V1QQncOKDmgYGCU0WXI9+EilLGpwF0V/IjxADLrCQ98H4Cx0FB70DH2o+IyC62MS9hdPphDekJsWrinj8MZEGIPKvHSH02D7kFefi9MNLR/aa1XjFYsxdScePq0uc8u5W6GCuDbgX2Ah/mSHT3hhz2oOUpYrdq2RIuU62FRa5pwht0u5aP4eY62azQd74zQHUnfh5XWYnxPXlzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mztTg+LQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mztTg+LQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkbwN6tDxz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 19:15:47 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2d747f05ffdso322425ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 02:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789463746; x=1790068546; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KyTzZj9bu9m6y51EDmw17tS/R3K9wAgV1FMAvLd0wJ0=;
        b=mztTg+LQfDDkPb1F4+luyW64YU+b7Z8Nxhml1m7VLjtBaFaN7oSxD5LEpNT2R/n0/0
         HS1mLIdyIaE4iLdsQMFYoqKU1Py0jV0MkD74uRh4ZISNlGUR97HRt91lyBx+WxlyARAL
         Y1QpuWerBLqtM30f/4It5g3RN1k83/ahl6Ca7odyUEnfsIPXDjtHsAMZe3TjdfqOTfKv
         v/FxrsW/uh7mOnenkqwU4tH+wyFak0W41i4aGOQ3XzX48azqSjrVCmKxg/1oezuCKlrm
         yAYAaZuFfPpP4K8tzZkcMXgwAdEet7xRUbizIQUSuCrY2aOPbLtt9ew0YhwCufDKU+IH
         GPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789463746; x=1790068546;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KyTzZj9bu9m6y51EDmw17tS/R3K9wAgV1FMAvLd0wJ0=;
        b=LXcsuHAjZ7t0xS+wrtq7kCn+IarnlMvguaJZalt5lvRDoGsgBusTGxQIAxG5dMPnk6
         eXCwIJewy+7K8ZfvrTraYt8u66sl7mGrEkwv7DkX39yAEz8ONStAQbowgfyM9nRFLUiJ
         hqdNtF6nI0ZAid2ZJyvtrPLhrpflUpI+xFnO1U8FGNmGM7CoJ3LcNp/Jbwer9t/E1LxE
         prhe9PmBgVmqcIDmIWTFwIweNwMinuTa/OmtwjFVg8hixizGGIguY/t2NmQppyo9g6S1
         /+zb8RTrbM8l3kAFzxfxjNn+yiKLy284z9zZiZk35Zt/2Y1XgN3HXhPSORxMXoG7E3w5
         ee6Q==
X-Forwarded-Encrypted: i=1; AKwUvBzqdPWablfiARB29QjU3A837Shw3PiExOgi9y7G/Bdcb3zjTucHrr4YlDUIZAi6/anax+2RbDSHtZHgx8M=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lZyZEzST00tog4kWo1eONR0iHRx5TwGxn9UdpE8WBKmiTfSt2y
	jlJT/J0PqECFfbgYlXXd+RyW2Cu3enjm9vYf3w2W8k3G4jFYfqaVjaFZ
X-Gm-Gg: AYBFou0quXMaFeBgd/SX0kZQFeHhzX1ER1iWkVOOizi7NX+kp4A2d1PV1sZjtDGg9+j
	IZkkeqA0cc6T7hTToe+Rn6N4toONuv6Ow/PKmt3nliPwZJHGusZZiMbTaWBa05jNBK50eVTv5iZ
	CkyJirNZ1bpbjZ5xNe0vlpyE+uVGBaKLTksIuq8TyX8MetotKaNB8B6lx8Hu6ybOPIDgkAOxj6I
	w/Ij9T/VY6qTMmIvglF6B4/OGv4HZrrgHB1eR4a6HpbSI9nwT9KFZPOnq9k6N17D982JsBk0TFC
	A1qJszfLFPGbSoFIDVThYwEISb5wwryjphlXc7HJ7wiylf0XNKEsy6Hhfp+Cl3DfOzgwfxVbUGr
	ZPoZLy8nKA9JtPDuAXXSCoACzlKx+h3gp0ZmvIK+cMLuy6s8+crlxVmxPQNi+pEmGB5DAl4Dbi+
	go0N+rtMx+kuvOetAontPUzTqW/Hbtg+th2T5JXYAvw/VFmn5tdLZqMAvIYDJePY1KxLH+EQrf1
	eCJDzNa/ibc0eqj+FkSwC2lT6g4oa5wEi3Z+fZxKyU=
X-Received: by 2002:a17:903:3b86:b0:2cf:9347:f445 with SMTP id d9443c01a7336-2dd83851a2emr4167135ad.10.1789463745776;
        Tue, 15 Sep 2026 02:15:45 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd4a7f17ecsm47233025ad.14.2026.09.15.02.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:15:45 -0700 (PDT)
Date: Tue, 15 Sep 2026 14:45:34 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, kees@kernel.org, ritesh.list@gmail.com, amachhiw@linux.ibm.com, 
	mahesh@linux.ibm.com, nikhilks@linux.ibm.com, robh@kernel.org, sayalip@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-riscv@lists.infradead.org, linux-hardening@vger.kernel.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH V2] powerpc/kasan: require memintrinsic prefix support
 for KASAN
Message-ID: <aqkMYJXu7mV40baM@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260911180536.3234640-2-mkchauras@gmail.com>
 <508afce0-d479-46f3-a2af-d7e6cdb65232@kernel.org>
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
In-Reply-To: <508afce0-d479-46f3-a2af-d7e6cdb65232@kernel.org>

> > - cputable.c, prom_init.c: the original comments said "use memcpy() so
> >    GCC emits __memcpy() under KASAN". The real reason is that these run
> >    pre-relocation: the destination pointer is PTRRELOC-adjusted to its
> >    current physical address, and the kernel is loaded at a different
> >    address than it was linked at. A struct assignment (*t = *s) may cause
> >    the compiler to emit an implicit memcpy() call that resolves through
> >    the unrelocated virtual symbol address -- before the MMU mapping is set
> >    up -- jumping to garbage. An explicit memcpy(t, ...) uses the already-
> >    corrected pointer and is safe. Update the comments accordingly.
> 
> Nope, see my other email.
> 
Got it. I'll remove this.
> > diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> > index 6f6801da9dc1..233b5c650d1e 100644
> > --- a/arch/powerpc/kernel/cputable.c
> > +++ b/arch/powerpc/kernel/cputable.c
> > @@ -36,8 +36,12 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
> >   	t = PTRRELOC(t);
> >   	/*
> > -	 * use memcpy() instead of *t = *s so that GCC replaces it
> > -	 * by __memcpy() when KASAN is active
> > +	 * Use memcpy() instead of *t = *s because t is a PTRRELOC-adjusted
> > +	 * pointer and this code runs before the MMU mapping is established.
> > +	 * A struct assignment is a compiler-generated aggregate copy whose
> > +	 * implementation is not under our control in relocation-sensitive code;
> > +	 * memcpy() ensures the adjusted pointer is explicitly passed to the
> > +	 * copy routine.
> 
> This comment is wrong, see my response to your explanation. I think the
> comment should be removed completely, now it is possible to use *t = *s
> without any issue again.
> 
> 
yeah i'll fix this.
> >   	 */
> >   	memcpy(t, s, sizeof(*t));
> > @@ -55,7 +59,11 @@ static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
> >   	/*
> >   	 * Copy everything, then do fixups. Use memcpy() instead of *t = *s
> > -	 * so that GCC replaces it by __memcpy() when KASAN is active
> > +	 * because t is a PTRRELOC-adjusted pointer and this code runs before
> > +	 * the MMU mapping is established. A struct assignment is a
> > +	 * compiler-generated aggregate copy whose implementation is not under
> > +	 * our control in relocation-sensitive code; memcpy() ensures the
> > +	 * adjusted pointer is explicitly passed to the copy routine.
> 
> Same
> 
Sure.
> >   	 */
> >   	memcpy(t, s, sizeof(*t));
> > diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> > index eb9f556b0937..d6d7f1ede319 100644
> > --- a/arch/powerpc/kernel/prom_init.c
> > +++ b/arch/powerpc/kernel/prom_init.c
> > @@ -1363,10 +1363,12 @@ static void __init prom_check_platform_support(void)
> >   				       "ibm,arch-vec-5-platform-support");
> >   	/*
> > -	 * First copy the architecture vec template
> > -	 *
> > -	 * use memcpy() instead of *vec = *vec_template so that GCC replaces it
> > -	 * by __memcpy() when KASAN is active
> > +	 * First copy the architecture vec template. Use memcpy() instead of
> > +	 * a struct assignment because this code runs before the MMU mapping
> > +	 * is established. A struct assignment is a compiler-generated
> > +	 * aggregate copy whose implementation is not under our control in
> > +	 * relocation-sensitive code; memcpy() ensures the adjusted pointer
> > +	 * is explicitly passed to the copy routine.
> 
> Same.
> 
Sure.
> >   	 */
> >   	memcpy(&ibm_architecture_vec, &ibm_architecture_vec_template,
> >   	       sizeof(ibm_architecture_vec));
> 

