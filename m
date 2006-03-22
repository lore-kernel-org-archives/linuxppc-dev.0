Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5ECB7679F6
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Mar 2006 08:50:47 +1100 (EST)
Subject: Re: new sound driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1143020119.11724.41.camel@localhost>
References: <1143020119.11724.41.camel@localhost>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 08:50:36 +1100
Message-Id: <1143064237.3823.29.camel@localhost.localdomain>
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

On Wed, 2006-03-22 at 10:35 +0100, Johannes Berg wrote:

> Firstly, the soundbus objects need to be able to handle data
> transmission. What I'm not too sure about is how the API should look
> like. I'm thinking that since all objects there are actually sound
> objects (well, there's the modem too, but it can get an alsa interface
> too), the soundbus objects actually get to create the alsa pcm
> interfaces, somehow helped by the codecs to select the valid rates and
> formats. Or the codecs create the alsa pcm streams, but refer to
> soundbus object functions for handling the actual data transfer. I'd
> like to push as much of the interface into the soundbus object as
> possible. At this point also the question of how to program the dbdma
> engine best comes up. I really don't know, because I don't quite
> understand the alsa pcm api.
> In any case, I'm thinking of putting dbdma register stuff into the
> soundbus module and adding dbdma data to struct soundbus_dev.

that would make soundbus totally pmac specific, in which case you should
call it aoa-bus or something like that.

Regarding your previous question well... I think the soundbus can create
the pcm streams. Alsa has 2 levels: PCM objects and PCM substreams. We
need the former. Substreams are used when the harware has several
streams that are hw mixed to the same mixers which isn't the case with
apple layout. When we have multiple i2s busses, they are really
independant with separate codecs, frame rates & formats etc.. thus
separate PCM objects.

I think the sound bus should create the PCMs. Now I don't remember from
Alsa API but do we need to know the available rates in advance ? In that
case, we may want to have the bitmask provided by the fabric (from the
layout array for example).

I'm also not sure how Alsa handle changes there. For example, if you
plug a digital input, the entire bus where this input is has to be
clocked from that, thus limiting dynamically what rates/formats are
available. I'm not sure Alsa API can cope with that yet.

> Actually, this isn't quite possible. On the newer machines where you
> have two codecs on the same i2s bus, we need to have the layout fabric
> create the one pcm stream and have it ask the codecs what it should
> advertise. Then it needs to advertise the lowest common denominator of
> the multiple codecs... (Or can alsa handle pcms that change their
> supported rates/formats?) Then it refers to the soundbus functions for
> actual data transmission.

The problem is that codec objects have to be created asynchronously
since they use asynchronous i2c discovery. Unless you instanciate them
all but simply mark them "offline" and then mark them "online" later
when the hardware actually shows up. That is fine except for .. topaz
where you need to access the hw to know the chip type, thus you can't
really know everything you need early enough (or maybe you can ...)
 
> Another thing that needs to be done is teach the layout-id fabric module
> how to handle all the dozens of platform functions and publish those to
> alsa that make sense to be set by the user (like line out select etc.).
> Then also register the interrupt ones and handle them appropriately. The
> codecs will need to be notified on changes/interrupts though, since in
> some cases things need to be switched around there too. This is just a
> matter of inventing the right way to find all of the functions...
> 
> Whee. I was going to write more but for one it is already long enough,
> and I also forgot what I wanted to write :)

Just sleep on it for now :) We definitely need a "core" module that
handles all of the gpio mess. ..

Ben.
