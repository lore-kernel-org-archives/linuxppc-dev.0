Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CCAE1A09FD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 15:04:22 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0145.outbound.protection.outlook.com [157.56.110.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 531661400D5
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2014 15:04:20 +1100 (AEDT)
Message-ID: <1417665850.15957.237.camel@freescale.com>
Subject: Re: [PATCH v3 3/4] powerpc/mpc85xx: Add FSL QorIQ DPAA BMan support
 to device tree(s)
From: Scott Wood <scottwood@freescale.com>
To: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 3 Dec 2014 22:04:10 -0600
In-Reply-To: <7923839.hEiWgLtlCl@wuerfel>
References: <1417428135-12895-1-git-send-email-Emilian.Medve@Freescale.com>
 <1417566777.15957.227.camel@freescale.com> <547EC183.2070005@Freescale.com>
 <7923839.hEiWgLtlCl@wuerfel>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Poonam
 Aggrwal <poonam.aggrwal@freescale.com>, Geoff
 Thorpe <Geoff.Thorpe@freescale.com>, Emil Medve <Emilian.Medve@freescale.com>,
 linuxppc-dev@ozlabs.org, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-12-03 at 20:42 +0100, Arnd Bergmann wrote:
> On Wednesday 03 December 2014 01:53:39 Emil Medve wrote:
> > On 12/02/2014 06:32 PM, Scott Wood wrote:
> > > On Mon, 2014-12-01 at 04:02 -0600, Emil Medve wrote:
> > >> diff --git a/arch/powerpc/boot/dts/t4240rdb.dts b/arch/powerpc/boot/dts/t4240rdb.dts
> > >> index 53761d4..431bf4e 100644
> > >> --- a/arch/powerpc/boot/dts/t4240rdb.dts
> > >> +++ b/arch/powerpc/boot/dts/t4240rdb.dts
> > >> @@ -69,10 +69,27 @@
> > >>              device_type = "memory";
> > >>      };
> > >>  
> > >> +    reserved-memory {
> > >> +            #address-cells = <2>;
> > >> +            #size-cells = <2>;
> > >> +            ranges;
> > >> +
> > >> +            bman_fbpr: bman-fbpr {
> > >> +                    compatible = "fsl,bman-fbpr";
> > >> +                    alloc-ranges = <0 0 0xffff 0xffffffff>;
> > >> +                    size = <0 0x1000000>;
> > >> +                    alignment = <0 0x1000000>;
> > >> +            };
> > >> +    };
> > > 
> > > Can't this be done at the SoC level rather than board level?
> > 
> > The size of the memory is not SoC specific. Among other things is
> > determined by the number of MACs that are pinned-out on the board
> > 

Oh, right.

> Is this really a hardware property then, or some setting?

It's sort of a gray area (as is the reserved-memory mechanism itself)...
The hardware technically allows software to choose the size of the
memory, but the size required to perform optimally is primarily
determined by the ethernet ports that are pinned out on a given board --
except for any extra memory required by accelerators.

I previously suggested an extension to the reserved-memory binding to
convey the fact that the region can potentially be sized differently:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-October/122300.html

In most cases the size calculated from the board's ethernet ports is
what is desired, so I think providing a sane default counts as hardware
description.

-Scott
