Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DC5B0DDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Feb 2007 03:12:38 +1100 (EST)
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A16E@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A16E@MERCURY.inside.istor.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <205D2E1A-FDE9-4BC6-BC81-150D186207E4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: understanding an IO question
Date: Fri, 23 Feb 2007 10:11:32 -0600
To: Charles Krinke <ckrinke@istor.com>
Cc: Randy Brown <rbrown@istor.com>, Chris Carlson <ccarlson@istor.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 23, 2007, at 8:16 AM, Charles Krinke wrote:

>
> Dear Kumar:
>
> Thank you very much for your advice on addressing our PCI device. It
> turned out that the OutboundTranslation windows were the key.
>
> In uboot, I setup two windows to allow accesses to 32bit cpu space
> 0x8400_000 & 0x8800_0000 to be translated to 64bit DAC (Dual Address
> Cycles) at 0x3_0000_0000 & 0x1_0000_0000 respectively, and both the  
> 8241
> and 8541 do this quite well.
>
> Once the potar, powbar and other outbound translation address windows
> were reset to the same values in Linux that they had in uboot,  
> outbound
> transactions work fine and address the registers and memory in our  
> ASIC.

Good to hear.

> Next, I need to study the difference between the DMA engines in the  
> 8241
> and 8541 to accomplish a similar mission. This one may be a bit  
> trickier
> and you advice would be greatly appreciated.
>
> The 8241 DMA engine understands 64bit DMA  in that it has a high  
> source
> & destination address register for the upper 32bits of a 64bit  
> address.
> Unfortunately, the 8541 does not. It only supports 32bit DMA.

This is doable, however I haven't done it myself.

> So, my assumption is that there is some way to use a different  
> outbound
> address translation window and emulate 64bit DMA transactions using  
> the
> 32bit DMA engine in the 8541.

Yep. If you have the POTARs setup to access the 64 bit PCI address  
space you want than you just DMA to the 'internal' address that the  
POTAR is pointing to.

I suggest a simple direct mode test first to make sure everything  
appears to be working properly (maybe via hand in u-boot with memory  
write commands)

> I don't know if you have studied this part at all, but if you or  
> anyone
> would be willing to offer a few hints, I would be appreciative.

- k
