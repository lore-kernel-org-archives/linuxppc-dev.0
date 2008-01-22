Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1A236DDF60
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 09:02:42 +1100 (EST)
Message-Id: <FE3EA513-0531-422C-B35D-918E5EBD93EB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <4796605B.2000807@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] Add docs for Freescale DMA & DMA channel device
	tree nodes
Date: Tue, 22 Jan 2008 16:02:22 -0600
References: <Pine.LNX.4.64.0801221511540.24873@blarg.am.freescale.net>
	<4796605B.2000807@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 22, 2008, at 3:30 PM, Timur Tabi wrote:

> Kumar Gala wrote:
>> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
>> Signed-off-by: Ebony Zhu <ebony.zhu@freescale.com>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>> Guys please review and make sure I got all your previous comments  
>> fixed
>> up.  I've added cell-index. and the examples should represent real  
>> HW.
>> Documentation/powerpc/booting-without-of.txt |  128 ++++++++++++++++ 
>> ++++++++++
>> 1 files changed, 128 insertions(+), 0 deletions(-)
>> diff --git a/Documentation/powerpc/booting-without-of.txt b/ 
>> Documentation/powerpc/booting-without-of.txt
>> index da98154..3584c33 100644
>> --- a/Documentation/powerpc/booting-without-of.txt
>> +++ b/Documentation/powerpc/booting-without-of.txt
>> @@ -2615,6 +2615,134 @@ platforms are moved over to use the  
>> flattened-device-tree model.
>>        - clock-frequency  : The frequency of the input clock, which  
>> typically
>>                             comes from an on-board dedicated  
>> oscillator.
>> +    * Freescale 83xx DMA Controller
>> +
>> +    Freescale PowerPC 83xx have on chip general purpose DMA  
>> controllers.
>> +
>> +    Required properties:
>> +
>> +    - compatible        : compatible list, contains 2 entries,  
>> first is
>> +			 "fsl,CHIP-dma", where CHIP is the processor
>> +			 (mpc8349, mpc8360, etc.) and the second is
>> +			 "fsl,elo-dma"
>> +    - reg               : <registers mapping for DMA general  
>> status reg>
>> +    - ranges 		: Should be defined as specified in 1) to describe  
>> the
>> +			  DMA controller channels.
>
> What does "Should be defined as specified in 1)" mean?

Its referring to section 1 of the doc on ranges.  Other nodes use this  
description for ranges. (soc, muram)

>> +    - cell-index        : controller index.  0 for controller @  
>> 0x8100
>
> This should be more generic.  I believe for each of our SoCs, we  
> designation one DMA controller to be "DMA Controller 1", and that  
> one should have a cell-index of "0".

Ok, on 83xx that controller is always at offset 0x8100.

- k
