Return-Path: <arnd@arndb.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D7D71A0B12
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 06:43:14 +1100 (AEDT)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6B97D1400D5
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2014 06:43:12 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Emil Medve <Emilian.Medve@freescale.com>
Subject: Re: [PATCH v3 3/4] powerpc/mpc85xx: Add FSL QorIQ DPAA BMan support
 to device tree(s)
Date: Wed, 03 Dec 2014 20:42:50 +0100
Message-ID: <7923839.hEiWgLtlCl@wuerfel>
In-Reply-To: <547EC183.2070005@Freescale.com>
References: <1417428135-12895-1-git-send-email-Emilian.Medve@Freescale.com>
 <1417566777.15957.227.camel@freescale.com> <547EC183.2070005@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: devicetree@vger.kernel.org, Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Geoff Thorpe <Geoff.Thorpe@freescale.com>, linuxppc-dev@ozlabs.org,
 Scott Wood <scottwood@freescale.com>, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 03 December 2014 01:53:39 Emil Medve wrote:
> On 12/02/2014 06:32 PM, Scott Wood wrote:
> > On Mon, 2014-12-01 at 04:02 -0600, Emil Medve wrote:
> >> diff --git a/arch/powerpc/boot/dts/t4240rdb.dts b/arch/powerpc/boot/dts/t4240rdb.dts
> >> index 53761d4..431bf4e 100644
> >> --- a/arch/powerpc/boot/dts/t4240rdb.dts
> >> +++ b/arch/powerpc/boot/dts/t4240rdb.dts
> >> @@ -69,10 +69,27 @@
> >>              device_type = "memory";
> >>      };
> >>  
> >> +    reserved-memory {
> >> +            #address-cells = <2>;
> >> +            #size-cells = <2>;
> >> +            ranges;
> >> +
> >> +            bman_fbpr: bman-fbpr {
> >> +                    compatible = "fsl,bman-fbpr";
> >> +                    alloc-ranges = <0 0 0xffff 0xffffffff>;
> >> +                    size = <0 0x1000000>;
> >> +                    alignment = <0 0x1000000>;
> >> +            };
> >> +    };
> > 
> > Can't this be done at the SoC level rather than board level?
> 
> The size of the memory is not SoC specific. Among other things is
> determined by the number of MACs that are pinned-out on the board
> 

Is this really a hardware property then, or some setting?

Also, if you use the name 'ranges', I would assume that the second
set of two cells is a length and should be <0 0 0x10000 0>.

Finally, you add a label here, so anything that is not board
specific could just stay in the per-soc file, with the board
specific properties added at teh board level.

	Arnd
