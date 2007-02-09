Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AE211DDEF3
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 09:47:51 +1100 (EST)
In-Reply-To: <1171058780.6578.4.camel@localhost.localdomain>
References: <989B956029373F45A0B8AF02970818900D444B@zch01exm26.fsl.freescale.net>
	<1170969965.2620.345.camel@localhost.localdomain>
	<0640B069-F05E-4A08-A8EB-C277BEF1466E@embeddedalley.com>
	<1171058780.6578.4.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1EFFAE36-7396-45B5-B8F2-DD7348FBE385@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Discussion about iopa()
Date: Fri, 9 Feb 2007 16:46:57 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Tabi Timur-B04825 <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 9, 2007, at 4:06 PM, Benjamin Herrenschmidt wrote:

> On Fri, 2007-02-09 at 12:13 -0500, Dan Malek wrote:
>> On Feb 8, 2007, at 4:26 PM, Benjamin Herrenschmidt wrote:
>>
>>> I'm really not fan of it.
>>
>> That's because I think it's a terribly useful function
>> and the first step toward some orthogonal VM APIs. :-)
>
> No, I think it's very inefficient to walk the page tables, even  
> worse if
> you have PTEs in HIGHMEM. I think it's better to keep track the  
> physical
> address from alloc time, something similar than dma_alloc_coherent but
> for use with that MURAM thingy.

My feeling is to leave the code alone until we have the dma mapping  
api setup to handle MURAM.  If we can't do alloc/map/free with the  
same mechanism I dont see the value in just doing 'map'.  It just  
makes the code more confusing w/o any big gain.

Truthfully the normal system memory size should be cleaned up to use  
the dma mapping API instead of straight allocations and mapping like  
its using now.

- k
