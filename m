Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A775EDDDE0
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Nov 2008 08:33:55 +1100 (EST)
In-Reply-To: <ed82fe3e0811070743l1e0f7430o6bbb2b3d5e5a446f@mail.gmail.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Using DMA
MIME-Version: 1.0
Message-ID: <OFDAB4AD6D.6B393411-ON882574FA.007560E7-882574FA.007634F1@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Fri, 7 Nov 2008 13:31:23 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: timur.tabi@gmail.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Timur,

Thanks for the reply, very informative.

> 
> The Elo device driver is an async DMA back-end driver.  That is, you
> don't communicate with that driver directly, you communicate with the
> async library (which is new - so you won't find it in LDD3).
> 
> Please note that the async DMA stuff is intended for single-shot
> one-way transfers only between two memory regions.  It has a very
> specific usage.  If you need something more complicated, you'll need
> to write your own DMA driver.  You can find an example of that in
> sound/soc/fsl/fsl_dma.c.
> 

I'm not sure if I need something as complicated as sound/soc/fsl/fsl_dma.c 
or not.  Maybe you can offer an opinion.  The NAND flash in our product is 
our backing storage, i.e., our hard drive.  We know that we're going to be 
storing away system status at about a 1 second rate and in the future 
we'll probably end up storing collected data at a very high rate, so we're 
potentially going to be doing a LOT of data movement to the NAND.  I'm 
still not clear on the adma stuff, so I'm not sure if a "single-shot 
one-way transfer" is appropriate or not.  Seems like I'd waste a lot of 
time setting up and tearing down the DMA channel.

So, do I need something complicated?

Thanks again for the explination Timur, I appreciate it.

Bruce
