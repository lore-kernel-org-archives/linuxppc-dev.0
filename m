Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3CAEDDDEB8
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 07:56:55 +1000 (EST)
In-Reply-To: <20070604211740.GN17456@chiana.homelinux.org>
References: <20070604095625.GF17456@chiana.homelinux.org>
	<4E25DA41-741E-40AC-9186-936FEEFE6B29@freescale.com>
	<20070604211740.GN17456@chiana.homelinux.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C1F9584D-E778-4BE7-B11A-5505BA9B6F6C@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: 83xx GPIO/EXT int in arch/powerpc/
Date: Mon, 4 Jun 2007 16:57:00 -0500
To: Marc Leeman <marc.leeman@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 4, 2007, at 16:17, Marc Leeman wrote:

>
> So I don't have to define the GPIO pins in pio-map in "vi) Pin
> configuration nodes" and already set in the U-Boot bootloader?  
> Using the
> GPIOs for interrupts or IO would just work "out of the box" after the
> U-boot initialisation (used for TI's HPI in with the UPMB).

I meant external interrupts, not GPIOs.  I just had a brain fart.

>
> Hang, and I finally thought the documentation made sense to me :-)
>
> I already tried hardcoding the EXT7 pin as assigned in the ppc arch
> (int 23); this would mean that, in the powerpc arch, the  
> assignments of
> interrupts is different wrt to ppc?


In the intervening versions between the introduction of arch/powerpc,  
and now, the interrupt mapping has also changed.  The interrupts are  
now all virtualized, and therefore all the interrupts start at 1 for  
each interrupt controller.  The numbers therefore change depending on  
how things are initialized.  You can't use hard-coded numbers  
anymore.  You need to map them into virtual numbers.  The easiest way  
is to set up an of node for the device, and invoke the necessary  
translation functions from your board code (Take a look at the CDS  
code for an example with a fairly complicated tree.  Or any other fsl  
board code for an almost-reasonable topology.  :) )

Andy
