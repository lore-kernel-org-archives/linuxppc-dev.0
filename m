Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 037FC679E6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Mar 2006 06:59:29 +1100 (EST)
To: John Otken <jotken@softadvances.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: make modules_install fails with [_modinst_post] Error 139 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 06 Mar 2006 13:08:33 CST."
	<440C88B1.6010809@softadvances.com>
Date: Mon, 06 Mar 2006 20:59:26 +0100
Sender: wd@denx.de
Message-Id: <20060306195926.C7B303525CB@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <440C88B1.6010809@softadvances.com> you wrote:
> I'm trying to build the USB gadget file storage module for
> a Yosemite board using the latest Denx kernel and ELDK4.
> 
> $ make yosemite_defconfig
> $ make menuconfig  # turn on CONFIG_USB_FILE_STORAGE <M>

This is not necessary. The default config file for the Yosemite board
has USB and mass storage devices support  already  enabled  (compiled
in, i. e. not as modules). Just use the unmodified config file and it
will work.

Note that CONFIG_USB_GADGET is not set, though (not sure what exactly
you want to do).

> if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map -b /opt/eldk4/ppc_4xxFP -r 2.6.15-g6afd198e; fi
> make: *** [_modinst_post] Error 139
> 
> I see a g_file_storage.ko but I get an "Invalid module" if I
> try to modprobe it.

Your native system's (x86 ?) module utilities (depmod,  modprobe)  do
not understand PowerPC modules. If you want to run "depmod", you must
overwrite  the  Makefile's  default  setting of DEPMOD to use a cross
version of depmod instead.

> I do want to solve this problem, but if anyone wants to give
> me the trick to building the gadget driver into kernel and
> passing the file=disk_image parameter, I'd like to know that
> as well.

What exactly do you have in mind?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Our management frequently gets lost in thought.   That's because it's
unfamiliar territory.
