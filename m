Return-Path: <dgibson@ozlabs.org>
Date: Tue, 14 Oct 2008 13:00:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] powerpc/boot: compare _start against ei.loadsize
	instead ei.memsize
Message-ID: <20081014020004.GE20620@yookeroo.seuss>
References: <20080923203857.GB10935@www.tglx.de>
	<200809240146.m8O1kIpZ077447@sullivan.realtime.net>
	<20080925214357.GA2929@www.tglx.de>
	<1223611088.8157.144.camel@pasglop>
	<20081013091526.GA9925@www.tglx.de>
	<20081014015753.GD20620@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081014015753.GD20620@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 14, 2008 at 12:57:53PM +1100, David Gibson wrote:
> On Mon, Oct 13, 2008 at 11:15:26AM +0200, Sebastian Andrzej Siewior wrote:
> > If the vmlinux binary in memory is larger than 4 MiB than it collides
> > with the initial boot code which is linked at 4 MiB in case of cuBoot.
> > If the the uncompressed image size (on disk size) is less than 4 MiB
> > then it would fit. The difference between those two sizes is the bss
> > section. In cuBoot we have the dtb embedded right after the data
> > section so it is very likely that the reset of the bss section (in
> > kernel's start up code) will overwrite the dtb blob. Therefore we
> > reallocate the dtb. Something similar is allready done to the initrd.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> This patch looks sound to me.  It does strike me as only a stopgap
> until we come up with some better way of managing the early memory,
> preferably avoiding the magical fixed 4MiB (or whatever) offset.
> 
> Still, it looks safe - since it does check that the wrapper's malloc()
> region can't collide with the kernel's BSS.  So, if this little slice
> of extra BSS room is useful for the time being, I see no reason not to
> apply the patch.
> 
> Acked-by: David Gibson <david@gibson.dropbear.id.au>

Oh, one other thing.  Since we are now unconditionally copying the dtb
into a malloc()ed buffer, possibly it would be sensible to add a
little padding to the buffer at that point, so that further device
tree manipulations won't need to reallocate it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
