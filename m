Return-Path: <linuxppc-dev+bounces-22850-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4FDCD98F2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Jun 2026 09:57:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gjmwL5Ww0z2xQD;
	Sun, 21 Jun 2026 19:57:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782035858;
	cv=none; b=dZLRIvKIshSrLxRQKWvdMSonIcGZmswXIwZCQma4YCYhRm0o1ATMEA6d2cN+LTyoVXwjkYA5JjIwjH7GqaJ0bokB8wg/qwPH0zop1MHaXyhj1x/yZ17ZQzSAUIYvYFKeZp95z8sMGc/sxf0moor7h7aVow0WATVd3A9Jj22J7wsIgk00lFAQF68F1AQQB4SaNsFLRaSEvfIREyeCC/HVeOMvbaxV4MRPpjdHm/6LNSRpIzzMy8kEVc9UyHSfwjxZXcOrh9lI7FXTwnmMfQvnGrLN/CtQT1fxCNMSK3j+c3/7NXu8Zw+yXMwX4n0sMScckQPwtd0Ob+qEZLRpJSCKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782035858; c=relaxed/relaxed;
	bh=bDDdiLLNjwpRAIM1Pb4P4IMGb/RTUM1UfOJfvWRzG4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqP9oZu3R9H4hKbBnCArSflN7rMHcfMPLXJwmQdH83ANh4YDRu9q1bxfXI7Ba3bOxringQ3w+OHYgu9wWaBteSzMevTt9En1Mc5tpVuN5qyMueyxse+0Xr+RFLNPc/2IRD5uUcYbVhNWYlnSfkw5cFsh8wbu061BYcDdDgbNpmwn5VfrA8IZ2E9/TYIKhqaOaxuP9/ArU3ft8iHOp7kCb1wbS/bbA5PWVI5UMSxFXK+F3t01Fp5ylKCGCRCgMC7J8HapweoMVg/1oMsTd93VOCsuOOPgh3pxJZJD9SfXg6h+evQwyV0x74T8EVzRgzLh5PBroltg5zOfOFQ9gewf1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass (client-ip=216.40.44.11; helo=relay.hostedemail.com; envelope-from=rostedt@goodmis.org; receiver=lists.ozlabs.org) smtp.mailfrom=goodmis.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=goodmis.org (client-ip=216.40.44.11; helo=relay.hostedemail.com; envelope-from=rostedt@goodmis.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 596 seconds by postgrey-1.37 at boromir; Sun, 21 Jun 2026 19:57:37 AEST
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gjmwK4Mjfz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2026 19:57:36 +1000 (AEST)
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 5F2911669C9;
	Sun, 21 Jun 2026 09:47:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 423E619;
	Sun, 21 Jun 2026 09:47:24 +0000 (UTC)
Date: Sun, 21 Jun 2026 05:47:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Thomas
 Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Julia
 Lawall <julia.lawall@inria.fr>, Yury Norov <yury.norov@gmail.com>,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] tracing: Add CONFIG_TRACE_PRINTK_DEBUGGING to clean
 up kernel.h
Message-ID: <20260621054721.7cde38f0@fedora>
In-Reply-To: <20260621093811.168514984@kernel.org>
References: <20260621093430.264983361@kernel.org>
	<20260621093811.168514984@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 423E619
X-Stat-Signature: fmj3ggtdgzonpf7zkcaz1xu59knp7xib
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/c1xrYJCl0ydW3HbIGCPludPRhKvEu6LQ=
X-HE-Tag: 1782035244-818315
X-HE-Meta: U2FsdGVkX18+OnZrvpIyWt/RWyUKQSX5PXFpTHJVo4PwVmZ7eZdT47ziWR0MyYlIDY1fqyBrJQ7Sk8k5g0+2jmXTLK3lUwRTI0f5QPWBoSBJkbuT1sPD257mlKV1a7d0s3ZNeXJGyaSPBFFVvXt1+Qf+cUBFPUoqGZ0yMtfaXjw3YaFrUe3XLns/TKPMVLkkLwAcJDTciB1Xe3NH/20RSxO90n0HLC/gAJL0U4ehyKGkMZazF4mztUQ3rNuBe2ykFgmEtFv/v9YSeGsstUMosrvQssX7vVaGO3wWKdHlxvzC3LFqWs5SWRpkx5HfojuQQ6b/YNA/zDIqUKZELcAtaTTF9olXpSEl

On Sun, 21 Jun 2026 05:34:32 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> Instead of having trace_printk.h included in kernel.h, create a config
> TRACE_PRINTK_DEBUGGING that when set will update the CFLAGS in the
> Makefile to allow developers to add trace_printk() without the need to add
> the include for it. Having it included in the Makefile keeps it from being
> in the dependency chain and it will not waste extra CPU cycles for those
> building the kernel without using trace_printk.

Bah, I only tested with the config option enabled, and missed some
dependencies with it disabled.

For instance, rcu.h also uses ftrace_dump() so that too needs to go
into kernel.h. I also need to add a few more includes to trace_printk.h.

OK, I need to run this through all my tests to find where else I missed
adding the includes. But the idea should hopefully satisfy everyone.

-- Steve

