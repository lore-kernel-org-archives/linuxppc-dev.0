Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0212.outbound.protection.outlook.com [207.46.163.212])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 90D032C007A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Dec 2013 05:37:32 +1100 (EST)
Message-ID: <1387219034.10013.360.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/5] powerpc/85xx/dts: add third elo3 dma component
From: Scott Wood <scottwood@freescale.com>
To: Hongbo Zhang <hongbo.zhang@freescale.com>
Date: Mon, 16 Dec 2013 12:37:14 -0600
In-Reply-To: <52AEC40C.6000008@freescale.com>
References: <1386760774-14743-1-git-send-email-Shengzhou.Liu@freescale.com>
 <52A9887D.3060109@freescale.com>
 <ae3fab730b4a45c0812d3ca5a89fce52@DM2PR03MB398.namprd03.prod.outlook.com>
 <52AEC40C.6000008@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Liu Shengzhou-B36685 <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-12-16 at 17:12 +0800, Hongbo Zhang wrote:
> On 12/13/2013 01:43 PM, Liu Shengzhou-B36685 wrote:
> >
> >> -----Original Message-----
> >> From: Hongbo Zhang [mailto:hongbo.zhang@freescale.com]
> >> Sent: Thursday, December 12, 2013 5:57 PM
> >> To: Liu Shengzhou-B36685; linuxppc-dev@lists.ozlabs.org; Wood Scott-
> >> B07421
> >> Subject: Re: [PATCH 1/5] powerpc/85xx/dts: add third elo3 dma component
> >>
> >> Shengzhou,
> >> I canceled my patch http://patchwork.ozlabs.org/patch/295157/ because the
> >> original wrong elo3-dma-2.dtsi hadn't been merged.
> >> But please pay attention to comments from Scott about my changes of
> >> adding 208 for some interrupts, and take some actions if needed, or
> >> further discussions.
> >>
> >> Below comments form Scott:
> >> "The FSL MPIC binding should be updated to point out how this works.
> >> Technically it's not a change to the binding itself, since it's defined
> >> in terms of register offset, but the explanatory text says "So interrupt
> >> 0 is at offset 0x0, interrupt 1 is at offset 0x20, and so on." which is
> >> not accurate for these new high interrupt numbers."
> >>
> > Hongbo,
> > Could you update FSL MPIC binding as Scott pointed out?
> 
> We only need to add more explanatory text after the sentence Scott 
> pointed out, like:
> "But for some hardwares, the MPIC registers for interrupts are not 
> continuous in address,  in such cases, an offset can be added to the 
> interrupt number to skip the registers which is not for interrupts."
> 
> Scott, is that OK?

Actually, I misread what that sentence actually says, and it's correct
as is -- but not as helpful as it could be.

I'd add this new paragraph instead:

For example, internal interrupt 0 is at offset 0x200 and thus is
interrupt 16 in the device tree.  MSI bank A interrupt 0 is at offset
0x1c00, and thus is interrupt 224.  MPIC v4.3 adds a new discontiguous
address range for internal interrupts, so internal interrupt 160 is at
offset 0x3000, and thus is interrupt 384.

-Scott
