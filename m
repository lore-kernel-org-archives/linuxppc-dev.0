Return-Path: <det.nicolas@free.fr>
Received: from smtp2.wanadoo.fr (smtp2.wanadoo.fr [193.252.22.29])
	by ozlabs.org (Postfix) with ESMTP id B8B8567A6C
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Mar 2005 06:48:39 +1100 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0203.wanadoo.fr (SMTP Server) with ESMTP id 0E3211C001EB
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Mar 2005 20:48:35 +0100 (CET)
Received: from free.fr (ALyon-151-1-9-130.w83-113.abo.wanadoo.fr
	[83.113.151.130])
	by mwinf0203.wanadoo.fr (SMTP Server) with ESMTP id B4DB01C001DE
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Mar 2005 20:48:34 +0100 (CET)
From: Nicolas DET <det.nicolas@free.fr>
To: linuxppc-dev@ozlabs.org
Cc: 
Date: 06 Mar 2005 20:48:01 +0100
In-Reply-To: <20050306191034.GA10975@pegasos>
Message-Id: <20050306194834.B4DB01C001DE@mwinf0203.wanadoo.fr>
Subject: Re: mv64x60 updates
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Sven,

On 06/03/2005, you wrote:

> Ah, i guess that was the missing bit. Basically i need to set MV64360 for
> my board, but since it is a generic PPC_CHRP, how is that supposed to
> work ?  
> Could you send me maybe a list of files which need merging yet, compared
> to 2.6.11 ? I guess it just doesn't work because i am missing pieces.

I fixed that here.
TheKconfig issue is really minor compared to the rest :-)

>> > Anyway, how do you probe for the chip ? On the pegasos we used to map
>> > on the marvell pci id :
>> > 
>> >   0000:00:00.0 Host bridge: Marvell Technology Group Ltd.
>> > MV64360/64361/64362   System Controller (rev 03)
>> > 
>> > too bad Marvell didn't do the logical thing and made the ethernet port
>> > appear as separated devices on a third internal pci bus.
>> 
>> The mv643xx_eth probe is dependent on having the appropriate
>> platform device entry.  See eth0_device and mv64x60_add_pds() in
>> arch/ppc/syslib/mv643x60.c .

> The pegasos has the mv64360 registers mapped at 0xf1000000, and the ports
> (only port1 is wired though) mapped at interrupt 9, shared with other
> devices. I guess that would be the only real difference with the other
> currently supported hardware, right ? 

Yeah, and also, Pegasos II kernel shouldn't call all the chipset init call
which has been added.
Pegasos II chipset init is done by the OFW. OSs kernel shouldn't have to
touch it much.

> Will look at the above mentioned files and function and try to enable it.

I already patch a bit the kernel. However, enabling new Marvell code means
not booting anymore ATM.
I'm trying to find a way to patch the current source, without breaking
Katana & friends support.

The smartest could be to move all unneeded/board specific code somewhere
else (chipset init...) and to keep ony the minimal (only
platform_get_resource() realted stuff), in arch/ppc/syslib/mv64x60*

Regards
-- 
Nicolas DET
MorphOS & Linux developer
