Return-Path: <linuxppc-dev+bounces-22879-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E569CDB471
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2026 16:40:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkYqD5jnPz2yVd;
	Tue, 23 Jun 2026 02:40:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782146456;
	cv=none; b=TyBJariQOkUws+nMLJ45L3zJ0AAv6tbicU1hW7LXBpTqnLHpHej6xS7FRMu0oJexh/jjaBbn9GgLldisAqOmJJStx8lOj70jp3TiOMIxpkTkauuXWT4NEB6fah8a01I04821C0yPICRgpFYFOvbonz1KYnI1YQ38QwgLoAYM1sfxTGlc3PdcTIylhZTFb1Ip+tmukvINbOnc+EhnEeBuIzD7QupPPw1BZGjaEvhQsT18AlLzGPCAz4JSa6LSCMLEeVNSQCtnn0Raz45Y/JhcMT7TmDaY1dFh7KCqysyVy/JdchpPUk+hS2MNwOEaA4laFIAiSH7ugD9IRtlViAiPww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782146456; c=relaxed/relaxed;
	bh=c5UMhYqzW3FXITWipN5SHhAQOB1P9YUKBIDy0r3xPQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Me48DrZT5cmHxir4lmiCdgp5H723lSvR6qQ3JI5mIa/zBtzqpnJ0WNUZISFFXXnjiPzzIuOXMPTANSBrJQV0uY5ltW+3oMiptdQU7wam2MTse1GVMHAhQ+urPrPiarXE2cDkUPa8RgJYgXpt9msTPJC3i1ZrcpcdyIGM8CD7FPknjr8ufy2T/sq3xUbJ09bTsE9m360N1E0y6OM+Kqk0CkJzrKiFmIG5NBcYRzSoyRP+zZ+oDKFLJY2riecxQn/f6Dvc5fafcN/J9YUCrQIcM9K0gUOVTjLYkCMgVMvvrvn0uySfQ6+A49i4axOhsjsV2Ldrc0kPdRtm8XeeLJumOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wSEig2tX; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wSEig2tX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkYqC02JXz2yVZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 02:40:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=c5UMhYqzW3FXITWipN5SHhAQOB1P9YUKBIDy0r3xPQw=; b=wSEig2tXNqqYlMi+DO0fVntY5n
	xOHolZZKA+fIDoV0P9vbcZYk+nTw3ZO3neQaPzi4xv2gcxwSzlDonXdcprWpDH2QVuSHb1XstdPJW
	SDJunku4cTdk3jGABXOOirk4qvdvStLyf+TSspP6lyyvSkgzI8foJ7iUHjAWC1KMbyOnlr8Bk2/AC
	kSmplFs4mh7vU8qt6mUcBWozaXfZYbjxcaOPfxhFG3Z95uao/bptRNf0v9TlnvAPmJRfMGZZ11YUj
	Kd2cOw4Cnm3blaF1fkpC/rbtuwYhawbpOJtgBO9UdgKUgdoYUd8ev6TfDb5XWKvISvKwTYP33Ug+E
	awdU0f0A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbhhW-00000005CFj-0vuV;
	Mon, 22 Jun 2026 16:40:46 +0000
Message-ID: <08b3c961-18bb-43d9-8d7f-8a87bcad0afa@infradead.org>
Date: Mon, 22 Jun 2026 09:40:45 -0700
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tracing: Move trace_printk.h out of kernel.h
To: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>, Thomas Gleixner <tglx@kernel.org>,
 Julia Lawall <julia.lawall@inria.fr>, Yury Norov <yury.norov@gmail.com>,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
References: <20260621093430.264983361@kernel.org>
 <20260622083440.GX49951@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260622083440.GX49951@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/22/26 1:34 AM, Peter Zijlstra wrote:
> On Sun, Jun 21, 2026 at 05:34:30AM -0400, Steven Rostedt wrote:
>> There's been complaints about trace_printk() being defined in kernel.h as it
>> can increase the compilation time. As it is only used by some developers for
>> debugging purposes, it should not be in kernel.h causing lots of wasted CPU
>> cycles for those that do not ever care about it.
>>
>> Instead, add a CONFIG_TRACE_PRINTK_DEBUGGING option that developers that do
>> use it can set and not have to always remember to add #include <linux/trace_printk.h>
>> to the files they add trace_printk() while debugging. It also means that
>> those that do not have that config set will not have to worry about wasted
>> CPU cycles as it is only include in the CFLAGS when the option is set, and
>> its completely ignored otherwise.
> 
> Did you forget your C 101 class? If you use a function, you gotta
> include the relevant header.

Also item #1 in Documentation/process/submit-checklist.rst.

> You don't see userspace saying: 'Hey, you know what, perhaps we should
> add stdio.h to every other header, just in case someone wants to
> printf()' either.
> 
> I really don't understand your argument. Yes, maybe someone will forget
> and then either their editor (if they have a halfway modern setup with
> LSP enabled) or their build will complain, but so what? This is all
> trivial stuff, surely we have more pressing matters to concern outselves
> with?



-- 
~Randy


