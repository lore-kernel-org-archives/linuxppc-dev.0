Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-32.bluehost.com (outbound-mail-32.bluehost.com
	[69.89.18.152]) by ozlabs.org (Postfix) with SMTP id 30D7DDDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 02:51:49 +1000 (EST)
Message-ID: <4A085612.9050602@dlasys.net>
Date: Mon, 11 May 2009 12:45:06 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: device trees.
References: <4A0457BC.3040408@dlasys.net>
	<fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
	<1242007203.7767.28.camel@concordia>
	<fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
	<4A07C664.6040609@dlasys.net>
	<fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
In-Reply-To: <fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
>   
>>    We are very actively headed in the opposite direction. It is my/our
>> intention to have a single linux executable that works accross
>>    everyone of our cards and everyone of our bitfiles.
>>     
>
> That is the direction we are already going in.  U-Boot supports this.
> In fact, I can build a single kernel image which will boot on all of
> my MPC5200 boards, and my MPC83xx boards.  Similarly, if I have u-boot
> running on a Virtex board, I can build a single image which will boot
> all of them if the correct .dtb is passed to it.
>   
    I was not aware that u-boot was currently doing that, but I was
aware that was possible.
    It is the most useful alternative to simple image.
    I was not specifically trying to criticize simple image.
    My problem is not with specific means of handling device trees.
    It is that it is a one size fits all solution, and it is not
sufficiently flexible for that.


> You *could* generate the device tree dynamically, but I think that is
> a path of diminishing returns considering that generating a .dts at
> the same time as bitstream creation time is cheap and it is small.  At
> one time Steven Neuendorffer was playing with a scheme to preload a
> section of BRAM with a gzipped .dtb so that the correct device tree is
> always present.  I really liked the idea, and I'd like to try to
> pursue it.
>   
    I would prefer not to waste bram by filling it with a device tree.
    The best alternative to creating the device tree dynamically would
be to
    append the devicetree to the bitimage in a way the boot loader could
always find it.

    But ultimately the problem still exists.

    Device trees are the ONLY legitimate way to pass information post
2.6.26.
    That means that if there is a single peice of dynamic information
that needs to be passed to linux,
    at a minimum the device tree must be edited.
    It is my understanding that u-boot already does some of this to
manage command lines, and maybe a few other items.

    Regardless it still makes my point.  The problem with devicetrees as
they are is that they handle probably 98% of all cases well.
    The remaining 2% are a mess.

    lots of .dtb files lying arround is only a better solution than
simpleimage.
    I will guarantee that unless they are welded together the wrong
device tree will get used with the wrong bit file.
    Inevitably I will make that mistake myself occasionally and waste
hours or possibly days trying to debug it.
    And if I will do it rarely clients will do it frequently.

    In my expereince if you create a situation where confusion can exist
it will.

    It is also my expereince that time spend coding a solution to a
common client problem is well spent.
    If it takes me a week to work out dynamically creating a device
tree, that ill likely save many weeks of
    support headaches.

    Even if I do not end up creating the device tree dynamically, I am
likely to end up at a minimum doing some validation on it.
    i.e. once the bitfile is loaded scanning the device tree and probing
to ascertain that the hardware that I am supposed to expect
    it really present.

    ultimately devicetrees are supposed to be a database not a black box.

    Anyway, all I was looking for was a leg up on figuring out how to do
what I want with them. Rather than starting from scratch.
    I am not looking to be convinced that I am approaching this all wrong.
    If you are happy with what you have - great. I am not.
    While I was not looking to restart a great debate over device trees
- I do not actually think they are a bad idea.
   

> g.
>
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
