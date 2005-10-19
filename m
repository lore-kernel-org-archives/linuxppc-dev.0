Return-Path: <dhlii@comcast.net>
Received: from sccrmhc13.comcast.net (sccrmhc13.comcast.net [204.127.202.64])
	by ozlabs.org (Postfix) with ESMTP id 1AE21685D3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Oct 2005 15:22:16 +1000 (EST)
Message-ID: <4355D6C1.4030004@comcast.net>
Date: Wed, 19 Oct 2005 01:16:49 -0400
From: "David H. Lynch Jr" <dhlii@comcast.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <4354AC78.5080206@comcast.net> <4354B707.6060002@iki.fi>
	<435549C2.1000106@dlasys.net> <435557A0.8090505@iki.fi>
In-Reply-To: <435557A0.8090505@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: Need help Understanding initial memory conditions.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kalle Pokki wrote:

> David H. Lynch Jr. wrote:
>
>> Kalle Pokki wrote:
>>
>>> 1. Put RAM to 0x0000000 and flash to some location it mirrors to 
>>> your boot vector. Linux always expects your physical memory to be at 
>>> zero. It is then mapped to virtual address 0xC0000000.
>>
>>
>>    In both this list and elsewhere I have seen several references to 
>> the difficulty setting up Linux with a physical RAM base other than 
>> 0x0. I was hoping that I could bypass that by re-arranging physical 
>> memory using the BAT's or MMU.
>> I am gathering that while this is possible, that it not sufficient. 
>> That if memory is re-arranged after power-on it has to be done by 
>> something Linux is not aware of.
>
>
> I'm afraid you cannot fool Linux that way... it will take control of 
> the BATs and MMU. Even as a concept, you cannot re-arrange physical 
> memory with the MMU at all - it's virtual memory when you do the 
> address translation. The only way to arrange physical memory is to 
> program the memory controller. I don't know how flexible the OCM 
> controller in ppc405 is, but I'd be surprised if one couldn't freely 
> set the addresses to whatever suits best.
>
>
    I have built a Kernel - that is something I am pretty compitent at. 
My system is fairly similar to an abreviated xilinx ml-300, and I have 
added it to the Linux configuration and made what adjustments I beleive 
were needed (mostly eliminating hardware I do not have or want). The 
resulting Kernel is configured and successfully built.

Alright I have RAM at physical 0x0 now.  I throw a copy of a compressed 
linux image into RAM (anywhere special ?) load the assorted registers 
with the appropriate values, fill the board info struct., and just jump 
to the start of the image and pray that load text starts coming out my 
serial port ?

    Once this sucker gets through the code in head_4xx.S I should be in 
business, or atleast to a point where I can deal with whatever crops up.
