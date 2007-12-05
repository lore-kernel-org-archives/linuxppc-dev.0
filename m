Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A442CDDDF6
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 09:46:59 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB5Mkurk027445
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Dec 2007 17:46:56 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB5MkuXY452030
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Dec 2007 17:46:56 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB5MktV1000402
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Dec 2007 17:46:56 -0500
Date: Wed, 5 Dec 2007 16:44:08 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: dtc: RFC: Fix some lexical problems with references
Message-ID: <20071205164408.53745866@zod.rchland.ibm.com>
In-Reply-To: <20071205163409.77fba42b@zod.rchland.ibm.com>
References: <20071122061007.GA22888@localhost.localdomain>
	<20071205163409.77fba42b@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 5 Dec 2007 16:34:09 -0600
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> On Thu, 22 Nov 2007 17:10:07 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > The recent change to the lexer to only recognize property and node
> > names in the appropriate context removed a number of lexical warts in
> > our language that would have gotten ugly as we add expression support
> > and so forth.
> > 
> > But there's one nasty one remaining: references can contain a full
> > path, including the various problematic node name characters (',', '+'
> > and '-', for example).  This would cause trouble with expressions, and
> > it also causes trouble with the patch I'm working on to allow
> > expanding references to paths rather than phandles.  This patch
> > therefore reworks the lexer to mitigate these problems.
> > 
> > 	- References to labels cause no problems.  These are now
> > recognized separately from references to full paths.  No syntax change
> > here.
> > 
> > 	- References to full paths, including problematic characters
> > are allowed by "quoting" the path with braces
> > e.g. &{/pci@10000/somedevice@3,8000}.  The braces protect any internal
> > problematic characters from being confused with operators or whatever.
> > 
> > 	- For compatibility with existing dts files, in v0 dts files
> > we allow bare references to paths as before &/foo/bar/whatever - but
> > *only* if the path contains no troublesome characters.  Specifically
> > only [a-zA-Z0-9_@/] are allowed.
> > 
> > This is an incompatible change to the dts-v1 format, but since AFAIK
> > no-one has yet switched to dts-v1 files, I think we can get away with
> > it.  Better to make the transition when people to convert to v1, and
> > get rid of the problematic old syntax.
> > 
> > Strictly speaking, it's also an incompatible change to the v0 format,
> > since some path references that were allowed before are no longer
> > allowed.  I suspect no-one has been using the no-longer-supported
> > forms (certainly none of the kernel dts files will cause trouble).  We
> > might need to think about this harder, though.
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> So this breaks some of the in-kernel DTS files.  Example, bamboo.dts on
> line 19 produces:
> 
> bamboo.dts: 19 syntax error
> FATAL ERROR: Couldn't read input tree
> 
> I tried quoting the path with {} but that didn't seem to work.

Nevermind, the quoting worked.

josh
