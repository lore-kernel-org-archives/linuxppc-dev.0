Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E2C44DDDFB
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:17:06 +1100 (EST)
In-Reply-To: <200703160134.23536.arnd@arndb.de>
References: <Pine.LNX.4.64.0703151816370.3448@localhost.localdomain>
	<200703160134.23536.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3999EC16-6013-4632-A0A5-376D006CE057@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RFC: arch/powerpc Kconfig cleanup
Date: Thu, 15 Mar 2007 20:16:14 -0500
To: Arnd Bergmann <arnd@arndb.de>
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


On Mar 15, 2007, at 7:34 PM, Arnd Bergmann wrote:

> On Friday 16 March 2007, Kumar Gala wrote:
>> +
>> +config PPC_PS3
>> +       bool "Sony PS3 (incomplete)"
>> +       depends on PPC_MULTIPLATFORM && PPC64
>> +       select PPC_CELL
>> +       select USB_ARCH_HAS_OHCI
>> +       select USB_OHCI_LITTLE_ENDIAN
>> +       select USB_OHCI_BIG_ENDIAN_MMIO
>> +       select USB_ARCH_HAS_EHCI
>> +       select USB_EHCI_BIG_ENDIAN_MMIO
>> +       help
>> +         This option enables support for the Sony PS3 game console
>> +         and other platforms using the PS3 hypervisor.
>> +         Support for this platform is not yet complete, so
>> +         enabling this will not result in a bootable kernel on a
>> +         PS3 system.
>> +
>> +config PPC_CELLEB
>> +       bool "Toshiba's Cell Reference Set 'Celleb' Architecture"
>> +       depends on PPC_MULTIPLATFORM && PPC64
>> +       select PPC_CELL
>> +       select PPC_OF_PLATFORM_PCI
>> +       select HAS_TXX9_SERIAL
>> +       select PPC_UDBG_BEAT
>> +       select USB_OHCI_BIG_ENDIAN_MMIO
>> +       select USB_EHCI_BIG_ENDIAN_MMIO
>
> I'm not sure if these should really be part of cell/Kconfig, as  
> they are
> about platform code that is in other directories. I think it would  
> make
> more sense conceptually to have them in ps3/Kconfig and celleb/ 
> Kconfig.
>
> At some point we should also separate the common code (mostly spufs)
> from the cell native support that does not apply to ps3 and celleb.

Fair point, I'll fix that up.  I'm more interested if people are ok  
with having the 'Cell Broadband Engine options' under 'Platform  
support' is ok or if it should stay at the top level.

- k
