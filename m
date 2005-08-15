Return-Path: <tnt@246tNt.com>
Received: from outmx026.isp.belgacom.be (outmx026.isp.belgacom.be
	[195.238.2.91])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B97467EB8
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 Aug 2005 23:36:32 +1000 (EST)
Received: from outmx026.isp.belgacom.be (localhost [127.0.0.1])
	by outmx026.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j7FDaPkt026612
	for <linuxppc-embedded@ozlabs.org>; Mon, 15 Aug 2005 15:36:25 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <43009A8D.1040704@246tNt.com>
Date: Mon, 15 Aug 2005 15:37:17 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Andrey Volkov <avolkov@varma-el.com>
References: <43006FD4.6060801@varma-el.com>
In-Reply-To: <43006FD4.6060801@varma-el.com>
Content-Type: text/plain; charset=KOI8-R
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [00/02] MPC5200 Bestcomm platform driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Andrey,

Andrey Volkov wrote:
> Hi Sylvain
> 
> This is first part of "platformizied" bestcomm/fec drivers.
> 
> Comments/Commit?

Obviously I haven't yet had the time to review all the code but the
glance I had looked good ! I'll review it deeper and test it and come
back to you asap.

Still, some "preliminary" comments :

 - I never really liked to have multiple "type" of buffer descriptors
depending of the number of pointers in them. "standard" task have
either 1 or 2 pointers true but I have custom tasks with 3 so I need a
subtmitbuffer3 ... Not very extensible imho. I think there is no problem
as defining the descriptor structure with an array of pointer and then
just allocate the good size at init. Whoever use them must anyway know
the number of pointer to fill.

 - When I started to clean up bescomm a while ago, the only thing I
really got done was a rewrite of the SRAM allocator that supports the
freeing of block at little overcost. I'll try to find it and send it to you.

 - I like the separation of phys/virt ;)

 - sdma_clear_irq(struct sdma *s) is useless, interrupt acking for the
SDMA is already done in mpc52xx_irq.c

 - I thought of separating bestcomm.h in two headers : one public for
the drivers that use the SDMA like the fec. one private for the
bestcomm.c and the tasks implementation. I think it makes sense but I
never deeply looked it one wouldn't end up almost empty.



... to be continued ;)



	Sylvain
