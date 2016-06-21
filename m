Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYWZJ0DQ7zDq62
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 12:16:55 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L2E51L008522
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 22:16:54 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n0mem5j1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 22:16:53 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Tue, 21 Jun 2016 12:16:51 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 642102CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 12:16:48 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5L2GmDH7864576
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 12:16:48 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5L2Gl3x011716
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 12:16:48 +1000
Subject: Re: [RESEND PATCH v2 1/4] PCI: Ignore resource_alignment if
 PCI_PROBE_ONLY was set\\
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1464846411-16895-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1464846411-16895-2-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160621014346.GA30307@localhost>
Cc: nikunj@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 linux-doc@vger.kernel.org, aik@ozlabs.ru, linux-pci@vger.kernel.org,
 corbet@lwn.net, linux-kernel@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, warrier@linux.vnet.ibm.com,
 alex.williamson@redhat.com, paulus@samba.org, bhelgaas@google.com,
 linuxppc-dev@lists.ozlabs.org
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Tue, 21 Jun 2016 10:16:58 +0800
MIME-Version: 1.0
In-Reply-To: <20160621014346.GA30307@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <6b457696-5cb6-66ba-911a-fec42bb3e0d3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/6/21 9:43, Bjorn Helgaas wrote:

> On Thu, Jun 02, 2016 at 01:46:48PM +0800, Yongji Xie wrote:
>> The resource_alignment will releases memory resources allocated
>> by firmware so that kernel can reassign new resources later on.
>> But this will cause the problem that no resources can be
>> allocated by kernel if PCI_PROBE_ONLY was set, e.g. on pSeries
>> platform because PCI_PROBE_ONLY force kernel to use firmware
>> setup and not to reassign any resources.
>>
>> To solve this problem, this patch ignores resource_alignment
>> if PCI_PROBE_ONLY was set.
>>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>>   drivers/pci/pci.c |    6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index c8b4dbd..a259394 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4761,6 +4761,12 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
>>   	spin_lock(&resource_alignment_lock);
>>   	p = resource_alignment_param;
>>   	while (*p) {
>> +		if (pci_has_flag(PCI_PROBE_ONLY)) {
>> +			printk(KERN_ERR "PCI: Ignore resource_alignment parameter: %s with PCI_PROBE_ONLY set\n",
>> +					p);
>> +			*p = 0;
>> +			break;
> Wouldn't it be simpler to make pci_set_resource_alignment_param() fail
> if PCI_PROBE_ONLY is set?

I add the check here because I want to print some logs so that users
could know the reason why resource_alignment doesn't work when
they add this parameter.

Thanks,
Yongji

>> +		}
>>   		count = 0;
>>   		if (sscanf(p, "%d%n", &align_order, &count) == 1 &&
>>   							p[count] == '@') {
>> -- 
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
