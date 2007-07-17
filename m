Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BB1C7DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 02:06:39 +1000 (EST)
Message-ID: <469CE904.2090900@freescale.com>
Date: Tue, 17 Jul 2007 11:06:28 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] 82xx: Parse SMC serial device node in DTS
References: <469B33F9.2080604@windriver.com> <200707171506.43102.arnd@arndb.de>
	<1184682576.18501.62.camel@mark> <200707171618.54903.arnd@arndb.de>
In-Reply-To: <200707171618.54903.arnd@arndb.de>
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

Arnd Bergmann wrote:
> On Tuesday 17 July 2007, Mark Zhan wrote:
> 
>>>Well, AFAICS, all of them currently use scc. The 8xx platforms don't
>>>even build correctly in the mainline kernel, so I guess it would
>>>be good to change them to also list fsl,cpm-smc in the compatible
>>>property.
>>
>>That probably could be done by another series of patches, and I really
>>don't want to introduce those kinds of patches in my BSP patches. I
>>don't know if the 8xx/82xx series patches from Scott Wood will cover
>>this issue or not.
> 
> 
> I guess he can best answer that himself. Scott, what are your plans
> to deal with the different types of cpm ports?

My patchset converts the CPM enet and serial drivers to of platform 
devices when CONFIG_PPC_MERGE is defined, and signficantly overhauls the 
device tree binding.  A 885 CPM UART would have a compatible like this:

compatible = "fsl,mpc885-smc-uart", "fsl,cpm1-smc-uart",
              "fsl,cpm1-uart", "fsl,cpm-smc-uart", "fsl,cpm-uart";

-Scott
