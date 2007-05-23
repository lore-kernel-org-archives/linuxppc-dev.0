Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2C623DDE42
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 02:05:50 +1000 (EST)
In-Reply-To: <1179934657.11247.14.camel@pterry-fc6.micromemory.com>
References: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
	<46B96294322F7D458F9648B60E15112C234AE6@zch01exm26.fsl.freescale.net>
	<Pine.LNX.4.64.0705230916170.535@localhost.localdomain>
	<1179934657.11247.14.camel@pterry-fc6.micromemory.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <836bca7802dca173490f4d38e0c48b7a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Porting RapidIO from ppc arch to powerpc arch in support of
	MPC8641D
Date: Wed, 23 May 2007 18:05:43 +0200
To: pterry@micromemory.com
Cc: linuxppc-dev@ozlabs.org, Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The law should really be removed.
> In my application I'm may be using a huge part of the 36-bit address
> space to address multiple remote RIO boards in a peer DMA multicomputer
> application. The default law just for maintenance messages isn't going
> to cut it.

If the firmware sets up the "law", it should put a property
in the node describing the setting.  If Linux sets up the
laws, there shouldn't be a property (since it is a policy
decision).

>>> The dbells and mboxs can be removed. The default setting in rio is 
>>> okay.
>>
>> this could possibly be useful.

Same issue.  Even if the firmware uses a default setting,
it should still put it in the device tree _iff_ it is the
firmware's decision (and not the kernel's).


Segher
