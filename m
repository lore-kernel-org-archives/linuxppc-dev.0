Return-Path: <B04825@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DDB4C2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2012 06:18:56 +1100 (EST)
Message-ID: <5098110E.20201@freescale.com>
Date: Mon, 5 Nov 2012 13:18:38 -0600
From: Timur Tabi <b04825@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao-B38951 <B38951@freescale.com>
Subject: Re: [linuxppc-release] [PATCH] powerpc/fsl-pci: Add PCI controller
 ATMU PM support
References: <1351736348-26754-1-git-send-email-B38951@freescale.com>
 <50927862.9080909@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01B2F820@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01B2F820@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jia Hongtao-B38951 wrote:

>>
>>> +#ifdef CONFIG_SUSPEND
>>> +static int fsl_pci_resume(struct platform_device *pdev)
>>> +{
>>> +	struct pci_controller *hose;
>>> +	struct resource pci_rsrc;
>>> +
>>> +	hose = pci_find_hose_for_OF_device(pdev->dev.of_node);
>>> +	of_address_to_resource(pdev->dev.of_node, 0, &pci_rsrc);
>>> +	setup_pci_atmu(hose, &pci_rsrc);
>>> +
>>> +	return 0;
>>> +}
>>
>> Some of these functions can fail, so they should return an error code if
>> they do.
> 
> I checked the of_address_to_resource function now.
> Is that necessary to check other two fuctions?

Yes, check to ensure that 'hose' is not NULL.

-- 
Timur Tabi
Linux kernel developer at Freescale
