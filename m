Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3F045DDE1F
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 02:55:10 +1000 (EST)
Message-ID: <464C871C.4090300@freescale.com>
Date: Thu, 17 May 2007 11:47:24 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/5] powerpc: Document device nodes for I2C devices.
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>
	<FB8DD3C1-A095-4ABB-9E74-7EC66A43D983@kernel.crashing.org>
	<464C800C.20400@freescale.com>
	<FFBD3A3A-ADBE-4DC8-A1A1-4163367244D5@kernel.crashing.org>
In-Reply-To: <FFBD3A3A-ADBE-4DC8-A1A1-4163367244D5@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On May 17, 2007, at 11:17 AM, Scott Wood wrote:
>> Kumar Gala wrote:
>>> As I've stated before, we need a bus number as well so we can  
>>> handle  things like I2C switches and muxes.
>>
>> Is this something we handle now?  If not, then it's really not  within 
>> the scope of this patchset.  If so, how am I breaking it?
> 
> We don't handle i2c devices in the dev tree today.  If you are going  to 
> propose a solution it should work for all cases that people are  aware 
> of even if linux doesn't support the functionality.

But we do handle i2c *controllers* in the device tree, and that's where 
a bus number property would go.  Given that we don't have a binding for 
non-toplevel i2c buses, and I'm not adding one, I don't see the 
relevance.  Note that adding a bus number property makes zero sense for 
toplevel buses, as at that level the bus number is just a fiction 
maintained by Linux for user API and device preregistration purposes.

It's not a matter of the binding only covering some cases; it's a matter 
of the binding being for one thing (i2c devices) and not another 
(multiplexed i2c buses).

> If only some subset of cases are handled what good is the device tree  
> to a user?  They will just have to figure out if their usage is  
> supported or not and if not find some other solution that works for  them.

...just as they'll have to figure out if a binding exists for device 
type $FOO.

-Scott
