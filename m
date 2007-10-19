Return-Path: <dgibson@ozlabs.org>
Date: Fri, 19 Oct 2007 11:45:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Merge dtc
Message-ID: <20071019014510.GD30283@localhost.localdomain>
References: <9a3f3582990ad94feb76770e82c50bdd@bga.com>
	<20071018195926.GA22887@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071018195926.GA22887@uranus.ravnborg.org>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 18, 2007 at 09:59:26PM +0200, Sam Ravnborg wrote:
> On Thu, Oct 18, 2007 at 12:49:54PM -0500, Milton Miller wrote:
> > On Tue Oct 16 15:02:17 EST 2007, David Gibson wrote:
> > 
> > >This very large patch incorporates a copy of dtc into the kernel
> > >source, in arch/powerpc/boot/dtc-src.  This means that dtc is no
> > >longer an external dependency to build kernels with configurations
> > >which need a dtb file.
> > >
> > >Signed-off-by: David Gibson <david at gibson.dropbear.id.au>
> > >
> > >Too big for the list, full patch at
> > >http://ozlabs.org/~dgibson/home/merge-dtc.patch+
> > 
> > So split it up.   The obvious one is "here is the unique content, then 
> > copy these files from dtc git" would have been better.
> One obvious split is a patch solely containing the _shipped files.
> And next patch the rest.

Um.. why?  No way is that a logical split.

> As Milton already pointed out you should build dtc in the
> dtc directory (why the -src prefix??).

The -src suffix is only there because I'm not building in the
directory - we can't have both a dtc binary and a dtc directory in
arch/powerpc/boot.  

Ok, so how do I build in the subdirectory?  I was going to do that,
but couldn't for the life of me figure out how.

> And the dtc specific Makefile looks like something from
> the late 80'. Please drop all these ALLUPPERCASE variables
> and accept a little bit of redundancy.

Hrm... I'm pretty dubious about this.  Practically every Makefile in
the universe, *except* Kbuild uses uppercase for most variables.
Makefile.dtc is imported verbatim from the standalone dtc package, and
is supposed to have the minimal information about what needs to be
built to import into Makefiles that actually know how to build things.

> Then mere humans may be able to read the Makefile.

Says a maintainer of Kbuild, about my tiny and not-very-complex
Makefile fragment... um, ok...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
