Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DAF1A679F4
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 05:32:58 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: PowerMac7,3 sound (was: PowerBook5,4 -- no sound?)
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
Date: Wed, 17 May 2006 21:32:48 +0200
In-Reply-To: <1147862072.14395.25.camel@johannes> (Johannes Berg's message of
	"Wed, 17 May 2006 12:34:32 +0200")
Message-ID: <je3bf85twf.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg <johannes@sipsolutions.net> writes:

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

I have the following sound resources in /proc/iomem:

        80008000-800083ff : 0.00010000:i2s
          80008000-800083ff : Sound DMA
        80010000-80010fff : 0.00010000:i2s
          80010000-80010fff : Sound Control

I'm not sure whether the first mapping should be split, but I don't know
much about how resource mappings work.

> After that, you'll probably still not have usable sound though because I
> know nothing about the layout-id of your machine. If I have support for
> your codec already, that should be easy though.

The layout id is 36, and it has both line out and headphone, detected as a
Snapper.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
