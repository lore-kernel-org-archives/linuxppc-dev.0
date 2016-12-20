Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjthq23JxzDwVY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 10:07:06 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBKN4St8017340
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 18:07:03 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27fbstwu5r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 18:07:03 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 21 Dec 2016 09:07:00 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B6ED12CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 10:06:58 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBKN6wp753936224
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 10:06:58 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBKN6waU004521
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 10:06:58 +1100
Date: Wed, 21 Dec 2016 10:06:57 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org, #v4.9+@gwshan.ozlabs.ibm.com
Subject: Re: [PATCH] drivers/pci/hotplug: Handle presence detection change
 properly
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1482216573-21487-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20161220093709.GA12938@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161220093709.GA12938@kroah.com>
Message-Id: <20161220230657.GA7066@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 20, 2016 at 10:37:09AM +0100, Greg KH wrote:
>On Tue, Dec 20, 2016 at 05:49:33PM +1100, Gavin Shan wrote:
>> The surprise hotplug is driven by interrupt in PowerNV PCI hotplug
>> driver. In the interrupt handler, pnv_php_interrupt(), we bail when
>> pnv_pci_get_presence_state() returns zero wrongly. It causes the
>> presence change event is always ignored incorrectly.
>> 
>> This fixes the issue by bailing on error (non-zero value) returned
>> from pnv_pci_get_presence_state().
>> 
>> Fixes: 360aebd85a4 ("drivers/pci/hotplug: Support surprise hotplug in powernv driver")
>> Cc: stable@vger.kernel.org #v4.9+
>> Reported-by: Hank Chang <hankmax0000@gmail.com>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> Tested-by: Willie Liauw <williel@supermicro.com.tw>
>> ---
>>  drivers/pci/hotplug/pnv_php.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
>> index 56efaf7..38a2309 100644
>> --- a/drivers/pci/hotplug/pnv_php.c
>> +++ b/drivers/pci/hotplug/pnv_php.c
>> @@ -707,8 +707,12 @@ static irqreturn_t pnv_php_interrupt(int irq, void *data)
>>  		added = !!(lsts & PCI_EXP_LNKSTA_DLLLA);
>>  	} else if (sts & PCI_EXP_SLTSTA_PDC) {
>>  		ret = pnv_pci_get_presence_state(php_slot->id, &presence);
>> -		if (!ret)
>> +		if (ret) {
>> +			dev_warn(&pdev->dev, "PCI slot [%s] error %d handling PDC event (0x%04x)\n",
>> +				php_slot->name, ret, sts);
>
>What can a user do with this warning?
>

This warning is to catch developer's attention only. It's very
rare for pnv_pci_get_presence_state() to fail as it simply checks
hardware regiter bit (from Slot Status regsiter in PCIe capability
or PHB's Hotplug Override register) in the skiboot firmware.

User needs to retry the operation (hot-add or hot-remove) when
seeing this warning. Greg, please let me know if below message
is better?

dev_warn(&pdev->dev, "PCI slot [%s] error %d getting presence status on event 0x%04x, to retry the operation.\n",
         php_slot->name, ret, sts);

Thanks,
Gavin
