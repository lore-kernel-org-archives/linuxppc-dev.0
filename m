Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id E9095679A6
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Jun 2005 06:45:41 +1000 (EST)
In-Reply-To: <20050531105939.7486e071@dxpl.pdx.osdl.net>
References: <1107b64b01fb8e9a6c84359bb56881a6@freescale.com>
	<20050531105939.7486e071@dxpl.pdx.osdl.net>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <92F1428A-0B26-428B-8C06-35C7E5B9EEE3@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Date: Wed, 1 Jun 2005 15:45:26 -0500
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Netdev <netdev@oss.sgi.com>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: PHY Abstraction Layer II
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 31, 2005, at 12:59, Stephen Hemminger wrote:

> Here are some patches:
>     * allow phy's to be modules
>     * use driver owner for ref count
>     * make local functions static where ever possible

I agree with all these.

>     * get rid of bus read may sleep implication in comment.
>       since you are holding phy spin lock it better not!!

But not this one.  The phy_read and phy_write functions are reading  
from and writing to a bus.  It is a reasonable implementation to have  
the operation block in the bus driver, and be awoken when an  
interrupt signals the operation is done.  All of the phydev spinlocks  
have been arranged so as to prevent the lock being taken during  
interrupt time.

Unless I've misunderstood spinlocks (it wouldn't be the first time),  
as long as the lock is never taken in interrupt time, it should be ok  
to hold the lock, and wait for an interrupt before clearing the lock.

Andy Fleming
