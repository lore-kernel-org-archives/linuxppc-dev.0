Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0CC50DDF56
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 07:32:01 +1000 (EST)
Message-ID: <463F9AC9.8080304@freescale.com>
Date: Mon, 07 May 2007 16:31:53 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 12/13] gianfar: Add flags for magic packet and MDIO.
References: <20070507182957.GK26920@ld0162-tx32.am.freescale.net>
	<20F58AAE-A35D-4BEC-9597-A882567BA5B4@kernel.crashing.org>
	<463F83FC.6080807@freescale.com>
	<1C79B879-58E1-4274-BB90-A6D39FC852C8@freescale.com>
In-Reply-To: <1C79B879-58E1-4274-BB90-A6D39FC852C8@freescale.com>
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

Andy Fleming wrote:
> On May 7, 2007, at 14:54, Scott Wood wrote:
>> TSEC1 contains the MDIO registers for both TSEC1 and TSEC2.  Thus,  TSEC1
>> cannot be put to sleep if TSEC2 is active (plus, the phy timer would
>> have to be deactivated).  For now, the simple approach of never  sleeping
>> TSEC1 is used.
> 
> The PHY timer is part of the PHY Lib.  The PHY Lib has infrastructure  
> to support suspend/resume.  Any thoughts on using that?  More in an  
> another email.

If the MDIO registers had their own clock disable bit, then sure.  They 
don't.

As for the phy timer issue, it seems that phy_stop() doesn't stop the 
timer, which is probably a bug.

-Scott
