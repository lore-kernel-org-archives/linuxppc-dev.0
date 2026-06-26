Return-Path: <linuxppc-dev+bounces-23012-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E86CD4F26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 09:42:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmrLP4P2kz2yVv;
	Fri, 26 Jun 2026 19:42:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782466941;
	cv=none; b=U51TOwk0t5RjNcfBk9JXUv6z6RNkE1/PQtdUbDuTrhxole5bjhkTcJ4dUy6xPA9AQrpzj/ivSSk7CIUEARNpfYFxr6TimFRGGB0k13KIHBdLyzOcMExVHEtMAR11JXa9wz8ErUmjv4+bh3jmnnuCtyYuGFlGTLnX/83BKUrnIWCYJTa0nkMBwi3cQM22s768ApJzFXTmqZob+ZTD80WgKjLh4P4KVBL28tvv/aqTDABt/5F2qnHrLhEYAXaGrTaqmRcsmj/n3oiFvq+OpC25ekL9Y71TPRfu8T6pb57iLUiqmRiWqi5IqJhS9qLZ6UYJma+7CMazEstL6kgONQ8Lyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782466941; c=relaxed/relaxed;
	bh=i57MYdMXpilBWj0slexli9uFmzGeK180L7PM67C9CYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGDwAbT71SzwEJ7DItPARsuqJp6tTsnzklrQsTKxoV35QDvxzshGVN1/nsyMVtHoX3UqCSvp25+pSZMIiLy5N3IVtP8FadwaMBSr6ygD2Qv+XfAF+/JXjB+AGwfPMu/GpHO2PZPK62Q5ptKX9dZuP4XDE+d9d1QMLiO8+p8Hitqp8ou4fr/HwplpLnbCIsOTsdZpbZMU6/iEiIUyl4VV6+h/l/LYpY7I5+rbvW/Vjxpp7K8wS4zdjnhCrO8MuMv2ocSENdiQr/yRzx0TQEODTsc72WFF8rF/TpgRWJPRBDiE2iN/QhN2z3qwq4ZzvuRacMBAyqlOXbDbuhK9lo2a4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=JcOVely6; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=JcOVely6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmrLN0fbGz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 19:42:18 +1000 (AEST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-46f8562013bso199661f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 02:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782466930; x=1783071730; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i57MYdMXpilBWj0slexli9uFmzGeK180L7PM67C9CYU=;
        b=JcOVely6IUbSQasFm7ZdXHlTH2QCGIaWsZFtTSW6Di6mMLfD8L66QZV//WS8QqODPu
         1smFNandZVw6vqZNRXwqx+EIIXWNSTXc/c7guj/psh9BKq8M7gJYt4xAbromJflQqTyg
         Qh0fKQBzlO9cnApEl4T2EojLYPzK0pL2ZoxyI48L3CFAaZdKmNNTh+YY+ENjDM1b1ZbX
         F+MUImOcBK7PKpfi4j7ahOTtvCZL1Y4ujWBXX3h6EfMYpbPA4xdK/MDvqpZw1WSAnZaA
         8ldgFYNWjb1smKg0Fl3fy10dIMiMldBLZ3kng0BM5XwLmQEOfyL3o+ZoWdInON92x/um
         vtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782466930; x=1783071730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i57MYdMXpilBWj0slexli9uFmzGeK180L7PM67C9CYU=;
        b=X2Z4ouRM4EvVCDKYgCEs+kZqt38Kus17/8/cn2f3drFaOwXPKtM/bQLCyhjCBfhBof
         gR602tef+9RnCrAozEDwtTks3CwdtTEG4sLjlOmcox1ambtfCxBOESkmNWUOSAILWQUI
         phg6OUtHNOrYu6yrwsfka6P7WntROkx/OTMAeOX60EB+HEBmm7LBmv0WVbLgqWZYQLFh
         1ioyT84d9F45QHd2ffHXvL0/Ai5OG4DuMHYY9qcmubPWxqxWMif4xlTOUExNCN/3KMyc
         Tj+7Y4v9kqc/VpwYamRvIgcAEgy3HKZe7DHXVRAiS5tqYuf7czrBrjeSDYLhhUf/Cle/
         gKGA==
X-Forwarded-Encrypted: i=1; AHgh+RqOEs6a6ddKiGQPagg6OPgoNaM+NCjnwtyasRfUc9ElB/FoyMJ6Gp+v7sLA4deClqzE/QGQq4KW7nKSLsY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyFtGEPbCeduI3wxSgvcNeNrw3YRiX1+9LVofmLOWooRM/LIUx7
	ofARc+O4a3z/XStQYxcfUPpRMqOqZve29jxRpfJx50xxc1LjM3a+NGyuO9SBPRdTmrg=
X-Gm-Gg: AfdE7cnqhHHCYjm5W0scfgaDdwGihB0tra/VdpOLcnJnGhNEvMCyLQ3kClGYqrZ5OT0
	ehiH9XWjqGDeC2/v/LOPHubjuzsWlfBD5WdFcUhYHz6stLKIOkj3IlThsNsBd6nUfGqls4FGlG+
	3NhvotoGB4PiF50YgMRb3L102i4d8on0tkDzl6By5RAQjpPAzO9yenxPqIKMlJtuYYRs8AA5sOj
	8x5nmiakIYzPZ4xr4fErgqCXMO8f66sdqyZ9yIANipxBS3BMzNUlsEncGCpwx178k9uQnn4U3nR
	JrDG5ONsUXFwjxZokGBVGYpzPeKXMXghaOyRfBvMlZ24nBm9mTWqNdZKa3blDSs4rt5oJkCIXSq
	qLJOVOT5Y57DEQKYO+ZyRlo8VLilOcWbJOa+sOokCkMh0I6p7kby0g6HCj9rQ+oaC9zzEaNqL8F
	jHMiTNMXwP9pMawbk=
X-Received: by 2002:a05:6000:461d:b0:446:db72:e8ec with SMTP id ffacd0b85a97d-46dc1a9181amr10448749f8f.23.1782466930592;
        Fri, 26 Jun 2026 02:42:10 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c2279b734sm24794053f8f.30.2026.06.26.02.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 02:42:10 -0700 (PDT)
Date: Fri, 26 Jun 2026 11:42:07 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 3/4] powerpc/watchdog: use sys_info_with_filter() to
 avoid duplicate backtraces
Message-ID: <aj5Jb1VPqfOLlCBQ@pathway.suse.cz>
References: <20260625152558.7450-1-include@grrlz.net>
 <20260625152558.7450-4-include@grrlz.net>
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
In-Reply-To: <20260625152558.7450-4-include@grrlz.net>

On Thu 2026-06-25 15:25:57, Bradley Morgan wrote:
> The powerpc watchdog prints all CPU backtraces itself. When the watchdog
> mask contains only SYS_INFO_ALL_BT, stripping that bit leaves zero and
> sys_info(0) falls back to kernel_sys_info.
> 
> Use sys_info_with_filter() so an explicit all_bt mask does not request
> the global default.
> 
> --- a/arch/powerpc/kernel/watchdog.c
> +++ b/arch/powerpc/kernel/watchdog.c
> @@ -418,11 +421,12 @@ DEFINE_INTERRUPT_HANDLER_NMI(soft_nmi_interrupt)
>  
>  		xchg(&__wd_nmi_output, 1); // see wd_lockup_ipi
>  
> +		si_mask = READ_ONCE(hardlockup_si_mask);
>  		if (sysctl_hardlockup_all_cpu_backtrace ||
> -		    (hardlockup_si_mask & SYS_INFO_ALL_BT))
> +		    (si_mask & SYS_INFO_ALL_BT))
>  			trigger_allbutcpu_cpu_backtrace(cpu);
>  
> -		sys_info(hardlockup_si_mask & ~SYS_INFO_ALL_BT);
> +		sys_info_with_filter(si_mask, SYS_INFO_ALL_BT);
>  		if (hardlockup_panic)
>  			nmi_panic(regs, "Hard LOCKUP");

I thought more about it and it is even more complicated.

Even if we prevent the duplicated output with sys_info_with_filter()
here. Then nmi_panic() might still trigger it once again.

We could say that this patch is a step in the right direction and
fix the other problem later. But I am not sure. We might need
a completely different approach and this is just a step aside.

And there is another problem in the panic() code. I am going to
comment in it in the 4th patch.

Best Regards,
Petr

