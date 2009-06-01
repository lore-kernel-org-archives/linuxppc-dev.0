Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9E72EDDD1B
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Jun 2009 16:14:53 +1000 (EST)
In-Reply-To: <1243764699.3217.0@antares>
References: <OFC4733C3C.0E94C44D-ONC12575C5.00215A32-C12575C5.0023DB18@transmode.se>	(from
	joakim.tjernlund@transmode.se on Fri May 29 08:31:39 2009)
	<1243764699.3217.0@antares>
Subject: Re: [PATCH] powerpc: tiny memcpy_(to|from)io optimisation
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Message-ID: <OFEEF9A8F1.2B11D1F7-ONC12575C8.00214DF9-C12575C8.00224E4F@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 1 Jun 2009 08:14:43 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> Hi Jocke:
>
> Am 29.05.09 08:31 schrieb(en) Joakim Tjernlund:
> > > No (and I wasn't aware of the PPC pre-inc vs. post-inc stuff) - I
> > just
> >
> > I think this is true for most RISC based CPU's. It is a pity as
> > post ops are a lot more common. The do {} while(--chunks) is also
> > better. Basically the "while(--chunks)" is free(but only if you don't
> > use
> > chunks inside the loop).
>
> Just a side note:  I looked at the assembly output of gcc 4.3.3 coming
> with Ubuntu Jaunty/PowerPC for
>
> <snip case="1">
>    n >>= 2;
>    do {
>      *++dst = *++src;
>    } while (--n);
> <snip>
>
> and
>
> <snip case="2">
>    n >>= 2;
>    while (n--)
>      *dst++ = *src++;
> </snip>
>
> Using the gcc options "-O2 -mcpu=603e -mtune=603e" (same effect with
> "-O3" instead of "-O2") the loop core is *exactly* the same in both
> cases.

Yes, the compiler can/should optimize this but ...

>
> With gcc 4.2.2 (coming with ELDK 4.2) the loop core in case 2 is indeed
> one statement longer, though...

.. not even 4.2.2 which is fairly modern will get it right. It breaks very
easy as gcc has never been any good at this type of optimization. Sometimes
small changes will make gcc unhappy and it won't do the right optimization.

 Jocke
