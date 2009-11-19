Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 13E75B6F0E
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 05:51:47 +1100 (EST)
Subject: Re: [PATCH v3 3/3] powerpc/fsl: 85xx: add cache-sram support
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091119174546.GB6845@b07421-ec1.am.freescale.net>
Date: Thu, 19 Nov 2009 12:51:38 -0600
Message-Id: <D88B1DB0-B4ED-4695-B81A-1A7C77B11A86@kernel.crashing.org>
References: <1256129459-10685-1-git-send-email-vivek.mahajan@freescale.com>
	<1256129459-10685-2-git-send-email-vivek.mahajan@freescale.com>
	<1256129459-10685-3-git-send-email-vivek.mahajan@freescale.com>
	<181208B7-AC0B-4634-A04E-46468D376719@freescale.com>
	<2B43D645-7977-4C24-A3EF-C55A392228B4@kernel.crashing.org>
	<20091119174546.GB6845@b07421-ec1.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Vivek Mahajan <vivek.mahajan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 19, 2009, at 11:45 AM, Scott Wood wrote:

> On Thu, Nov 19, 2009 at 08:29:19AM -0600, Kumar Gala wrote:
>>>> +config FSL_85XX_CACHE_SRAM_BASE
>>>> +	hex
>>>> +	depends on FSL_85XX_CACHE_SRAM
>>>> +	default "0xfff00000"
>>>> +
>>>
>>> I really don't like setting the physical address this way, can we
>>> not do this via the device tree?
>>
>> At a high level I think we should add something like the following in
>> the .dts:
>>
>> sram@fff00000 {
>> 	fsl,sram-ctrl-handle = <&L2>;
>> 	reg = <0xfff00000 0xNNNN>;
>> 	compatible = "fsl,mpc85xx-l2-sram";
>> }
>>
>> the NNNN can be the size the sram is configured as.
>
> I don't see why this needs to go in the device tree, if it's the  
> kernel
> that is setting it up.  The kernel can pick any address and size it
> wants.

It can, we just don't normally do physical address allocation in the  
kernel.  I just dont want it as a compile time thing.  Either .dts or  
make it runtime allocated by the kernel.

- k
