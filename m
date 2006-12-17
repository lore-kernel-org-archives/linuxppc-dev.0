Return-Path: <tnt@246tNt.com>
Received: from outmx020.isp.belgacom.be (outmx020.isp.belgacom.be
	[195.238.4.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A47B567BE4
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Dec 2006 22:37:21 +1100 (EST)
Received: from outmx020.isp.belgacom.be (localhost [127.0.0.1])
	by outmx020.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kBHBb82C007582
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Dec 2006 12:37:08 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45852B95.6050008@246tNt.com>
Date: Sun, 17 Dec 2006 12:35:49 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Joerg Maier <joerg.maier@shove-it.de>
Subject: Re: compile error on 2.6.20-rc1
References: <20061216135256.GB7526@shove-it.de>
In-Reply-To: <20061216135256.GB7526@shove-it.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joerg Maier wrote:
> Hi,
>
> i got the following compile error:
>
> $ gcc -m32 -Wp,-MD,drivers/usb/host/.ohci-hcd.o.d  -nostdinc -isystem /usr/lib/gcc/powerpc-linux-gnu/4.1.2/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -Iarch/powerpc -Iarch/powerpc/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -O2 -msoft-float -pipe -Iarch/powerpc -ffixed-r2 -mmultiple -mno-altivec -funit-at-a-time -mstring -mcpu=powerpc -Wa,-maltivec -fomit-frame-pointer -g  -fno-stack-protector -Wdeclaration-after-statement -Wno-pointer-sign   -DMODULE -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(ohci_hcd)"  -D"KBUILD_MODNAME=KBUILD_STR(ohci_hcd)" -c -o drivers/usb/host/.tmp_ohci-hcd.o drivers/usb/host/ohci-hcd.c
> In file included from drivers/usb/host/ohci-hcd.c:945:
> drivers/usb/host/ohci-ppc-soc.c:225: error: redefinition of '__inittest'
> drivers/usb/host/ohci-pci.c:252: error: previous definition of '__inittest' was here
> drivers/usb/host/ohci-ppc-soc.c:225: error: redefinition of 'init_module'
> drivers/usb/host/ohci-pci.c:252: error: previous definition of 'init_module' was here
> drivers/usb/host/ohci-ppc-soc.c:226: error: redefinition of '__exittest'
> drivers/usb/host/ohci-pci.c:260: error: previous definition of '__exittest' was here
> drivers/usb/host/ohci-ppc-soc.c:226: error: redefinition of 'cleanup_module'
> drivers/usb/host/ohci-pci.c:260: error: previous definition of 'cleanup_module' was here
>
> i found both CONFIG macros set in my config: CONFIG_USB_OHCI_HCD_PPC_SOC and CONFIG_PCI. they lead to an include for ohci-ppc-soc.c and ohci-pci.c. Both declare (after preprocessing)  the symbol __inittest.
>
> Is the use of these two config options an error?
>
> Hoping that this was not discussed before and i did not find it.
>
> Joerg
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>   
You can't compile ohci in module if you have several bus glues.

I sent a fix for this, it is in Greg KH "list", pending merge ...


    Sylvain
