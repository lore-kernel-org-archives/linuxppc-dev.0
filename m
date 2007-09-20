Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 82E2ADDF92
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 04:44:51 +1000 (EST)
Message-ID: <46F2BF80.5030502@freescale.com>
Date: Thu, 20 Sep 2007 13:44:16 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [POWERPC] Fix QEIC->MPIC cascading
References: <20070920130244.GA18043@localhost.localdomain>	<46F2A7CC.1040106@freescale.com>	<20070920174159.GA10765@localhost.localdomain>
	<46F2B8FD.7040501@freescale.com>
In-Reply-To: <46F2B8FD.7040501@freescale.com>
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

Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
>> I don't know (didn't look) why this works for 83xx w/o ack()...
>> maybe IPIC don't need this. Or maybe there is a bug hiding.
> 
> Scott W told me that me that the IPIC doesn't have the concept of EOI ack.  It 
> just has IRQ masks.

And the IRQ will be masked at the QEIC while being processed.  Doing it 
this way allows another QE interrupt to come through while the first is 
being serviced.

It might make sense on MPIC to ack after masking at the QEIC, for this 
reason.

-Scott
