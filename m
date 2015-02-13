Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F58A1A016E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 13:47:04 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Fri, 13 Feb 2015 12:47:03 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id F02493578048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 13:46:59 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1D2kp6e47382704
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 13:46:59 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1D2kQ2Q031845
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 13:46:26 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t1D2kQf2031410
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 13:46:26 +1100
Received: from [10.61.2.200] (haven.au.ibm.com [9.192.253.15])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 0C14DA01A5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 13:46:03 +1100 (AEDT)
Message-ID: <54DD656A.4020608@au1.ibm.com>
Date: Fri, 13 Feb 2015 13:46:02 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: Check image loaded or not before calling
 flash
References: <20150212095323.1829.45732.stgit@localhost.localdomain>
 <1423776439.5965.65.camel@au1.ibm.com>
In-Reply-To: <1423776439.5965.65.camel@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13/02/15 08:27, Benjamin Herrenschmidt wrote:
> On Thu, 2015-02-12 at 15:23 +0530, Vasant Hegde wrote:
>> Present code checks for update_flash_data in opal_flash_term_callback().
>> update_flash_data has been statically initialized to zero, and that
>> is the value of FLASH_IMG_READY. Also code update initialization happens
>> during subsys init.
> 
> Please statically initialize it to a sane value instead.

I've tested this patch and it works for me (the message is suppressed)
but I agree with Ben that it seems cleaner to use a static initializer.

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
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
