Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1C251B70A8
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jul 2010 06:54:28 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o62Ks9Xl015276
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jul 2010 13:54:19 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o62L5oEx010325
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jul 2010 16:05:50 -0500 (CDT)
Message-ID: <4C2E51F0.8060208@freescale.com>
Date: Fri, 02 Jul 2010 15:54:08 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: sandeep.kumar@freescale.com
Subject: Re: [PATCH] powerpc: introduce basic support for the Freescale P1022DS
	reference board
References: <1277847274-24648-1-git-send-email-timur@freescale.com>
	<20100629171904.d6ae6233.kim.phillips@freescale.com>
In-Reply-To: <20100629171904.d6ae6233.kim.phillips@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sandeep,

I believe you are the author of the code that adds multiple queue and
multiple group support to the Gianfar driver.  Can you update
Documentation/powerpc/dts-bindings/fsl/tsec.txt with the binding
documentation for these nodes, so that we can all know what they're supposed
to look like?

Kim Phillips wrote:

>> +		enet0: ethernet@B0000 {
>> +			queue-group@0{
>> +				#address-cells = <1>;
>> +				#size-cells = <1>;
>> +				reg = <0xB0000 0x1000>;
>> +				fsl,rx-err-int-map = <0xAA>;
>> +				fsl,tx-int-map = <0xAA>;
>> +				interrupts = <29 2 30 2 34 2>;
>> +			};
>> +			queue-group@1{
>> +				#address-cells = <1>;
>> +				#size-cells = <1>;
>> +				reg = <0xB4000 0x1000>;
>> +				fsl,rx-err-int-map = <0x55>;
>> +				fsl,tx-int-map = <0x55>;
>> +				interrupts = <17 2 18 2 24 2>;
>> +			};
>> +		};
>> +
>> +		enet1: ethernet@B1000 {
> 
>> +			queue-group@0{
>> +				#address-cells = <1>;
>> +				#size-cells = <1>;
>> +				reg = <0xB1000 0x1000>;
>> +				fsl,rx-err-int-map = <0xAA>;
>> +				fsl,tx-int-map = <0xAA>;
>> +				interrupts = <35 2 36 2 40 2>;
>> +			};
>> +			queue-group@1{
>> +				#address-cells = <1>;
>> +				#size-cells = <1>;
>> +				reg = <0xB5000 0x1000>;
>> +				fsl,rx-err-int-map = <0x55>;
>> +				fsl,tx-int-map = <0x55>;
>> +				interrupts = <51 2 52 2 67 2>;
>> +			};
> 
> these queue-group nodes, fsl,{r,t}x-* properties...
> 
>> +		crypto@30000 {
> 
>> +			fsl,multi-host-mode = "dual";
>> +			fsl,channel-remap = <0x3>;
> 
> and the above two properties aren't supported by their respective
> drivers, nor are they listed in the dts bindings documentation.
> 
> Kim
