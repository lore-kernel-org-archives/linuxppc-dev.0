Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4260B1A0272
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 19:45:39 +1000 (AEST)
Message-ID: <1442483138.26748.4.camel@ellerman.id.au>
Subject: Re: Time to remove platforms/cell?
From: Michael Ellerman <mpe@ellerman.id.au>
To: Marc Dietrich <marvin24@gmx.de>
Cc: linuxppc-dev@lists.ozlabs.org, Geoff Levand <geoff@infradead.org>
Date: Thu, 17 Sep 2015 19:45:38 +1000
In-Reply-To: <2023345.Irprl084gX@fb07-iapwap2>
References: <1442467727.25483.0.camel@ellerman.id.au>
 <2023345.Irprl084gX@fb07-iapwap2>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-09-17 at 10:43 +0200, Marc Dietrich wrote:
> Am Donnerstag, 17. September 2015, 15:28:47 schrieb Michael Ellerman:
> > Discuss ...
> 
> as long as Geoff still maintains the ps3 port - why?

Because even if Geoff maintains the ps3 port, there's still a non-zero cost to
us for carrying the Cell code.

To be clear there's more to Cell than just ps3. The platforms/cell code is
mainly about supporting the IBM Cell Blades, as well as spufs, which is also
used on ps3.

See for example commit 74b5037baa20 ("powerpc/mm: Fix pte_pagesize_index()
crash on 4K w/64K hash"):

  https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?id=74b5037baa2011a2799e2c43adde7d171b072f9e

Which is a fix for crashes we were seeing on non-cell machines, caused by some
obscure code that was added for Cell. It took several of us a few days to track
that one down.

But the main motivation would just be to drop code that no one's using. From
December 2013 until April 2015 the Cell machines (not ps3) were broken in
mainline and no one noticed. I now have automated boot tests to prevent that
happening again, but it makes me think no one is using those machines much
anymore.


You also raise a good point, which is that ps3 is a separate platform, so we
could actually keep that but get rid of platforms/cell. If we did that we'd
need to move spufs out of platforms/cell though.

Looking at the code size:

	platforms/ps3	 	 6 KSLOC
	platforms/cell		11 KSLOC
	platforms/cell/spufs	 7 KSLOC
	other cell code		 2 KSLOC

So dropping platforms/cell but not ps3 would save us ~6 KSLOC.


Having said all that, this email was mainly a fishing expedition to see if
anyone still cares about Cell support at all. It sounds like you at least are
running mainline kernels on PS3?

cheers
