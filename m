Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (dsl027-180-168.sfo1.dsl.speakeasy.net
	[216.27.180.168]) by ozlabs.org (Postfix) with ESMTP id 85D3967BBC
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 08:03:13 +1000 (EST)
Date: Wed, 23 Aug 2006 15:03:14 -0700 (PDT)
Message-Id: <20060823.150314.41637066.davem@davemloft.net>
To: linas@austin.ibm.com
Subject: Re: [PATCH 2/6]: powerpc/cell spidernet low watermark patch.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060823213642.GG4401@austin.ibm.com>
References: <1156055509.5803.77.camel@localhost.localdomain>
	<200608201203.15645.arnd@arndb.de>
	<20060823213642.GG4401@austin.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: arnd@arndb.de, jklewis@us.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: linas@austin.ibm.com (Linas Vepstas)
Date: Wed, 23 Aug 2006 16:36:42 -0500

> I could create a searate patch to change struct descr {} to split 
> the u32 into several u8's; there's a dozen spots that get touched.
> 
> Alternatel, I could do a cheesy cast to char[4] and access that way.
> Opinions?

The most portable scheme would be a "u32/u8[4]" union with
appropriate endianness checks when determining which byte
to access in the u8[] view.
