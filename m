Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EEA6DDDF50
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 05:54:43 +1000 (EST)
Message-ID: <463F83FC.6080807@freescale.com>
Date: Mon, 07 May 2007 14:54:36 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 12/13] gianfar: Add flags for magic packet and MDIO.
References: <20070507182957.GK26920@ld0162-tx32.am.freescale.net>
	<20F58AAE-A35D-4BEC-9597-A882567BA5B4@kernel.crashing.org>
In-Reply-To: <20F58AAE-A35D-4BEC-9597-A882567BA5B4@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On May 7, 2007, at 1:29 PM, Scott Wood wrote:
> 
>> The magic packet flag indicates that the hardware has this
>> capability.  The MDIO flag indicates that this device's
>> registers contain active MDIO registers, and thus this
>> device should not be put to sleep.
> 
> 
> Can you explain the MDIO part further, do you mean its the tsec that  
> has the MDIO registers in its address space or that its actively  using 
> MDIO for something?

TSEC1 contains the MDIO registers for both TSEC1 and TSEC2.  Thus, TSEC1 
cannot be put to sleep if TSEC2 is active (plus, the phy timer would 
have to be deactivated).  For now, the simple approach of never sleeping 
TSEC1 is used.

-Scott
