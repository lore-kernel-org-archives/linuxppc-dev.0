Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sY6Sl2tGGzDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 11:25:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Colin King <colin.king@canonical.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 Kevin Hao <haokexin@gmail.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32: add missing \n at end of printk warning
 message
In-Reply-To: <fcc50e93-5009-496d-3251-b2d7ef820224@c-s.fr>
References: <20160912101224.24877-1-colin.king@canonical.com>
 <fcc50e93-5009-496d-3251-b2d7ef820224@c-s.fr>
Date: Tue, 13 Sep 2016 11:25:58 +1000
Message-ID: <87sht4pp3t.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Le 12/09/2016 =C3=A0 12:12, Colin King a =C3=A9crit :
>> diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
>> index 448685f..b532dd9 100644
>> --- a/arch/powerpc/mm/init_32.c
>> +++ b/arch/powerpc/mm/init_32.c
>> @@ -137,7 +137,7 @@ void __init MMU_init(void)
>>  	if (memblock.memory.cnt > 1) {
>>  #ifndef CONFIG_WII
>>  		memblock_enforce_memory_limit(memblock.memory.regions[0].size);
>> -		printk(KERN_WARNING "Only using first contiguous memory region");
>> +		printk(KERN_WARNING "Only using first contiguous memory region\n");
>
> This line was already 81 characters long. It is now 83.

That doesn't really bother me.

> I would suggest to use pr_warn() instead in order to shorten the line.

But I do like pr_warn(), it's less shouty.

I'll fix it up when I apply it.

cheers
