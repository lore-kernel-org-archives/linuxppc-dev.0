Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp8.wanadoo.fr (smtp8.wanadoo.fr [193.252.22.23])
	by ozlabs.org (Postfix) with ESMTP id BDB0767A67
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Mar 2005 23:58:06 +1100 (EST)
Date: Mon, 7 Mar 2005 13:46:11 +0100
To: James Chapman <jchapman@katalix.com>
Message-ID: <20050307124611.GA20153@pegasos>
References: <20050307105838.3DB6C1C007DE@mwinf0309.wanadoo.fr>
	<422C495B.8090805@katalix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <422C495B.8090805@katalix.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Nicolas DET <det.nicolas@free.fr>, linuxppc-dev@ozlabs.org
Subject: Re: mv64x60 updates
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 07, 2005 at 12:30:19PM +0000, James Chapman wrote:
> Hi Nicolas,
> 
> A few general comments:-
> 
> - mv64x60 stuff is best posted to linuxppc-embedded

The pegasos is not an embedded machine though, but i guess it is on -embedded
where the people using it are.

> - you change several generic files to support your platform. It should
>   be possible to support new mv64x60 platforms by writing a new
>   xxx_setup.c file in arch/ppc/platforms with no other generic changes.

Well, the pegasos is a chrp, so most of the stuff is in chrp_setup.c already.

>   It is a goal that all mv64x60 boards can be supported by the generic
>   code in arch/ppc/syslib. If some changes need to be made outside

I don't think this is sane. The generic mv64x60 stuff is for embedded boards, 
and does initialize too much stuff for the pegasos. At least in the current
state of it, which is why i asked about Mark's comments about our case.

>   arch/ppc/platforms to support your board, try to make them generic so
>   that other similar boards would be able to use them. I suggest you
>   clone chrp_setup.c or katana.c rather than adding conditionals in

Why ? The pegasos is a chrp, and it works perfectly with the chrp_setup stuff,
we just need to add the necessary code for making use of the gige interface of
the marvell, the rest works perfectly in chrp.

>   chrp_setup.c for your board. Then use code in your board specific
>   setup file to call arch/ppc/syslib mv64x60 routines as appropriate.

Yep.

> - you shouldn't need to add board-specific changes in mv643xx_eth.c.
>   Setup device platform data for your board in your platform file.
>   If something needs to be added to the platform data for a generic
>   change to mv643xx_eth, do that rather than add platform conditionals
>   in the driver.

Ok.

> - why do you need to use SA_SHIRQ in the ethernet driver?

I think because the two ports share the irq with other devices, not sure
though.

Friendly,

Sven Luther
