Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 37E30DE776
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 00:57:08 +1000 (EST)
Message-Id: <572C9A4F-D5F2-4A43-AD2E-01A7FDC86832@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080409135925.GA6905@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] mpc8315: fix USB UTMI Host setup
Date: Thu, 17 Apr 2008 09:56:55 -0500
References: <20080409135925.GA6905@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 9, 2008, at 8:59 AM, Anton Vorontsov wrote:
> Currently USB Host isn't functional on the MPC8315E boards, for two
> reasons as described below.
>
> MPC8315 Reference Manual says:
> "The USB DR unit must have the same clock ratio as the encryption core
> unit, unless one of them has its clock disabled."
>
> The encryption core also drives I2C clock, so it is enabled and is  
> equal
> to 01. That means USBDRCM should be 01 here.
>
> Plus, according to MPC8315E-RDB schematics, USB unit consumes CLK_IN
> clock from the 24.00MHz oscillator, which means we must adjust REFSEL
> bits as well.
>
> p.s.
> Idially we should rework whole 83xx/usb.c code, in two steps:
> 1. Move SCCR code to the U-Boot;
> 2. Implement fsl,usb-clock property in the device tree, so usb.c could
>   decide what clock exactly to use on per-board basis.
>
> Though, today we're not in a hurry since there is just one 8315e board
> out there.
>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: Kim Phillips <kim.phillips@freescale.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

applied.
