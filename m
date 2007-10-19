Return-Path: <dgibson@ozlabs.org>
Date: Fri, 19 Oct 2007 11:30:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: Merge dtc
Message-ID: <20071019013048.GC30283@localhost.localdomain>
References: <9a3f3582990ad94feb76770e82c50bdd@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9a3f3582990ad94feb76770e82c50bdd@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 18, 2007 at 12:49:54PM -0500, Milton Miller wrote:
> On Tue Oct 16 15:02:17 EST 2007, David Gibson wrote:
> 
> > This very large patch incorporates a copy of dtc into the kernel
> > source, in arch/powerpc/boot/dtc-src.  This means that dtc is no
> > longer an external dependency to build kernels with configurations
> > which need a dtb file.
> >
> > Signed-off-by: David Gibson <david at gibson.dropbear.id.au>
> >
> > Too big for the list, full patch at
> > http://ozlabs.org/~dgibson/home/merge-dtc.patch+
> 
> So split it up.   The obvious one is "here is the unique content, then 
> copy these files from dtc git" would have been better.

*facepalm*

The point of the small patches thing is not to glom together logically
separate patches.  It's *not* to split patches up simply for the sake
of making them smaller.

You've suggested the closest thing to a logical split here, but even
then - the dtc files are dead without the Makefile changes, and the
Makefile changes won't build without the dtc files (so the patches
would have to go in reversed order to what you suggest).

Not to mention that the Makefile patch will be tiny and the raw import
will still be way too big for the list.

> I finally went and looked at the url.  The Kbuild integration is wrong. 

Wrong?  Not how you'd prefer them perhaps...

>   It should build dtc in dtc-src and run the binary from there, and the 
> rules should be in a Kconfig as a normal host-target in that directory. 

Why?  This approach has the advantage that the subdirectory contains
*only* verbatim imported files, which could well make updates simpler.

>    (I don't have a problem with that Kbuild including Makefie.dtc).
> 
> things like the dependancy on scripts_basic in the top level
> Makefile.

I'm not even sure what you mean by this.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
