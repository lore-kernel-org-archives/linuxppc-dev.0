Return-Path: <euphoria@arcor.de>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C40F6DDE26
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 00:52:32 +1000 (EST)
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net
	[151.189.8.16])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id D65D33033F9
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Aug 2007 16:52:22 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id CA275ABAE0
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Aug 2007 16:52:22 +0200 (CEST)
Received: from [192.168.100.2] (e181053021.adsl.alicedsl.de [85.181.53.21])
	(Authenticated sender: florian.boelstler@arcor.de)
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id A335B1B3264
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Aug 2007 16:52:22 +0200 (CEST)
Message-ID: <46D193A3.70601@arcor.de>
Date: Sun, 26 Aug 2007 16:52:19 +0200
From: Florian Boelstler <euphoria@arcor.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] xmon: setjmp / longjmp implementation problems
References: <46CE0CF6.2010804@arcor.de>
In-Reply-To: <46CE0CF6.2010804@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Just for the record:
I made a mistake in my userspace test environment regarding the
setjmp/longjmp implementation.
I defined setjmp/longjmp functions as static ones, which triggered
recent compilers to inline. Inlining breaks setjmp/longjmp of course.

Further I realized that the NuBus-specific setjmp/longjmp was also
defined as static functions. For xmon this was never the case (even
defined in a separate file).

Thanks to David Gibson and Sergei Shtylyov for answering my questions
on #mklinux.

Cheers,

 Florian
