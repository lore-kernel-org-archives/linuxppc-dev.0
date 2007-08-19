Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.192.123.res-cmts.eph.ptd.net
	[24.152.192.123]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 39A25DDE00
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 19 Aug 2007 11:51:20 +1000 (EST)
Message-ID: <46C79CE6.8050507@dlasys.net>
Date: Sat, 18 Aug 2007 21:29:10 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Leonid <Leonid@a-k-a.net>
Subject: Re: Best Linux tree for Xilinx support.
References: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com><fa686aa40708091142n520f222amec7c6a76786c7fcc@mail.gmail.com>	<fa686aa40708102137o25b83daar82a40471756a3f2b@mail.gmail.com>	<406A31B117F2734987636D6CCC93EE3C02053A10@ehost011-3.exch011.intermedia.net>	<20070814050748.EE7C2D0075@mail26-fra.bigfish.com>
	<406A31B117F2734987636D6CCC93EE3C02053B0F@ehost011-3.exch011.intermedia.net>
In-Reply-To: <406A31B117F2734987636D6CCC93EE3C02053B0F@ehost011-3.exch011.intermedia.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Leonid wrote:
> I deem such approach is not very good one. I'm using precisely same IP
> cores like GPIO, EMAC, SPI, CAN, etc... in Virtex and Spartan FPGAs
> which means (OK, may be cores are different somewhat for different FPGAs
> but low level Xilinx code is the same). That means at least 2 different
> CPU architectures (PPC and Microblaze). 
>   
    Most device drivers are outside the arch tree, only board specific 
configuration
    is inside.
   
    While there is a great deal of similarity between the microblaze and 
ppc code that
    would be under the arch tree's they are still as distinct as 
different architecures.
    Maybe there would be some way to share some of the code, but for the 
most part
    the similar or identical code falls outside the arch tree.

> A How EDK project parameters get into Linux kernel? This is huge issue
> which can be divided on several items.
>   
    Xilinx has their own idea's and thus far they do not seem to fit 
well with the
norms of Linux kernel developers. It is extremely unlikely the latter 
will change.

    I did the BSP for the Pico E1x series of boards. While it is based 
heavily on Grant's
MLXXX work that I am trying to track, very little of it is even xilinx 
specific.

    One the key distinctions between FPGA based systems and typical 
systems is that
the core is very very small. In a Pico E1x, you can only count on:
    A processor,
    an MMU,
    memory,
    and some serial (or pseudo serial) device capable of functioning as 
a console.
    Flash, Ethernet, Specific Uarts, Even interrupts and interrupt 
handling are
    all optional.
   
> A.2. There is also a question how these definitions get into .c and Make
> files. Petalogix has interesting solution when they bump all XILINX
> parameters to autoconf.h and .config files thus making them available
> for both compiler and make. What's your approach?
>   
    With all respect to Petalogix and the significant work they have 
done, I can not see migrating all
    the xparameters.h values into .config being adopted. Besides little 
of none of those values are
    needed outside the core of the BSP.

    I am not particular enamored with the CONFIG_VIRTEX or    
    CONFIG_VIRTEX_4 flags either. There is very very little that knowing
    the exact FPGA tells Linux. As an example Pico E12's, E14's and E16's
    are fundimentally very similar, despite having different form factors,
    being on different cards (CF, CardBus, ExpressBus), and using different
    Xilinx parts (sometimes on the same model)

    I beleive that the long term effort is to put everything into device 
tree's
    then the device information for the product is
        dynamically created, or stored in flash or otherwise provided to 
Linux
    at boot. But that is pretty close to the extent of my knowledge of 
device
    trees at this time.  

> A.4. Is it assumed that Xilinx low level code will stay intact as it is
> supplied with EDK package or you are going to prepare special Linux
> Xilinx set (mostly because of name convention)?
>   
    I do not beleive anyone is anticipating the Xilinx EDK code making 
its way into
a kernel.org Linux source.

> B How drivers get registered - via platform devices structure in
> virtex.c file or something different?
>   
    I beleive the current approach is mostly using platform devices - though
individual drivers may vary. I beleive the longterm approach is to use 
device
trees - I am not sure how the two interrelate.


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
