Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41qWvP591kzF0Qs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2018 22:22:41 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7ECETNN091319
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2018 08:22:39 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kuwkr3kwc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2018 08:22:38 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Tue, 14 Aug 2018 13:22:36 +0100
Subject: Re: [PATCH V2] ocxl: Fix access to the AFU Descriptor Data
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 fbarrat@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
References: <1534169362-9394-1-git-send-email-clombard@linux.vnet.ibm.com>
 <87in4dljch.fsf@concordia.ellerman.id.au>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Tue, 14 Aug 2018 14:22:33 +0200
MIME-Version: 1.0
In-Reply-To: <87in4dljch.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <954aa561-0eeb-db87-42f7-56c11f967a9d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 14/08/2018 à 05:26, Michael Ellerman a écrit :
> Hi Christophe,
> 
> The patch looks fine, just a nit about the change log:
> 
> Christophe Lombard <clombard@linux.vnet.ibm.com> writes:
>> The AFU Information DVSEC capability is a means to extract common,
>> general information about all of the AFUs associated with a Function
>> independent of the specific functionality that each AFU provides.
>>
>> This patch fixes the access to the AFU Descriptor Data indexed by the
>> AFU Info Index field.
> 
>> Fixes: 5ef3166e8a32 ("ocxl: Driver code for 'generic' opencapi devices")
>> Cc: stable <stable@vger.kernel.org>     # 4.16
>> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> 
> When fixing a bug it's always good to describe how the bug manifests.
> ie. in this case we are clearly writing to the wrong location in config
> space, but what is the consequence of that? Does it kill the device, or
> just fails to initialise something correctly? How could I tell if I'm
> hitting this bug currently? How would I tell if the fix is applied
> correctly?

You are right, let me send a new version.

Thanks

> 
> cheers
> 
>> ---
>> Changelog[v2]
>>   - Rebase to latest upstream.
>>   - Use pci_write_config_byte instead of pci_write_config_word
>> ---
>>   drivers/misc/ocxl/config.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
>> index 2e30de9..57a6bb1 100644
>> --- a/drivers/misc/ocxl/config.c
>> +++ b/drivers/misc/ocxl/config.c
>> @@ -280,7 +280,9 @@ int ocxl_config_check_afu_index(struct pci_dev *dev,
>>   	u32 val;
>>   	int rc, templ_major, templ_minor, len;
>>   
>> -	pci_write_config_word(dev, fn->dvsec_afu_info_pos, afu_idx);
>> +	pci_write_config_byte(dev,
>> +			fn->dvsec_afu_info_pos + OCXL_DVSEC_AFU_INFO_AFU_IDX,
>> +			afu_idx);
>>   	rc = read_afu_info(dev, fn, OCXL_DVSEC_TEMPL_VERSION, &val);
>>   	if (rc)
>>   		return rc;
>> -- 
>> 2.7.4
> 
