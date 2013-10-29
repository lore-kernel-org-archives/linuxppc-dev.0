Return-Path: <B32579@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 20C042C0199
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 14:40:43 +1100 (EST)
Message-ID: <526F2E18.20501@freescale.com>
Date: Tue, 29 Oct 2013 09:10:08 +0530
From: Prabhakar Kushwaha <prabhakar@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2][v8] powerpc/mpc85xx:Add initial device tree support
 of T104x
References: <1380771865-2534-1-git-send-email-prabhakar@freescale.com>	
 <5264A161.6030803@freescale.com>
 <1383009085.3410.46.camel@snotra.buserror.net>
In-Reply-To: <1383009085.3410.46.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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


On 10/29/2013 6:41 AM, Scott Wood wrote:
> On Mon, 2013-10-21 at 09:07 +0530, Prabhakar Kushwaha wrote:
>> Hi Ben,
>>
>> This patch is present in upstream review list from a long time.
>> There are no review comments.
>>
>> So, I request you to pick this patch-set for powerpc.git repository.
>> http://patchwork.ozlabs.org/patch/280207/
>> http://patchwork.ozlabs.org/patch/280208/
> This revision has only been posted for about 2.5 weeks.
>
>>> +		#address-cells = <1>;
>>> +		#size-cells = <1>;
>>> +		pll0: pll0@800 {
>>> +			#clock-cells = <1>;
>>> +			reg = <0x800 4>;
>>> +			compatible = "fsl,qoriq-core-pll-2.0";
>>> +			clocks = <&clockgen>;
>>> +			clock-output-names = "pll0", "pll0-div2", "pll0-div4";
>>> +		};
>>> +		pll1: pll1@820 {
>>> +			#clock-cells = <1>;
>>> +			reg = <0x820 4>;
>>> +			compatible = "fsl,qoriq-core-pll-2.0";
>>> +			clocks = <&clockgen>;
>>> +			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
>>> +		};
>>> +		mux0: mux0@0 {
>>> +			#clock-cells = <0>;
>>> +			reg = <0x0 4>;
>>> +			compatible = "fsl,core-mux-clock";
>>> +			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
>>> +				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
>>> +			clock-names = "pll0_0", "pll0_1", "pll0_2",
>>> +				"pll1_0", "pll1_1", "pll1_2";
>>> +			clock-output-names = "cmux0";
>>> +		};
> The clock bindings are still under discussion.

I think, I should wait for clock bindings discussion :(

>>> +++ b/arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi
>>> @@ -0,0 +1,106 @@
>>> +/*
>>> + * T1040/T1042 Silicon/SoC Device Tree Source (pre include)
>>> + *
>>> + * Copyright 2013 Freescale Semiconductor Inc.
>>> + *
>>> + * Redistribution and use in source and binary forms, with or without
>>> + * modification, are permitted provided that the following conditions are met:
>>> + *     * Redistributions of source code must retain the above copyright
>>> + *	 notice, this list of conditions and the following disclaimer.
>>> + *     * Redistributions in binary form must reproduce the above copyright
>>> + *	 notice, this list of conditions and the following disclaimer in the
>>> + *	 documentation and/or other materials provided with the distribution.
>>> + *     * Neither the name of Freescale Semiconductor nor the
>>> + *	 names of its contributors may be used to endorse or promote products
>>> + *	 derived from this software without specific prior written permission.
>>> + *
>>> + *
>>> + * ALTERNATIVELY, this software may be distributed under the terms of the
>>> + * GNU General Public License ("GPL") as published by the Free Software
>>> + * Foundation, either version 2 of that License or (at your option) any
>>> + * later version.
>>> + *
>>> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
>>> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
>>> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
>>> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
>>> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
>>> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
>>> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
>>> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
>>> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
>>> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +/include/ "e5500_power_isa.dtsi"
>>> +
>>> +/ {
>>> +	compatible = "fsl,T104x";
> No wildcards in compatibles.  If your response is that this will get
> overwritten anyway, then why have compatible here at all?

I will take care of this

>>> +		crypto = &crypto;
>>> +
>>> +	};
> No blank lines before a closing brace.
>
>

I will take care of this.

Thanks,
Prabhakar
