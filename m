Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200509140435.21916.arnd@arndb.de>
References: <1126644202.11056.59.camel@cashmere.sps.mot.com>
	<200509140435.21916.arnd@arndb.de>
Content-Type: text/plain
Message-Id: <1126705588.14036.10.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Wed, 14 Sep 2005 08:46:28 -0500
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: PATCH powerpc: Merge asm-ppc*/sections.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-09-13 at 21:35, Arnd Bergmann wrote:
> On Dinsdag 13 September 2005 22:43, Jon Loeliger wrote:
> > Here is a patch to merge asm-ppc*/sections.h.
> > 
> > If anyone knows if we can do better here,
> > please feel free to abuse, er, let me know!
> 
> Ok, I don't like this patch. 

You will be pleased to know, then, that Becky and I both
didn't like this patch either. :-)

> IMHO for the architecture merge, we should
> have a common implementation of this, either always using per-platform
> sections or never using them, meaning that we get rid of this file.

Yeah.

> At the very least, the __*func() macros should go away, they are completely
> bogus.

I'll work on eliminating those (at least) and submitting a
cleanup patch for that as needed.

> Using the sections in arch/powerpc has the obvious advantage that it
> reduces the size of the running kernel, but also has a certain amount
> of bug-potential or at least makes the code slightly more ugly.
> It is also easier to remove the feature in ppc than adding it in ppc64.

In the Grand Scheme of Things, removing things and making them
simpler seems a lofty goal. :-)   Anyone know of any pitfalls that
await me if I try to remove these sections, a la pmac and friends?
And I assume that the obvious mappings can take place (ie, that
"pmac.text" can just be placed in regular .text, etc), right?

> The users of the ppc64 function in_kernel_text() can probably be converted
> to the generic is_kernel_text() function.

I'll peer into that a bit too.

> 	Arnd <><

Thanks!
jdl
