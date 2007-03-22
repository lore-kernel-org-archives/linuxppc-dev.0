Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 60C52DDF6E
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 23:03:55 +1100 (EST)
In-Reply-To: <1174543838.10836.21.camel@localhost.localdomain>
References: <1174543838.10836.21.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5fd8e208c5e6c87f852d6a528589dce3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: Always use -mno-string & -mno-multiple
Date: Thu, 22 Mar 2007 13:02:42 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Akinobu Mita <mita@fixstars.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> powerpc: Always use -mno-string and -mno-multiple
>
> The string and multiple load/store instructions are causing more
> damage than help on a lot of processors where they are microcoded
> and are generally no good for the kernel to use. Let's make sure
> we don't emit them on any powerpc variant.

And they help a lot on many 32-bit CPUs.  NAK.

If you tell your GCC to compile for a certain CPU where
these insns would be very slow, GCC will automagically
not generate them, already.


Segher
