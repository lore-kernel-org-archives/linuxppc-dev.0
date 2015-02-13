Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F8061A0BE4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 16:52:55 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Fri, 13 Feb 2015 11:22:52 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C2464E0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 11:24:25 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1D5qnCb63045662
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 11:22:49 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1D5qn0L003960
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 11:22:49 +0530
Message-ID: <54DD9131.5010301@linux.vnet.ibm.com>
Date: Fri, 13 Feb 2015 11:22:49 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Check image loaded or not before calling
 flash
References: <20150212095323.1829.45732.stgit@localhost.localdomain>
 <1423776439.5965.65.camel@au1.ibm.com>
In-Reply-To: <1423776439.5965.65.camel@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org, sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/13/2015 02:57 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2015-02-12 at 15:23 +0530, Vasant Hegde wrote:
>> Present code checks for update_flash_data in opal_flash_term_callback().
>> update_flash_data has been statically initialized to zero, and that
>> is the value of FLASH_IMG_READY. Also code update initialization happens
>> during subsys init.
> 
> Please statically initialize it to a sane value instead.

Ok. Will fix and send v2 soon. Thanks!


-Vasant

> 
>> So if reboot is issued before the subsys init stage then we endup displaying
>> "Flashing new firmware" message.. which may confuse end user.
>>
>> This patch adds additional validation to make sure image is actually loaded
>> or not.
>>
>> Reported-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
>> Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/powernv/opal-flash.c |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/opal-flash.c b/arch/powerpc/platforms/powernv/opal-flash.c
>> index 5c21d9c..5455cd4 100644
>> --- a/arch/powerpc/platforms/powernv/opal-flash.c
>> +++ b/arch/powerpc/platforms/powernv/opal-flash.c
>> @@ -319,7 +319,8 @@ void opal_flash_term_callback(void)
>>  {
>>  	struct cpumask mask;
>>  
>> -	if (update_flash_data.status != FLASH_IMG_READY)
>> +	if (update_flash_data.status != FLASH_IMG_READY ||
>> +	    image_data.status != IMAGE_READY)
>>  		return;
>>  
>>  	pr_alert("FLASH: Flashing new firmware\n");
> 
> 
