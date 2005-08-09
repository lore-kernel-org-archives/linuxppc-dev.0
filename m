Return-Path: <va824363@albany.edu>
Received: from smtp.albany.edu (mail1.its.albany.edu [169.226.1.105])
	by ozlabs.org (Postfix) with ESMTP id 99EF967F82
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Aug 2005 23:38:44 +1000 (EST)
Message-ID: <24431.198.22.236.230.1123594721.squirrel@198.22.236.230>
In-Reply-To: <20050803153540.3530e114.kim.phillips@freescale.com>
References: <32704.198.22.236.230.1122651627.squirrel@198.22.236.230>
	<20050729153323.3f2c62ad.kim.phillips@freescale.com>
	<32798.24.92.61.26.1122694772.squirrel@24.92.61.26>
	<20050730183217.3310585b.kim.phillips@freescale.com>
	<33216.24.92.61.26.1122857296.squirrel@24.92.61.26>
	<20050801123728.62764c7e.kim.phillips@freescale.com>
	<53547.198.22.236.230.1122997515.squirrel@198.22.236.230>
	<20050803114749.739ae51e.kim.phillips@freescale.com>
	<30177.198.22.236.230.1123094006.squirrel@198.22.236.230>
	<20050803153540.3530e114.kim.phillips@freescale.com>
Date: Tue, 9 Aug 2005 09:38:41 -0400 (EDT)
From: "Vikas Aggarwal" <va824363@albany.edu>
To: "Kim Phillips" <kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc8248  SEC -- interrupt handler 'is' invoked
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Does that still use the DMA if i bypass channel infrastructure.?
Do i have to  implement channel-infrastructure in software driver.
-vikas

> On Wed, 3 Aug 2005 14:33:26 -0400 (EDT)
> "Vikas Aggarwal" <va824363@albany.edu> wrote:
>
>> I will try the new BSP but meanwhile like to debug my ported driver.
>>
>> Is there a way , like kernel level single-stepping to know why the
>> "interrupt status register"  gets a value of "0x0000000000000040" which
>> means TEA , transfer error acknowledge.
>
> afaik, TEA usually means memory was unable to be accessed by the sec
> (somewhat along the same lines as a SIGBUS or SIGSEGV).
>
> It's a long shot, but you may want to increase the 4-byte alignment of the
> rng buffer (0x009ffc5c in your trace?) to at least 8-byte.
>
> as for debugging, you can printk sec status registers every time you write
> one, e.g. in a sec register write wrapper fn.  Be sure to check the RNG
> interrupt status register, and the RNG status register, and the RNG
> interrupt control register.
>
> and if all else fails, you can bypass the channel infrastructure
> altogether, and use the RNG EU in slave mode.  Reset the SEC, write the
> RNG Reset Control Register SR bit, write <anyvalue> to the RNG Data size
> register, and pull data off the RNG FIFO at will.
>
> Kim
>
