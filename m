Return-Path: <Hans.Thielemans@skynet.be>
Received: from outmx007.isp.belgacom.be (outmx007.isp.belgacom.be
	[195.238.3.234]) by ozlabs.org (Postfix) with ESMTP id DE91367A6F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 06:16:58 +1000 (EST)
Received: from outmx007.isp.belgacom.be (localhost [127.0.0.1])
	by outmx007.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j3DKGqN6002381
	for <linuxppc-embedded@ozlabs.org>; Wed, 13 Apr 2005 22:16:53 +0200
	(envelope-from <Hans.Thielemans@skynet.be>)
Message-ID: <006a01c54066$a89dc180$870ea8c0@mordor>
From: "Hans Thielemans" <Hans.Thielemans@skynet.be>
To: <linuxppc-embedded@ozlabs.org>,
	"Eric N. Johnson (ACD)" <ejohnson@acdstar.com>
References: <Your message of "Tue, 12 Apr 2005 14:38:20
	CDT."<6.2.1.2.1.20050412143653.02ae7720@mail.int.acdstar.com><20050412211342.B7C92C108D@atlas.denx.de>
	<6.2.1.2.1.20050412173010.02adaaa0@mail.int.acdstar.com>
Date: Wed, 13 Apr 2005 22:23:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=response
Subject: Re: MPC5200 I2S driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Eric,

I have been working on a driver for a similar case:
mpc5200 talking to adi blackfin sport channel.

It is rather stable at the moment. Only now and then (~1/hour)
transmission stops due to bestcomm missing a taskstart.
When I check with the bdi2000 it is always the task active bit which
is cleared in the bestcomm registers.
When I kick the dma descriptor by setting the task active bit again with the
bdi2000 it continues normally. I suspect a problem with the bestcomm
api. The dma task active bit is cleared when dma is done. When this 
interferes with the
ppc setting the bit. the task is not started (so far my analysis).
I did not find yet a 100% secure way of getting the bit set.

My main problem was also that I wanted the blackfin to be master of the
link. But the mpc5200 has an anomaly on the frame sync. I managed to
get it work by using the mpc5200 psc spi slave mode and proper
settings at the blackfin side. I got reliable transmission for several hours 
at 16 Mbit/s

The driver supports simultaneous use of several psc channels. I tried psc2 
and psc3 together.
You can use the driver as master or slave by changing the control register 
with ioctl.
I'll forward the present version and a test program when i'm back at work 
tomorrow.

Regards,

Hans Thielemans
HAZO bvba

----- Original Message ----- 
From: "Eric N. Johnson (ACD)" <ejohnson@acdstar.com>
To: <linuxppc-embedded@ozlabs.org>
Sent: Wednesday, April 13, 2005 12:46 AM
Subject: Re: MPC5200 I2S driver


> At 04:13 PM 4/12/2005, Wolfgang Denk wrote:
>>i2s.c is not really a driver, but a (very OLD) test  version  of  one
>>used  to  demonstrate  certain  BestComm  related problems. Don't try
>>using it as a real driver ;-)
>
> Humm, any pointers on writing our own driver then then?  Digging through 
> the source for other drivers, bestcomm seems to be a real house of cards. 
> We just want simple audio output capability.  No need to make it work with 
> the standard Linux/OSS sound API.
>
> Where can we keep track of the eratta/bugs in bestcomm?  Browsing through 
> the mailing list, I've found references that:
>   IDE and Ethernet DMA can't work at the same time
>   I2S TX and RX DMA can't work at the same time
>   AC-97 is terminally broken (no way to handle the slot tags properly
>          for variable sampling rates)
> Are these all still true?
>
> We've tried asking our local Freescale rep, but they seem to think that 
> Linux==Metrowerks, and they are looking into the bestcomm question, but 
> official responses from Freescale tend to take >1 week.
>
> This is for a custom MPC5200 board, heavily based on IceCube with a single 
> I2S DAC on PSC2 running in "CODEC with MCLK" mode.
>
> Sorry about the null subject line previously: fingers were working faster 
> than brain...
>
> Thanks
> Eric
>
>
> ------------------------------------
> Eric Johnson, Electrical Engineer
> Advanced Communication Design
>   7901 12th Avenue South
>   Bloomington, MN 55425
> Ph: 952-854-4000  Fax: 952-854-5774
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
