Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 32BEAB7E4A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 May 2010 07:28:49 +1000 (EST)
Subject: Re: "event-scan failed" logflood
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: pacman@kosh.dhis.org
In-Reply-To: <20100513111603.3352.qmail@kosh.dhis.org>
References: <20100513111603.3352.qmail@kosh.dhis.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 14 May 2010 07:28:24 +1000
Message-ID: <1273786104.21352.190.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-05-13 at 06:16 -0500, pacman@kosh.dhis.org wrote:
> Benjamin Herrenschmidt writes:
> > 
> > Well, first it should be called once per second, not 60 times per
> > second, so something is wrong there...
> 
> Actually I think it was happening a lot more than 60 times per second, and
> klogd was losing most of the messages because they came too fast. When
> running the new kernel, vmstat shows 170000 context switches per second (and
> CPU usage never going below 5%) even when everything should be idle.
> 
> My next experiment was to hack rtas_init to return 0 unconditionally. Now
> everything still runs fine, and the context switches per second are back down
> in the 2-digit range.
> 
> > 
> > Then, it wouldn't surprise me if the Pegasos RTAS didn't implement
> > the event scan properly. Maybe we failed silently before that ? I
> > doubt it's necessary there anyways.
> 
> If I'm reading things correctly, rtas-event-scan-rate is the key to the
> frequency of attempts. And rtasd.c didn't expect this:
> 
> $ od -t x1 /proc/device-tree/rtas/rtas-event-scan-rate
> 0000000 00 00 00 00
> 0000004

Ok, that gives us a good thing to use to not do the scanning then. If
that's 0 then we assume it's a bogus OF and we disable the scan
completely. I'll do a patch later today, though feel free to beat me to
it.

Cheers,
Ben.
