Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DFC30DDF00
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 11:54:57 +1000 (EST)
In-Reply-To: <200704250001.18162.arnd@arndb.de>
References: <20070417210745.GA3567@aepfle.de>
	<20070424112530.GA11489@aepfle.de>
	<20070424185402.GA16077@aepfle.de>
	<200704250001.18162.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0e76c9675bd1bcf4b7ed6bf83da8c3d7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] generic check_legacy_ioport
Date: Wed, 25 Apr 2007 03:54:47 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Krafft <krafft@de.ibm.com>, Olaf Hering <olaf@aepfle.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Do you think a device_type fdc, i8042 or ipmi will appear outside an 
>>> isa
>>> node?
>>
>> Does anyone know where those ipmi devices appear in the device-tree?
>
> There are actually _no_ ipmi devices that we expect to appear here.
> the reason why the check is in the ipmi driver is in order not to crash
> on powerpc machines that load the ipmi driver but have no ipmi nodes
> in the device tree.

> I don't think there are any powerpc machines where it can find 
> something
> there, but we decided to leave the code architecture independent in
> case there ever are, and just to add the check_legacy_ioport call in 
> there.

SLOF/JS21 (at least some versions of it) have an "ipmi"
node on the "isa" bus.  And the kernel ipmi driver actually
works on it, too (no idea about the currently proposed
scanning though -- but the principle is correct at least).


Segher
