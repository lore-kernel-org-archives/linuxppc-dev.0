Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 82A3067B2A
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 18:17:00 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 19 May 2006 10:16:55 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Cell and new CPU feature bits
Message-ID: <20060519081654.GB22952@iram.es>
References: <1148011621.13249.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1148011621.13249.7.camel@localhost.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 19, 2006 at 02:07:01PM +1000, Benjamin Herrenschmidt wrote:
> The Cell has a couple of "features" that should be exposed to userland
> in a way or another. That raises some questions however about how those
> should be done. Among others that come to mind:
> 
>  - The timebase errata (should we use a separate aux vector for "bugs"
> than for "features" ?

Is this bug really going to be exposed in the wild or is it
an early silicon bug that will only bite early-testers?

>  - Additional Altivec instructions (load/store right/left). A new
> feature bit for these ?

Yes. So IBM was not happy with Altivec instructions to generate
vsel control words and got their inspiration from MIPS?

>  - Lack of data stream instructions. Until now, it was assumed that
> those were tied to the presence
>    of an Altivec (and they are documented in the Altivec manual). Maybe
> we should split that to a
>    new bit. I don't know if existing applications use them though, if
> they do, there will be a 
>    problem to get them updated as the new bit isn't present on older
> kernels...

Is it really important? These instructions become nop on Cell, so their
impact on performance should be minimal while they may be useful in
code designed to run on any processor having Altivec.

>  - Extended implementation of dcbt. (Another bit ? Or sould we just have
> a "CELL" bit ? In which
>    case should it cover the altivec additions too or are those likely to
> exist in future non-Cell 
>    processors ?)

I believe that a Cell bit would be useful. After all you need a bit
that tell you that you have the SPUs and related infrastructure?

>  - Not strictly Cell specific but we currently don't expose the support
> for optional instructions
>    fres and frsqte (which are supported by Cell)

Should be exposed IMHO. But these instructions have been present
in a lot of PPC processors AFAIR, they are in my original 603 and
604 manuals from 1994 (fsel is also marked as optional and is not
implemented on the 601, but I'm not sure it's really supported
anymore). I don't know about Power processors. 

> Part of the problem is that we only have 32 userland feature bits and
> for some reason decided to put the microarchitecture in there, thus we
> are running out fast...

It will have to be extended and perhaps become a variable length
structure, better sooner than later.

	Regards,
	Gabriel
