Return-Path: <shawnxjin@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.206])
	by ozlabs.org (Postfix) with ESMTP id 335F267A95
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jan 2005 12:55:02 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id 1so318359rny
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jan 2005 17:55:01 -0800 (PST)
Message-ID: <c3d0340b0501271755585c2b0b@mail.gmail.com>
Date: Thu, 27 Jan 2005 17:55:01 -0800
From: Shawn Jin <shawnxjin@gmail.com>
To: linuxppc <linuxppc-dev@ozlabs.org>
In-Reply-To: <20050127134117.D4266@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <c3d0340b0501271005409166e6@mail.gmail.com>
	<20050127111615.A4266@cox.net>
	<c3d0340b050127121826b92395@mail.gmail.com>
	<20050127134117.D4266@cox.net>
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

> > I guess the value set to PPC_MEMSTART should be the offset to the
> > physical starting address of 2GB SDRAM not the absolute physical
> > address, right?
> 
> It would be 0x00000000 for the first processor and 0x40000000 for the
> second processor. Note that head_44x.S is a major place where a lot
> of "system memory is at zero" assumptions take place that need to
> be addressed for the second processor.

The theory behind changing PPC_MEMSTART is to change MMU configuration
and to let it translate 0xC0000000 to 0x40000000 for the 2nd
processor. Right?

One place I found the assumption is when loading the kernel physical address.
	/* Kernel is at the base of RAM */
	li r4, 0			/* Load the kernel physical address */

I'll find out more places as you indicated.

Best regards,
-Shawn.
