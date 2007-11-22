Return-Path: <dgibson@ozlabs.org>
Date: Thu, 22 Nov 2007 17:23:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: dtc: RFC: Fix some lexical problems with references
Message-ID: <20071122062339.GB22888@localhost.localdomain>
References: <20071122061007.GA22888@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071122061007.GA22888@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 22, 2007 at 05:10:07PM +1100, David Gibson wrote:
> The recent change to the lexer to only recognize property and node
> names in the appropriate context removed a number of lexical warts in
> our language that would have gotten ugly as we add expression support
> and so forth.
> 
> But there's one nasty one remaining: references can contain a full
> path, including the various problematic node name characters (',', '+'
> and '-', for example).  This would cause trouble with expressions, and
> it also causes trouble with the patch I'm working on to allow
> expanding references to paths rather than phandles.  This patch
> therefore reworks the lexer to mitigate these problems.
> 
> 	- References to labels cause no problems.  These are now
> recognized separately from references to full paths.  No syntax change
> here.
> 
> 	- References to full paths, including problematic characters
> are allowed by "quoting" the path with braces
> e.g. &{/pci@10000/somedevice@3,8000}.  The braces protect any internal
> problematic characters from being confused with operators or whatever.
> 
> 	- For compatibility with existing dts files, in v0 dts files
> we allow bare references to paths as before &/foo/bar/whatever - but
> *only* if the path contains no troublesome characters.  Specifically
> only [a-zA-Z0-9_@/] are allowed.
> 
> This is an incompatible change to the dts-v1 format, but since AFAIK
> no-one has yet switched to dts-v1 files, I think we can get away with
> it.  Better to make the transition when people to convert to v1, and
> get rid of the problematic old syntax.
> 
> Strictly speaking, it's also an incompatible change to the v0 format,
> since some path references that were allowed before are no longer
> allowed.  I suspect no-one has been using the no-longer-supported
> forms (certainly none of the kernel dts files will cause trouble).  We
> might need to think about this harder, though.

Just to note: we need to do something here, but there are approaches
other than the one above (hence the RFC).  For example, if we just
separate the lexical recognition of refs-to-labels from refs-to-paths
then we can continue to recognize full bare path references.  However,
in some circumstances it might be necessary to add whitespace in the
dts to correctly mark the end of the path (in the case '/' and ' '
would essentially take the place of the braces for delimiting the
path).  That maintains full compatibility, and avoids the arguably
ugly &{/foo} syntax, but it does mean there are some odd situations
like the fact that (once string references are implemented):
		&label1, &label2
	and	&label1 , &label2
would be equivalent, but the following two:
		&/node1, &/node2
		&/node1 , &/node2
would not be equivalent (depending on context one or both of them
could be syntax errors).  The first is a reference to the node
"/node1," then a reference to the node "/node2", the second is a
reference to the node "/node1" then a comma then a reference to the
node "/node2".

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
