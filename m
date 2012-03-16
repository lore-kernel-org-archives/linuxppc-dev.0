Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3494AB6FE2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 06:43:01 +1100 (EST)
Message-ID: <4F6397BB.7080802@freescale.com>
Date: Fri, 16 Mar 2012 14:42:51 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/dts: Added aliased MSIIR register address to
 MSI node in dts
References: <1328111434-564-1-git-send-email-diana.craciun@freescale.com>
 <9D3E9651-1D03-4079-98D9-B08D46306879@kernel.crashing.org>
In-Reply-To: <9D3E9651-1D03-4079-98D9-B08D46306879@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Diana Craciun <diana.craciun@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/16/2012 02:32 PM, Kumar Gala wrote:
> 
> On Feb 1, 2012, at 9:50 AM, Diana Craciun wrote:
> 
>> From: Diana CRACIUN <Diana.Craciun@freescale.com>
>>
>> The MSIIR register for each MSI bank is aliased to a different
>> address. The MSI node reg property was updated to contain this
>> address:
>>
>> e.g. reg = <0x41600 0x200 0x44140 4>;
>>
>> The first region contains the address and length of the MSI
>> register set and the second region contains the address of
>> the aliased MSIIR register at 0x44140.
>>
>> Signed-off-by: Diana CRACIUN <Diana.Craciun@freescale.com>
>> ---
>> .../devicetree/bindings/powerpc/fsl/msi-pic.txt    |    6 ++++--
>> arch/powerpc/boot/dts/fsl/qoriq-mpic.dtsi          |    6 +++---
>> 2 files changed, 7 insertions(+), 5 deletions(-)
> 
> Why, we should only use one of the register regions.  The second region was added to allow for 4k separation and thus PAMU protection.  Not sure what listed both regions gets us.

We list both because the hardware has both.  Device tree describes the
hardware; it doesn't tell you how to use it.

Plus, the separte 4K page has only the MSIIRn register, not the other
MSI registers.  So we still need the first resource.

The second resource will probably not be used by Linux at the moment,
but it used by Topaz, and it may be used by KVM/VFIO in the future.

-Scott
