Return-Path: <Yanjiang.Jin@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTlsg18FDzDvyC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 16:17:42 +1100 (AEDT)
Message-ID: <583FAF71.7070708@windriver.com>
Date: Thu, 1 Dec 2016 13:04:49 +0800
From: yjin <yanjiang.jin@windriver.com>
MIME-Version: 1.0
To: Scott Wood <oss@buserror.net>, <benh@kernel.crashing.org>,
 <paulus@samba.org>, <mpe@ellerman.id.au>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <jinyanjiang@gmail.com>, <yanjiang.jin@windriver.com>
Subject: Re: [PATCH] powerpc: cputime: fix a compile warning
References: <1479704219-21403-1-git-send-email-yanjiang.jin@windriver.com>
 <1480516844.21746.66.camel@buserror.net>
In-Reply-To: <1480516844.21746.66.camel@buserror.net>
Content-Type: multipart/mixed; boundary="------------090906000303010903050305"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--------------090906000303010903050305
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Scott,

Thanks for your reminder!
I rephrased it as below:

-#define cputime64_to_clock_t(ct) cputime_to_clock_t((cputime_t)(ct))
+#define cputime64_to_clock_t(ct)       \
+       (u64)(cputime_to_clock_t((cputime_t)(ct)))


and rebuilt the kernel, no warnings found.
New patch is attached, could you also help me to review it?

Regards!
Yanjiang

On 2016年11月30日 22:40, Scott Wood wrote:
> On Mon, 2016-11-21 at 12:56 +0800, yanjiang.jin@windriver.com wrote:
>> From: Yanjiang Jin <yanjiang.jin@windriver.com>
>>
>> This patch is to avoid the below warning:
>>
>> kernel/sched/cpuacct.c:298:25: warning:
>> format '%lld' expects argument of type 'long long int',
>> but argument 4 has type 'long unsigned int' [-Wformat=]
>>
>> Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
>> ---
>>   arch/powerpc/include/asm/cputime.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/cputime.h
>> b/arch/powerpc/include/asm/cputime.h
>> index 4f60db0..4423e97 100644
>> --- a/arch/powerpc/include/asm/cputime.h
>> +++ b/arch/powerpc/include/asm/cputime.h
>> @@ -228,7 +228,8 @@ static inline cputime_t clock_t_to_cputime(const
>> unsigned long clk)
>>   	return (__force cputime_t) ct;
>>   }
>>   
>> -#define cputime64_to_clock_t(ct)	cputime_to_clock_t((cputime_t)(ct))
>> +#define cputime64_to_clock_t(ct)	\
>> +	(__force u64)(cputime_to_clock_t((cputime_t)(ct)))
> Why is __force needed?
>
> -Scott
>


--------------090906000303010903050305
Content-Type: text/x-patch;
	name="0001-powerpc-cputime-fix-a-compile-warning.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-powerpc-cputime-fix-a-compile-warning.patch"

>From c32bc6ffe070e3d79a420e6adcbed5709079dc23 Mon Sep 17 00:00:00 2001
From: Yanjiang Jin <yanjiang.jin@windriver.com>
Date: Sat, 19 Nov 2016 05:04:53 +0000
Subject: [PATCH] powerpc: cputime: fix a compile warning

This patch is to avoid the below warning:

kernel/sched/cpuacct.c:298:25: warning:
format '%lld' expects argument of type 'long long int',
but argument 4 has type 'long unsigned int' [-Wformat=]

Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
---
 arch/powerpc/include/asm/cputime.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
index 4f60db0..a25082b 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -228,7 +228,8 @@ static inline cputime_t clock_t_to_cputime(const unsigned long clk)
 	return (__force cputime_t) ct;
 }
 
-#define cputime64_to_clock_t(ct)	cputime_to_clock_t((cputime_t)(ct))
+#define cputime64_to_clock_t(ct)	\
+	(u64)(cputime_to_clock_t((cputime_t)(ct)))
 
 /*
  * PPC64 uses PACA which is task independent for storing accounting data while
-- 
1.9.1


--------------090906000303010903050305--
