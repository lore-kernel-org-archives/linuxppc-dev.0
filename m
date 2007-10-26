Return-Path: <dgibson@ozlabs.org>
Date: Fri, 26 Oct 2007 11:33:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH 05/11] [POWERPC] TQM5200 DTS
Message-ID: <20071026013343.GD457@localhost.localdomain>
References: <20071023231302.29359.27417.stgit@hekate.izotz.org>
	<20071023231333.29359.35252.stgit@hekate.izotz.org>
	<13403420.post@talk.nabble.com>
	<fa686aa40710250653o6e7df26y1890d5c485a6d508@mail.gmail.com>
	<4720BA4B.5090707@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4720BA4B.5090707@semihalf.com>
Cc: linuxppc-dev@ozlabs.org, Martin Krause <Martin.Krause@tqs.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 25, 2007 at 05:46:19PM +0200, Marian Balakowicz wrote:
> Grant Likely wrote:
> > On 10/25/07, Martin Krause <Martin.Krause@tqs.de> wrote:
[snip]
> >> On a board with 16 MiB FLASH for example the "big-fs" _and_ the "misc"
> >> partition could not be used. "big-fs", because the memory is too small
> >> (which is OK) and "misc", because it overlaps 1 MiB over the physikal
> >> flash border. So only the first 9 MiB of the flash could be used in Linux.
> >> The remaining 7 MiB couldn't be accessed.
> > 
> > Perhaps it would be better to drop the flash layout from the in-kernel
> > dts files entirely since flash layout can be a fluid thing.
> 
> Well, but that would not be really user friendly, I'd rather stick
> with some default config.

Strictly speaking the device-tree is not the right place for flash
partitioning information.  We put it there because it's preferable to
having hardcoded per-board flash layouts in the code itself.

It only really works well, though, when there are strong conventions
(shared with the firmware) about how to partition the flash.

Where it's really up to the user to determine how they want to lay out
their flash, putting things in the device tree isn't a really good
idea.

Incidentally, it's not required that *all* the flash address space be
in partitions, so it is possible only give partitions for those flash
chunks which the firmware needs to know about.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
