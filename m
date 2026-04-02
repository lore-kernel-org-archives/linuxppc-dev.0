Return-Path: <linuxppc-dev+bounces-19216-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259CED3941D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 13:08:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmhx26z94z2xS3;
	Fri, 03 Apr 2026 00:08:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775135286;
	cv=none; b=OqjQIEK2Q+/4deMudn3gQvj4dqC8Paz3iHp2dmp+Qaj9TLMc9XuyKQH8/PMVgMK/BDH9hPTTZ2r5+6fwsQGBQOmuyZgF4TDLxxpWMY6BBSHhb52IcL5IHs4Hnkis82Gh1cx9xrBVeMlwUB4hpS2vmF/4HXJfizjROMg02IndtMr+P6xnMdu3IuxgPYovfZBe5Kd6m7P3Jl82afPKraC7WLW4gcwzsPcqPIj7WCGITR+EqlPDCgdAmhOPZ8FXIENrYY2FD7TLixD0Mv4eTwH4vo3Mrmk04nGYg8evnbTEe5Wqesa8wmCUX6bUBPKYPNh5PjX6Vnhk3n45+2bUjnF8jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775135286; c=relaxed/relaxed;
	bh=KWxJTOWQkri5jmv5ZKMT+tNuIWsfKgbRVKTEMtbqloY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9TCIigjRwM7fTZ1Y0KxrjHWpNGlmoZW+NcooAU7B67AZGYU/KuocbBVciGhc0DtvNiZtIygBsqEsbZykl7sYVPDWnwQ6YSh8d0O4X3RDihA/MO9BdOL/N3Kpp6jawYAGx8VsAAEOFeIWui9708Ijfnza66kHzbaTMGkv8eIb1ZErEb87k4cS7ePMyjr3McftEzQeSSsp7TrOGKEr5fryQofzGBHAH1vRCxA8iMiB32RT3hDoP5zO1XNXhalkcXMsK6F4+Xt3uUe9yE8iciOtaaaSb9Mr3CKEMsndcJaij7kqUBpLI9wXRxXI+dPLo1x4r3MKZvw3yVdpBB56kLlfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aYMrR4Co; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=liuhangbin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aYMrR4Co;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=liuhangbin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmhx03W6Mz2xN8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 00:08:03 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so535041a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 06:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775135281; x=1775740081; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWxJTOWQkri5jmv5ZKMT+tNuIWsfKgbRVKTEMtbqloY=;
        b=aYMrR4CoY07wEEfJv7vDUwD3aMcUfiDC0/jJcrS4HLpdAEpu03Fxd7I7Fa6cJbb3Vb
         18uBGhb1mzFlOUV6SG1RbX+bhGuxBeV8/SHHBACcDtgOR25No+tSMq3WJ0oEM6rpb98V
         /Yxm9UMjBwFdahjuEdkv1D9AEtr1hWTQ7Kjpa3iIxoE9uXHGOG7mXj/23wFD0RzKUlZE
         uPTpjqxoOJ34O3nFTmF76l2TqJLWa3+Ue1trs/1QW/E8HLrs5w+z8I/YdQ4ml/DRmXiu
         rL08a6PNofMkaX3e4iKmWLitx2CqE1GR2tASD0NX6UG9fNLa5SmwX7DCGzSFVXJ6MImC
         lsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775135281; x=1775740081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWxJTOWQkri5jmv5ZKMT+tNuIWsfKgbRVKTEMtbqloY=;
        b=GdacZvExljKLRgpECgquGrRWPEpTgI3ZofjXJ9iIDvTqco6MtDiP1mElPm7FFg7qkj
         rqx0FIgEfJg99VJXiGZogBo3QDRsaciC56DptjiE1WDZ24d9f5suvawqby88Ef5g/Bl7
         Eah9b2iBdait6nNAf42cdrSYFK8uhCJ24fLFPz0+lpKBuS+5lq8CftxQ87MSe57X2b17
         ylCDIGN7gVQuX8hKm/LWYCbTlGtUsWVh1+foMdhRskl8wqw5lfrfit3/fzoRyUHYzjAt
         wfDsZFcE16vFuoaGp8jghRy7qjlPWZt41lvcvkgfL/xlJAdZ2ovYh6FEeehIvYSGWt8U
         ceGA==
X-Forwarded-Encrypted: i=1; AJvYcCXmhPtygOGM064bYVs7EbvS8esKDMY4+3gATQgPWpft6wFL8HViwIdoM9OhNCnnl73Vj9DW1SsFsNJi1gU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw8xfz3czGNhKfr7WT8YYTC6HN2E/X6Bz6PqmNXBf0Endepk0y8
	MaF8fR+Mf9E1woPXOVOUZTUF1sFlDnhsjS8az898lIpwidDBouQPkSu9
X-Gm-Gg: AeBDiesLgZCEYzIcTADLEUfMlg0IIa2hznAimBXdU6yTle8HgTI/0a5fNJreROBBASV
	fQvQeCGtt1Qn4wH8ErtqyQvPgXKQUJLt/uGNYn6sDrLXGEMTkEH9BZ6DxoeKqDVd11o9UQieu1h
	IpLA8KiOkhq6jf1Q/j/EKAfj0285MQS0T9/9Teiaue0sNqPOKgLqFqmy0/aGdzSw7Vq1O2nfdGV
	kY6pZee3bAccvsmGd+SNoJ8Uw64Bq86BGSwoerpVO0/Rocct+PHp4rVdl+/G+0Yc7v7ZFOggBc6
	WtVreSNpCbRD1RcurlGd6VgVJWF4B+lL028e2dloJffstebvD9KofxtLkYhgF+HsNlMOA2YLCRP
	7mBUcQD9dK1n4XVDzofW24c/AmpsforNT+jeVWRXus/2bmI3vfnpgzobdr8QKSAPJvo36948i1h
	JGWLQi0suA6MEhPQYovgKZrvwEj6w=
X-Received: by 2002:a17:90b:4d81:b0:35d:a412:3c79 with SMTP id 98e67ed59e1d1-35dc7079cb6mr6805318a91.30.1775135280985;
        Thu, 02 Apr 2026 06:08:00 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe41b11fsm7822915a91.0.2026.04.02.06.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 06:08:00 -0700 (PDT)
Date: Thu, 2 Apr 2026 13:07:45 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Brian Cain <bcain@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] cmpxchg: allow const-qualified old value in cmpxchg()
Message-ID: <ac5qIUS5azbWAc9q@fedora>
References: <20260402-cmpxchg-v1-1-4561e2c05d2c@gmail.com>
 <20260402095747.6efbd456@pumpkin>
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
In-Reply-To: <20260402095747.6efbd456@pumpkin>

On Thu, Apr 02, 2026 at 09:57:47AM +0100, David Laight wrote:
> > diff --git a/arch/alpha/include/asm/cmpxchg.h b/arch/alpha/include/asm/cmpxchg.h
> > index ae1b96479d0c..b4b8dac759c4 100644
> > --- a/arch/alpha/include/asm/cmpxchg.h
> > +++ b/arch/alpha/include/asm/cmpxchg.h
> > @@ -234,7 +234,7 @@ ____cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
> >  
> >  #define arch_cmpxchg_local(ptr, o, n)					\
> >  ({									\
> > -	__typeof__(*(ptr)) _o_ = (o);					\
> > +	__typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);		\
> >  	__typeof__(*(ptr)) _n_ = (n);					\
> >  	(__typeof__(*(ptr))) ____cmpxchg((ptr), (unsigned long)_o_,	\
> >  					  (unsigned long)_n_,		\
> 
> That looks like it loses the check that 'o' has the same type as '*ptr'.
> Maybe this works?
> 	auto _o_ = 1 ? (o) : *(ptr);
> 
Oh, I didn't notice this. Thanks for the comment!

Best Regards
Hangbin

