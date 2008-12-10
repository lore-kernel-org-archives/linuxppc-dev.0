Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ACA95DDEE8
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 21:01:34 +1100 (EST)
Date: Wed, 10 Dec 2008 13:01:13 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <503391615.20081210130113@emcraft.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re[2]: [PATCH] fork_init: fix division by zero
In-Reply-To: <Pine.LNX.4.64.0812100944080.25126@vixen.sonytel.be>
References: <200812092044.40649.yur@emcraft.com>
	<Pine.LNX.4.64.0812100944080.25126@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Detlev Zundel <dzu@denx.de>, Ilya Yanok <yanok@emcraft.com>,
	linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=0D=0A Hello Geert,

On Wednesday, December 10, 2008 you wrote:
> On Tue, 9 Dec 2008, Yuri Tikhonov wrote:
>> The following patch fixes divide-by-zero error for the
>> cases of really big PAGE_SIZEs (e.g. 256KB on ppc44x).
>> Support for such big page sizes on 44x is not present in the
>> current kernel yet, but coming soon.
>>=20
>> Also this patch fixes the comment for the max_threads
>> settings, as this didn't match the things actually done
>> in the code.
>>=20
>> Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
>> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
>> ---
>>  kernel/fork.c |    8 ++++++--
>>  1 files changed, 6 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index 2a372a0..b0ac2fb 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -181,10 +181,14 @@ void __init fork_init(unsigned long mempages)
>> =20
>>       /*
>>        * The default maximum number of threads is set to a safe
>> -      * value: the thread structures can take up at most half
>> -      * of memory.
>> +      * value: the thread structures can take up at most
>> +      * (1/8) part of memory.
>>        */
>> +#if (8 * THREAD_SIZE) > PAGE_SIZE
>>       max_threads =3D mempages / (8 * THREAD_SIZE / PAGE_SIZE);
>> +#else
>> +     max_threads =3D mempages * PAGE_SIZE / (8 * THREAD_SIZE);
>                       ^^^^^^^^^^^^^^^^^^^^
>> +#endif

> Can't this overflow, e.g. on 32-bit machines with HIGHMEM?

 The multiplier here is not PAGE_SIZE, but [PAGE_SIZE / (8 *=20
THREAD_SIZE)], and this value is expected to be rather small (2, 4, or=20
so).

 Furthermore, due to the #if/#endif construction multiplication is=20
used only with rather big PAGE_SIZE values, and the bigger page size=20
is then the smaller 'mempages' is.

 So, for example, when running with PAGE_SIZE=3D256KB, THREAD_SIZE=3D8KB,=
=20
on 32-bit 440spe-based machine with 4GB RAM installed, here we have:

 max_threads =3D (4G/256K) * (256K / 8 * 8K) =3D 16384 * 4 =3D 65536.

 And the overflow will have a place only in case of very very big=20
sizes of RAM: >=3D 256TB:

 max_threads =3D (256T / 256K) * (256K / 8 * 8K) =3D 0x4000.0000 * 4.

 But I don't think that with 256TB RAM installed this code will be=20
the only place of problems :)

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
