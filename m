Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1D358679F7
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 08:09:17 +1100 (EST)
Subject: Re: new sound driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1143134017.8395.19.camel@localhost>
References: <1143020119.11724.41.camel@localhost>
	<1143064237.3823.29.camel@localhost.localdomain>
	<1143134017.8395.19.camel@localhost>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 08:09:05 +1100
Message-Id: <1143148145.4257.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Alastair Poole <netstar@gatheringofgray.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> What I'm currently thinking of is creating one PCM per codec, and then
> if you can't use them at the same time just forbid access to it.

No, it should really be one PCM per bus... I don't see why you would
prevent somebody from outputing on both digital and analog outputs at
the same time for example (the same data of course). One PCM = one
stream = one bus carrying the samples. All codecs on that bus whould be
set to the same settings of course. If one can't but the other can, just
mute the one that can't I suppose...

Also, Alsa does have some means of asynchronous notifyication of a state
change on a control (and calls you back later with some locking) though
I'm not too familiar with the details. You should ask on the list once
you have the basic dbdma stuff there :)
 
> > Just sleep on it for now :) We definitely need a "core" module that
> > handles all of the gpio mess. ..
> 
> Yeah. Haven't even opened that can of worms yet...
> 
> johannes
