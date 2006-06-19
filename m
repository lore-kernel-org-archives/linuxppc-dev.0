Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 30A6167A63
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 08:44:47 +1000 (EST)
In-Reply-To: <E1FsSOB-0000CE-2o@jdl.com>
References: <E1Frjen-0004Oz-Hz@jdl.com>
	<1150600056.23600.152.camel@localhost.localdomain>
	<1150725866.9022.5.camel@cashmere.sps.mot.com>
	<F34E213C-B073-4D85-A323-644340E3C09D@kernel.crashing.org>
	<E1FsSOB-0000CE-2o@jdl.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A609CF22-66E8-404C-A6F2-528BE097BF57@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 5/9 v3] Add the MPC8641 HPCN platform files. 
Date: Tue, 20 Jun 2006 00:44:35 +0200
To: Jon Loeliger <jdl@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Btw, IMNSHO, it should be the firmware's job to synchronise
>> the timebases, even before the kernel gets started; at least
>> as the default.  We don't want to have millions of separate
>> GPIO thingies, one for every board, unless really necessary,
>> I think?
>
> The second CPU isn't even running in the firmware.
> It is in hard-reset until Linux says "Hey, start that
> secondary CPU for me!".

In that case you obviously need to sync the timebases, sure.
The firmware could be smart and do the sync at CPU start-up
time though.

On other boards, all CPUs are always running (not a desirable
situation, but outside of our control, heh).

In either case, the knowledge about how to sync the timebases
more properly belongs in the firmware than in the kernel.  In
some cases the kernel explicitly tells the firmware to start/
stop the timebases, that's better than the kernel having to
handle the nitty-gritty details itself already.

Thoughts?


Segher
