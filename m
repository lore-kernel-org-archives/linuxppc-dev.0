Return-Path: <tpiepho@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C00E7DE059
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 09:03:40 +1000 (EST)
Date: Thu, 22 May 2008 15:56:52 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Improve (in|out)_beXX() asm code
In-Reply-To: <1211516683.8297.271.camel@pasglop>
Message-ID: <Pine.LNX.4.64.0805221553400.8205@t2.domain.actdsltmp>
References: <4833524C.3040207@freescale.com>
	<20080520.153947.84346222.davem@davemloft.net>
	<4833542E.3040608@freescale.com>
	<20080520.155326.195407196.davem@davemloft.net>
	<1211516683.8297.271.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 23 May 2008, Benjamin Herrenschmidt wrote:
> On Tue, 2008-05-20 at 15:53 -0700, David Miller wrote:
>> From: Scott Wood <scottwood@freescale.com>
>> Date: Tue, 20 May 2008 17:43:58 -0500
>>> David Miller wrote:
>>>> The __volatile__ in the asm construct disallows movement of the
>>>> inline asm relative to statements surrounding it.
>>>>
>>>> The only reason barrier() in kernel.h needs a memory clobber is
>>>> because of a bug in ancient versions of gcc.  In fact, I think
>>>> that memory clobber might even be removable.
>>>
>>> Current versions of GCC seem quite happy to move non-asm memory accesses
>>> around a volatile asm without a memory clobber; see the test Trent posted.
>>
>> Indeed, and even the GCC manual is clear about this.
>
> So what is the scope of that problem ?
>
> IE. Take an x86 version of that test, writing to memory, doing a writel
> to some MMIO, then another memory write, can those be re-ordered with
> the current x86 version of writel ?

Yes, the same thing can happen on x86.  As far as I could tell, this is
something that all other arches can have happen.  Usually aliasing prevents
it, but it's not hard to constuct a test case where it doesn't.
