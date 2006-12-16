Return-Path: <joerg.maier@shove-it.de>
Received: from shove-it.de (shove-it.de [213.239.221.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9799E679FD
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Dec 2006 01:05:22 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by shove-it.de (Postfix) with ESMTP id 0D78BB5CE
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Dec 2006 14:53:02 +0100 (CET)
Received: from shove-it.de ([127.0.0.1])
	by localhost (shove-it.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 21622-06 for <linuxppc-dev@ozlabs.org>;
	Sat, 16 Dec 2006 14:52:56 +0100 (CET)
Date: Sat, 16 Dec 2006 14:52:56 +0100
From: Joerg Maier <joerg.maier@shove-it.de>
To: linuxppc-dev@ozlabs.org
Subject: compile error on 2.6.20-rc1
Message-ID: <20061216135256.GB7526@shove-it.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

i got the following compile error:

$ gcc -m32 -Wp,-MD,drivers/usb/host/.ohci-hcd.o.d  -nostdinc -isystem /usr/lib/gcc/powerpc-linux-gnu/4.1.2/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -Iarch/powerpc -Iarch/powerpc/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -O2 -msoft-float -pipe -Iarch/powerpc -ffixed-r2 -mmultiple -mno-altivec -funit-at-a-time -mstring -mcpu=powerpc -Wa,-maltivec -fomit-frame-pointer -g  -fno-stack-protector -Wdeclaration-after-statement -Wno-pointer-sign   -DMODULE -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(ohci_hcd)"  -D"KBUILD_MODNAME=KBUILD_STR(ohci_hcd)" -c -o drivers/usb/host/.tmp_ohci-hcd.o drivers/usb/host/ohci-hcd.c
In file included from drivers/usb/host/ohci-hcd.c:945:
drivers/usb/host/ohci-ppc-soc.c:225: error: redefinition of '__inittest'
drivers/usb/host/ohci-pci.c:252: error: previous definition of '__inittest' was here
drivers/usb/host/ohci-ppc-soc.c:225: error: redefinition of 'init_module'
drivers/usb/host/ohci-pci.c:252: error: previous definition of 'init_module' was here
drivers/usb/host/ohci-ppc-soc.c:226: error: redefinition of '__exittest'
drivers/usb/host/ohci-pci.c:260: error: previous definition of '__exittest' was here
drivers/usb/host/ohci-ppc-soc.c:226: error: redefinition of 'cleanup_module'
drivers/usb/host/ohci-pci.c:260: error: previous definition of 'cleanup_module' was here

i found both CONFIG macros set in my config: CONFIG_USB_OHCI_HCD_PPC_SOC and CONFIG_PCI. they lead to an include for ohci-ppc-soc.c and ohci-pci.c. Both declare (after preprocessing)  the symbol __inittest.

Is the use of these two config options an error?

Hoping that this was not discussed before and i did not find it.

Joerg
