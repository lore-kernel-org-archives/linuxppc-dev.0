Return-Path: <tpearson@raptorengineering.com>
Received: from mail.rptsys.com (mail.rptsys.com [192.119.205.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41DWMd2NBjzF1DM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 11:11:08 +1000 (AEST)
Message-ID: <5B304127.7090308@raptorengineering.com>
Date: Sun, 24 Jun 2018 20:11:03 -0500
From: Timothy Pearson <tpearson@raptorengineering.com>
MIME-Version: 1.0
To: Russell Currey <ruscur@russell.cc>
CC: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/7] Add initial version of "cognitive DMA"
References: <1564865529.2569245.1529797922226.JavaMail.zimbra@raptorengineeringinc.com>
 <4b2ca540d0784bddd9e901fdd50eb73033290823.camel@russell.cc>
In-Reply-To: <4b2ca540d0784bddd9e901fdd50eb73033290823.camel@russell.cc>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When should we be targeting merge?  At this point this is a substantial
improvement over currently shipping kernels for our systems, and we
don't really want to have to ship a patched / custom OS kernel if we can
avoid it.

On 06/24/2018 08:09 PM, Russell Currey wrote:
> On Sat, 2018-06-23 at 18:52 -0500, Timothy Pearson wrote:
> 
> There's still more to do and this shouldn't be merged yet - would
> encourage anyone with suitable hardware to test though.
> 
>> POWER9 (PHB4) requires all peripherals using DMA to be either
>> restricted
>> to 32-bit windows or capable of accessing the entire 64 bits of
>> memory
>> space.  Some devices, such as most GPUs, can only address up to a
>> certain
>> number of bits (approximately 40, in many cases), while at the same
>> time
>> it is highly desireable to use a larger DMA space than the fallback
>> 32 bits.
>>
>> This series adds something called "cognitive DMA", which is a form of
>> dynamic
>> TCE allocation.  This allows the peripheral to DMA to host addresses
>> mapped in
>> 1G (PHB4) or 256M (PHB3) chunks, and is transparent to the peripheral
>> and its
>> driver stack.
>>
>> This series has been tested on a Talos II server with a Radeon WX4100
>> and
>> a wide range of OpenGL applications.  While there is still work,
>> notably
>> involving what happens if a peripheral attempts to DMA close to a TCE
>> window boundary, this series greatly improves functionality for AMD
>> GPUs
>> on POWER9 devices over the existing 32-bit DMA support.
>>
>> Russell Currey (4):
>>   powerpc/powernv/pci: Track largest available TCE order per PHB
>>   powerpc/powernv: DMA operations for discontiguous allocation
>>   powerpc/powernv/pci: Track DMA and TCE tables in debugfs
>>   powerpc/powernv/pci: Safety fixes for pseudobypass TCE allocation
>>
>> Timothy Pearson (3):
>>   powerpc/powernv/pci: Export pnv_pci_ioda2_tce_invalidate_pe
>>   powerpc/powernv/pci: Invalidate TCE cache after DMA map setup
>>   powerpc/powernv/pci: Don't use the lower 4G TCEs in pseudo-DMA mode
>>
>>  arch/powerpc/include/asm/dma-mapping.h    |   1 +
>>  arch/powerpc/platforms/powernv/Makefile   |   2 +-
>>  arch/powerpc/platforms/powernv/pci-dma.c  | 320
>> ++++++++++++++++++++++
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 169 ++++++++----
>>  arch/powerpc/platforms/powernv/pci.h      |  11 +
>>  5 files changed, 452 insertions(+), 51 deletions(-)
>>  create mode 100644 arch/powerpc/platforms/powernv/pci-dma.c
>>


-- 
Timothy Pearson
Raptor Engineering
+1 (415) 727-8645 (direct line)
+1 (512) 690-0200 (switchboard)
https://www.raptorengineering.com
