Return-Path: <linuxppc-dev+bounces-22870-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD375CDB471
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2026 13:11:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkTB44pm4z2xyh;
	Mon, 22 Jun 2026 23:11:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b12e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782133916;
	cv=none; b=ae+XuIqIYo35yQHDGv1jGcHvo4c7NUHsyYGfWMopXyfxqi+o1qxARwDjTEJnBYgNNXAcAYf9wdeYZJsJP2BdlLlFcEPyfykKPEEWY540gQ7l+cTM9OEB+ktISjNPa5FfycJNirpRFBOVKoeFjgoeqrMO6RHiWPqC9Qn+I6oDqxbH0y5PVuWPxqgBTos/KzejPZmRf8CDkvm0gjUp/nUZDTYULwi81gC85gCZK8yGUjHwFu2QkQXA4hHAB2hFd4dxn0N+VnFbESES6sZHGkcBQClaVgwcyA+hVIt1VRN6LXMJglF+L8q09K59LYsgOTnmeRWh2VcYg7ft4/N/BQqaeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782133916; c=relaxed/relaxed;
	bh=XkaEWxUJkCuHp/17+ud4oWXJ3qqAKnltzqopfMTtFIs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvNsSwpqfK+tnmmzZmC6oewZ9Qn0B0EEkbOeODPHtpVeDI3N9Dn6LL44oaTMtWN6ugvj2NL4PDRMytxhXgDdDq9/1ssbLNaTBKH/Dj1aBf9yRTymzPimnTlYJGSz5UeyQa6xMyRW0ZxaztcgLUk5bGouien4UOUXU0uWRpAIUEF7zIwQS4PX7n6lxD9SXSCvmW+tU0+0WYdNLH/vpW+g+5RKkw2mFTk3uS8hHgyc0gU+9z5ZCVjW3y9knT8f6QT1ms6mjc1I3WQeYombWA2RAmB1EDHVfyT7ew7tHMwxeL5ZtvDkgZRLCvFwS5rMN972LioYrc2MrRoxkH94s+H5Ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EOEj9+z4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12e; helo=mail-yx1-xb12e.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EOEj9+z4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12e; helo=mail-yx1-xb12e.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com [IPv6:2607:f8b0:4864:20::b12e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkTB25m80z2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2026 23:11:53 +1000 (AEST)
Received: by mail-yx1-xb12e.google.com with SMTP id 956f58d0204a3-662bb8b1f93so4130293d50.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2026 06:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782133911; x=1782738711; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XkaEWxUJkCuHp/17+ud4oWXJ3qqAKnltzqopfMTtFIs=;
        b=EOEj9+z48nIi023LRTlvjLZmLpA2WIU4qbRas2mY3sZDm2uKwA5QpU8WHPMVhjpHW1
         g/qUTljYdXbpU9grI4zTgnlPUe17EJXE5McBbcNVVu9EhOl6wpieB3+JSHFRtSa1+mx8
         lKl9XVZT2rLDKDrl5QJgLFiV6TKSMxL8geJrvhqTwIegJ2shb3k+3kZZS2Wkcb1hrV6F
         wu4IqCZeOealapYM/jTi9MYiuEgJp/EQ/BP3c2FLe/wGFrrimsPTThMLg+pgDB4SkOrt
         Aw781qBxMJiKWyNSBYS3QSix+ZDgRQWULRz2s6JEy5ojopucEdILHFHZKVBCcYtjloPJ
         k0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782133911; x=1782738711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkaEWxUJkCuHp/17+ud4oWXJ3qqAKnltzqopfMTtFIs=;
        b=nAp+oT0ImNeWCr9jm8xoceTWZFdqCGG5i7jnj8UlzgrJR55cSpqgd4Rz1TRCbRdRke
         cCmYHWsOf+CKAON0Qbth5Dn3JwkVXmvmRKb0zqAI1EqH4lbe1hBceNjpQLKXBi6kiQkL
         0zNbStBG47XuFCFB43Yj50M+MEHwqk7YZNGnC1ZbTmZPsktMu08CvZnoVfuTINMF+EVj
         i+kIow+vecsIdUSL6kHt0KtwZsyf5fQfkKMRXofwIF8gd5QCnIP2pNydIdamx3rBdYlx
         8Fk0NThnr2zmabnv1gXnjo7/pX24h/f6TCbUdVRwqUuxJwL7OZd23YPvTrGrJw722vRz
         U6OA==
X-Forwarded-Encrypted: i=1; AHgh+Rq6SGMc+TZg9M7ZBNFcVvpIhvNi5kWA7NK5VeNvHK5JorTgKfPukZGEKUyBFn+fCZC4vNoW1mxbTXQkz4I=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwaTSZHmuMkR/3NsAAzEdmJbpvFCK690qvKk1zcp4LpMlohhRtg
	ACEk9EeSC9SFqJW9oBOrVzGU4mCwH5+OtO1iQN/RMslkpR1jDK7WXugK
X-Gm-Gg: AfdE7cnWFsDahbYB+nHD50X/6c2xl4CCtR/IFzQHps1ebdRqjW2t9zZetsfUIu5Dk0z
	1GyQftrWx4dHGimSnbTnjbYGvj8yN38EgOAqF3j2KS3c1EPayQbbv2j2Ol9fB9sa9s5z45lx96c
	6gaq6Oepi9Kt3+7rDFmixhEXWV2gnmPncj9XvmylewpeYVKYmM6ui4PYKGeGgwwEoVT/GhFRXLo
	KSIwBse0b0VE1iMCZ5P0Pz80r+RRzYnjWQbomDOEkDIwuNsM7xNocn+3JJ8VOkFATHSEsZYxBGE
	k39+wJwKDkZ4gUpisPagTefEZQaum8yB9TskCRKms916EhLTonnGynOXelPpqg9XwDFbT9onZIa
	d+st00piZbfB8pDJuLMTtZ/ybASrOV4qJGqaqKG9PK7Mz52MKbuuUa0udShmTDG7n3oGhjfAAWC
	mWULam0z4=
X-Received: by 2002:a05:690e:120c:b0:660:54e4:5dd1 with SMTP id 956f58d0204a3-6630333ac1bmr11505521d50.44.1782133910591;
        Mon, 22 Jun 2026 06:11:50 -0700 (PDT)
Received: from localhost ([38.101.158.131])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66314ac3f96sm3600882d50.1.2026.06.22.06.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:11:50 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Mon, 22 Jun 2026 09:11:49 -0400
To: Steven Rostedt <rostedt@kernel.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Yury Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 0/2] tracing: Move trace_printk.h out of kernel.h
Message-ID: <ajk0lT9P0SeuD94j@yury>
References: <20260621093430.264983361@kernel.org>
 <dbb5915e-6587-4de9-87f3-76bea5024da8@kernel.org>
 <20260622090826.20efadb3@fedora>
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
In-Reply-To: <20260622090826.20efadb3@fedora>

On Mon, Jun 22, 2026 at 09:08:26AM -0400, Steven Rostedt wrote:
> On Mon, 22 Jun 2026 10:05:13 +0200
> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:
> 
> > > There's been complaints about trace_printk() being defined in kernel.h as it
> > > can increase the compilation time. As it is only used by some developers for
> > > debugging purposes, it should not be in kernel.h causing lots of wasted CPU
> > > cycles for those that do not ever care about it.  
> > 
> > Do we have a measurement of the increased compilation time ?
> 
> I believe Yury does.

I re-run compilation is a more strict environment, and the difference
is negligible.

