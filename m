Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9190DC433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Sep 2021 01:43:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F4D96128C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Sep 2021 01:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0F4D96128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HJzfm413Hz3bXR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Sep 2021 11:43:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=linux.intel.com
 (client-ip=192.55.52.120; helo=mga04.intel.com;
 envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN>)
X-Greylist: delayed 124 seconds by postgrey-1.36 at boromir;
 Wed, 29 Sep 2021 11:43:03 AEST
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HJzfH2Nx2z2yHy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Sep 2021 11:43:03 +1000 (AEST)
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="222947712"
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; d="scan'208";a="222947712"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 18:39:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; d="scan'208";a="476486375"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 28 Sep 2021 18:39:53 -0700
Subject: Re: [PATCH v2 9/9] iommu/vt-d: Use pci core's DVSEC functionality
To: Dan Williams <dan.j.williams@intel.com>,
 Ben Widawsky <ben.widawsky@intel.com>
References: <20210923172647.72738-1-ben.widawsky@intel.com>
 <20210923172647.72738-10-ben.widawsky@intel.com>
 <CAPcyv4i4T4XLW-P=CzdO47mZ8+_Mih7GMeDEXAtgEE+gO9JQHw@mail.gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6bca371c-44e4-3ba7-b49d-78c55a40d3a5@linux.intel.com>
Date: Wed, 29 Sep 2021 09:36:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4i4T4XLW-P=CzdO47mZ8+_Mih7GMeDEXAtgEE+gO9JQHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Andrew Donnellan <ajd@linux.ibm.com>, Linux PCI <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-cxl@vger.kernel.org,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Bjorn Helgaas <helgaas@kernel.org>,
 "David E. Box" <david.e.box@linux.intel.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>, Kan Liang <kan.liang@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, baolu.lu@linux.intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Dan,

On 9/29/21 1:54 AM, Dan Williams wrote:
> On Thu, Sep 23, 2021 at 10:27 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>>
>> Reduce maintenance burden of DVSEC query implementation by using the
>> centralized PCI core implementation.
>>
>> Cc: iommu@lists.linux-foundation.org
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 15 +--------------
>>   1 file changed, 1 insertion(+), 14 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index d75f59ae28e6..30c97181f0ae 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -5398,20 +5398,7 @@ static int intel_iommu_disable_sva(struct device *dev)
>>    */
>>   static int siov_find_pci_dvsec(struct pci_dev *pdev)
>>   {
>> -       int pos;
>> -       u16 vendor, id;
>> -
>> -       pos = pci_find_next_ext_capability(pdev, 0, 0x23);
>> -       while (pos) {
>> -               pci_read_config_word(pdev, pos + 4, &vendor);
>> -               pci_read_config_word(pdev, pos + 8, &id);
>> -               if (vendor == PCI_VENDOR_ID_INTEL && id == 5)
>> -                       return pos;
>> -
>> -               pos = pci_find_next_ext_capability(pdev, pos, 0x23);
>> -       }
>> -
>> -       return 0;
>> +       return pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_INTEL, 5);
>>   }
> 
> Same comments as the CXL patch, siov_find_pci_dvsec() doesn't seem to
> have a reason to exist anymore. What is 5?

"5" is DVSEC ID for Scalable IOV.

Anyway, the siov_find_pci_dvsec() has been dead code since commit
262948f8ba57 ("iommu: Delete iommu_dev_has_feature()"). I have a patch
to clean it up. No need to care about it in this series.

Best regards,
baolu
