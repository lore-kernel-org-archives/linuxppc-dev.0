Return-Path: <karim.eshapa@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wFqHb12kBzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Apr 2017 11:10:50 +1000 (AEST)
Received: by mail-wr0-x241.google.com with SMTP id 6so10723801wrb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Apr 2017 18:10:50 -0700 (PDT)
From: Karim Eshapa <karim.eshapa@gmail.com>
To: oss@buserror.net
Cc: claudiu.manoil@nxp.com, roy.pledge@nxp.com, colin.king@canonical.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: RE:drivers:soc:fsl:qbman:qman.c: unsigned long jiffies value
Date: Sun, 30 Apr 2017 03:09:26 +0200
Message-Id: <1493514566-12920-1-git-send-email-karim.eshapa@gmail.com>
In-Reply-To: <1493508775.25397.26.camel@buserror.net>
References: <1493508775.25397.26.camel@buserror.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 29 Apr 2017 18:32:55 -0500, Scott Wood wrote:
>On Sat, 2017-04-29 at 22:43 +0200, Karim Eshapa wrote:
>
>> unsigned long jiffies value sorry for that.
>>
> You mean unsigned long msecs?
>

Yes, I mean usecs. 

>>
>> Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
>> ---
>>  drivers/soc/fsl/qbman/qman.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
>> index e0df4d1..6e1a44a 100644
>> --- a/drivers/soc/fsl/qbman/qman.c
>> +++ b/drivers/soc/fsl/qbman/qman.c
>> @@ -1084,7 +1084,7 @@ static int drain_mr_fqrni(struct qm_portal *p)
>>                * entries well before the ring has been fully consumed, so
>>                * we're being *really* paranoid here.
>>                */
>> -             unsigned int udel_time = jiffies_to_usecs(10000);
>> +             unsigned long udel_time = jiffies_to_usecs(10000);
>>  
>>               usleep_range(udel_time/2, udel_time);
>>               msg = qm_mr_current(p);

>If unsigned int isn't big enough, then unsigned long won't be either on 32-
>bit.  With such a long delay why not use msleep()?
>

I agree with you in long int.
After looking at Documentation/timers/timers-howto.txt I think
the msleep() is better as we actually have long delay.
may be we can use jiffies_to_msecs() with msleep() in case of we still have 
this large jiffies difference.

>As for the previous patch[1], you're halving the minimum timeout which may not
>be correct.
>
>

For the minimum timeout, I've read the following comments.

		 /*
                  * if MR was full and h/w had other FQRNI entries to produce, we
                  * need to allow it time to produce those entries once the
                  * existing entries are consumed. A worst-case situation
                  * (fully-loaded system) means h/w sequencers may have to do 3-4
                  * other things before servicing the portal's MR pump, each of
                  * which (if slow) may take ~50 qman cycles (which is ~200
                  * processor cycles). So rounding up and then multiplying this
                  * worst-case estimate by a factor of 10, just to be
                  * ultra-paranoid, goes as high as 10,000 cycles. NB, we consume
                  * one entry at a time, so h/w has an opportunity to produce new
                  * entries well before the ring has been fully consumed, so
                  * we're being *really* paranoid here.
		  */
		  u64 now, then = jiffies;
		
		do {
	                now = jiffies;
                 } while ((then + 10000) > now);  

He needs to guarantee certain action so, he made a very large factor of saftey
therefore I've used sleep in range with approximate delay. But we still need 
the driver owner to define appropriate value to put.

>[1] When fixing a patch you've already posted that hasn't yet been applied,
>send a replacement (v2) patch rather than a separate fix.
>

Thanks so much, I'm just newbies :)


Karim   
