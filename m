Return-Path: <shawnxjin@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.193])
	by ozlabs.org (Postfix) with ESMTP id 5582A67A7F
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jan 2005 07:18:46 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id 1so292940rny
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jan 2005 12:18:45 -0800 (PST)
Message-ID: <c3d0340b050127121826b92395@mail.gmail.com>
Date: Thu, 27 Jan 2005 12:18:45 -0800
From: Shawn Jin <shawnxjin@gmail.com>
To: linuxppc <linuxppc-dev@ozlabs.org>
In-Reply-To: <20050127111615.A4266@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <c3d0340b0501271005409166e6@mail.gmail.com>
	<20050127111615.A4266@cox.net>
Subject: Re: Relocating interrupt vectors in ppc440?
Reply-To: Shawn Jin <shawnxjin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

First thank you for your valuable response.

> > Assumed that the interrupt vectors locate at the low address space
> > physically and given that there is 2GB SDRAM shared by two ppc440
> > cores, can one of linux kernels run at the top of 1GB space? This
> > means the interrupt vectors for this copy need to move to upper 1GB.
> > Each core runs a copy of linux kernel independently.
> 
> Yes, you'd have to do something like the APUS code does by settings
> PPC_MEMSTART appropriately for the second processor. Also, of course

I guess the value set to PPC_MEMSTART should be the offset to the
physical starting address of 2GB SDRAM not the absolute physical
address, right?

> limiting the memory on the first processor to 1GB. There's probably

Limiting the memory on the first processor to 1GB can be done by
setting the mem size to 1GB in boot arguments (mem=1024MB)?

> One idea is that if you really don't have to do it, then don't. :)

The SoC is designed in this way that two cores share the DDR but it's
not SMP. Two kernels have to run independently. Relocating interrupt
vectors to upper 1GB memory means that another copy of kernel can run
at upper memory, right. So I'm afraid I have to do that. :(

Thanks,
-Shawn.
