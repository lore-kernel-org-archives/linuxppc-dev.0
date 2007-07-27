Return-Path: <dgibson@ozlabs.org>
Date: Fri, 27 Jul 2007 12:00:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>, linuxppc-dev@ozlabs.org
Subject: Re: DTC 1.0.0 Release Coming?
Message-ID: <20070727020041.GC1561@localhost.localdomain>
References: <E1IDjSy-0003eC-T4@jdl.com>
	<20070726030550.GA1149@localhost.localdomain>
	<E1IE314-0000qF-5x@jdl.com>
	<20070726142739.GB18684@localhost.localdomain>
	<E1IE59h-0001tt-JE@jdl.com>
	<20070727013331.GB1561@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070727013331.GB1561@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 27, 2007 at 11:33:31AM +1000, David Gibson wrote:
> On Thu, Jul 26, 2007 at 10:21:33AM -0500, Jon Loeliger wrote:
[snip]
> > I hve also verified that at least one other independent build
> > using this approach produces a correct version string for them
> > as well.
> 
> Yes, well, this is the other trouble - the current system is so
> complex it's very hard to debug and figure out why it's claiming my
> build is dirty but not yours.

Ok, figured out why.  When I push, then pop a quilt patch some of the
files end up with their original contents, but changed timestamps.
That altered stat information causes git-diff-index to give false
indications of changed files, so setlocalversion adds the -dirty.
Running git status, or gitool or various other things causes git to
notice that the files aren't really changed, updates the index and
then the version is generated correctly again.

Not very robust though.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
