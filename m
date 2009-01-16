Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A9C03DE2FA
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jan 2009 02:19:01 +1100 (EST)
Date: Fri, 16 Jan 2009 18:18:42 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <1336101832.20090116181842@emcraft.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re[2]: [PATCH][v4] powerpc 44x: support for 256KB PAGE_SIZE
In-Reply-To: <f341f40f2bfa0818be32a86da62ada9b@bga.com>
References: <200901130149.43588.yur@emcraft.com>
	<f341f40f2bfa0818be32a86da62ada9b@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: wd@denx.de, dzu@denx.de, linuxppc-dev@ozlabs.org, paulus@samba.org,
	hugh@veritas.com, akpm@linux-foundation.org, prodyuth@gmail.com,
	yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Milton,

On Friday, January 16, 2009 you wrote:

> On Jan 12, 2009, at 4:49 PM, Yuri Tikhonov wrote:

>> This patch adds support for 256KB pages on ppc44x-based boards.

> Another day, another comment.  The motivation for reply was the second
> comment below.

>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 84b8613..18f33ef 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -443,6 +443,19 @@ config PPC_64K_PAGES
>>       bool "64k page size" if 44x || PPC_STD_MMU_64
>>       select PPC_HAS_HASH_64K if PPC_STD_MMU_64
>>
>> +config PPC_256K_PAGES
>> +     bool "256k page size" if 44x
>> +     depends on !STDBINUTILS && !SHMEM

> depends on !STDBINUTILS && (!SHMEM || BROKEN)

> to identify that it is not fundamentally incompatable just not a chance
> of working without other changes.

 This makes sense.

[..]

>> +config STDBINUTILS
>> +     bool "Using standard binutils settings"
>> +     depends on 44x
>> +     default y


> I think this should be

> config STDBINUTILS
>         bool "Using standard binutils settings" if 44x
>         default y

> that way we imply that all powerpc users are using the standard=20
> binutils instead of only those using a 44x platform.  We still get the
> intended effect of asking the user only on 44x.

> I haven't looked at the resulting question or config order to see if it
> makes sense to leave it here or put it closer to the page size.

 I'm not sure about this. For 44x platforms - the STDBINUTILS option=20
is reasonable, because it's used in the PAGE_SIZE selection process.=20
But as regarding the other powerpcs the STDBINUTILS option will do=20
nothing, but taking a superfluous string in configs. Are you sure this=20
will be better ?

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
