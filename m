Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 11E5CB7B7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 23:19:49 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8GDAuGQ004155
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2009 09:10:56 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8GDJkR5224964
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2009 09:19:46 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8GDJjOw005979
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2009 09:19:45 -0400
Date: Wed, 16 Sep 2009 09:19:43 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: RFC: delete UART current-speed from 4xx DTS?
Message-ID: <20090916131943.GA14261@zod.rchland.ibm.com>
References: <20090915143135.GA7015@windriver.com>
	<20090915153220.GG12372@zod.rchland.ibm.com>
	<1253051047.8375.232.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1253051047.8375.232.camel@pasglop>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 16, 2009 at 07:44:07AM +1000, Benjamin Herrenschmidt wrote:
>On Tue, 2009-09-15 at 11:32 -0400, Josh Boyer wrote:
>> On Tue, Sep 15, 2009 at 10:31:36AM -0400, Paul Gortmaker wrote:
>> >One of the guys here was getting a messed up console on a bamboo board
>> >(on linux boot), which he traced to the fact that the default dts has a
>> >9600 baudrate coded into it (board was running 115k2, not 9600).  Either
>> >deleting the line, or replacing the 9600 with zero fixed the problem.
>> 
>> Once booted, was there a valid current-speed property in /proc/device-tree
>> for the serial node?  I'm curious if U-Boot created it, or if the kernel
>> just used whatever baud was present already.
>> 
>> When I did the bamboo port a while ago, I recall having issues with either
>> a missing clock-frequency or current-speed (or both perhaps) and the bootloader
>> on the board was the original PIBS.  It might have been an issue with PIBS
>> but I'm guessing the rest of the 4xx boards copied from either Ebony or
>> Bamboo in their ports and hence contain that property.
>
>I think I recently added code to legacy_serial probe the speed from the
>HW if the property is absent, which should help.

Ok, so I think that is related to what I originally hit.

I played around with removing the current-speed property on canyonlands today,
and noticed that I would get no console output at all unless I specified a
baudrate with console=ttyS0,115200.  That was sort of contrary to what I found
with bamboo, so I diffed the configs to see why.  Bamboo has udbg enabled and
hence has legacy_serial builtin, whereas canyonlands just has of_serial.

So on boards where of_serial is the only serial driver, we need either an
accurate current-speed property, or a specific baudrate on the command line.
That makes a bit more tenuous to remove the properties entirely, because if
people disable udbg and are relying on that behavior they get no more console
output.  Need to think on that a bit I guess.

Alternatively, we could try patching of_serial.c to do the baudrate probe
as well.

josh
