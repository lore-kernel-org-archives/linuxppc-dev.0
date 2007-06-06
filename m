Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 4856FDDEB8
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 00:22:06 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 05/18] PS3: Fix sparse warnings
Date: Wed, 6 Jun 2007 16:21:59 +0200
References: <20070606024407.786638029@am.sony.com>
	<20070606024407.786638029@am.sony.com>>
	<46662326.4030706@am.sony.com>
In-Reply-To: <46662326.4030706@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706061621.59963.arnd@arndb.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 06 June 2007, Geoff Levand wrote:
> -=A0=A0=A0=A0=A0=A0=A0spu->local_store =3D ioremap(spu->local_store_phys,=
 LS_SIZE);
> +=A0=A0=A0=A0=A0=A0=A0spu->local_store =3D (__force void *)ioremap(spu->l=
ocal_store_phys,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 L=
S_SIZE);

I haven't noticed this before, but it seems to be a preexisting bug:
You map the local_store as with the guarded page table bit set, which
causes a performance degradation when accessing the memory from kernel
space.

If you're lucky, your hypervisor knows this and will fix it up for
you, but I would replace the ioremap call with an
ioremap_flags(..., _PAGE_NO_CACHE); to be on the safe side.

If you want to measure the impact, I'd suggest timing a user space
read() on the mem file of a running SPU context.

	Arnd <><
