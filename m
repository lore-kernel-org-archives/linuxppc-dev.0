Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 78433DE035
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 16:48:50 +1000 (EST)
Date: Thu, 14 May 2009 08:48:36 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Matt Sealey <matt@genesi-usa.com>
Subject: [RFC] How to allow selecting mv643xx_eth on Pegasos again
Message-ID: <20090514064836.GA21486@iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LinuxPPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 08, 2009 at 11:53:10PM -0600, Matt Sealey wrote:
> Lennert Buytenhek wrote:
>> On Thu, Jan 08, 2009 at 11:38:33PM -0600, Matt Sealey wrote:
>>
>> On this topic, I sent a patch to linuxppc-dev@ some time ago that moves
>> the mv643xx_eth SRAM window programming code from the Pegasos platform
>> code to the mv643xx_eth driver, and adds a couple of fields to the
>> mv643xx_eth platform data that lets you pass the sram addresses/sizes
>> in.  Since I don't have the hardware I haven't been able to test it,
>> but it would be nice if someone could.
>
> It seems to work. However it's still static stuff in some platform  
> driver, which I don't really like. pegasos_eth.c is really a holdover  
> from the very early days of ppc->powerpc architecture port, where they  
> insisted that we do detection that way (and fudge it based on host  
> controller PCI ID)
>
> The Pegasos device tree is so screwed up, you could never gain the  
> information you need from it. And times have changed..

I just tried to compile a very recent kernel for my Pegasoi, and
I can no more select the MV643XX_ETH driver. The root cause is that
PPC_MULTIPLATFORM has been removed. There are several possibilities:

1) remove simply the PPC_MULTIPLATFORM and let it depends on PPC32

2) replace PPC_MULTIPLATFORM && PPC32 by 6xx which is apparently the
   blessed way of doing this. But I dislike a 6xx condition in anything
   outside arch/powerpc.

3) add a select statement for MV64X60 in CHRP. It will bring in more
   code and would probably need an OF node for the system controller.
   I suspect that the mv64x60 pic and i2c are not wired on Pegasos.

Pick your poison...

While at it, I'm also going to remove the last remnants of MV64360
since it is never selected anywhere (replaced by MV64X60).  

	Regards,
	Gabriel

P.S.: this is not sufficient, after this the driver crashes at initialization
but that's a separate patch, that has to do with the dma mapping interface.
