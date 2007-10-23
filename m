Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9323FDDFFB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Oct 2007 04:49:25 +1000 (EST)
Message-ID: <471E423F.40304@freescale.com>
Date: Tue, 23 Oct 2007 13:49:35 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: raul.moreno@telvent.abengoa.com
Subject: Re: DMA problem - mpc8xx
References: <OF0ED90B65.60296006-ONC125737D.0028DB92-C125737D.002A55F3@abengoa.com>
In-Reply-To: <OF0ED90B65.60296006-ONC125737D.0028DB92-C125737D.002A55F3@abengoa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

raul.moreno@telvent.abengoa.com wrote:
> Hi everybody,
> 
> I am having problems with the serial cpm driver in a mpc866. But I've found
> out that my problem comes from the DMA and not really from the driver.  The
> Rx and Tx buffers use the DMA and then the sytem hangs. However, if I set
> these buffers to internal ram memory (DPRAM), it works. The DMA address is
> configured with a kernel parameter in advance setup:
> CONFIG_CONSISTENT_START (and the size in CONFIG_CONSISTENT_SIZE), but I
> don't know what they are exactly and I could not find a right documentation
> about it.
> I saw a pair of mailing list where some guys set the
> CONFIG_CONSISTENT_START to 0xff100000, but my driver continues failing (and
> an error about dma-mapping appears in the boot).

What kernel version?  arch/ppc or arch/powerpc?  What is the error about 
dma-mapping that you get?  What does your memory map look like (in 
particular, is there anything that might be getting mapped in conflict 
with the consistent area at 0xff100000)?

-Scott
