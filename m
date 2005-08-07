Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 82C5267F0F
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  8 Aug 2005 03:25:23 +1000 (EST)
In-Reply-To: <20050807154432.GE5210@cathedrallabs.org>
References: <20050806180353.GW5210@cathedrallabs.org>
	<20050806232701.GD1099@dmt.cnet>
	<e5caa80a2cd721a4f6ee3c74ead906b2@embeddededge.com>
	<20050807043110.GA6316@dmt.cnet>
	<09b0792f426f1d5883cf5d437723f075@embeddededge.com>
	<20050807154432.GE5210@cathedrallabs.org>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2fcd8a329246b2f2c303e515dd0cb7bf@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sun, 7 Aug 2005 13:25:34 -0400
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 7, 2005, at 11:44 AM, Aristeu Sergio Rozanski Filho wrote:

> what about don't cache it and call ioremap() from driver? (I guess
> ioremap() already check if an area is already mapped, no?)

Either way.  I'm actually leaning toward these "pointer helper"
functions. :-)  Something like get_cpmp(), or get_immr(), that will
hide the details of the mapping, so you don't have to include
and know which #defines to use as part of an ioremap() call.

It seems to be more clear to me, and I'm thinking about making
the same changes to the CPM2 drivers.  It also allows a
performance versus compact code trade off, declaring these
as inline functions or as real functions.

Thanks.

	-- Dan
