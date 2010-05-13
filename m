Return-Path: <pacman@kosh.dhis.org>
Received: from kosh.dhis.org (c-98-226-122-10.hsd1.in.comcast.net
	[98.226.122.10]) by ozlabs.org (Postfix) with SMTP id 37246B7E1A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 May 2010 21:16:05 +1000 (EST)
Message-ID: <20100513111603.3352.qmail@kosh.dhis.org>
From: pacman@kosh.dhis.org
Subject: Re: "event-scan failed" logflood
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 13 May 2010 06:16:03 -0500 (GMT+5)
In-Reply-To: <1273747607.21352.185.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:
> 
> Well, first it should be called once per second, not 60 times per
> second, so something is wrong there...

Actually I think it was happening a lot more than 60 times per second, and
klogd was losing most of the messages because they came too fast. When
running the new kernel, vmstat shows 170000 context switches per second (and
CPU usage never going below 5%) even when everything should be idle.

My next experiment was to hack rtas_init to return 0 unconditionally. Now
everything still runs fine, and the context switches per second are back down
in the 2-digit range.

> 
> Then, it wouldn't surprise me if the Pegasos RTAS didn't implement
> the event scan properly. Maybe we failed silently before that ? I
> doubt it's necessary there anyways.

If I'm reading things correctly, rtas-event-scan-rate is the key to the
frequency of attempts. And rtasd.c didn't expect this:

$ od -t x1 /proc/device-tree/rtas/rtas-event-scan-rate
0000000 00 00 00 00
0000004

-- 
Alan Curry
