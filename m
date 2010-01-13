Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3CD43B7CA8
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 05:59:10 +1100 (EST)
Subject: Re: [PATCH]: powerpc: Fix build breakage due to incorrect location	of
	autoconf.h
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <OFF0BABDB9.D573B5F9-ONC12576A9.0041BA69-C12576A9.0041D76A@transmode.se>
Date: Wed, 13 Jan 2010 12:54:51 -0600
Message-Id: <FB3DFBD5-9976-4D03-828A-EB4E6E08DAA4@kernel.crashing.org>
References: <20100112022150.GE12666@kryten>
	<20100112140136.c8ccc357.sfr@canb.auug.org.au>
	<OFF0BABDB9.D573B5F9-ONC12576A9.0041BA69-C12576A9.0041D76A@transmode.se>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Roel Kluin <roel.kluin@gmail.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Richard Purdie <rpurdie@rpsys.net>, Anton Blanchard <anton@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 12, 2010, at 5:59 AM, Joakim Tjernlund wrote:

>>=20
>> Hi Anton,
>>=20
>> On Tue, 12 Jan 2010 13:21:51 +1100 Anton Blanchard <anton@samba.org> =
wrote:
>>>=20
>>> commit ac4c2a3bbe5db5fc570b1d0ee1e474db7cb22585 (zlib: optimize =
inffast when
>>> copying direct from output) referenced include/linux/autoconf.h =
which
>>> is now called include/generated/autoconf.h.
>>=20
>> Even with this fix, you cannot build with a separate object =
directory.
>> See my other posting "linux-next: origin tree build failure" ...
>> --
>=20
> How does this work for you?
>=20
>> =46rom 044f40d169bf5fe189d5cb058f56b7cd72675ca4 Mon Sep 17 00:00:00 =
2001
> From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> Date: Tue, 12 Jan 2010 11:20:36 +0100
> Subject: [PATCH] powerpc: Fix build breakage due to incorrect location =
of autoconf.h
>=20
> commit ac4c2a3bbe5db5fc570b1d0ee1e474db7cb22585 (zlib: optimize =
inffast when
> copying direct from output) referenced include/linux/autoconf.h which
> is now called include/generated/autoconf.h.
> Also, -I include paths needs to be prefixed with $(srctree)
>=20
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> ---
> arch/powerpc/boot/Makefile |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 826a30a..79ebd6f 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -34,8 +34,8 @@ BOOTCFLAGS	+=3D -fno-stack-protector
> endif
>=20
> BOOTCFLAGS	+=3D -I$(obj) -I$(srctree)/$(obj)
> -BOOTCFLAGS	+=3D -include include/linux/autoconf.h =
-Iarch/powerpc/include
> -BOOTCFLAGS	+=3D -Iinclude
> +BOOTCFLAGS	+=3D -include include/generated/autoconf.h
> +BOOTCFLAGS	+=3D -I$(srctree)/arch/powerpc/include =
-I$(srctree)/include
>=20
> DTS_FLAGS	?=3D -p 1024
>=20

Ack, this works for me (seeing as -rc4 doesn't generate uImages w/o it =
:)

- k=
