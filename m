Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42HKHb4LyLzF2QG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2018 15:47:38 +1000 (AEST)
Date: Sat, 22 Sep 2018 00:45:16 -0500
From: Scott Wood <oss@buserror.net>
To: David Lamparter <equinox@diac24.net>
Cc: Scott Wood <swood@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 York Sun <york.sun@nxp.com>
Message-ID: <20180922054516.GA19015@home.buserror.net>
References: <20180920224856.GJ487685@eidolon.nox.tf>
 <1537489893.7689.38.camel@redhat.com>
 <20180921010019.GL487685@eidolon.nox.tf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180921010019.GL487685@eidolon.nox.tf>
Subject: Re: [PATCH ppc-next] powerpc/fsl-booke: don't load early TLB at once
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 21, 2018 at 03:00:19AM +0200, David Lamparter wrote:
> On Thu, Sep 20, 2018 at 07:31:33PM -0500, Scott Wood wrote:
> > Do you have a JTAG that can be used to find out where it's hanging?  If
> > not, I can try to get early debug working (needs an early IOMMU mapping).

s/IOMMU mapping/MMU mapping for MMIO/ :-P

> I only have JTAG tools for ARM chips available; hardware wise I could
> probably solder up an adapter but software wise I have absoutely no clue
> how to fire up a session on anything PPC...  I'm a novice openocd user,
> that's it.
> 
> > York, can you try booting the latest kernel on p4080ds?
> 
> d9e1831a42 has been around for quite some time, 4.4 already has it.  I
> was a bit surprised noone has run into this, but then again P4080 is not
> exactly the most recent/interesting hardware.

I don't suppose you're running a relocatable kernel at a non-zero
address, and/or are running in an environment that sets
HID0[EN_L2MMU_MHD] (neither standard U-boot nor Linux sets this bit,
though they probably should)?  On 32-bit, we're already running in an AS1
trampoline when loadcam_multi() is called, but loadcam_multi() sets up
its own.  This happens to not be catastrophic in standard scenarios, but
it does add a duplicate TLB entry, and we return to AS0 sooner than
expected.  I think your patch, plus ifdefs to make the change 32-bit
only, is the appropriate fix.

I also got an earlier udbg for e500 working (and happened to decide to
test it with a relocatable kernel); I'll send that out once I've cleaned
it up (or sooner with the extra TLB dumping included if the above doesn't
explain why you're hitting this bug).

-Scott
