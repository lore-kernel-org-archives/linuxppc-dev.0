Return-Path: <khali@linux-fr.org>
Received: from mallaury.nerim.net (smtp-101-monday.noc.nerim.net [62.4.17.101])
	by ozlabs.org (Postfix) with ESMTP id C2667DDF93
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 07:58:48 +1100 (EST)
Date: Mon, 18 Feb 2008 21:58:42 +0100
From: Jean Delvare <khali@linux-fr.org>
To: benh@kernel.crashing.org
Subject: Re: [Patch 0/2] powerpc: avoid userspace poking to legacy ioports
Message-ID: <20080218215842.66bb004f@hyperion.delvare>
In-Reply-To: <1203367323.6740.21.camel@pasglop>
References: <20080213182800.5c6940a8@de.ibm.com>
	<20080213183506.7f3e3145@de.ibm.com>
	<1202935374.7296.44.camel@pasglop>
	<20080218211519.2b159ade@hyperion.delvare>
	<1203367323.6740.21.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: parabelboi@bopserverein.de, Christian Krafft <krafft@de.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 19 Feb 2008 07:42:03 +1100, Benjamin Herrenschmidt wrote:
> 
> > Maybe Christian's patch can be improved to not do the check on these?
> > As long as /dev/port exists, it seems reasonable that the kernel should
> > behave, no matter what I/O ports are accessed from user-space.
> 
> nonsense.
> 
>  /dev/mem exists for example, but you are still not supposed to go
> bang all over the place in it.

You should at least be able to read from it without crashing the
machine. Of course writing is a different story.

> > > I hate that sensors_detect.. or for that matter any other userland code
> > > that pokes random ports like that. It should die.
> > 
> > What do you propose as a replacement?
> 
> Dunno, something less scary, like knowing where your sensors are on a
> given machine...

You mean, having a complete database for the, what, 4000 PC
motherboards out there? And maintaining it day after day? _This_ sounds
much scarier to me than the current situation.

> honestly, it's just scary the risk you guys are taking
> by banging random IO ports.

I don't remember anyone reporting problems with this in the past 3 or 4
years, so it doesn't seem to be a big problem in practice.

> At the very least, that shouldn't be done on non-x86.

I am surprised that anyone would actually run sensors-detect on
non-x86... Non-PC hardware usually doesn't have sensors driven by
"hwmon" drivers anyway, or people know what they have and do not need
detection. But I would be totally fine with updating sensors-detect to
skip some of the probes on non-x86 hardware. There are basically
3 /dev/port probes that are done currently:

* Super-I/O chips at 0x2e/0x2f and 0x4e/0x4f.

* Legacy PC hardware monitoring chips at 0x290-0x297.

* IPMI interface at 0x0ca3 and 0x0cab (read-only).

Please tell me which ones should be skipped on PowerPC.

Christian, can you tell me which of these probes caused trouble for you?

> > And how is userland code poking at random ports different from kernel
> > code poking at random ports? We could move sensors-detect inside the
> > kernel (and I have some plan to do that) but I fail to see how this
> > would solve this particular problem.
> 
> It wouldn't, but at least I could NAK it or make it CONFIG_X86 :-)

The same could be done for user-space (or at the /dev/port level.)

-- 
Jean Delvare
