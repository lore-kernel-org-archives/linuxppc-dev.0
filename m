Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 6BC84DDE29
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 02:01:13 +1000 (EST)
Subject: RE: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and
	Rev1.02hardware
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
In-Reply-To: <46B96294322F7D458F9648B60E15112C23466B@zch01exm26.fsl.freescale.net>
References: <1179245829.8132.100.camel@rhino> <1179247809.8132.138.camel@rhino>
	<46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>
	<1179417813.8132.250.camel@rhino>
	<744CD970-5421-47D6-A30A-C7C79BE21BE8@kernel.crashing.org>
	<1179421139.8132.256.camel@rhino>
	<46B96294322F7D458F9648B60E15112C23466B@zch01exm26.fsl.freescale.net>
Content-Type: text/plain
Date: Mon, 21 May 2007 09:01:11 -0700
Message-Id: <1179763271.8132.288.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-05-18 at 18:20 +0800, Zhang Wei-r63237 wrote:
> For support rev 1.0 boards, you can only remove the
> pci@00:pci@00:interrupt-map sector. The pci driver can use
> pci@8000:interrupt-map for irq mapping.
> 
> Such as below:
> 
> diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> index 260b264..04626b1 100644
> --- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> @@ -297,6 +297,12 @@
>  				interrupts = <49 2>;
>  				interrupt-parent = <&mpic>;
>  			};
> +			uli1575: uli1575@100 {
> +				reg = <0 0 0 0 0>;
> +				pci_bridge@200 {
> +					reg = <0 0 0 0 0>;
> +				};
> +			};
>  
>  		};
> 
> Cheers,
> Wei

Hmm.  For some reason I thought that wouldn't work, but after some
testing it appears I was wrong.  I'll incorporate that into the next
version of the patchset.

Thanks.

--Wade
