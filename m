Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BE2C7DDF5D
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 21:29:22 +1100 (EST)
Date: Wed, 10 Dec 2008 13:29:12 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <1795455197.20081210132912@emcraft.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re[2]: [PATCH] fork_init: fix division by zero
In-Reply-To: <20081210101745.GG28946@ZenIV.linux.org.uk>
References: <200812092044.40649.yur@emcraft.com>
	<Pine.LNX.4.64.0812100944080.25126@vixen.sonytel.be>
	<503391615.20081210130113@emcraft.com>
	<20081210101745.GG28946@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>,
	linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=0D=0A Hello Al,

On Wednesday, December 10, 2008 you wrote:

> On Wed, Dec 10, 2008 at 01:01:13PM +0300, Yuri Tikhonov wrote:

>> >> +     max_threads =3D mempages * PAGE_SIZE / (8 * THREAD_SIZE);
>> >                       ^^^^^^^^^^^^^^^^^^^^
>> >> +#endif
>>=20
>> > Can't this overflow, e.g. on 32-bit machines with HIGHMEM?
>>=20
>>  The multiplier here is not PAGE_SIZE, but [PAGE_SIZE / (8 *=20
>> THREAD_SIZE)], and this value is expected to be rather small (2, 4, or=
=20
>> so).

> x * y / z is parsed as (x * y) / z, not x * (y / z).

 Here we believe in preprocessor: since all PAGE_SIZE, 8, and=20
THREAD_SIZE are the constants we expect it will calculate this.

 E.g. here is the result from this line as produced by cross-gcc=20
4.2.2:

        lis     r9,0
        rlwinm  r29,r29,2,16,29
        stw     r29,0(r9)

 As you see - only rotate-left, i.e. multiplication to the constant.

 In any case, adding braces as follows probably would be better:

+     max_threads =3D mempages * (PAGE_SIZE / (8 * THREAD_SIZE));

 Right ?

> Only assignment operators (and ?:, in a sense that a ? b : c ? d : e is
> parsed as a ? b : (c ? d : e)) are right-to-left.  The rest is left-to-ri=
ght.



 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
