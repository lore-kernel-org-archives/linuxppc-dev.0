Return-Path: <jonmasters@gmail.com>
Received: from mproxy.gmail.com (rproxy.gmail.com [64.233.170.207])
	by ozlabs.org (Postfix) with ESMTP id 134142BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Oct 2004 22:45:31 +1000 (EST)
Received: by mproxy.gmail.com with SMTP id 76so4778913rnk
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 04 Oct 2004 05:45:29 -0700 (PDT)
Message-ID: <35fb2e5904100405451423c391@mail.gmail.com>
Date: Mon, 4 Oct 2004 13:45:28 +0100
From: Jon Masters <jonmasters@gmail.com>
To: Pantelis Antoniou <panto@intracom.gr>
In-Reply-To: <4160E898.9080905@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <35fb2e59040930165327f2dd59@mail.gmail.com>
	<87127382-1357-11D9-8EFC-000393DBC2E8@freescale.com>
	<20041001220648.GJ21896@smtp.west.cox.net>
	<4160E898.9080905@intracom.gr>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: bi_recs
Reply-To: jonathan@jonmasters.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 04 Oct 2004 09:07:20 +0300, Pantelis Antoniou <panto@intracom.gr> wrote:

> Allow me, to cut in and plug my own thing.

Yeah cool. btw, I looked at the ppc64 stuff (having eventually
realised I need to be using the bk tree for everything ppc64 rather
than 2.6.8.1) and I see what benh is getting at now - so I am figuring
out the best way to proceed on that front. None of my boards support
2.6 yet so I either fix that this week or get up and running with 2.4
first. Anyway, I'm working on it in my spare time.

> If you follow the u-boot-users list, you'll know that some time
> ago there was a similar discussion.

I don't, but I will sign up to the list at some point. Currently I use
my own firmware as I was too lazy to go figure out the ins and outs of
uboot :-).

> I just create an argv of all the environment variables of the firmware
> and I pass the psysical address of that NULL terminated argv array
> to the kernel command line like so... "u-boot-env=0x0f000f00".

I think that's an approach which works up to a point. It's nice to
have a hierachy of devices like with OF because then we can infer
things like order of devices on a bus that need to be shutdown for a
suspend. This can be done as a flat list but I the reason ben put me
off my original idea of going with tagged records is that OF is
clearly the better approach.

> I have working patches for u-boot, the kernel parser, a kernel /proc
> interface for accessing them and also some patches for busybox

That's great. So seriously worth looking at then.

> I know this is the Nth time this discussion is taking place bu IMO

So we probably need to decide. I think Mark's XML idea also works, but
I don't see anything wrong with a flattened OF type tree either since
it's ASCII strings also, just layed out in a slightly more involved
fashion than having a long list of parameters.

I'm going to get this OF thing sorted anyway because it's worth having
that option - but I'm indifferent towards what is ultimately decided
(as long as something is agreed upon). If we went with a solution such
as yours then I would prefer Mark's idea of a structured set of data.
This way I can say which PCI bridge device X lives behind in a nicer
fashion.

Blah.

Jon.
