Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1C0CD1292
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2024 03:10:56 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Q3QIzxzR;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V9k5V6nyhz3vYY
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2024 14:10:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Q3QIzxzR;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V9k4j5wsTz3bfS
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2024 14:10:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1712286613;
	bh=5YM7mvGWbMlZmbIx5ybNEkNpgBfZXycaMReGwErZsdc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Q3QIzxzRbXpx2e47F9wae2WgRCUdoJb3BHqgFNQVHo4XOAcj6V4A6KAwpGReH2mLc
	 f4tWtIJ+360ZAKdin4JhCHTv8ghAVgTzDcPVTwAJNRCc/XIai15DUZ9CcoTd+cXGl3
	 CD64SNl4kNizJb6K2tWtg4KZzFiVTo67Mm7LyQ/ef6Ff7cb7pSMjsnUThoWI+4srek
	 3NrOXgKPwAv5ld8VkOq9Zsx07cH9xbaJYm5WvPsNggkC+eeNBC6WhkTXLl9IbgkFrt
	 kUeb7ERnoYAz1FDsjnvakUEh/M29R0AZI9Ci6zUJqmudcmTafdmRUuAxe33KrBmI4x
	 w8K64JUPj8pfw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V9k4j0HHRz4wyh;
	Fri,  5 Apr 2024 14:10:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Finn Thain <fthain@linux-m68k.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2] serial/pmac_zilog: Remove flawed mitigation for rx
 irq flood
In-Reply-To: <0df45bedded1249f6c6ec2c2fb0d9879da1841b7.1712273040.git.fthain@linux-m68k.org>
References: <0df45bedded1249f6c6ec2c2fb0d9879da1841b7.1712273040.git.fthain@linux-m68k.org>
Date: Fri, 05 Apr 2024 14:10:12 +1100
Message-ID: <87v84w7be3.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-m68k@lists.linux-m68k.org, Nicholas Piggin <npiggin@gmail.com>, linux-serial@vger.kernel.org, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Finn Thain <fthain@linux-m68k.org> writes:
> The mitigation was intended to stop the irq completely. That may be
> better than a hard lock-up but it turns out that you get a crash anyway
> if you're using pmac_zilog as a serial console:
>
> ttyPZ0: pmz: rx irq flood !
> BUG: spinlock recursion on CPU#0, swapper/0
>
> That's because the pr_err() call in pmz_receive_chars() results in
> pmz_console_write() attempting to lock a spinlock already locked in
> pmz_interrupt(). With CONFIG_DEBUG_SPINLOCK=y, this produces a fatal
> BUG splat. The spinlock in question is the one in struct uart_port.
>
> Even when it's not fatal, the serial port rx function ceases to work.
> Also, the iteration limit doesn't play nicely with QEMU, as can be
> seen in the bug report linked below.
>
> A web search for other reports of the error message "pmz: rx irq flood"
> didn't produce anything. So I don't think this code is needed any more.
> Remove it.

Yeah I think you're probably right.

I assume you have tested this on an actual pmac, as well as qemu?

cheers
