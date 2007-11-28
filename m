Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: RFC: Fix some lexical problems with references 
In-Reply-To: Your message of "Thu, 22 Nov 2007 17:10:07 +1100."
	<20071122061007.GA22888@localhost.localdomain>
References: <20071122061007.GA22888@localhost.localdomain> 
Date: Wed, 28 Nov 2007 13:53:38 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IxSyY-0008Lf-4W@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
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
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
