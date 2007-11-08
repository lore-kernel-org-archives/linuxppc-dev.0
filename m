Return-Path: <dgibson@ozlabs.org>
Date: Fri, 9 Nov 2007 09:40:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] Use embedded libfdt in the bootwrapper
Message-ID: <20071108224051.GB18592@localhost.localdomain>
References: <20071108033241.GA11695@localhost.localdomain>
	<20071108033603.8A29FDDE0F@ozlabs.org>
	<20071108160839.GA4356@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071108160839.GA4356@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 08, 2007 at 10:08:39AM -0600, Scott Wood wrote:
> On Thu, Nov 08, 2007 at 02:36:03PM +1100, David Gibson wrote:
> > This patch incorporates libfdt (from the source embedded in an earlier
> > patch) into the wrapper.a library used by the bootwrapper.  This
> > includes adding a libfdt_env.h file, which the libfdt sources need in
> > order to integrate into the bootwrapper environment, and a
> > libfdt-wrapper.c which provides glue to connect the bootwrappers
> > abstract device tree callbacks to the libfdt functions.
> > 
> > In addition, this patch changes the various wrapper and platform files
> > to use libfdt functions instead of the older flatdevtree.c library.
> 
> Won't we need to change the dtc invocation in the wrapper to reserve some
> space now?
> 
> Speaking of which, it seems dtc still only supports setting the total size,
> as opposed to specifying the amount of additional space.  It's still a bit
> crappy having to guess how much space to add, but it's better than needing
> to know how big the dtb will be without additional space.
> 
> How hard would it be to get libfdt to dynamically allocate any extra space
> it needs?  This is a regression from the current flat device tree code...

Uh.. it already does.  Or rather, the shims in libfdt-wrapper.c do so,
when libfdt functions which can expand the tree report that they've
run out of room.

Ah... except that I haven't properly placed an fdt_open_into() with
possible expansion somewhere to make sure we can handle v16 or dtbs
with the blocks in unusual order.

I'll need to fix that before we merge.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
