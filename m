Return-Path: <linuxppc-dev+bounces-17480-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA639FD0079
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Mar 2026 22:16:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPGcr1T9Jz2xR4;
	Mon, 02 Mar 2026 09:16:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772403404;
	cv=none; b=XqJgFn8qMfSHqswGMpkPxI+8ZZQJMpylmnOgxaX23bneswAhCoaeabvKrYmcSOQXHC2qhlrJOCSNMYR+SYrJ/6bWjBrAXdaFLxPnY4N3MSbVrtEApDDUkeoQfSgtwQhVdGhu08g91kmyibHElgwkkWrEV9NJUnGoxL6eAMaStR4dbTk4C73iT7RW/yzHe3N0LmQitRPxgoqgzbYTDRqIWHPRosFHkPashrb+3ZCWKG8sf3faqn3uhyH8093yrBffGsYEUji0L7X/YJWM6d51Qf9FXUE1r32Ffz2uvDJaSIg19qMztycaovyxmopDGnpjbQ+Q2VCn3rbadS4vpsCy9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772403404; c=relaxed/relaxed;
	bh=AIl/dHV642tMqRZscE3Zjz5R/EkJp5KZJrPHqY8MUl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fKg9XwB8UtY/FeEl6u5IhAf0vYKt/yw750YN8nd4XWM7avsIeekfAgZaaKU0mQMZgVLbTD1SeMnhJhrBfLXXjuHh9kTPYgmjcCgkS866P9GRza9C2m8iOqhjs08oPDjgccKSzQQ8TvpO5vIXfTNqZycXEdANr6JsRwvJtq7UDHtdAbEMYfoIwo7EeM+NTOGP8XQ2O5g0SnqkmNlB5j020uIi69MhvjNmRiJA+3qANvLMK7zRSmyZ5JCAKxozyP8JCXIQZKF10YK5rDiAjJLJfDBvGUpvCBoFEOSyFsycJTXebMExFD7eK02X18iNpCJKc+fZXURl7g+bbohPJHN6zA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=K+d8j2fg; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=K+d8j2fg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPGcp2dD3z2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Mar 2026 09:16:41 +1100 (AEDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-437711e9195so2899989f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Mar 2026 14:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772403398; x=1773008198; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIl/dHV642tMqRZscE3Zjz5R/EkJp5KZJrPHqY8MUl4=;
        b=K+d8j2fgkOpOG+JRAYMcOYlMhIH/1eqlDXYPgDftEvbUq3wUHlLtr/qSIe0lOVvVR7
         Sh+FnhNpccWNQ9XErhJ88+igUdpl5r8VIgqhLzOtJIXpDBb0qJaI4VIymz6d7BRAmJYU
         rTYsntn5pMn8F+Y+5kJJeatzXpBxTIlueO+xoz/L0h9NWNBp2gDKdKB9Pg8poUDP19zC
         rHSI0Hh2yNyNm7me52pWnKWEITV7MEFkrppHmXxsVZd4LPIsHZB24QeGb4m48y6VkwIn
         SBf74NdHN8e8qe1FoTgVsnxOoHkKAbW/Hb6PFr5nysWSkR4e0a9tMAZtxIVPfZLqYXjo
         r+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772403398; x=1773008198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AIl/dHV642tMqRZscE3Zjz5R/EkJp5KZJrPHqY8MUl4=;
        b=lIDHkkPV/o9j02Ai/zEEL2e+QQYtFcDxHm6jaBx6KlDo10i4GLt9+UJKd2jcdAjyPX
         dzlP+WReBURn7Kv07gKCZ/HnXPz0MYis3Q/mhJQlrnJhDoynNBHoWZ3UXPSXAKGNumml
         ia6G9lWV6jREXuochJt5PXI411udM40qzRWJBKhqpg4I+PMs2RyMboF5MCDUN4gfdY4o
         uJnzVo1UAQO7k33LeQJlBnvUWsVUvpK6s1AG7BgCOIdyJM0jZRxalAAtTeS4o0OQOoJL
         GMw7G1+pUvv1THfZXrXUJdXHTxErQdQ4OkbEMEoS6T/jgyyNx+/y+HR+nnPvOjmxpAKb
         Aegg==
X-Forwarded-Encrypted: i=1; AJvYcCWOSwamdi+hnMGEjjPNFoG6ZMv7DHyd2hL9PhuWbSegRG6EhthJqlk7wkwub8ylT1khZfthaZzV4Jhce3o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyq3cCOSKeADaShJ0NxGOuwdEXyg4b8Ugi8udRP5diNhIy3anUD
	OJuhv18Pc0d5uZ0fyuYuAjo7GGzNMQ829XT45GuysEXL4y5YYeV+6mRz
X-Gm-Gg: ATEYQzxG1RHJA4TC262oHXTUihTsYxRl9/ktjPas7pMV1iJGb9QULAV/2fWOJVHBPsC
	LNCmtn8J0agZZ8DC9muWbuQfNpy/xRX1lfKmq2MrsHkhJpPGZXhv2JSAgj0Xmdl6RwL8Z7dFZ1V
	906Qk5LWgpITu/0G6vLku4Ej2hkdiZtAKXoRgoahOUQPzuv6jmobsBWXhDegfXVdoAfljlSsefz
	0HF85db6Rq4MGZJyPcqthAwK3UdD/IoN7UVsrOYsDs73Ed+zyx55OqpdX3ARbmnHr5ZG2c3zv88
	M3sYbIFFjTXVpswJmjeLuBLj1NPp+nb/O4J8oze6KisdXFgfI9dxyRRbHatnI9b9XW3DHcXvSRt
	p4fojkAvmrfbjWd6M9e1JrPgyEb6vVIQCSmDFsOytkdSe4FIiKL5q8OP4Aalr4Bsydm71p5CVau
	l7rwYtctOnrbcmTI3OabQ4LK4VVdRB06X1HnmaNCtz58LEarZ8MX3iwt2EKDktNC6M
X-Received: by 2002:a05:600c:4444:b0:475:de12:d3b5 with SMTP id 5b1f17b1804b1-483c9c323d8mr157846385e9.34.1772403398069;
        Sun, 01 Mar 2026 14:16:38 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b3cc2e65sm6649234f8f.2.2026.03.01.14.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 14:16:37 -0800 (PST)
Date: Sun, 1 Mar 2026 22:16:36 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, kernel test robot <lkp@intel.com>, Russell
 King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Heiko
 Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas
 Palix <nicolas.palix@imag.fr>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Andre Almeida <andrealmeid@igalia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] uaccess: Fix build of scoped user access with const
 pointer
Message-ID: <20260301221636.0efa722c@pumpkin>
In-Reply-To: <CAHk-=wixyP1mzyVcpZqQZd_xbabZQ873KVph3L-EkrNZGv3Ygw@mail.gmail.com>
References: <4e994e13b48420ef36be686458ce3512657ddb41.1772393211.git.chleroy@kernel.org>
	<CAHk-=wixyP1mzyVcpZqQZd_xbabZQ873KVph3L-EkrNZGv3Ygw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 1 Mar 2026 12:01:08 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

I also added to compiler.h :

+/*
+ * Sometimes a #define needs to declare a variable that is scoped
+ * to the statement that follows without having mismatched {}.
+ *	with (int x = expression) {
+ *		statements
+ *	}
+ * is the same as:
+ *	{
+ *		int x = expression;
+ *		statements
+ *	}
+ * but lets it all be hidden from the call site, eg:
+ *	frobnicate(args) {
+ *		statements
+ *	} 
+ * Only a single variable can be defined, and_with() allows extra ones
+ * without adding an additional outer loop.
+ *
+ * The controlled scope can be terminated using break, continue or goto.
+ */
+#define with(declaration) \
+	for (bool _with_done = false; !_with_done; _with_done = true)	\
+		and_with (declaration)
+#define and_with(declaration) \
+	for (declaration; !_with_done; _with_done = true)
+

So that you get:
#define __scoped_user_access(mode, uptr, size, elbl)					\
	with (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl)) \
		and_with (CLASS(user_##mode##_access, scope)(_tmpptr))			\
		/* Force modified pointer usage within the scope */			\
		and_with (const auto uptr = _tmpptr)

The next patch did:
-		and_with (const typeof(uptr) uptr = _tmpptr)
+		__diag_push() __diag_ignore_all("-Wshadow", "uptr is readonly copy")	\
+		and_with (const typeof(uptr) uptr = _tmpptr)				\
+		__diag_pop()

I'll update (to use auto as above) and resend.

	David

