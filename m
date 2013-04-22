Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0CAC32C0115
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 11:45:54 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sun, 21 Apr 2013 21:45:51 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 31DB36E8048
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2013 21:45:46 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3M1jmnw304418
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2013 21:45:49 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3M1jl7J024353
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2013 21:45:48 -0400
Date: Mon, 22 Apr 2013 09:45:33 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/3] powerpc/powernv: Patch MSI EOI handler on P8
Message-ID: <20130422014533.GA7902@shangw.(null)>
References: <1366363965-23281-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1366363965-23281-3-git-send-email-shangw@linux.vnet.ibm.com>
 <20130421233436.GB22246@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130421233436.GB22246@concordia>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 22, 2013 at 09:34:36AM +1000, Michael Ellerman wrote:
>On Fri, Apr 19, 2013 at 05:32:45PM +0800, Gavin Shan wrote:
>> The EOI handler of MSI/MSI-X interrupts for P8 (PHB3) need additional
>> steps to handle the P/Q bits in IVE before EOIing the corresponding
>> interrupt. The patch changes the EOI handler to cover that.

Thanks for your time to review it, Michael. By the way, I think I need
rebase the patch since the patch fb1b55d654a7038ca6337fbf55839a308c9bc1a7
("Using bitmap to manage MSI") has been merged to linux-next.

>> diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
>> index 48861d3..289355e 100644
>> --- a/arch/powerpc/sysdev/xics/icp-native.c
>> +++ b/arch/powerpc/sysdev/xics/icp-native.c
>> @@ -27,6 +27,10 @@
>>  #include <asm/xics.h>
>>  #include <asm/kvm_ppc.h>
>>  
>> +#if defined(CONFIG_PPC_POWERNV) && defined(CONFIG_PCI_MSI)
>> +extern int pnv_pci_msi_eoi(unsigned int hw_irq);
>> +#endif
>
>You don't need to #ifdef the extern. But it should be in a header, not
>here.
>

Ok. I'll put it into asm/xics.h, but I want to confirm we needn't
#ifdef when moving it to asm/xics.h?

>> @@ -89,6 +93,24 @@ static void icp_native_eoi(struct irq_data *d)
>>  	icp_native_set_xirr((xics_pop_cppr() << 24) | hw_irq);
>>  }
>>  
>> +static void icp_p8_native_eoi(struct irq_data *d)
>> +{
>> +	unsigned int hw_irq = (unsigned int)irqd_to_hwirq(d);
>> +	int ret;
>> +
>> +	/* Let firmware handle P/Q bits */
>> +#if defined(CONFIG_PPC_POWERNV) && defined(CONFIG_PCI_MSI)
>> +	if (hw_irq != XICS_IPI) {
>> +		ret = pnv_pci_msi_eoi(hw_irq);
>> +		WARN_ON_ONCE(ret);
>> +	}
>> +#endif
>
>Why the ifdef in here? You only ever hook this function up if those are
>true, so why do you need to check them again?
>

Right. I will remove #ifdef here in next version.

>> @@ -296,6 +318,15 @@ int __init icp_native_init(void)
>>  	if (found == 0)
>>  		return -ENODEV;
>>  
>> +	/* Change the EOI handler for P8 */
>> +#if defined(CONFIG_PPC_POWERNV) && defined(CONFIG_PCI_MSI)
>
>This would be neater if you created CONFIG_POWERNV_MSI, like we have
>CONFIG_PSERIES_MSI.
>

Sure. I'll introduce CONFIG_PSERIES_MSI in next version.

Thanks,
Gavin
