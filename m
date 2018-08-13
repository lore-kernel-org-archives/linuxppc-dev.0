Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41pxjj0J84zDr5t
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 23:42:16 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7DDZWjZ038448
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 09:42:14 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kua332t59-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 09:42:13 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Mon, 13 Aug 2018 14:42:12 +0100
Subject: Re: [PATCH] ocxl: Fix access to the AFU Descriptor Data
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com
References: <1534150891-19394-1-git-send-email-clombard@linux.vnet.ibm.com>
 <85eab07a-5ef8-0d0a-fe82-9860ae84015e@au1.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Mon, 13 Aug 2018 15:42:09 +0200
MIME-Version: 1.0
In-Reply-To: <85eab07a-5ef8-0d0a-fe82-9860ae84015e@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <bb174873-18af-ba7a-e38e-2d9aca0db882@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 13/08/2018 à 11:48, Andrew Donnellan a écrit :
> On 13/08/18 19:01, Christophe Lombard wrote:
>> From: Christophe Lombard <christophe_lombard@fr.ibm.cm>
> 
> Your git committer email should probably match your sign-off email.
> 
>>
>> The AFU Information DVSEC capability is a means to extract common,
>> general information about all of the AFUs associated with a Function
>> independent of the specific functionality that each AFU provides.
>>
>> This patch fixes the access to the AFU Descriptor Data indexed by the
>> AFU Info Index field.
>>
>> Fixes: 5ef3166e8a32 ("ocxl: Driver code for 'generic' opencapi devices")
>>
>> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> 
> This looks like it should go to stable? I assume the reason we haven't 
> noticed this previously is because we have not been testing with 
> multi-AFU cards.
> 
>> ---
>>   drivers/misc/ocxl/config.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
>> index 2e30de9..de01623 100644
>> --- a/drivers/misc/ocxl/config.c
>> +++ b/drivers/misc/ocxl/config.c
>> @@ -280,7 +280,9 @@ int ocxl_config_check_afu_index(struct pci_dev *dev,
>>       u32 val;
>>       int rc, templ_major, templ_minor, len;
>> -    pci_write_config_word(dev, fn->dvsec_afu_info_pos, afu_idx);
>> +    pci_write_config_word(dev,
>> +                  fn->dvsec_afu_info_pos + OCXL_DVSEC_AFU_INFO_AFU_IDX,
>> +                  afu_idx);
> 
> pci_write_config_byte() would be more appropriate here (see 
> ocxl_config_read_afu() at line 454)
> 
>>       rc = read_afu_info(dev, fn, OCXL_DVSEC_TEMPL_VERSION, &val);
>>       if (rc)
>>           return rc;
>>
> 

right. Thanks for the review.
