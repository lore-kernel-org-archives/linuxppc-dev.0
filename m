Return-Path: <dgibson@ozlabs.org>
Date: Sat, 10 Feb 2007 12:02:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 19/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
Message-ID: <20070210010237.GF8276@localhost.localdomain>
References: <20070207230017.GA3758@ld0162-tx32.am.freescale.net>
	<20070207230149.GS3849@ld0162-tx32.am.freescale.net>
	<20070208211529.GA1894@localhost.localdomain>
	<45CCAB41.4080003@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45CCAB41.4080003@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 09, 2007 at 11:11:29AM -0600, Scott Wood wrote:
> David Gibson wrote:
> > On Wed, Feb 07, 2007 at 05:01:49PM -0600, Scott Wood wrote:
> > 
> >>Add a bootwrapper platform (cuboot) that takes a bd_t from a legacy
> >>U-Boot, and inserts data from it into a device tree which has been
> >>compiled into the kernel.  This should help ease the transition to
> >>arch/powerpc in cases where U-Boot has not yet been updated to pass a
> >>device tree, or where upgrading firmware isn't practical.
> >>
> >>The device trees currently in the kernel tree must have
> >>/chosen/linux,stdout-path added to work with cuboot.
> >>
> >>The kernel command line, mac addresses, and various clocks will be filled
> >>in based on the bd_t.
> > 
> > 
> > You're still using config dependent stuff in here...
> 
> They come from platform files such as cuboot-83xx.c, not (directly) from 
> the kernel config.

/me looks again...

.c files containing only #defines?  My brain hurts.

Better to pass these in as -D flags from the gcc invocation within the
wrapper script, depending on the given platform (for the platform .o
*only*).  Oh, and please don't call them CONFIG_* or everyone will
assume, like me, that they come from the kernel's overall config.h.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
