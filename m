Return-Path: <auke-jan.h.kok@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by ozlabs.org (Postfix) with ESMTP id 8188BDDE03
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 10:25:35 +1100 (EST)
Message-ID: <474B5380.9040104@intel.com>
Date: Mon, 26 Nov 2007 15:15:12 -0800
From: "Kok, Auke" <auke-jan.h.kok@intel.com>
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] e1000: Fix for 32 bits platforms with 64 bits resources
References: <20071116073821.548CCDDDF4@ozlabs.org> <474791D3.1090607@pobox.com>
In-Reply-To: <474791D3.1090607@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, auke-jan.h.kok@intel.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jeff Garzik wrote:
> Benjamin Herrenschmidt wrote:
>> The e1000 driver stores the content of the PCI resources into
>> unsigned long's before ioremapping. This breaks on 32 bits
>> platforms that support 64 bits MMIO resources such as ppc 44x.
>>
>> This fixes it by removing those temporary variables and passing
>> directly the result of pci_resource_start/len to ioremap.
>>
>> The side effect is that I removed the assignments to the netdev
>> fields mem_start, mem_end and base_addr, which are totally useless
>> for PCI devices.
>>
>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> -- 
>>
>>  drivers/net/e1000/e1000_main.c |   18 +++++-------------
>>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> Looks good to me.  auke?

yes, please apply.

Acked-by: Auke Kok <auke-jan.h.kok@intel.com>



Auke
