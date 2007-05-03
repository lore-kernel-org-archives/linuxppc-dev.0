Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ECDCFDE01B
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 03:26:02 +1000 (EST)
In-Reply-To: <463A14E6.5010608@ru.mvista.com>
References: <20070501051804.GB3881@localhost.localdomain>
	<20070503103534.63ff67b6@localhost.localdomain>
	<20070503070358.GA9430@localhost.localdomain>
	<4639CF44.6020608@ru.mvista.com>
	<20070503122213.GD26659@localhost.localdomain>
	<4639E389.4040604@ru.mvista.com>
	<a8625bde363025ce23393d5b2bb6ec07@kernel.crashing.org>
	<463A14E6.5010608@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e6d461fe5adb92e08ba5bf920c4027fb@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: powerpc_flash_init(), wtf!?
Date: Thu, 3 May 2007 19:25:55 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>     BTW, is it legal/appropriate to specify device (not bus) types 
>>> for
>>> of_platform_bus_probe()?
>
>> In almost all cases you should probe on "name"/"compatible",
>
>    Probing on name is not a good idea, since those are mostly generic.

The OF standard tells you to probe on "name" before
probing on "compatible".  If the "name" in a certain
node is generic, that doesn't harm at all, since you
probe for the more specific names only.

>> and not use "device_type" at all.
>
>    Heh, SPARC device trees I saw seem to not have this "useless" prop 
> at all. :-)

Well they have it in the nodes for which they _should_
have it, but not anywhere else no.


Segher
