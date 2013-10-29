Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DF30B2C012E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 12:11:33 +1100 (EST)
Message-ID: <1383009085.3410.46.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/2][v8] powerpc/mpc85xx:Add initial device tree support
 of T104x
From: Scott Wood <scottwood@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Date: Mon, 28 Oct 2013 20:11:25 -0500
In-Reply-To: <5264A161.6030803@freescale.com>
References: <1380771865-2534-1-git-send-email-prabhakar@freescale.com>
 <5264A161.6030803@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Varun Sethi <Varun.Sethi@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Priyanka Jain <Priyanka.Jain@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-10-21 at 09:07 +0530, Prabhakar Kushwaha wrote:
> Hi Ben,
> 
> This patch is present in upstream review list from a long time.
> There are no review comments.
> 
> So, I request you to pick this patch-set for powerpc.git repository.
> http://patchwork.ozlabs.org/patch/280207/
> http://patchwork.ozlabs.org/patch/280208/

This revision has only been posted for about 2.5 weeks.  

> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		pll0: pll0@800 {
> > +			#clock-cells = <1>;
> > +			reg = <0x800 4>;
> > +			compatible = "fsl,qoriq-core-pll-2.0";
> > +			clocks = <&clockgen>;
> > +			clock-output-names = "pll0", "pll0-div2", "pll0-div4";
> > +		};
> > +		pll1: pll1@820 {
> > +			#clock-cells = <1>;
> > +			reg = <0x820 4>;
> > +			compatible = "fsl,qoriq-core-pll-2.0";
> > +			clocks = <&clockgen>;
> > +			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
> > +		};
> > +		mux0: mux0@0 {
> > +			#clock-cells = <0>;
> > +			reg = <0x0 4>;
> > +			compatible = "fsl,core-mux-clock";
> > +			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
> > +				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
> > +			clock-names = "pll0_0", "pll0_1", "pll0_2",
> > +				"pll1_0", "pll1_1", "pll1_2";
> > +			clock-output-names = "cmux0";
> > +		};

The clock bindings are still under discussion.

> > +++ b/arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi
> > @@ -0,0 +1,106 @@
> > +/*
> > + * T1040/T1042 Silicon/SoC Device Tree Source (pre include)
> > + *
> > + * Copyright 2013 Freescale Semiconductor Inc.
> > + *
> > + * Redistribution and use in source and binary forms, with or without
> > + * modification, are permitted provided that the following conditions are met:
> > + *     * Redistributions of source code must retain the above copyright
> > + *	 notice, this list of conditions and the following disclaimer.
> > + *     * Redistributions in binary form must reproduce the above copyright
> > + *	 notice, this list of conditions and the following disclaimer in the
> > + *	 documentation and/or other materials provided with the distribution.
> > + *     * Neither the name of Freescale Semiconductor nor the
> > + *	 names of its contributors may be used to endorse or promote products
> > + *	 derived from this software without specific prior written permission.
> > + *
> > + *
> > + * ALTERNATIVELY, this software may be distributed under the terms of the
> > + * GNU General Public License ("GPL") as published by the Free Software
> > + * Foundation, either version 2 of that License or (at your option) any
> > + * later version.
> > + *
> > + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
> > + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
> > + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
> > + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
> > + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> > + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> > + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> > + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> > + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
> > + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +/include/ "e5500_power_isa.dtsi"
> > +
> > +/ {
> > +	compatible = "fsl,T104x";

No wildcards in compatibles.  If your response is that this will get
overwritten anyway, then why have compatible here at all?

> > +		crypto = &crypto;
> > +
> > +	};

No blank lines before a closing brace.

-Scott
