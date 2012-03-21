Return-Path: <STFD002@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F1C2DB6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 02:33:43 +1100 (EST)
Message-ID: <4F69F4C5.6090708@freescale.com>
Date: Wed, 21 Mar 2012 17:33:25 +0200
From: Diana CRACIUN <diana.craciun@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/dts: Removed fsl,msi property from dts.
References: <1328794860-12592-1-git-send-email-diana.craciun@freescale.com>
 <36B1F034-98A1-4571-8B94-A01D345935DF@kernel.crashing.org>
In-Reply-To: <36B1F034-98A1-4571-8B94-A01D345935DF@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/16/2012 09:33 PM, Kumar Gala wrote:
> On Feb 9, 2012, at 7:41 AM, Diana Craciun wrote:
>
>> From: Diana CRACIUN<Diana.Craciun@freescale.com>
>>
>> The association in the decice tree between PCI and MSI
>> using fsl,msi property was an artificial one and it does
>> not reflect the actual hardware.
>>
>> Signed-off-by: Diana CRACIUN<Diana.Craciun@freescale.com>
>> ---
>> arch/powerpc/boot/dts/p2041rdb.dts |    3 ---
>> arch/powerpc/boot/dts/p3041ds.dts  |    4 ----
>> arch/powerpc/boot/dts/p3060qds.dts |    2 --
>> arch/powerpc/boot/dts/p4080ds.dts  |    3 ---
>> arch/powerpc/boot/dts/p5020ds.dts  |    4 ----
>> 5 files changed, 0 insertions(+), 16 deletions(-)
> Should we not also remove the code associated with this property?
>
> - k

No. The property may be present in the device tree when running under 
Freescale hypervisor and it is used to skip the MSI nodes which are not 
mapped in PAMU.

The code in kernel handles both situations: when the property is present 
and in this case it searches only the corresponding MSI device for 
available interrupts and when the property is not present and in this 
case it loops over all the MSI devices.

Diana
