Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 30EE41A08A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 20:27:34 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 15:57:31 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 7E04B1258056
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 15:59:52 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t54AQqHQ56361198
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 15:56:53 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t549bFt5008497
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 15:07:15 +0530
Message-ID: <557027E4.7010601@linux.vnet.ibm.com>
Date: Thu, 04 Jun 2015 15:56:44 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>,
 Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 8/9] powerpc/powernv: Add OPAL support for Nest PMU
References: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1433260778-26497-9-git-send-email-maddy@linux.vnet.ibm.com>
 <1433292866.438.64.camel@axtens.net>
In-Reply-To: <1433292866.438.64.camel@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 03 June 2015 06:24 AM, Daniel Axtens wrote:
>> +int64_t opal_nest_ima_control(uint32_t value);
> If I'm understanding things correctly, you call this function in patch
> 3. Quoting from that patch:
>> +static void nest_init(void *dummy)
>> +{
>> +       opal_nest_ima_control(P8_NEST_ENGINE_START);
>> +}
> Does this patch need to be moved earlier in the series?
I applied all the patches together and tested it since the Makefile 
inclusion is
the final patch in the series. I guess it is better rearrange the series.

> Have you tested that the series compiles at every point?
> (I've found that this can be done quite easily with
>   git rebase --interactive using x to run the compile)
Nice. will try this out.

Thanks for the review
Maddy

>> +
>>   /* Internal functions */
>>   extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
>>   				   int depth, void *data);
>> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
>> index a7ade94..ce36a68 100644
>> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
>> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
>> @@ -295,3 +295,4 @@ OPAL_CALL(opal_i2c_request,			OPAL_I2C_REQUEST);
>>   OPAL_CALL(opal_flash_read,			OPAL_FLASH_READ);
>>   OPAL_CALL(opal_flash_write,			OPAL_FLASH_WRITE);
>>   OPAL_CALL(opal_flash_erase,			OPAL_FLASH_ERASE);
>> +OPAL_CALL(opal_nest_ima_control,		OPAL_NEST_IMA_CONTROL);
