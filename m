Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 503A667EFD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Aug 2005 01:05:45 +1000 (EST)
Message-ID: <4300AF41.9000807@varma-el.com>
Date: Mon, 15 Aug 2005 19:05:37 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
References: <43006FD4.6060801@varma-el.com> <43009A8D.1040704@246tNt.com>
In-Reply-To: <43009A8D.1040704@246tNt.com>
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

Sylvain Munaut wrote:
> Obviously I haven't yet had the time to review all the code but the
> glance I had looked good ! I'll review it deeper and test it and come
> back to you asap.
As you could see it was only first step (I hope at not so long way :)):
bring Dale's code to the current kernel, and make point from which
everyone could start dance.

> 
> Still, some "preliminary" comments :
> 
>  - I never really liked to have multiple "type" of buffer descriptors
> depending of the number of pointers in them. "standard" task have
> either 1 or 2 pointers true but I have custom tasks with 3 so I need a
> subtmitbuffer3 ... Not very extensible imho. I think there is no problem
> as defining the descriptor structure with an array of pointer and then
> just allocate the good size at init. Whoever use them must anyway know
> the number of pointer to fill.
Accepted. But I think it will be better to start from another end:
allow everyone to create him/here self task (variable buffers number
will consequence of that).

> 
>  - When I started to clean up bescomm a while ago, the only thing I
> really got done was a rewrite of the SRAM allocator that supports the
> freeing of block at little overcost. I'll try to find it and send it to you.
I agree with you, sram_free is required function, especially if
sdma-depended drivers will loaded/unloaded as modules. But I also agree
with Dale's comments: What to do with fragmentations? I could lightly
imagine situation, when after some load/unload iterations we receive
ENOMEM :(.

> 
>  - I like the separation of phys/virt ;)
I'd like it too :), but I had a pa/va headache when setting up
task/var/inc tables, so everyone, who will write sdma related code must
be very careful.

> 
>  - sdma_clear_irq(struct sdma *s) is useless, interrupt acking for the
> SDMA is already done in mpc52xx_irq.c
Ok, will be removed.

> 
>  - I thought of separating bestcomm.h in two headers : one public for
> the drivers that use the SDMA like the fec. one private for the
> bestcomm.c and the tasks implementation. I think it makes sense but I
> never deeply looked it one wouldn't end up almost empty.
I review code. It will be done bloodless, I hope :).

> 
> ... to be continued ;)
Will wait impatiently ;).
> 

-- 
Regards
Andrey Volkov
