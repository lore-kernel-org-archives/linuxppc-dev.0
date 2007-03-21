Return-Path: <dgibson@ozlabs.org>
Date: Wed, 21 Mar 2007 12:51:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 05/17] bootwrapper: misc device tree fixes
Message-ID: <20070321015104.GC27969@localhost.localdomain>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172845.GE29784@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316172845.GE29784@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 16, 2007 at 12:28:45PM -0500, Scott Wood wrote:
> 1. The dtb should be generated in $tmpdir, rather than the current directory.
> Normally, $tmpdir is ".", so it doesn't matter, but the wrapper should obey
> the -W option if it should be passed.

This is still wrong (or at least insufficient).  If we're building
with a target directory different from the source directory we
shouldn't add anything to the source directory, but $tmpdir still
will.

> 2. DTC has a habit of complaining about errors which are not really
> errors.  Thus, the -f option is now passed to it, to force it to generate
> output regardless.

I'd really prefer not to add -f by default.  I think getting rid of
the bogus warnings from dtc is a better idea.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
