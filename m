Return-Path: <B32579@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 25E982C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 13:50:16 +1000 (EST)
Message-ID: <524A4664.7080008@freescale.com>
Date: Tue, 1 Oct 2013 09:19:56 +0530
From: Prabhakar Kushwaha <prabhakar@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2][v7] powerpc/mpc85xx:Add initial device tree support
 of T104x
References: <1380524042-13720-1-git-send-email-prabhakar@freescale.com>
 <1380570471.24959.517.camel@snotra.buserror.net>
In-Reply-To: <1380570471.24959.517.camel@snotra.buserror.net>
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

On 10/01/2013 01:17 AM, Scott Wood wrote:
> On Mon, 2013-09-30 at 12:24 +0530, Prabhakar Kushwaha wrote:
>>      - Removed l2switch. It will be added later
> Why?

I am not aware of bindings required for l2switch as we are not working 
on the driver.
Earlier I thought of putting a place holder. but as you suggested to put 
bindings in documentation.
it will require proper discussion this may delay the base patch acceptance.
so It will be good if it is put by actual driver owner.

>> +sata@220000 {
>> +			fsl,iommu-parent = <&pamu0>;
>> +			fsl,liodn-reg = <&guts 0x550>; /* SATA1LIODNR */
>> +};
>> +/include/ "qoriq-sata2-1.dtsi"
>> +sata@221000 {
>> +			fsl,iommu-parent = <&pamu0>;
>> +			fsl,liodn-reg = <&guts 0x554>; /* SATA2LIODNR */
>> +};
> Whitespace

do we have any scripts which check for whitespace as checkpatch never 
give any warning/error.
it is a very silly mistake which I am doing continuously :(

>> +/include/ "qoriq-sec5.0-0.dtsi"
>> +};
>> diff --git a/arch/powerpc/boot/dts/fsl/t1042si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1042si-post.dtsi
>> new file mode 100644
>> index 0000000..f286a50
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/fsl/t1042si-post.dtsi
>> @@ -0,0 +1,35 @@
>> +/*
>> + * T1042 Silicon/SoC Device Tree Source (post include)
>> + *
>> + * Copyright 2013 Freescale Semiconductor Inc.
>> + *
>> + * Redistribution and use in source and binary forms, with or without
>> + * modification, are permitted provided that the following conditions are met:
>> + *     * Redistributions of source code must retain the above copyright
>> + *       notice, this list of conditions and the following disclaimer.
>> + *     * Redistributions in binary form must reproduce the above copyright
>> + *       notice, this list of conditions and the following disclaimer in the
>> + *       documentation and/or other materials provided with the distribution.
>> + *     * Neither the name of Freescale Semiconductor nor the
>> + *       names of its contributors may be used to endorse or promote products
>> + *       derived from this software without specific prior written permission.
>> + *
>> + *
>> + * ALTERNATIVELY, this software may be distributed under the terms of the
>> + * GNU General Public License ("GPL") as published by the Free Software
>> + * Foundation, either version 2 of that License or (at your option) any
>> + * later version.
>> + *
>> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
>> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
>> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
>> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
>> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
>> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
>> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
>> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
>> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
>> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>> + */
>> +
>> +/include/ "t1040si-post.dtsi"
> Should at least have a comment indicating that eventually this should
> hold the l2 switch node.

yes. Ideally it should be.
but if i put a comment then I believe this patch will not be completed. 
it will think as a RFC.
as I believe putting of TODO is generally for RFC patches.

should I put comment without TODO?

>> +	aliases {
>> +		ccsr = &soc;
>> +		dcsr = &dcsr;
>> +
>> +		serial0 = &serial0;
>> +		serial1 = &serial1;
>> +		serial2 = &serial2;
>> +		serial3 = &serial3;
>> +		pci0 = &pci0;
>> +		pci1 = &pci1;
>> +		pci2 = &pci2;
>> +		pci3 = &pci3;
>> +		usb0 = &usb0;
>> +		usb1 = &usb1;
>> +		sdhc = &sdhc;
>> +
>> +		crypto = &crypto;
>> +
>> +	};
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
> [snip]
>> +			L2_4: l2-cache {
>> +				next-level-cache = <&cpc>;
>> +			};
>> +		};
>> +
>> +	};
>> +};
> Don't leave a blank line before a closing brace.
>
>
>
>    
>
My mistake. I will take care.

thanks,
Prabhakar
