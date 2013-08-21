Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 535D12C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 09:12:59 +1000 (EST)
Message-ID: <52154976.2010204@wwwdotorg.org>
Date: Wed, 21 Aug 2013 17:12:54 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v7 1/3] DMA: Freescale: revise device tree binding document
References: <1375094944-3343-1-git-send-email-hongbo.zhang@freescale.com>
 <1375094944-3343-2-git-send-email-hongbo.zhang@freescale.com>
 <5215402E.70007@wwwdotorg.org> <1377125156.5029.40.camel@snotra.buserror.net>
In-Reply-To: <1377125156.5029.40.camel@snotra.buserror.net>
Content-Type: text/plain; charset=UTF-8
Cc: devicetree@vger.kernel.org, hongbo.zhang@freescale.com,
 linux-kernel@vger.kernel.org, vinod.koul@intel.com, djbw@fb.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/21/2013 04:45 PM, Scott Wood wrote:
> On Wed, 2013-08-21 at 16:33 -0600, Stephen Warren wrote:
>> On 07/29/2013 04:49 AM, hongbo.zhang@freescale.com wrote:
>>> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>>>
>>> This patch updates the discription of each type of DMA controller and its
>>> channels, it is preparation for adding another new DMA controller binding, it
>>> also fixes some defects of indent for text alignment at the same time.
>>
>>> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt b/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
>>
>>> -- compatible        : compatible list, contains 2 entries, first is
>>> -		 "fsl,CHIP-dma", where CHIP is the processor
>>> -		 (mpc8349, mpc8360, etc.) and the second is
>>> -		 "fsl,elo-dma"
>>> +- compatible        : must include "fsl,elo-dma"
>>
>> Why remove the list of supported compatible values. Lately it seems that
>> we're moving towards listing more/all the values rather than removing
>> their documentation...
> 
> Previous versions had language that required fsl,CHIP-dma for 83xx (and
> maybe 85xx?) but not the new chip.  I asked for it to be consistent.
> The reason that 83xx still has fsl,CHIP-dma is not because of anything
> special to 83xx, but that most other chips with this device have been
> converted to dtsi and it's much more of a pain to specify the specific
> SoC in that context.  The existing language does not match actual device
> trees when it comes to 85xx.
> 
> Plus, the exact SoC name is of dubious value for integrated devices.  It
> doesn't uniquely identify the hardware because different versions of the
> SoC could have different versions of the subdevice.  As such, on our
> chips we've been moving away from including a compatible that specifies
> the exact SoC.  If it turns out we made a mistake in naming different
> versions of the device, or if there are errata, the exact SoC can still
> be determined at runtime using SVR.

OK, if there's some alternative run-time way of enabling chip-specific
quirking, it's probably fine to remove the extra compatible values.

Now, that does rather assume that this DMA IP block will only ever be
used within SoCs that have that SVR concept, but perhaps if that's ever
not the case, we can simply go back to requiring extra compatible values
in those specific cases?
