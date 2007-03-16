Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 2DA00DDE06
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 11:34:45 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RFC: arch/powerpc Kconfig cleanup
Date: Fri, 16 Mar 2007 01:34:22 +0100
References: <Pine.LNX.4.64.0703151816370.3448@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0703151816370.3448@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703160134.23536.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 16 March 2007, Kumar Gala wrote:
> +
> +config PPC_PS3
> +=A0=A0=A0=A0=A0=A0=A0bool "Sony PS3 (incomplete)"
> +=A0=A0=A0=A0=A0=A0=A0depends on PPC_MULTIPLATFORM && PPC64
> +=A0=A0=A0=A0=A0=A0=A0select PPC_CELL
> +=A0=A0=A0=A0=A0=A0=A0select USB_ARCH_HAS_OHCI
> +=A0=A0=A0=A0=A0=A0=A0select USB_OHCI_LITTLE_ENDIAN
> +=A0=A0=A0=A0=A0=A0=A0select USB_OHCI_BIG_ENDIAN_MMIO
> +=A0=A0=A0=A0=A0=A0=A0select USB_ARCH_HAS_EHCI
> +=A0=A0=A0=A0=A0=A0=A0select USB_EHCI_BIG_ENDIAN_MMIO
> +=A0=A0=A0=A0=A0=A0=A0help
> +=A0=A0=A0=A0=A0=A0=A0 =A0This option enables support for the Sony PS3 ga=
me console
> +=A0=A0=A0=A0=A0=A0=A0 =A0and other platforms using the PS3 hypervisor.
> +=A0=A0=A0=A0=A0=A0=A0 =A0Support for this platform is not yet complete, =
so
> +=A0=A0=A0=A0=A0=A0=A0 =A0enabling this will not result in a bootable ker=
nel on a
> +=A0=A0=A0=A0=A0=A0=A0 =A0PS3 system.
> +
> +config PPC_CELLEB
> +=A0=A0=A0=A0=A0=A0=A0bool "Toshiba's Cell Reference Set 'Celleb' Archite=
cture"
> +=A0=A0=A0=A0=A0=A0=A0depends on PPC_MULTIPLATFORM && PPC64
> +=A0=A0=A0=A0=A0=A0=A0select PPC_CELL
> +=A0=A0=A0=A0=A0=A0=A0select PPC_OF_PLATFORM_PCI
> +=A0=A0=A0=A0=A0=A0=A0select HAS_TXX9_SERIAL
> +=A0=A0=A0=A0=A0=A0=A0select PPC_UDBG_BEAT
> +=A0=A0=A0=A0=A0=A0=A0select USB_OHCI_BIG_ENDIAN_MMIO
> +=A0=A0=A0=A0=A0=A0=A0select USB_EHCI_BIG_ENDIAN_MMIO

I'm not sure if these should really be part of cell/Kconfig, as they are
about platform code that is in other directories. I think it would make
more sense conceptually to have them in ps3/Kconfig and celleb/Kconfig.

At some point we should also separate the common code (mostly spufs)
from the cell native support that does not apply to ps3 and celleb.

	Arnd <><
