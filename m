Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtXPZ0R8XzDqJ8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 02:54:09 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2TFo1LG003292
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 11:53:59 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29gcn9tj6w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 11:53:58 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Wed, 29 Mar 2017 16:53:56 +0100
Subject: Re: [PATCH V3 2/7] cxl: Remove unused values in bare-metal
 environment.
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com
References: <1490714052-18902-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1490714052-18902-3-git-send-email-clombard@linux.vnet.ibm.com>
 <5ce2cdd1-7e56-998b-f1fa-2c50fd543d6c@au1.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Wed, 29 Mar 2017 17:53:27 +0200
MIME-Version: 1.0
In-Reply-To: <5ce2cdd1-7e56-998b-f1fa-2c50fd543d6c@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <0b7b817d-711f-5072-92ea-95cb96c3282c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 29/03/2017 à 02:21, Andrew Donnellan a écrit :
> On 29/03/17 02:14, Christophe Lombard wrote:
>> The two fields pid and tid of the structure cxl_irq_info are only used
>> in the guest environment. To avoid confusion, it's not necessary
>> to fill the fields in the bare-metal environment. These two fields
>> are renamed to 'reserved' to avoid undefined behavior on bare-metal.
>> The PSL Process and Thread Identification Register (CXL_PSL_PID_TID_An)
>> is only used when attaching a dedicated process for PSL8 only. This
>> register goes away in CAIA2.
>>
>> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>
>> ---
>>  drivers/misc/cxl/cxl.h    | 13 +++++++------
>>  drivers/misc/cxl/hcalls.c |  4 ++--
>>  drivers/misc/cxl/native.c |  5 -----
>>  3 files changed, 9 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
>> index 79e60ec..2bbe077 100644
>> --- a/drivers/misc/cxl/cxl.h
>> +++ b/drivers/misc/cxl/cxl.h
>> @@ -895,19 +895,20 @@ int __detach_context(struct cxl_context *ctx);
>>   * plpar_hcall9() in hvCall.S
>>   * As a consequence:
>>   * - we don't need to do any endianness conversion
>> - * - the pid and tid are an exception. They are 32-bit values 
>> returned in
>> - *   the same 64-bit register. So we do need to worry about byte 
>> ordering.
>> + * - the pid (reserved0) and tid (reserved1) are an exception. They are
>> + *   32-bit values returned in the same 64-bit register. So we do need
>> + *   to worry about byte ordering.
>>   */
>
> Comment should explain that pid/tid are now reserved0/1 because we've 
> decided not to use them at all.
>

ok, I will update the comment.

thanks
