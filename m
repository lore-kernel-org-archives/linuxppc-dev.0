Return-Path: <B25806@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5F3562C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 12:27:13 +1000 (EST)
Received: from mail131-va3 (localhost [127.0.0.1])	by
 mail131-va3-R.bigfish.com (Postfix) with ESMTP id 42B7D240109	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 02:27:08 +0000 (UTC)
Received: from VA3EHSMHS012.bigfish.com (unknown [10.7.14.237])	by
 mail131-va3.bigfish.com (Postfix) with ESMTP id 6B02AC0041	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 02:27:06 +0000 (UTC)
Message-ID: <5065B460.6060906@freescale.com>
Date: Fri, 28 Sep 2012 10:29:52 -0400
From: Chunhe Lan <b25806@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] edac/85xx: Enable the EDAC PCI err driver by
 device_initcall
References: <1348772523-17587-1-git-send-email-Chunhe.Lan@freescale.com>
 <1348772523-17587-3-git-send-email-Chunhe.Lan@freescale.com>
 <1348762151.18375.6@snotra>
In-Reply-To: <1348762151.18375.6@snotra>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: kumar.gala@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/27/2012 12:09 PM, Scott Wood wrote:
> On 09/27/2012 02:02:03 PM, Chunhe Lan wrote:
>> Original process of call:
>>     The mpc85xx_pci_err_probe function completes to been registered
>>     and enabled of EDAC PCI err driver at the latter time stage of
>>     kernel boot in the mpc85xx_edac.c.
>> Current process of call:
>>     The mpc85xx_pci_err_probe function completes to been registered
>>     and enabled of EDAC PCI err driver at the first    time stage of
>>     kernel boot in the fsl_pci.c.
>>
>> So in this case the following error messages appear in the boot log:
>>
>>     PCI: Probing PCI hardware
>>     pci 0000:00:00.0: ignoring class b20 (doesn't match header type 01)
>>     PCIE error(s) detected
>>     PCIE ERR_DR register: 0x00020000
>>     PCIE ERR_CAP_STAT register: 0x80000001
>>     PCIE ERR_CAP_R0 register: 0x00000800
>>     PCIE ERR_CAP_R1 register: 0x00000000
>>     PCIE ERR_CAP_R2 register: 0x00000000
>>     PCIE ERR_CAP_R3 register: 0x00000000
>>
>> Because the EDAC PCI err driver is registered and enabled earlier than
>> original point of call. But at this point of time, PCI hardware is not
>> probed and initialized, and it is in unknowable state.
>>
>> So, move enable function into mpc85xx_pci_err_en which is called at the
>> middle time stage of kernel boot and after PCI hardware is probed and
>> initialized by device_initcall in the fsl_pci.c.
>>
>> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
>> ---
>>  arch/powerpc/sysdev/fsl_pci.c |   12 ++++++++++
>>  arch/powerpc/sysdev/fsl_pci.h |    5 ++++
>>  drivers/edac/mpc85xx_edac.c   |   47 
>> ++++++++++++++++++++++++++++------------
>>  3 files changed, 50 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/powerpc/sysdev/fsl_pci.c 
>> b/arch/powerpc/sysdev/fsl_pci.c
>> index 3d6f4d8..a591965 100644
>> --- a/arch/powerpc/sysdev/fsl_pci.c
>> +++ b/arch/powerpc/sysdev/fsl_pci.c
>> @@ -904,4 +904,16 @@ static int __init fsl_pci_init(void)
>>      return platform_driver_register(&fsl_pci_driver);
>>  }
>>  arch_initcall(fsl_pci_init);
>> +
>> +static int __init fsl_pci_err_en(void)
>> +{
>> +    struct device_node *np;
>> +
>> +    for_each_node_by_type(np, "pci")
>> +        if (of_match_node(pci_ids, np))
>> +            mpc85xx_pci_err_en(np);
>> +
>> +    return 0;
>> +}
>> +device_initcall(fsl_pci_err_en);
>
> Why can't you call this from the normal PCIe controller init, instead 
> of searching for the node independently?
     Because PCIe controller init is earlier than device_initcall, and 
it does not fix this issue.
     Do you indicate that which function calls fsl_pci_err_en in the 
which file ?

     Thanks,
     Chunhe
>
> -Scott
