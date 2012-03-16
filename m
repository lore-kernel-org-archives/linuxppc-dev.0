Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 60908B6FF4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 07:42:47 +1100 (EST)
Message-ID: <4F63A5BD.1090207@freescale.com>
Date: Fri, 16 Mar 2012 15:42:37 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
References: <1328861387-31390-1-git-send-email-shuo.liu@freesacle.com>
 <2F2A8FBF-BD4D-4A53-A293-F5426F8C5BAA@kernel.crashing.org>
In-Reply-To: <2F2A8FBF-BD4D-4A53-A293-F5426F8C5BAA@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, r61911@freescale.com,
 "<shuo.liu@freesacle.com>" <shuo.liu@freesacle.com>,
 Zhao Chenhui <b35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/16/2012 03:35 PM, Kumar Gala wrote:
> On Feb 10, 2012, at 2:09 AM, <shuo.liu@freesacle.com> <shuo.liu@freesacle.com> wrote:
>> +static int is_in_pci_mem_space(phys_addr_t addr)
>> +{
>> +	struct pci_controller *hose;
>> +	struct resource *res;
>> +	int i;
>> +
>> +	list_for_each_entry(hose, &hose_list, list_node) {
>> +		for (i = 0; i < 3; i++) {
>> +			res = &hose->mem_resources[i];
>> +			if ((res->flags & IORESOURCE_MEM) &&
>> +				addr >= res->start && addr <= res->end)
>> +				return 1;
>> +		}
>> +	}
>> +	return 0;
> 
> just move this into fsl_pci_mcheck_exception() no need for a separate function.

A separate function increases readability.

-Scott
