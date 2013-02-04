Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 738D52C02A5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2013 17:43:24 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Mon, 4 Feb 2013 16:39:07 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C276C357804E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2013 17:43:19 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r146V9iM9764934
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Feb 2013 17:31:10 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r146hHUo031839
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Feb 2013 17:43:17 +1100
Message-ID: <510F5881.7030409@linux.vnet.ibm.com>
Date: Mon, 04 Feb 2013 14:43:13 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 0/3] Enable multiple MSI feature in pSeries
References: <1358235536-32741-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <1359948180.25414.11.camel@concordia> <510F2FDB.6020303@linux.vnet.ibm.com>
 <1359957375.25414.31.camel@concordia>
In-Reply-To: <1359957375.25414.31.camel@concordia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2013/2/4 13:56, Michael Ellerman:
> On Mon, 2013-02-04 at 11:49 +0800, Mike Qiu wrote:
>>> On Tue, 2013-01-15 at 15:38 +0800, Mike Qiu wrote:
>>>> Currently, multiple MSI feature hasn't been enabled in pSeries,
>>>> These patches try to enbale this feature.
>>> Hi Mike,
>>>
>>>> These patches have been tested by using ipr driver, and the driver patch
>>>> has been made by Wen Xiong <wenxiong@linux.vnet.ibm.com>:
>>> So who wrote these patches? Normally we would expect the original author
>>> to post the patches if at all possible.
>> Hi Michael
>>
>> These Multiple MSI patches were wrote by myself, you know this feature
>> has not enabled
>> and it need device driver to test whether it works suitable. So I test
>> my patches use
>> Wen Xiong's ipr patches, which has been send out to the maillinglist.
>>
>> I'm the original author :)
> Ah OK, sorry, that was more or less clear from your mail but I just
> misunderstood.
>
>>>> [PATCH 0/7] Add support for new IBM SAS controllers
>>> I would like to see the full series, including the driver enablement.
>> Yep, but the driver patches were wrote by Wen Xiong and has been send
>> out.
> OK, you mean this series?
>
> http://thread.gmane.org/gmane.linux.scsi/79639
Yes, exactly.
>
>
>> I just use her patches to test my patches. all device support Multiple
>> MSI can use my feature not only IBM SAS controllers, I also test my
>> patches use the broadcom wireless card tg3, and also works OK.
> You mean drivers/net/ethernet/broadcom/tg3.c ? I don't see where it
> calls pci_enable_msi_block() ?
Yes, I just modify the driver to support mutiple MSI.
>
> All devices /can/ use it, but the driver needs to be updated. Currently
> we have two drivers that do so (in Linus' tree), plus the updated IPR.
Not all devices, just the device which support the multiple MSI by hardware,
can use it
>
>>>> Test platform: One partition of pSeries with one cpu core(4 SMTs) and
>>>>                 RAID bus controller: IBM PCI-E IPR SAS Adapter (ASIC) in POWER7
>>>> OS version: SUSE Linux Enterprise Server 11 SP2  (ppc64) with 3.8-rc3 kernel
>>>>
>>>> IRQ 21 and 22 are assigned to the ipr device which support 2 mutiple MSI.
>>>>
>>>> The test results is shown by 'cat /proc/interrups':
>>>>            CPU0       CPU1       CPU2       CPU3
>>>> 21:          6          5          5          5      XICS Level     host1-0
>>>> 22:        817        814        816        813      XICS Level     host1-1
>>> This shows that you are correctly configuring two MSIs.
>>>
>>> But the key advantage of using multiple interrupts is to distribute load
>>> across CPUs and improve performance. So I would like to see some
>>> performance numbers that show that there is a real benefit for all the
>>> extra complexity in the code.
>> Yes, the system just has suport two MSIs. Anyway, I will try to do
>> some proformance test, to show the real benefit.
>> But actually it needs the driver to do so. As the data show above, it
>> seems there is some problems in use the interrupt, the irq 21 use few,
>> most use 22, I will discuss with the driver author to see why and if
>> she fixed, I will give out the proformance result.
> Yeah that would be good.
>
> I really dislike that we have a separate API for multi-MSI vs MSI-X, and
> pci_enable_msi_block() also pushes the contiguous power-of-2 allocation
> into the irq domain layer, which is unpleasant. So if we really must do
> multi-MSI I would like to do it differently.
Yes, but the multi-MSI must need the hardware support, it is one extend 
for MSI,
The device may sopport MSI and multiple MSI, but not support MSI-X.
for these devices, we'd better use multiple MSI to makes it more efficiency,
compare with MSI.

multi-MSI just can use no more than 32 interrupts

Thanks
>
> cheers
>
>
