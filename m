Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C12D1A0239
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 12:51:12 +1000 (AEST)
Message-ID: <1439866271.1763.5.camel@ellerman.id.au>
Subject: Re: [PATCH 2/2] ppc64: Add a flag to tell the kernel it's booting
 from kexec
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Cc: Simon Horman <horms@verge.net.au>, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org
Date: Tue, 18 Aug 2015 12:51:11 +1000
In-Reply-To: <1439837987.15601.29.camel@freescale.com>
References: <1437249439-31496-1-git-send-email-scottwood@freescale.com>
 <1437249439-31496-2-git-send-email-scottwood@freescale.com>
 <1439837987.15601.29.camel@freescale.com>
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

On Mon, 2015-08-17 at 13:59 -0500, Scott Wood wrote:
> On Sat, 2015-07-18 at 14:57 -0500, Scott Wood wrote:
> > It needs to know this because the SMP release mechanism for Freescale
> > book3e is different from when booting with normal hardware.  In theory
> > we could simulate the normal spin table mechanism, but not (easily) at
> > the addresses U-Boot put in the device tree -- so there'd need to be
> > even more communication between the kernel and kexec to set that up.
> > Since there's already a similar flag being set (for kdump only), this
> > seemed like a reasonable approach.
> > 
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > ---
> >  kexec/arch/ppc64/kexec-elf-ppc64.c | 11 ++++++++++-
> >  kexec/arch/ppc64/kexec-ppc64.h     |  2 ++
> >  purgatory/arch/ppc64/v2wrap.S      | 11 +++++++++++
> >  3 files changed, 23 insertions(+), 1 deletion(-)
> 
> Any comment on these two patches?

We should probably reserve 0x58 in the kernel's head_64.S too?

cheers
