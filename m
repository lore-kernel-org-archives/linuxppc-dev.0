Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D7AE51A06B1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 11:21:18 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 13 Nov 2015 10:21:17 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3B0BB2CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 11:21:14 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAD0Kxvb28442766
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 11:21:07 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAD0Kene025122
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 11:20:41 +1100
Date: Fri, 13 Nov 2015 11:20:15 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 39/50] powerpc/powernv: Fundamental reset in
 pnv_pci_reset_secondary_bus()
Message-ID: <20151113002015.GA21341@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-40-git-send-email-gwshan@linux.vnet.ibm.com>
 <87fv0azrpe.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87fv0azrpe.fsf@gamma.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 13, 2015 at 11:08:29AM +1100, Daniel Axtens wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>>  void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
>>  {
>> -	pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
>> +	int option, freset = 0;
>> +
>> +	if (dev->subordinate)
>> +		pci_walk_bus(dev->subordinate,
>> +			     pnv_pci_dev_reset_type, &freset);
>> +
>> +	option = freset ? EEH_RESET_FUNDAMENTAL : EEH_RESET_HOT;
>> +	pnv_eeh_bridge_reset(dev, option);
>
>According to the skiboot sources, fundamental reset isn't supported on
>p5ioc2. As far as I can tell from your corresponding skiboot patches,
>this is still the case after they are applied. Do we need a fallback to
>EEH_RESET_HOT in this case? Otherwise there will be no reset performed
>at all.
>
>Likewise, if the FUNDAMENTAL reset fails for any reason, should we fall
>back to a HOT reset?
>

P5IOC2 won't export any PCI slots. So kernel won't issue fundamental reset
to PCI buses on P5IOC2.

We had the failback: hot reset is picked if fundamental reset can't be
supported on the target PCI bus. In case fundamental reset fails, we
shouldn't go ahead try hot reset.

Thanks,
Gavin

>Regards,
>Daniel
