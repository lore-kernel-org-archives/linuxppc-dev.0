Return-Path: <jotken@softadvances.com>
Received: from smtpauth02.mail.atl.earthlink.net
	(smtpauth02.mail.atl.earthlink.net [209.86.89.62])
	by ozlabs.org (Postfix) with ESMTP id 861A2679E6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Mar 2006 06:14:48 +1100 (EST)
Received: from [63.246.179.245] (helo=[192.168.8.100])
	by smtpauth02.mail.atl.earthlink.net with asmtp (Exim 4.34)
	id 1FGL4F-0000DN-RB
	for linuxppc-embedded@ozlabs.org; Mon, 06 Mar 2006 14:08:28 -0500
Message-ID: <440C88B1.6010809@softadvances.com>
Date: Mon, 06 Mar 2006 13:08:33 -0600
From: John Otken <jotken@softadvances.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: make modules_install fails with [_modinst_post] Error 139
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm trying to build the USB gadget file storage module for
a Yosemite board using the latest Denx kernel and ELDK4.

$ make yosemite_defconfig
$ make menuconfig  # turn on CONFIG_USB_FILE_STORAGE <M>
$ make uImage
$ make modules
$ make modules_install INSTALL_MOD_PATH=/opt/eldk4/ppc_4xxFP
   INSTALL drivers/usb/gadget/g_file_storage.ko
if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map -b /opt/eldk4/ppc_4xxFP -r 2.6.15-g6afd198e; fi
make: *** [_modinst_post] Error 139

I see a g_file_storage.ko but I get an "Invalid module" if I
try to modprobe it.

I do want to solve this problem, but if anyone wants to give
me the trick to building the gadget driver into kernel and
passing the file=disk_image parameter, I'd like to know that
as well.

Thanks in advance.
