Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E2E9EDDED4
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 12:09:59 +1000 (EST)
In-Reply-To: <46E6CE9A.8080402@freescale.com>
References: <Pine.LNX.4.64.0709110128040.27648@blarg.am.freescale.net>	<20070911141821.GA32545@lixom.net>	<230A7A2A-3184-4BC2-B8AC-C94090B532B0@kernel.crashing.org>	<20070911155558.GA10743@lixom.net>	<11B85E70-D643-4013-A9B3-59CD76F9D7AB@kernel.crashing.org>
	<20070911171521.GB10743@lixom.net> <46E6CE9A.8080402@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <41e2e527c0f0dfceedf2ffe6cdf34816@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Date: Wed, 12 Sep 2007 15:20:14 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> well the ifdefs are orthogonal.  We don't have a way of knowing
>>> primary from the device tree today.
>>
>> How about something like "fsl,primary-phb" in the bus device node? I 
>> don't
>> know, maybe it's already been discussed and turned down for some 
>> reason.
>
> It's more of a Linux issue than anything to do with the hardware.

Yeah, many machines actually have multiple "primary PHBs", and
Linux cannot really deal with that.  It's probably best to handle
this from platform code.

>> Or would it be sufficient to check children of that device node to see
>> if the ULi is on that bus?
>
> Or more generally, see if an isa node is somewhere in that subtree.

And if there is no ISA node, find any other legacy device (non-native
ATA controllers, ...), etc.


Segher
