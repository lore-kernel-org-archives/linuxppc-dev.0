Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-16.bluehost.com (outbound-mail-16.bluehost.com
	[69.89.20.231]) by ozlabs.org (Postfix) with SMTP id DB687DDDF6
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 07:38:25 +1000 (EST)
Message-ID: <4A089AC8.9080704@dlasys.net>
Date: Mon, 11 May 2009 17:38:16 -0400
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
	<4A085612.9050602@dlasys.net>
	<fa686aa40905111047p5f350b0dh796564cc1383a336@mail.gmail.com>
In-Reply-To: <fa686aa40905111047p5f350b0dh796564cc1383a336@mail.gmail.com>
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
> What do you mean by "one size fits all solution?"
>
> The kernel doesn't care where the device tree comes from.  All it
> cares about is that by the time the kernel is started the device tree
> must be fully formed and populated.  It can be completely pre-canned
> (like simpleImage), it can be modified by firmware (like u-boot), or
> it can be generated from scratch (like with real OpenFirmware).  There
> is lots of flexibility on how to handle it.
>
>   
First device trees are now the ONLY means of  passing information to the
kernel.
By definition that means it is a one size fits all solution.
While there is nothing inherently wrong with that, solutions intended to
meet all circumstances need to be
simple, powerful, and flexible. They need to work well 100% of the time
not 98%.
   
Not only is the device tree expected to pass static hardware
configuration information, but it is the sole means of passing anything.
As an example Command lines are to be in the device tree.
Everything is supposed to be in the device tree, whether that
information is static or dynamic, whether it is hardware information,
or user choices.

    That means that whether you are in a Sun or Apple Desktop or a
system with the no flash and barely enough resources to run Linux,
you still may have to manipulate the device tree.
 

>>    The best alternative to creating the device tree dynamically would
>> be to
>>    append the devicetree to the bitimage in a way the boot loader could
>> always find it.
>>     
>
> That sounds like a good solution to me.
>   
    I am glad you like it. If Xilinx would like to offer any advice as
to how to prepend a device tree to the end of a bit file without
    foreclosing any of their future plans or .... I would be happy to
look at implementing it.

> As for using up BRAM, a gzipped dtb image is smaller than 2k and it
> can be reclaimed for other uses after the kernel has booted.  That may
> not help your situation, but for my use cases the tradeoff works.
>   
    If I recall the minimum increment for BRAM is 16K.
    I am not trying to claim it is not an answer for anyone, or even
most people.
   
    Though I still have an issue. One of the problem with 98% solutions,
is that they result in a chain of work arrounds for
    the other 2%. Instead of one case or two cases, you end up with a
dozen cases each handling increasingly tiny slivers.
    And it becomes increasingly easy to claim that the problem is with
the slivers not the broad solution.   

   
>>    Regardless it still makes my point.  The problem with devicetrees as
>> they are is that they handle probably 98% of all cases well.
>>    The remaining 2% are a mess.
>>     
>
> No it isn't.  It is expected that firmware will fixup the device tree
> data with board specific values.  This is intentional.  The device
> tree is simply the bearer.  It makes no determination about where the
> data comes from.
>   
    I am not sure what you are saying here ?
    By firmware do you mean bootloader ? Or do you mean bitfiles ?


    In large systems like Sun or Apple desktop the OF Device tree need
not be static.
    There is software that may well be larger than the linux kernel.
    Our "firmware" bootloader is actually stored in the bitfile - 16K of
BRAM basically becomes the boot ROM - except that it is bitfile
initialized RAM.
    I guess this is much like you dtb in BRAM.
    We are not increasing the size of the BRAM, while most of our
systems have NOR flash, or ... or ...., the all don't.
     Even the amount of DRAM varies, and our code is written not to use
DRAM until we have verified that it works.


>   
>>    lots of .dtb files lying arround is only a better solution than
>> simpleimage.
>>    I will guarantee that unless they are welded together the wrong
>> device tree will get used with the wrong bit file.
>>     
>
> I agree.
>
>   
>>    Inevitably I will make that mistake myself occasionally and waste
>> hours or possibly days trying to debug it.
>>    And if I will do it rarely clients will do it frequently.
>>
>>    In my expereince if you create a situation where confusion can exist
>> it will.
>>
>>    It is also my expereince that time spend coding a solution to a
>> common client problem is well spent.
>>    If it takes me a week to work out dynamically creating a device
>> tree, that ill likely save many weeks of
>>    support headaches.
>>     
>
> Again, it doesn't sound like you want dynamic *creation* of device
> trees.  It sounds like you want a reliable way to make sure the
> bitstream is welded together with the correct dtb, preferably within
> the Xilinx toolchain.
>   
    Welding the bit file to the dtb might solve 75% of my issues,
     And it probably would get me to the point where I could move
forward and live with
    the remaining issues untile I was inspired to solve them.
    but it does not solve everything. It is increasingly clear to me
that I am going to have to
    manipulate device trees.



>   
>>    Even if I do not end up creating the device tree dynamically, I am
>> likely to end up at a minimum doing some validation on it.
>>    i.e. once the bitfile is loaded scanning the device tree and probing
>> to ascertain that the hardware that I am supposed to expect
>>    it really present.
>>     
>
> If you like.
>
>   
>>    ultimately devicetrees are supposed to be a database not a black box.
>>     
>
> I don't understand what you mean by this statement.
>   
    Right now for embedded systems device trees are a black box not a
database.
    You get them from EDK and pass them on to linux.
    Only Linux and the EDK understand and manipulate them.
    I gather u-boot is  twiddling at the fringes.

>   
>>    Anyway, all I was looking for was a leg up on figuring out how to do
>> what I want with them. Rather than starting from scratch.
>>    I am not looking to be convinced that I am approaching this all wrong.
>>    If you are happy with what you have - great. I am not.
>>    While I was not looking to restart a great debate over device trees
>> - I do not actually think they are a bad idea.
>>     
>
> I still don't understand what you're worried about starting an arguing
> about.  Pretty much any of the PowerPC maintainers can point at warts
> and problems in the current handling of device trees.  I'm not
> particularly happy with simpleImage (and I wrote it), but it takes
> time and effort to write something more capable.
>   
    I was not trying to start an argument, my initial question was

   "Is there an example somewhere that shows building a device tree on the fly ?"

   The responses have questioned why I want to do that rather than how can I do that.
   I was not actually seeking a debate over the merit of device trees, or u-boot, or libdft, or .... 

   







-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
