Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 160BF1A1FC7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 21:31:36 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0142.outbound.protection.outlook.com [157.56.110.142])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EB06E1400F1
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2014 21:31:34 +1100 (AEDT)
Message-ID: <5469CE79.7090406@Freescale.com>
Date: Mon, 17 Nov 2014 04:31:21 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@Freescale.com>
Subject: Re: [PATCH 2/2] powerpc/mpc85xx: Add DPAA Q/BMan support to device
 tree(s)
References: <1415870513-10632-1-git-send-email-Emilian.Medve@Freescale.com>
 <1415914923.15957.64.camel@freescale.com>
In-Reply-To: <1415914923.15957.64.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, Geoff Thorpe <Geoff.Thorpe@Freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@Freescale.com>,
 Chunhe Lan <Chunhe.Lan@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,


On 11/13/2014 03:42 PM, Scott Wood wrote:
> On Thu, 2014-11-13 at 03:21 -0600, Emil Medve wrote:
>> From: Kumar Gala <galak@kernel.crashing.org>
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>
>> Signed-off-by: Hai-Ying Wang <Haiying.Wang@freescale.com>
>> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
>> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
>> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
>> Change-Id: If643fa5ba0a903aef8f5056a2c90ebecc995b760
> 
> I suspect these patches are changed quite a bit from Kumar's version...

Across SDK releases I've been trying retain the authors names and the
'Signed-off-by' list is the only place that can accommodate them all.
Kumar is the first author, and besides this exercise the most significant

> It's good to note changes after the listed author has stopped being
> involved, so they don't get the blame for anything they wouldn't have
> put in there.

Bah. Most of the sordid history is lost

> Why is the devicetree list not CCed?

For no good reason. Will add it for the next version

>> diff --git a/arch/powerpc/boot/dts/b4qds.dtsi b/arch/powerpc/boot/dts/b4qds.dtsi
>> index 6188583..48c3fb4 100644
>> --- a/arch/powerpc/boot/dts/b4qds.dtsi
>> +++ b/arch/powerpc/boot/dts/b4qds.dtsi
>> @@ -1,7 +1,7 @@
>>  /*
>>   * B4420DS Device Tree Source
>>   *
>> - * Copyright 2012 Freescale Semiconductor, Inc.
>> + * Copyright 2012 - 2014 Freescale Semiconductor, Inc.
>>   *
>>   * Redistribution and use in source and binary forms, with or without
>>   * modification, are permitted provided that the following conditions are met:
>> @@ -38,6 +38,7 @@
>>  	#address-cells = <2>;
>>  	#size-cells = <2>;
>>  	interrupt-parent = <&mpic>;
>> +	reserved-ranges;
> 
> I don't see reserved-ranges documented anywhere,

Some digging through the git log will add some context to it

> and from the code in arch/powerpc I don't see how it has any effect
> when empty.

When I first wrote these nodes there was a bug that got fixed since
here: 'edba274 powerpc: fix skipping call to
early_init_fdt_scan_reserved_mem'. I'll remove the property in the next
version of the patch

>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		bman_fbpr: bman-fbpr {
>> +			compatible = "fsl,bman-fbpr";
>> +			alloc-ranges = <0 0 0xffff 0xffffffff>;
>> +			size = <0 0x1000000>;
>> +			alignment = <0 0x1000000>;
>> +			no-map;
>> +			reusable;
>> +		};
>> +		qman_fqd: qman-fqd {
>> +			compatible = "fsl,qman-fqd";
>> +			alloc-ranges = <0 0 0xffff 0xffffffff>;
>> +			size = <0 0x400000>;
>> +			alignment = <0 0x400000>;
>> +			no-map;
>> +			reusable;
>> +		};
>> +		qman_pfdr: qman-pfdr {
>> +			compatible = "fsl,qman-pfdr";
>> +			alloc-ranges = <0 0 0xffff 0xffffffff>;
>> +			size = <0 0x2000000>;
>> +			alignment = <0 0x2000000>;
>> +			no-map;
>> +			reusable;
>> +		};
>> +	};
> 
> no-map and reusable don't make sense together.  How can the OS reuse the
> memory if it can't map it?

Perhaps I've been reading/speculating(?) too much about it. Now granted
the code is still young (?), but in between "under the control of the
device driver using the region" and "the device driver(s) owning the
region need to be able to reclaim it back" it sort of made sense

> no-map is burdensome (and I believe not yet implemented) on mpc85xx,
> where we want to use huge TLB entries to cover all of (low) memory.  Is
> it really needed?

I'm thinking no-map would be part of having/making this reserved memory
into a different coherency domain then the... everything else

> What do we gain from specifying reusable here?

I guess the obvious of having this memory usable for something else when
the B/QMan drivers don't use it

> How is it actually supposed to work?

You mean how should one implement 'reusable'?

>> diff --git a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
>> index 86161ae..0f56263 100644
>> --- a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
>> +++ b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
>> @@ -1,7 +1,7 @@
>>  /*
>>   * B4420 Silicon/SoC Device Tree Source (post include)
>>   *
>> - * Copyright 2012 Freescale Semiconductor, Inc.
>> + * Copyright 2012 - 2014 Freescale Semiconductor, Inc.
>>   *
>>   * Redistribution and use in source and binary forms, with or without
>>   * modification, are permitted provided that the following conditions are met:
>> diff --git a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
>> index 338af7e..f392949 100644
>> --- a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
>> +++ b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
>> @@ -1,7 +1,7 @@
>>  /*
>>   * B4420 Silicon/SoC Device Tree Source (pre include)
>>   *
>> - * Copyright 2012 Freescale Semiconductor, Inc.
>> + * Copyright 2012 - 2014 Freescale Semiconductor, Inc.
>>   *
>>   * Redistribution and use in source and binary forms, with or without
>>   * modification, are permitted provided that the following conditions are met:
> 
> Why are you updating the copyright year on files you didn't change?

This leaked in here as I was splitting patches. I'll remove it here and
elsewhere


Cheers,
