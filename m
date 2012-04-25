Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AE394B6FE6
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2012 07:14:39 +1000 (EST)
Message-ID: <1335388465.21961.35.camel@pasglop>
Subject: Re: [PATCH 00/15] PowerMac i2c API conversions & windfarm updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Thu, 26 Apr 2012 07:14:25 +1000
In-Reply-To: <m2sjfs85pv.fsf@igel.home>
References: <1334823416-9138-1-git-send-email-benh__1987.51832726902$1334826600$gmane$org@kernel.crashing.org>
 <m2397sz1er.fsf@igel.home> <1335343125.21961.33.camel@pasglop>
 <m2sjfs85pv.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: khali@linux-fr.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-04-25 at 12:29 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > Also, does the new driver properly react to load ?
> 
> The old driver keeps the cpu fans running at 300 rpm (lowest speed?)
> for much longer when the cpus are put busy.  Only when the cpus are back
> idle it speeds them up to 1200 rpm or more for some time depending on
> how long the cpus were busy.  The new driver is faster at speeding up
> the fans to around 800 rpm when cpus get busy, and keeps them running
> longer at that speed, but doesn't appear to select much higher speeds.
> 
> The old driver appears to be better suited to desktops, whereas the new
> driver is probably better for servers.

That's odd... as I said, the algorithm is supposed to be the same...

> But the most annoying sound appears to be coming from the slots fan.

Constant or changing ? The slots fan is set to a fixed speed, which I
thought was constant (well, I "tickle" it a bit but roughly it's
constant). Or is that not the case for you ?

Darwin has an algorithm for it based on getting some data from the video
driver in the AGP slot, but I don't have that.

Cheers,
Ben.
