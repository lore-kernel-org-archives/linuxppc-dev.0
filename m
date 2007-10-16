Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0830CDDE46
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 02:31:44 +1000 (EST)
Message-ID: <4714E763.5060901@freescale.com>
Date: Tue, 16 Oct 2007 11:31:31 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alan Bennett <embedded@akb.net>
Subject: Re: Serial init / BRG
References: <bfa0697f0710160719r44099b19jbda55af2ef88e9f8@mail.gmail.com>
In-Reply-To: <bfa0697f0710160719r44099b19jbda55af2ef88e9f8@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alan Bennett wrote:
>   A few questions:  To use 3 brgs, should I have 1 brg entry and X reg
> values or three brg entries in my device tree? 

The current brg entry describes all 8 BRGs... don't touch it. :-)

> what are the third and fourth reg values of the brg item in the
> device tree. I'll need 3 separate baud rates on the serial lines.
> Should I just add code to initialize the brg's in u-boot or figure
> out how to get the kernel to do it?

No, the kernel should do it.  Are you associating the BRG with the SCC 
in the CMXSCR register, and setting up the pins required by SCC1 and 
SCC4, in either u-boot or your platform code?

> boot sequence
> ===========
>  CPM UART serial mem=e0011a80 pram=e0000000
>  ttyCPM0 at MMIO 0xe0011a80 (irq = 16) is a CPM UART
> 
>  CPM UART serial mem=e0011a00 pram=e0008000
>  CPM uart[1]:init_scc - sup = e0008000
>  ttyCPM1 at MMIO 0xe0011a00 (irq = 40) is a CPM UART
> 
>  CPM UART serial mem=e0011a60 pram=e0008300
>  CPM uart[2]:init_scc - sup = e0008300
>  ttyCPM2 at MMIO 0xe0011a60 (irq = 43) is a CPM UART
> 
> BRG Values after above
> =================
> brgc1: 0x00000000
> brgc2: 0x00000000
> brgc3: 0x00000000
> brgc4: 0x00000000
> brgc5: 0x00000000
> brgc6: 0x00000000
> brgc7: 0x0001004e
> brgc8: 0x00000000

This is expected if you haven't opened the other serial ports yet...  it 
doesn't initialize the brg until then.

-Scott
