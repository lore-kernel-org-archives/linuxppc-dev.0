Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 22A08DDEDA
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 07:14:33 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: CONFIG_PS3_USE_LPAR_ADDR dramically increases boot time
Date: Mon, 18 Jun 2007 23:14:26 +0200
References: <F4482BED-242B-42AD-96FF-3CB14B6BC5BE@watson.ibm.com>
In-Reply-To: <F4482BED-242B-42AD-96FF-3CB14B6BC5BE@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706182314.26918.arnd@arndb.de>
Cc: Jimi Xenidis <jimix@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 18 June 2007, Jimi Xenidis wrote:
>=20
> The following change set:
> =A0 =A0http://git.kernel.org/?p=3Dlinux/kernel/git/paulus/=20
> powerpc.git;a=3Dcommit;h=3D261efc3f178c8c5b55d76208aee1f39ce247f723
>=20
> setting CONFIG_PS3_USE_LPAR_ADDR (which is the default for PS3) =A0
> changes increases MAX_PHYSADDR_BITS =A0from 44 to 47 which makes the =A0
> array 8 time bigger and takes way longer for sparse_init() to run on =A0
> simulator.
>=20
> Is this really the right approach?
> Cell is actually 42 so could not the special address space be 43 or 44?

Unfortunately, the hypervisor chooses the addresses where things get
mapped, and since they are guest-real, there is no hard limit where
the hypervisor puts them, like the 42 bit limit on bare metal.

I guess this will improve if we get virt_mem_map support on powerpc,
but I'm not sure if that's currently being worked on.

	Arnd <><
