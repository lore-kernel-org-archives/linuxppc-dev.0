Return-Path: <Minghuan.Lian@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E4EE62C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jan 2014 14:57:35 +1100 (EST)
Message-ID: <52CA29C1.9010405@freescale.com>
Date: Mon, 6 Jan 2014 11:57:53 +0800
From: Lian Minghuan-b31939 <b31939@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, Minghuan Lian
 <Minghuan.Lian@freescale.com>
Subject: Re: [11/12,v3] pci: fsl: update PCI EDAC driver
References: <1382524894-15164-11-git-send-email-Minghuan.Lian@freescale.com>
 <20140103221603.GA22546@home.buserror.net>
In-Reply-To: <20140103221603.GA22546@home.buserror.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

I think we should reverse this commit

0f1741c74aa6794b1c7fbdd19f26a4f2377a11c6.

PCI controller driver is a platform driver supports probe and remove,
when removing the driver we should call mpc85xx_pci_err_remove() to free EDAC PCI resource.

Thanks,
Minghuan

On 01/04/2014 06:16 AM, Scott Wood wrote:
> On Wed, Oct 23, 2013 at 06:41:33PM +0800, Minghuan Lian wrote:
>> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
>> index 40d2e1d..4a03e1a 100644
>> --- a/arch/powerpc/sysdev/fsl_pci.c
>> +++ b/arch/powerpc/sysdev/fsl_pci.c
>> @@ -236,6 +236,7 @@ void fsl_arch_pci_sys_remove(struct fsl_pci *pci)
>>   	if (!hose)
>>   		return;
>>   
>> +	mpc85xx_pci_err_remove(to_platform_device(pci->dev));
>>   	pcibios_free_controller(hose);
> This causes a linker error if the EDAC driver is enabled, due to commit
> 0f1741c74aa6794b1c7fbdd19f26a4f2377a11c6 ("edac/85xx: Remove
> mpc85xx_pci_err_remove").
>
> -Scott
