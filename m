Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 74D69DDE9E
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 11:05:29 +1100 (EST)
In-Reply-To: <20070215221412.GB19126@localhost.localdomain>
References: <E1HHkAL-0005Xl-2f@jdl.com>
	<2BDA6214-F867-4719-B0F6-E3409FB525F7@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BB39@az33exm25.fsl.freescale.net>
	<DFBB231C-47A7-46B9-9D56-B651536B2C5A@kernel.crashing.org>
	<20070215221412.GB19126@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1998FEAC-10FC-4A30-BEA4-82D3430E6299@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [DTC PATCH] Add support for decimal,
	octal and binary based cell values.
Date: Thu, 15 Feb 2007 18:04:31 -0600
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 15, 2007, at 4:14 PM, David Gibson wrote:

> On Thu, Feb 15, 2007 at 12:41:50PM -0600, Kumar Gala wrote:
>>
>> On Feb 15, 2007, at 11:49 AM, Yoder Stuart-B08248 wrote:
>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: linuxppc-dev-bounces+b08248=freescale.com@ozlabs.org
>>>> [mailto:linuxppc-dev-bounces+b08248=freescale.com@ozlabs.org]
>>>> On Behalf Of Kumar Gala
>>> [snip]
>>>>> New syntax d#, b#, o# and h# allow for an explicit prefix
>>>>> on cell values to specify their base.  Eg: <d# 123>
>>>>>
>>>>> Signed-off-by: Jon Loeliger <jdl@freescale.com>
>>>>>
>>>>> ---
>>>>
>>>> What are people's thoughts on supporting '0x' and '0X' for hex?
>>>
>>> Are you saying allow d#1234, h#5678, and 0x5678?  Or use 0x instead
>>> of h#?
>>
>> I'm saying in addition to supporting the d#, h# notation.
>>
>> The reason I'm suggesting support '0x' is its pretty natural from C
>> and I know there have been a number of times when I forget that all
>> int constants in .dts are hex.
>
> I'd prefer not to do this.  I agree it would be nice in some ways, but
> I'm worried that if people see 0x all over the place, they'll assume
> that things without an 0x are decimal, which they can't be for
> compatibility.

People don't know what to assume, I know I've made a number of errors  
when I forget that all numbers where hex.

I think we should change dtc to follow standard C conventions and do  
it now rather than later.

We've already introduced dtc version compatibilities issues.  I agree  
with Dan that we should fix this now while there are a small handful  
of .dts in existence and we can provide a compat mode flag that  
treats non-prefixed numbers as hex instead of decimal.

(in theory with that we can use dtc to convert old .dts into new .dts)

- k
