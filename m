Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id CA4C367C5F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Jul 2005 22:36:59 +1000 (EST)
Message-ID: <42DBA26E.7050005@anagramm.de>
Date: Mon, 18 Jul 2005 14:37:02 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Clemens Koller <clemens.koller@anagramm.de>
References: <42D7CFC2.3020006@anagramm.de>
In-Reply-To: <42D7CFC2.3020006@anagramm.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8540 DMA routines (channel 0 broken?)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello again...

In the meanwhile, I got channel 0 working. It seems
that the DMA#0 machine got stuck in some configuration from any
previous (u-boot?) operation which didn't clean up things
properly. I had to explicitly abort a (continously running?)
transfer to be able to re-program it in the way I need.

Best greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19

Clemens Koller wrote:
> Hello,
> 
> I am about to bring Jason McMullan's DMA routines up to linux-2.6
> Currently I am in the process of getting the things started step
> by step.
> 
> Until today I had a pretty hard time for some basic direct dma
> transfers because it seems that dma channel 0 doesn't work at all
> on my hardware (PPC8540PX833LB 2L71V MSIA QEAD0412).
> The status register always stays 0x0 (means everything is happy and
> okay) but it doesn't copy any data. I cannot even trigger a
> programming error by a wrong configuration!
> But when I let ch 1,2,3 do the work, everything
> seems to work fine!
> I havent found anything in the errata sheets or in the web.
> Can a DMA machine crash that it stays completely unusable?
> Have anybody seen similar things like that?
> 
> Some other questions:
> I would also suggest to put my revised and almost
> complete immap_85xx.h and the mpc85xx_dma module into the
> current linux tree (Kumar?) to get things like that
> started more easily.
> Why is Jason's work not in the Kernel?
> 
> If you are fine with that, I can offer some patches.
> But I first need to strip tons of the debug stuff from
> the last two weeks. :-/
> 
> Best greets,
> 
> Clemens Koller
> _______________________________
> R&D Imaging Devices
> Anagramm GmbH
> Rupert-Mayer-Str. 45/1
> 81379 Muenchen
> Germany
> 
> http://www.anagramm.de
> Phone: +49-89-741518-50
> Fax: +49-89-741518-19
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
