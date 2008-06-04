Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4921ADDECF
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jun 2008 04:41:39 +1000 (EST)
Message-ID: <4846E1DC.9010104@freescale.com>
Date: Wed, 04 Jun 2008 13:41:32 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: matvejchikov@gmail.com
Subject: Re: The 2.6.25 kernel dosen't run on pq2fads based board
References: <8496f91a0806040525u7e137221sc4bea5466cde3161@mail.gmail.com>
In-Reply-To: <8496f91a0806040525u7e137221sc4bea5466cde3161@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matvejchikov Ilya wrote:
> Hi all!
> 
> There is a problem with 2.6.25.4 kernel on the pq2fads based board.

Works for me using cuImage.

> ## Booting kernel from Legacy Image at 00200000 ...
>    Image Name:   Linux-2.6.25.4
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1534783 Bytes =  1.5 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> ## Flattened Device Tree blob at 00800000
>    Booting using the fdt blob at 0x800000
>    Loading Device Tree to 007fe000, end 007fffff ... OK

I don't see FDT support for this board in current u-boot (I should 
really get around to fixing that...), so I assume you're using a 
modified u-boot?

> Xid mach(): done
> MMU:enter
> MMU:hw init
> MMU:mapin
> MMU:setio
> MMU:exit
> <<---- the reset was here :(

Perhaps your u-boot isn't properly filling in the memory node.

Oh, and just in case -- if you're using binutils 2.17, it's buggy.

-Scott
