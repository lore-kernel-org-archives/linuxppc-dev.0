Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 88B6F679F6
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 13:13:48 +1000 (EST)
Subject: Re: PowerMac7,3 sound (was: PowerBook5,4 -- no sound?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1147862072.14395.25.camel@johannes>
References: <878xq51t61.fsf@briny.internal.ondioline.org>
	<je1wvxo70l.fsf@sykes.suse.de>
	<1145220233.9833.11.camel@localhost.localdomain>
	<je7j5phz9j.fsf@sykes.suse.de>
	<1145231658.9833.17.camel@localhost.localdomain>
	<je3bgdhwre.fsf@sykes.suse.de>
	<1145233812.9833.21.camel@localhost.localdomain>
	<je1wvwfh7s.fsf@sykes.suse.de>
	<1145307118.3912.11.camel@localhost.localdomain>
	<1147862072.14395.25.camel@johannes>
Content-Type: text/plain
Date: Thu, 18 May 2006 13:13:42 +1000
Message-Id: <1147922022.17679.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-05-17 at 12:34 +0200, Johannes Berg wrote:
> > > request_mem_region(80000000 - 80000fff, i2sbus control)
> > > 
> > >       80000000-8007ffff : 0.80000000:mac-io
> > >         8000002c-8000002f : 0.0000004c:fans
> > >         80000030-80000033 : 0.0000004c:fans
> > >         80000034-80000037 : 0.0000004c:fans
> > >         8000004c-8000004f : 0.0000004c:fans
> > >         80000050-8000008a : 0.00000050:gpio
> 
> > Look like the bugs in the device-tree I told you about ...
> 
> Ben, is it safe to just hardcode 0x80010000-0x80010fff? Or hardcode
> 0x10000-0x10fff and have it do the translation depending on the
> device-tree node, iow assume that the 'reg' property is bogus and
> essentially replace it with one that contains the values
>   0x00010000 0x00001000 (buggy one seems to be 0x00000000 0x00001000)
>   0x00008000 0x00000100
>   0x00008100 0x00000100
> and then go from there? Even then though, I have no idea how to do the
> ranges translation for the node. Maybe we should just fix up the reg
> property in the device-tree for the affected machine(s)?

I'd rather avoid hard-coding in fact. I'm trying to figure out a better
way.

> Btw, it doesn't look like snd-powermac handles this correctly, it only
> ever handles the rx/tx specially and also takes the control io area
> straight from the device tree.
> 
> Andreas, you'll probably be able to get a bit further by inserting the
> following code in front of the loop in i2sbus-core.c line 162, and
> removing the of_address_to_resource call inside the loop.
> 
>   dev->resources[0].start = 0x80010000;
>   dev->resources[0].end   = 0x80010fff;
>   dev->resources[1].start = 0x80008000;
>   dev->resources[1].end   = 0x800080ff;
>   dev->resources[2].start = 0x80008100;
>   dev->resources[2].end   = 0x800081ff;
> 
> But I'm not sure that is correct on all machines (in fact, I'm not
> perfectly sure it is correct on your machine).
> 
> After that, you'll probably still not have usable sound though because I
> know nothing about the layout-id of your machine. If I have support for
> your codec already, that should be easy though.
> 
> johannes
