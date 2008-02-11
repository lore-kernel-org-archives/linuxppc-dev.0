Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A7AE2DDECC
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 08:50:19 +1100 (EST)
Message-ID: <47B0C30A.1030801@freescale.com>
Date: Mon, 11 Feb 2008 15:50:02 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: WARN_ON() hit in fsl bitbanged phy driver
References: <DCEAAC0833DD314AB0B58112AD99B93B03F931E6@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B03F931E6@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
> I hit the following WARN_ON when using mii-tools agains a ethernet
> interface using a bit-banged mii interface
> It is only diplayed once, and does not seem to impact usage at all
> 
> Does somebody know what is wrong, and how to fix it?

It looks like the kernel thinks it's in an interrupt, even though it 
clearly isn't from the backtrace.  Presumably, something slept from an 
interrupt handler; try turning on sleep-in-spinlock debugging.

The root cause was probably something other than the phy code.

-Scott
