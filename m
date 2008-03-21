Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EBC7BDDF5F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Mar 2008 07:34:58 +1100 (EST)
Message-ID: <47E41BE7.9020109@freescale.com>
Date: Fri, 21 Mar 2008 15:34:47 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: James Black <jblack547@gmail.com>
Subject: Re: muram in device tree for mpc8250 in arch/powerpc
References: <b77025b40803191006m60dc3145la368ac227df43b17@mail.gmail.com>	
	<20080319174001.GF7962@ld0162-tx32.am.freescale.net>	
	<b77025b40803191107x2f9a7884n9b7f062fcf45370@mail.gmail.com>	
	<b77025b40803201102w200dde6fuc4235d9a3cb8b0dd@mail.gmail.com>	
	<47E2AADD.6090101@freescale.com>	
	<b77025b40803201602q68fce3e1j703502a270351179@mail.gmail.com>	
	<20080321161833.GA4170@loki.buserror.net>
	<b77025b40803211314g74a41aa9of01f7cf3560a2505@mail.gmail.com>
In-Reply-To: <b77025b40803211314g74a41aa9of01f7cf3560a2505@mail.gmail.com>
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

James Black wrote:
> I've compiled the kernel with gcc 4.0.0 and  4.2.2 both versions have
> the same problem. Should I try the 2.6.25 kernel since the 2.6.19
> works just fine.

It's worth a try.  Also, since it seems to be a random corruption issue, 
make sure that no DMA is left running by the firmware (try resetting the 
CPM (though you'll have to turn off the early udbg output)), that you're 
not trying to use more memory than you have, etc.  Try dumping various 
registers to see if anything significant is different compared to 2.6.19.

If none of that helps, then I'm out of ideas as far as debug-by-email 
goes...

> I've stripped the kernel options down almost as far
> as I can go.

You turned off too much. :-)
Turn kallsyms back on, so you get symbols in crash dumps.

-Scott
