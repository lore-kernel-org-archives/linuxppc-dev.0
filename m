Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3F381DE294
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jun 2008 03:53:01 +1000 (EST)
Message-ID: <48516277.1050509@freescale.com>
Date: Thu, 12 Jun 2008 12:52:55 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Michael Galea <michaelgalea@ruggedcom.com>
Subject: Re: Question on assigning interrupts in a dts
References: <48512EB9.3080307@ruggedcom.com>
In-Reply-To: <48512EB9.3080307@ruggedcom.com>
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

Michael Galea wrote:
> Hi All,
>     I'm building a dts for a custom 8360 based board.  I'm looking at 
> the mpc8360_mds and mpc8360_rdk dts files, trying to figure out how the 
> UCCs (and all peripherals in general) got the values of their 
> "interrupts" properties chosen.

As someone else pointed out, you get the values from the manual.  The 
second cell of the IPIC interrupt specifier is the level/sense 
information (8 == level triggered, active low, 2 == rising edge).

>  And is there any relationship between 
> the choice of interrupts for ucc1 and the qeic controller..

No.  All QE interrupts are multiplexed over either IPIC 32 or IPIC 33. 
UCC0 and UCC1 just happen to be QEIC 32 and QEIC 33, respectively.

-Scott
