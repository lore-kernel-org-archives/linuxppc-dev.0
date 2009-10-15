Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F883B7B68
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Oct 2009 16:33:09 +1100 (EST)
Subject: powerpc problem with .data.page_aligned -> __page_aligned_data
	conversion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: tabbott@ksplice.com
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 15 Oct 2009 16:32:52 +1100
Message-Id: <1255584772.2347.86.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, sam@ravnborg.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi folks !

So I have a problem ... :-)

For some weird reason, our gcc until 4.3 (fixed in 4.3) had the weird
idea that the alignment attribute should not be allowed to force an
alignment greater than 32k. If attempted, it would warn -and- crop the
alignment to 32k.

As you can imagine, this doesn't play terribly well with 64K page size,
which is (sadly) our default on ppc64 on distros nowadays. I know it's
insane but that's what I have to live with...

And of course, our current distros (well, at least RHEL5 which is pretty
common) don't have a fixed gcc.

Until recently, we got away with it because very few people used
__page_aligned and those who did always did it on something that is
naturally a PAGE_SIZE multiple in size. So we just stick the thing into
the appropriate section and that's it.

The new generic macros __page_aligned_data/bss now always add the
alignment directive generically.

This has a few issues for us:

	- The patch that converted bits of powerpc to the new macro break since
it now hits that bug

	- We can't trivially change the macros to not to the align directive on
powerpc, but that's taking the risk that drivers or other pieces of
generic code now assume that they can use __page_aligned_* on a data
structure whose size isn't a multiple of _PAGE_SIZE, since that would
work on all architectures ... except powerpc where it would silently
break by shifting everybody else alignment in that section.

As of today, nothing seems to do that (unless I mis-grepped) though.

What do you recommend I do ? I can ban gcc < 4.3 but that's a bit
harsh :-) I know a few people that won't be happy to be unable to build
newer kernels with current distro gccs.

Or can do the above making the macro definition drop the alignment part
on powerpc. Will work for now, but will require great care to avoid
subtle and nasty breakage (basically same as before)

Or maybe I can do the above but only when using gcc < 4.3 so at least if
the breakage happen, that will only be with older gccs ...

Unless somebody has a better idea ?

Cheers,
Ben.
