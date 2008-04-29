Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 3E7FBDDE1A
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 19:46:48 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] Raise the upper limit of NR_CPUS and move the pacas
	into the BSS.
Date: Tue, 29 Apr 2008 11:46:30 +0200
References: <b863aa7fba7b2b00cb72d327fdd7a04b6cb81106.1209008469.git.tony@bakeyournoodle.com>
	<6bbf4d3637c9b72f9f0a4cf8a6f2c322c0784d7e.1209008469.git.tony@bakeyournoodle.com>
In-Reply-To: <6bbf4d3637c9b72f9f0a4cf8a6f2c322c0784d7e.1209008469.git.tony@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804291146.30353.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 24 April 2008, Tony Breeds wrote:
> This patch adds the required functionality to fill in all pacas at runtim=
e.
>=20
> With NR_CPUS=3D1024
> text =A0 =A0data =A0 =A0 bss =A0 =A0 dec =A0 =A0 hex filename
> =A0137 1704032 =A0 =A0 =A0 0 1704169 =A01a00e9 arch/powerpc/kernel/paca.o=
 :Before
> =A0121 1179744 =A0524288 1704153 =A01a00d9 arch/powerpc/kernel/paca.o :Af=
ter
>=20
> Also remove unneeded #includes from arch/powerpc/kernel/paca.c
>=20
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

Maybe we can go even further than this: Since it is now a substantial amount
of .bss, maybe the unused parts can be returned to the buddy allocator
using free_bootmem or similar once you know how many CPUs there are?

I know that this would be an evil hack, but it may still be worth it.
Your patch should certainly go in first though, freeing the memory would
be an additional extension.

	Arnd <><
