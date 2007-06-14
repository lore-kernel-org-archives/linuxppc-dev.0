Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 86661DDE49
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 23:56:27 +1000 (EST)
In-Reply-To: <1181729973.25586.31.camel@dolphin.spb.rtsoft.ru>
References: <1181729973.25586.31.camel@dolphin.spb.rtsoft.ru>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <db0d38e5b5e1a9a3a7fe35d25ebd357a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: MPC7450 L2 HW cache flush feature utilization
Date: Thu, 14 Jun 2007 15:56:20 +0200
To: Vladislav Buzov <vbuzov@ru.mvista.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I read the MPC7450 reference manual and it describes a method to flush
> the cache using L2 hardware flushing feature. The cache flushing
> procedure consist of several steps and some of them are dictated by
> MPC7448 errata (www.freescale.com/files/32bit/doc/errata/MPC7448CE.pdf,
> Erratum no.3).

Are these errata 7448-only?  If not, I wonder what is
done on PowerMacs?

> First, I'm looking for a help and advice why the current _set_L2CR()
> implementation may not work for MPC7450 (namely 7448 with 1Mb L2 cache
> installed). Is it a bug in _set_L2CR()  or a hardware problem.

I think that if anyone here could answer this straight
away, the source code would have been fixed already ;-)

> I've
> mentioned above about MPC7450 hardware bug in L2 hardware flushing
> mechanism. May it be applicable to common cache flushing procedure 
> based
> on sequence of lwz/dcbf instructions?

Dunno, too lazy to download that PDF, perhaps you can
quote the relevant part?

> Second, Is this patch acceptable?

Looks reasonable enough to me...  if it works (on all
things considered "7450" by the kernel).

>  	/* TODO: use HW flush assist when available */

You want to get rid of this old comment though -- and
perhaps branch over the non-hardware-assisted cache
flushing code.


Segher
