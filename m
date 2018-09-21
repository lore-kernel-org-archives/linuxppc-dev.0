Return-Path: <equinox@diac24.net>
Received: from eidolon.nox.tf (eidolon.nox.tf [IPv6:2a07:2ec0:2185::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GZyd2KV4zF3P6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 11:00:24 +1000 (AEST)
Date: Fri, 21 Sep 2018 03:00:19 +0200
From: David Lamparter <equinox@diac24.net>
To: Scott Wood <swood@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Scott Wood <oss@buserror.net>,
 York Sun <york.sun@nxp.com>
Subject: Re: [PATCH ppc-next] powerpc/fsl-booke: don't load early TLB at once
Message-ID: <20180921010019.GL487685@eidolon.nox.tf>
References: <20180920224856.GJ487685@eidolon.nox.tf>
 <1537489893.7689.38.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1537489893.7689.38.camel@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 20, 2018 at 07:31:33PM -0500, Scott Wood wrote:
> On Fri, 2018-09-21 at 00:48 +0200, David Lamparter wrote:
> > This is a *partial* revert of "powerpc/85xx: Load all early TLB entries
> > at once" (d9e1831a420267a7ced708bb259d65b0a3c0344d.)
> > 
> > My dusty old P4080DS just completely fails to boot (no output at all)
> > without this revert.  I have no clue what's going on here, I just
> > bisected it down and since it looks like an optimization to me I just
> > reverted it - and voilá, the P4080 boots again.
> 
> It's not an optimization; it was required to get kdump working, at least

Oh, my apologies for misunderstanding the code.

> for certain choices of crash kernel location.  I just tried booting a 32-
> bit kernel and did not see this problem -- but I don't have access to a
> p4080ds anymore.  I tried with qemu e500mc, and also running a 32-bit
> kernel on e6500 (needs a tiny change to get past SMP init, since 32-bit
> isn't really supported on e6500, but you do get output even without that).

Hrm, maybe I should just make it use the old mechanism under an #ifdef
CONFIG_PPC32?  Better to boot and have kdump not work than not boot.
(But obviously finding the actual problem would be best.)

> Do you have a JTAG that can be used to find out where it's hanging?  If
> not, I can try to get early debug working (needs an early IOMMU mapping).

I only have JTAG tools for ARM chips available; hardware wise I could
probably solder up an adapter but software wise I have absoutely no clue
how to fire up a session on anything PPC...  I'm a novice openocd user,
that's it.

> York, can you try booting the latest kernel on p4080ds?

d9e1831a42 has been around for quite some time, 4.4 already has it.  I
was a bit surprised noone has run into this, but then again P4080 is not
exactly the most recent/interesting hardware.

Cheers,


-David
