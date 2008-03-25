Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 09C27DDEF8
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 02:28:09 +1100 (EST)
Message-ID: <47E91A5B.1060406@ru.mvista.com>
Date: Tue, 25 Mar 2008 18:29:31 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: OF compatible MTD platform RAM driver ?
References: <200803101606.39184.laurentp@cse-semaphore.com>	<200803111139.12667.laurentp@cse-semaphore.com>	<20080311224048.GA7642@localhost.localdomain>
	<200803251536.17795.laurentp@cse-semaphore.com>
In-Reply-To: <200803251536.17795.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Laurent Pinchart wrote:

>>>>>here is the sram entry in our dts:

>>>>Except that your implementation of it is not good.

>>>>You're relying on the old obsolete flash binding with the "probe-type"
>>>>field.  The solution should be adapted to the new approach which uses
>>>>values in the "compatible" field to indicate various sorts of flash
>>>>device.

>>>What "compatible" values should I use for ROM and RAM mappings ?

>>That I'm not so sure of.  We'll need to find some consensus.

>>There may be existing IEEE1275 bindings for roms, which we should
>>investigate.

> Do you (or someone else here) have access to the IEEE1275 specification ? Is 

    Yeah, and I can point you to it -- see the documantation section on 
http://www.openbios.org/...

> there any ROM binding in there ?

    No. We initially called the flash devices that physmap_of driver 
controlled "rom" (I mean the "device_type" property) -- now this is obsoleted.

>>Arguably RAM should be represented by a memory node, but 
>>that's going to get messy for this sort of application.

    Note that the OF "memory" type nodes do *not* represent RAM devices.

> We're talking about a very specific type of RAM, used for permanent storage 
> with a battery backup. The RAM is really meant to be used as an MTD device 
> and as such I think it makes sense to describe it as an mtd-compatible device 
> on the local bus.

> What about the following definition for the RAM node ?

>         nvram@2,0000 {

    Note that there's a OF "device_type" of "nvram", so your (generic) device 
name seems to add some mess. (IIRC, that OF device type didn't actually 
represent a "real" device, and only served to provide access to NVRAM for OF).

>                 compatible = "mtd,ram";

    The part before comma should be a company name or a stock ticker. What did 
you mean here?

>                 reg = <2 0x0000 0x00100000>;
>                 bank-width = <2>;
>         };

> Or should the node have a device-type property of either 'ram' or 'rom' with 
> the compatible property just referencing MTD ?

    The "device_type" properties are not required and their further creation 
has been discouraged on liunxppc-dev.

> Best regards,

WBR, Sergei
