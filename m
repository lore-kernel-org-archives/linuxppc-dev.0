Return-Path: <jotken@softadvances.com>
Received: from elasmtp-junco.atl.sa.earthlink.net
	(elasmtp-junco.atl.sa.earthlink.net [209.86.89.63])
	by ozlabs.org (Postfix) with ESMTP id F1B9C679EA
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Mar 2006 07:42:15 +1100 (EST)
Message-ID: <440C9EAB.7080504@softadvances.com>
Date: Mon, 06 Mar 2006 14:42:19 -0600
From: John Otken <jotken@softadvances.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: make modules_install fails with [_modinst_post] Error 139
References: <20060306195926.C7B303525CB@atlas.denx.de>
In-Reply-To: <20060306195926.C7B303525CB@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Wolfgang Denk wrote:
> In message <440C88B1.6010809@softadvances.com> you wrote:
>> I'm trying to build the USB gadget file storage module for
>> a Yosemite board using the latest Denx kernel and ELDK4.
>>
>> $ make yosemite_defconfig
>> $ make menuconfig  # turn on CONFIG_USB_FILE_STORAGE <M>
> 
> This is not necessary. The default config file for the Yosemite board
> has USB and mass storage devices support  already  enabled  (compiled
> in, i. e. not as modules). Just use the unmodified config file and it
> will work.
> 
> Note that CONFIG_USB_GADGET is not set, though (not sure what exactly
> you want to do).

I want to simulate an USB thumb drive using the Yosemite's device
interface.  So the Yosemite board is the thumb drive.  I am not trying
to connect a thumb drive to the Yosemite.  Sorry if I wasn't clear.

I do not believe the device-side driver for the 440EP Musbhsfc is in
the kernel tree yet, so this will give me a chance to test the patch
that Wade Farnsworth released last September.

>> if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map -b /opt/eldk4/ppc_4xxFP -r 2.6.15-g6afd198e; fi
>> make: *** [_modinst_post] Error 139
>>
>> I see a g_file_storage.ko but I get an "Invalid module" if I
>> try to modprobe it.
> 
> Your native system's (x86 ?) module utilities (depmod,  modprobe)  do
> not understand PowerPC modules. If you want to run "depmod", you must
> overwrite  the  Makefile's  default  setting of DEPMOD to use a cross
> version of depmod instead.

Thanks, I'll work on that.

>> I do want to solve this problem, but if anyone wants to give
>> me the trick to building the gadget driver into kernel and
>> passing the file=disk_image parameter, I'd like to know that
>> as well.
> 
> What exactly do you have in mind?

Menuconfig does not let me build-in the gadget filesystem driver.  It
insists on it being a module.  I saw something that says you can build
one gadget driver into the kernel, but I was not able to figure out the
trick.  I'm also not clear about passing parameters to the driver, but
I'll try bootargs first.
