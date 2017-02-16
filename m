Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPWKt6vYMzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 09:39:14 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1GMcuVj093575
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 17:39:12 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28ndpjbksy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 17:39:11 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 17 Feb 2017 08:39:09 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1EE032CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 09:39:06 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1GMcwuj23134292
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 09:39:06 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1GMcXlI012089
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 09:38:33 +1100
Date: Fri, 17 Feb 2017 09:38:08 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, mpe@ellerman.id.au, bhelgaas@google.com
Subject: Re: [PATCH 0/3] pci/hotplug/pnv-php: More bug fixes
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1487200954-14681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20170216140925.GA21042@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170216140925.GA21042@bhelgaas-glaptop.roam.corp.google.com>
Message-Id: <20170216223808.GA7493@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 16, 2017 at 08:09:26AM -0600, Bjorn Helgaas wrote:
>On Thu, Feb 16, 2017 at 10:22:31AM +1100, Gavin Shan wrote:
>> This series bases on the series: https://patchwork.ozlabs.org/patch/713513.
>> This series fixes couple of issues:
>> 
>>    * Remove WARN_ON() in pnv_php_put_slot(). The parent slot's refcount
>>      is decreased when releasing PCI slot. The parent slot can be NULL
>>      and no need to give a warning.
>>    * The MSI (or MSIx) could be enabled prior to load pnv-php.ko. A
>>      backtrace is thrown when phv-php.ko attempts to enable MSI again.
>>      PATCH[2/3] skips enabling surprise hotplug if MSI has been enabled
>>      by other driver.
>>    * PATCH[3/3] doesn't disable MSI that was enabled by other dirver.
>>      Also, the upstream port of the PCI slot is disabled when it's
>>      destroyed.
>> 
>> Gavin Shan (3):
>>   pci/hotplug/pnv-php: Remove WARN_ON() in pnv_php_put_slot()
>>   pci/hotplug/pnv-php: Disable surprise hotplug capability on conflicts
>>   pci/hotplug/pnv-php: Disable MSI and PCI device properly
>> 
>>  drivers/pci/hotplug/pnv_php.c | 32 +++++++++++++++++++++++---------
>>  1 file changed, 23 insertions(+), 9 deletions(-)
>
>Since this is specific to pnv_php.c and depends on a previous series
>applied by Michael, I assume he'll handle this series as well.
>

Bjorn, yes, I think Michael will take care of this series and all
changes to pnv_php.c in future, as we all agreed previously. I was
asked by Michael to copy linux-pci@ and you when posting patches for
this component.

Thanks,
Gavin
