Return-Path: <linuxppc-dev+bounces-22989-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08432CDB479
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2026 15:30:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmN6V3zTDz2y8p;
	Fri, 26 Jun 2026 01:30:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782401426;
	cv=none; b=a55/ss1pG6jyov/lDi252VNNoLkvL5gNkzRgKu2RrTkbbhkDn//NYm7w0i68ILbK3lPRYHSwaBuwb/v5ph9i/tZSIsJ+wi9d9uRdtleoSFUKpVDbvpKkSgwfBuek0BfeRGB0dAHd8jIxB3XCeHAQ/UEe5TV6+CkQrmzsAXitglH0uJhhHP48mZnY4cUL+gSkZVefaCjc8qR1rp5E6mlXr9+rPlI8Li664aJ6qeNpmBPCnfrVjM86MbckY+AyXEK3UoNx0+hmjrsqbcMdv2VdSRAWyJBF6uSBD9sSlVs1ijddHx8LUS5JBwNMKq3GaCYVaqXfsZUaC7zrFRwb6GfD4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782401426; c=relaxed/relaxed;
	bh=hL6WQal4FI/mvhdzofHugqoqMtcJjs0nCtdAyeoXF5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrrNZny7ONw97DU3M6KvEvDCptnsVPKPtdbEYXrigpCHCetRUcKlK6lgVPsV8GBPVMpxvtSuuUAnbF6B526jr0BE6N2/5YpqFLHUaytvGq9hUYqiQMrz8uZfej1E90MI+HOkKCBPsbT93FU2addAc91O3haZntHfqBvTTJnOqTjEf8DzbzvorSgv5j7z3ZNBPLCAI+Sc04b/D+y5xngk1m/aGrso2ED7CYQXzzyY79jHGMMX3gKYtJdsyzyA7/whLWGrg0bJ/FfjR79d+YWfc//xKf0qZzPpoTj+qxW0qnn+Kk3EhvZlPIlS3CF/37/SGG94YjzXbu9K+mldcqMN+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=RK4PgONE; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=RK4PgONE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmN6T0lpVz2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 01:30:24 +1000 (AEST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4924e6fda5dso30895e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2026 08:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782401420; x=1783006220; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hL6WQal4FI/mvhdzofHugqoqMtcJjs0nCtdAyeoXF5k=;
        b=RK4PgONEvd1Wi+VswZEA/Isx5AFgjGIJGh/Has42ZRzTJd9A06ZQIdlvlgM3nXnbUE
         kpeFWXn27SPBlLF74fEtcTlR9nVqCecWnKXfyrObljnuejTV/Q49OixDg7x/88I2UmaI
         F4CiVEjz1jb8ny71GC/qloFHu+COwaI9BPEnI9VxD5ZwLe7XPVoYq4mit96PVLxCHcSP
         O2zEkR2w2EHKW22tcBip7iHgW5SmnPJwLOiGEXaBg5jfSQpX/SDisHO/858CXsheLkIS
         LD1G3bH1urN+bClmwZ+yIrH8DHXX624WwBWJCPeyen3E6WAZS8b/WJT/q9WrhLiOAk3Y
         fVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782401420; x=1783006220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hL6WQal4FI/mvhdzofHugqoqMtcJjs0nCtdAyeoXF5k=;
        b=ou4ccJeTEj2YbLce70QfwQ3jT8nZfXYvNl+HNK17VRTm/ZI225gUadfT4dwYRUjMeB
         efhhC+WOhF6jjXIpsTCOKiuIFBYMd2IikYc0as+d1yiGYTAG5rH58JuHQu/KnfMFzN7/
         eg8purOE8+qkUfkHyeWEP/E+Mn2HLfiXZs1w4ugaF1IrrMJGIumTpk4n+HAy/LVuwzea
         jlWmzOTI2t+4GAERhMDaEUAQkuamnocNsftELTJFCob6XFT8s1Zd7tqZzXZDqJGU0E08
         4RbAatRWQgz/cM/Jbdqib6wVnm28sQdwaju0u3kOWJIsscbDo4RHAGatKPnGpuw7axGa
         ezmg==
X-Forwarded-Encrypted: i=1; AFNElJ9BmiV24uE2TSVSwmNtcVkSR6C9FJFUXHg4KdoWealQBgn/Kn4nkgIZSaCkMtmVufz9eX1TT6T3LOxaO9E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwOpQZGCrnWp0T4qrMs+gJjWsYdilRcm20dJUOlxPmm0DX5TZoG
	lGBs4WcVaaJStW4m+Kh+qchS7yMtDV2zrY6nWrJudZogpyMr5q3Wb94DvVLsT9FvozU=
X-Gm-Gg: AfdE7cniiME9ShB6q82uIu5cDp7AATgZIbhBN4oWOG9Z7zjTALf2m6pQA8TsTcUZ0vy
	udS5yj/V23a2r+6/FvPzS1rnsHw5QxowVXfXpZMU00ToflwBbM3i7w4DEBusqU6XuUdICcuOLfl
	1iswQLDMuut/5zbUc5fNb5FBW6ZekgQUJxcJlbkvdx+x16afLTI8vKwfApMrldF6NTpNpVDI4vY
	2e3JZg2TZE2uk7R0KJg9ZAW1GvmxSl54c65FPPMwokOXLPe8Y7Xkc2wabbquy8H6elKHa9FJiq1
	9Rq0JsD47AFBPs+D+UyN0dU5KL00KF8D5cTsk2POTPt8AFrzjvx94B4m1m0uDn5Pzlp4MpwOczK
	RdmsWMuN26QbY9DYsgd0QtRWjFHEMn9cMmpG3bRAuKUI1k9y9tCfRWNnbKSUpuYaZnwAYeACuzW
	AjW2sbC9Rn3pMiJgE=
X-Received: by 2002:a05:600c:37c7:b0:490:44eb:c1e0 with SMTP id 5b1f17b1804b1-492668963bfmr41296065e9.21.1782401420019;
        Thu, 25 Jun 2026 08:30:20 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fc0f32sm5471145e9.3.2026.06.25.08.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 08:30:19 -0700 (PDT)
Date: Thu, 25 Jun 2026 17:30:15 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bradley Morgan <include@grrlz.net>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Kees Cook <kees@kernel.org>, Rio <rioo.tsukatsukii@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Mayank Rungta <mrungta@google.com>, Tejun Heo <tj@kernel.org>,
	Zhenguo Yao <yaozhenguo1@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Michal Hocko <mhocko@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
	Jiri Kosina <jkosina@suse.cz>
Subject: Fixed tag magic: was: Re: [PATCH v2 1/4] sys_info: add helper for
 callers that handle all_bt
Message-ID: <aj1Jh57McGH94gGY@pathway.suse.cz>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
 <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org>
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
In-Reply-To: <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org>

On Wed 2026-06-24 13:34:19, Andrew Morton wrote:
> On Tue, 23 Jun 2026 15:34:58 +0000 Bradley Morgan <include@grrlz.net> wrote:
> 
> > Some callers handle SYS_INFO_ALL_BT themselves before calling sys_info().
> > Add a helper that strips that bit without turning an all_bt only mask into
> > a kernel_sys_info fallback.
> 
> I assume this patch wants a Fixes: and a cc:stable also.
> 
> It would be nice to have the conventional [0/N] cover letter to tell
> readers what this is all about.
> 
> The patches all have different Fixes: targets.  This risks inviting the
> -stable maintainers to merge only some of the patches into some
> kernels, resulting in an untested combination and which might break
> things.

I do not agree here. The Fixes tag should should point to a commit
which introduced the regression into the given code. And finding
some magic common point beause there is some magic undocumented
process for maintaining stable kernels sounds like a way to hell
to me.

Best Regards,
Petr

