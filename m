Return-Path: <becky.bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5560CDE293
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 01:37:55 +1000 (EST)
Message-Id: <E87ABEE7-3CD0-45E5-9806-BE3BAAFCFE1C@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080709204435.4214f277@zod.rchland.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] powerpc: Fix problems with 32bit PPC's running with more
	than 2GB of RAM
Date: Thu, 10 Jul 2008 10:31:29 -0500
References: <1215611076-13518-1-git-send-email-sr@denx.de>
	<1215633758.8970.372.camel@pasglop>
	<20080709162219.4c07a67e@zod.rchland.ibm.com>
	<1215635979.8970.385.camel@pasglop>
	<20080709204435.4214f277@zod.rchland.ibm.com>
Cc: Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 9, 2008, at 7:44 PM, Josh Boyer wrote:

> On Thu, 10 Jul 2008 06:39:39 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>> On Wed, 2008-07-09 at 16:22 -0400, Josh Boyer wrote:
>>> On Thu, 10 Jul 2008 06:02:38 +1000
>>> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>>>
>>>> On Wed, 2008-07-09 at 15:44 +0200, Stefan Roese wrote:
>>>>> This patch enables 32bit PPC's (with 36bit physical address  
>>>>> space, e.g.
>>>>> IBM/AMCC PPC44x) to run with more than 2GB of RAM. Mostly its just
>>>>> replacing types (unsigned long -> phys_addr_t).
>>>>>
>>>>> Tested on an AMCC Katmai with 4GB of DDR2.
>>>>>
>>>>> Signed-off-by: Stefan Roese <sr@denx.de>
>>>>
>>>> But DMAs will break no ?
>>>
>>> How?
>>
>> Hrm... forget it. It's fine up to 4G of RAM... (ie. as long as DMA is
>> below 32 bits).
>
> Right.  We haven't really dealt with anything larger than 4 GiB, and  
> we
> certainly aren't dealing with discontiguous DRAM due to I/O ranges.

Are you *sure* you can see all 4GB?  I thought we lost some of the 32- 
bit PCI address space for PCI IO......  Disclaimer: I'm no expert on  
PCI :)

FYI, I'm *very* close to having swiotlb fully functional on powerpc to  
support larger RAM - I am able to boot with 6GB on 8641 right now.   
There are some bugs that I'm still shaking out - I hope to push this  
out in the next couple of weeks.

Cheers,
B
