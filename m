Return-Path: <B45939@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 25BD32C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 20:31:10 +1000 (EST)
Message-ID: <524169E3.7030408@freescale.com>
Date: Tue, 24 Sep 2013 18:30:59 +0800
From: Hongbo Zhang <hongbo.zhang@freescale.com>
MIME-Version: 1.0
To: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v10 2/3] DMA: Freescale: Add new 8-channel DMA engine
 device tree nodes
References: <1379499333-4745-1-git-send-email-hongbo.zhang@freescale.com>
 <1379499333-4745-3-git-send-email-hongbo.zhang@freescale.com>
 <524074A7.7000001@wwwdotorg.org>
In-Reply-To: <524074A7.7000001@wwwdotorg.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ian.campbell@citrix.com,
 pawel.moll@arm.com, vinod.koul@intel.com, linux-kernel@vger.kernel.org,
 rob.herring@calxeda.com, djbw@fb.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/24/2013 01:04 AM, Stephen Warren wrote:
> On 09/18/2013 04:15 AM, hongbo.zhang@freescale.com wrote:
>> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>>
>> Freescale QorIQ T4 and B4 introduce new 8-channel DMA engines, this patch adds
>> the device tree nodes for them.
>> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt b/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
>> +Required properties:
>> +
>> +- compatible        : must include "fsl,elo3-dma"
>> +- reg               : DMA General Status Registers, i.e. DGSR0 which contains
>> +                      status for channel 1~4, and DGSR1 for channel 5~8
> Is that a single entry, which is large enough to cover both registers,
> or a pair of entries, one per register? Reading the text, I might assume
> the former, but looking at the examples, it's the latter.
My impression is that I cannot tell it is one larger entry or two 
entries by reading the description text, but the example gives the answer.
Is it so important to specify it is only one entry or entries list?
I prefer language as concise as possible, especially for the common 
properties such as reg and interrupt (eg the reg is implicitly offset 
and length of registers, can be continuous or not), it is difficult or 
unnecessary or impossible to describe much details, the example can also 
work as a complementary description, otherwise no need to put an example 
in the binding document.

> ...
>   +Example:
>> +dma@100300 {
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +	compatible = "fsl,elo3-dma";
>> +	reg = <0x100300 0x4>,
>> +	      <0x100600 0x4>;
>
