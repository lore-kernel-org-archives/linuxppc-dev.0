Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5EC74DDF5A
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 04:57:18 +1100 (EST)
Date: Wed, 10 Dec 2008 20:56:51 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <527599002.20081210205651@emcraft.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re[2]: [PATCH] fork_init: fix division by zero
In-Reply-To: <20081210172512.GA19584@ld0162-tx32.am.freescale.net>
References: <200812092044.40649.yur@emcraft.com>
	<Pine.LNX.4.64.0812100944080.25126@vixen.sonytel.be>
	<503391615.20081210130113@emcraft.com>
	<20081210101745.GG28946@ZenIV.linux.org.uk>
	<1795455197.20081210132912@emcraft.com>
	<20081210172512.GA19584@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>,
	linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Al Viro <viro@ZenIV.linux.org.uk>,
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

=0D=0AHello Scott,

On Wednesday, December 10, 2008 you wrote:

> On Wed, Dec 10, 2008 at 01:29:12PM +0300, Yuri Tikhonov wrote:
>> On Wednesday, December 10, 2008 you wrote:
>> > x * y / z is parsed as (x * y) / z, not x * (y / z).
>>=20
>>  Here we believe in preprocessor: since all PAGE_SIZE, 8, and=20
>> THREAD_SIZE are the constants we expect it will calculate this.
>>=20
>>  E.g. here is the result from this line as produced by cross-gcc=20
>> 4.2.2:
>>=20
>>         lis     r9,0
>>         rlwinm  r29,r29,2,16,29
>>         stw     r29,0(r9)
>>=20
>>  As you see - only rotate-left, i.e. multiplication to the constant.

> Yes, and also note that it is masking the result by 0xfffc, to preserve
> the effect of any overflow in (x * y).

 Right, such a mask was the result of missed brackets. Now (see=20
"[PATCH][v2] fork_init: fix division by zero" I've just posted) the=20
situation is better:

        lis     r9,0
        rlwinm  r29,r29,2,0,29
        stw     r29,0(r9)

 I.e. the mask is 0xFFFFFFFC.

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
