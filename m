Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CA279DDE01
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 10:09:59 +1100 (EST)
Date: Thu, 8 Nov 2007 02:10:03 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <936845819.20071108021003@emcraft.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re[2]: [PATCH 1/2] [PPC 4xx] invalidate_l2cache_range()
	implementation for ppc44x
In-Reply-To: <20071107040428.GA22637@lixom.net>
References: <1078030427.20071107014028@emcraft.com>
	<20071107040428.GA22637@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Reply-To: Yuri Tikhonov <yur@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 Hi Olof,

 Thanks a lot for the feedbacks. Comments below.

On 07.11.2007, 7:04:28 you wrote:

> Hi,

> Some comments below. In general this patch adds #ifdefs in common code,
> that's normally frowned upon.
> It would maybe be better to add a new call to ppc_machdeps and call it
> if set.

 Agree; this looks better indeed. 

> On Wed, Nov 07, 2007 at 01:40:28AM +0300, Yuri Tikhonov wrote:

...

>> +
>>  /*
>>   * Write any modified data cache blocks out to memory.
>>   * Does not invalidate the corresponding cache lines (especially for
>> diff --git a/include/asm-powerpc/cache.h b/include/asm-powerpc/cache.h
>> index 5350704..8a2f9e6 100644
>> --- a/include/asm-powerpc/cache.h
>> +++ b/include/asm-powerpc/cache.h
>> @@ -10,12 +10,14 @@
>>  #define MAX_COPY_PREFETCH      1
>>  #elif defined(CONFIG_PPC32)
>>  #define L1_CACHE_SHIFT         5
>> +#define L2_CACHE_SHIFT         5
>>  #define MAX_COPY_PREFETCH      4
>>  #else /* CONFIG_PPC64 */
>>  #define L1_CACHE_SHIFT         7
>>  #endif
>>  
>>  #define        L1_CACHE_BYTES          (1 << L1_CACHE_SHIFT)
>> +#define        L2_CACHE_BYTES          (1 << L2_CACHE_SHIFT)

> The above looks highly system dependent to me. Should maybe be a part
> of the cache info structures instead, and filled in from the device tree?

 This is the Level-2 cache line parameter. I'll see what can be made here. For now I've just renamed these definitions and moved them into the PPC44x-specific header.


 Regards,
  Yuri 

-- 
Yuri Tikhonov, Senior Software Engineer
Emcraft Systems, www.emcraft.com
