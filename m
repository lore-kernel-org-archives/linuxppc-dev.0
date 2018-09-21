Return-Path: <swood@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GZKT2xxTzF3P5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 10:31:37 +1000 (AEST)
Message-ID: <1537489893.7689.38.camel@redhat.com>
Subject: Re: [PATCH ppc-next] powerpc/fsl-booke: don't load early TLB at once
From: Scott Wood <swood@redhat.com>
To: David Lamparter <equinox@diac24.net>, linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <oss@buserror.net>, York Sun <york.sun@nxp.com>
Date: Thu, 20 Sep 2018 19:31:33 -0500
In-Reply-To: <20180920224856.GJ487685@eidolon.nox.tf>
References: <20180920224856.GJ487685@eidolon.nox.tf>
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

On Fri, 2018-09-21 at 00:48 +0200, David Lamparter wrote:
> This is a *partial* revert of "powerpc/85xx: Load all early TLB entries
> at once" (d9e1831a420267a7ced708bb259d65b0a3c0344d.)
> 
> My dusty old P4080DS just completely fails to boot (no output at all)
> without this revert.  I have no clue what's going on here, I just
> bisected it down and since it looks like an optimization to me I just
> reverted it - and voilá, the P4080 boots again.

It's not an optimization; it was required to get kdump working, at least
for certain choices of crash kernel location.  I just tried booting a 32-
bit kernel and did not see this problem -- but I don't have access to a
p4080ds anymore.  I tried with qemu e500mc, and also running a 32-bit
kernel on e6500 (needs a tiny change to get past SMP init, since 32-bit
isn't really supported on e6500, but you do get output even without that).

Do you have a JTAG that can be used to find out where it's hanging?  If
not, I can try to get early debug working (needs an early IOMMU mapping).

York, can you try booting the latest kernel on p4080ds?

-Scott
