Return-Path: <kalle.pokki@iki.fi>
Received: from gw01.mail.saunalahti.fi (gw01.mail.saunalahti.fi
	[195.197.172.115]) by ozlabs.org (Postfix) with ESMTP id 58C0C685CC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Oct 2005 06:45:01 +1000 (EST)
Message-ID: <435557A0.8090505@iki.fi>
Date: Tue, 18 Oct 2005 23:14:24 +0300
From: Kalle Pokki <kalle.pokki@iki.fi>
MIME-Version: 1.0
To: dhlii@comcast.net
References: <4354AC78.5080206@comcast.net> <4354B707.6060002@iki.fi>
	<435549C2.1000106@dlasys.net>
In-Reply-To: <435549C2.1000106@dlasys.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
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

David H. Lynch Jr. wrote:

> Kalle Pokki wrote:
>
>> 1. Put RAM to 0x0000000 and flash to some location it mirrors to your 
>> boot vector. Linux always expects your physical memory to be at zero. 
>> It is then mapped to virtual address 0xC0000000.
>
>    In both this list and elsewhere I have seen several references to 
> the difficulty setting up Linux with a physical RAM base other than 
> 0x0. I was hoping that I could bypass that by re-arranging physical 
> memory using the BAT's or MMU.
> I am gathering that while this is possible, that it not sufficient. 
> That if memory is re-arranged after power-on it has to be done by 
> something Linux is not aware of.

I'm afraid you cannot fool Linux that way... it will take control of the 
BATs and MMU. Even as a concept, you cannot re-arrange physical memory 
with the MMU at all - it's virtual memory when you do the address 
translation. The only way to arrange physical memory is to program the 
memory controller. I don't know how flexible the OCM controller in 
ppc405 is, but I'd be surprised if one couldn't freely set the addresses 
to whatever suits best.
