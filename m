Return-Path: <dgibson@ozlabs.org>
Date: Fri, 9 Nov 2007 10:29:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] Use embedded libfdt in the bootwrapper
Message-ID: <20071108232958.GC18592@localhost.localdomain>
References: <20071108033241.GA11695@localhost.localdomain>
	<20071108033603.8A29FDDE0F@ozlabs.org>
	<20071108160839.GA4356@loki.buserror.net>
	<20071108224051.GB18592@localhost.localdomain>
	<473392A3.4010203@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <473392A3.4010203@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 08, 2007 at 04:50:11PM -0600, Scott Wood wrote:
> David Gibson wrote:
> >> How hard would it be to get libfdt to dynamically allocate any extra space
> >> it needs?  This is a regression from the current flat device tree code...
> > 
> > Uh.. it already does.  Or rather, the shims in libfdt-wrapper.c do so,
> > when libfdt functions which can expand the tree report that they've
> > run out of room.
> 
> Ah, good -- I was looking in libfdt itself, not the wrapper.  Now if 
> only we could get something similar into u-boot... maybe libfdt proper 
> could accept an optional realloc() function pointer in fdt_init(), and 
> eliminate the need for the caller to provide such a wrapper?

I've considered something like it (more likely an optional
realloc()ing wrapper layer that comes with libfdt).

For the bootwrapper itself, however, I'm still hoping to get rid of
malloc() entirely...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
