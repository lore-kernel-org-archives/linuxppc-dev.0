Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 819B0DDEE8
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 21:55:31 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: RFC: arch/powerpc Kconfig cleanup
Date: Fri, 16 Mar 2007 11:54:49 +0100
References: <Pine.LNX.4.64.0703151816370.3448@localhost.localdomain>
	<200703160134.23536.arnd@arndb.de>
	<3999EC16-6013-4632-A0A5-376D006CE057@kernel.crashing.org>
In-Reply-To: <3999EC16-6013-4632-A0A5-376D006CE057@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703161154.50218.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 16 March 2007, Kumar Gala wrote:
> >
> > At some point we should also separate the common code (mostly spufs)
> > from the cell native support that does not apply to ps3 and celleb.
>=20
> Fair point, I'll fix that up. =A0I'm more interested if people are ok =A0
> with having the 'Cell Broadband Engine options' under 'Platform =A0
> support' is ok or if it should stay at the top level.

I was never happy with having it at the top level, but I couldn't
figure out a better way at the time, and I think I just copied what
some other platforms did.

I think it would be good to turn them into menuconfig entries, so
that if platforms/Kconfig basically contains

source arch/powerpc/platforms/pseries/Kconfig
source arch/powerpc/platforms/powermac/Kconfig
source arch/powerpc/platforms/cell/Kconfig
source arch/powerpc/platforms/celleb/Kconfig
source arch/powerpc/platforms/ps3/Kconfig
=2E..

each of them can either be

config CELLEB
	bool "support for celleb"
	select FOO
	select BAR

or

menuconfig PSERIES
	bool "support for pseries"
	select BAR
	select BAZ
config PSERIES_FOO
	bool "option foo for pseries"
	depends on PSERIES
endmenu

	Arnd <><
