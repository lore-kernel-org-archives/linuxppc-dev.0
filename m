Return-Path: <linuxppc-dev+bounces-22196-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9765CD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 13:10:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYspr26LSz2ytV;
	Mon, 08 Jun 2026 23:10:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.181
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780921335;
	cv=none; b=jRt44mfnc4bhmHhgoE3vD+7Ws+QgAGjZJrnMSAcb1CtcUYylZDmBHULLjuY16ZM7vGQcpAEKpIYlRRTrxYi4klxBv70vP9QL/qfrKecxJ6hrewEaFOSj34aABRq2SJRJHgDVxoAY3Yg4Fg45pUfHnoRGaCBpdHA5JbQwiILnJ3TOLbEvq31cUtxUkD9InMLKmCBP7CQqa46yEZiQwVbQ7xc1nLMb08f/RRW5hQiukkw39r3c0C/tLn5W0ZjFDV8QSnG8RDz30XcLrHhf9ge+72YBqvOmITE2FPrQowjEkVBe6gVv5XL7y/BEjVJRLuZ8jfIc8b7hgTYX0G2OnJt47w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780921335; c=relaxed/relaxed;
	bh=4qLdgQOFPoLS8lqIoVa/g3Pc5VZu6aAkccWsW+ROeqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FILyOleq/zWuIud/mXiT1ITeD5crDKt/3kYzBym8L+/exk5yHrPD+pALHmXKfxtGvfVivOZqijXVCcsZEL4CDjDPvKN0vStq4vyqiixHQVL8sidgUShN94mp4kWooSF6s+KwGcd0gQX3avTm3uNoIiZMJ0uiYV7Oyp+LNQ60SjJIXMlGWvN0JOUTkzVhhuf0q1uFbYio/B9P3DdsDfoR0+aKNWiop/bb4x/Swx2wf9t18Gd9WPWqdj3FhFzm5deHC8UyArvuSzoXptMonXcRT4yUdmTW/nj5gAvgPJ3Bu5ESpSxgDX9OuXPGr0bFzXWaumZrTG/xszDReyk04iGOgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iKxSHvAk; dkim-atps=neutral; spf=pass (client-ip=91.218.175.181; helo=out-181.mta0.migadu.com; envelope-from=jiayuan.chen@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iKxSHvAk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.181; helo=out-181.mta0.migadu.com; envelope-from=jiayuan.chen@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 516 seconds by postgrey-1.37 at boromir; Mon, 08 Jun 2026 22:22:11 AEST
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYrl73Wwsz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 22:22:10 +1000 (AEST)
Message-ID: <ca4a6111-084f-4ec9-b411-1f79ef0866b0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780920789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4qLdgQOFPoLS8lqIoVa/g3Pc5VZu6aAkccWsW+ROeqk=;
	b=iKxSHvAkcysM603Fp2Wxjc36dlEjWAl0aDr+suhXJdTAup683n1BjoCe5RgVWF+f/5wSvD
	h4QckvKraqhQAwTyt5LSwpp7/oSq7aJ/9VPJeXZhH9ZIfGxRb1W1te23qvFWqGZIZBl2+F
	/1p+jiCZIa8G0bMHp2xH241XFtYcaBY=
Date: Mon, 8 Jun 2026 20:12:45 +0800
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
Subject: Re: [BUG] kernel BUG in team driver: buffer overflow in
 team_add_slave()
To: Yeswanth Krishna <yeswanth@linux.ibm.com>, netdev@vger.kernel.org,
 venkat88@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <3ad19e86-234c-408f-896e-0d6c774fea49@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <3ad19e86-234c-408f-896e-0d6c774fea49@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/8/26 6:00 PM, Yeswanth Krishna wrote:
> Hi Team ,
>
> I encountered a kernel crash while running selftests on kernel 7.1.0-rc6
> on a POWER10 system. The crash occurs when adding a slave device to a
> team interface, triggered by FORTIFY_SOURCE detecting a buffer overflow.
>
> **System Information:**
> - Kernel: 7.1.0-rc6-160099.42-default+ (commit d548c6f4301b)
> - Architecture: powerpc64le (ppc64le)
> - Hardware: IBM POWER10 (9043-MRX), pSeries
> - Config: CONFIG_FORTIFY_SOURCE=y
>
> **Crash Location:**
>
> [ 3492.897824][T77143] kernel BUG at lib/string_helpers.c:1044!
> [ 3492.898057][T77143] NIP [c000000000ac1120] __fortify_panic+0x18/0x28
> [ 3492.898096][T77143] [c00000000efdb350] [c00800000b857a18] 
> team_add_slave+0xc60/0xcc0 [team]
>
>
> **Call Trace:**
>
> __fortify_panic+0x18/0x28
> team_add_slave+0xc60/0xcc0 [team]
> do_set_master+0x19c/0x240
> do_setlink.isra.0+0x388/0x1450
> rtnl_newlink+0xac8/0x1030
> rtnetlink_rcv_msg+0x450/0x530
> netlink_rcv_skb+0x74/0x1b0
> rtnetlink_rcv+0x24/0x40
> netlink_unicast+0x2e0/0x430
> netlink_sendmsg+0x210/0x580
> ____sys_sendmsg+0x30c/0x470
> ___sys_sendmsg+0x94/0xf0
> __sys_sendmsg+0x84/0x100
> system_call_exception+0x154/0x2b0
>
> **Reproducer:**
> The crash is 100% reproducible via selftests:
> ```bash
> cd tools/testing/selftests
> make -C drivers/net/team run_tests


I tried this under x86, but the warning was not triggered with 
CONFIG_FORTIFY_SOURCE.


Hope somebody who has a PPC system can test it.



