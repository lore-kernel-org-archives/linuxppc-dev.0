MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: UPM driver of MPC8260 
Date: Thu, 1 Jul 2004 06:37:54 -0600
Message-ID: <065ACD8E84315E4394C835E398C8D5EB09229A@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf
> Of Alireza
> Sadri
> Sent: Thursday, July 01, 2004 7:13 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: UPM driver of MPC8260
>
>
>
> Hi , thanks for your attentins.
>
> I am not an expert, but i know the meanings of
> programming of the board , ppcboot(bootloader) ,
> kernel , linux,  ELDK(I have compiled it for my
> board), driver , service , and i am familiar with
> MPC8260 as a microprocessor.I was working on hardware
> of this board.
> we made a copy , a customized copy.
>
> now i am working on software ,
> i am going to make my custom SBC8260 standalone , so i
> need to replace the ppcboot of the board with a
> bootable linux image. I want this linux to mount the
> flash, and then i put my own final program on the
> flash , and as a service, linux will run the program
> on any reset.(now,it would be standalone)
>
> so i cannot hold the ppcboot (u-boot) on the flash, i
> need the changes in my linux image , or using a linux
> driver.
>
> Can you please guide me through this process?
> If I have to replace ppcboot , how can have
> bootloader?
> (I know board needs bootloader anyway , but i don't
> know what it is. is it ppcboot? or ELDK makes a
> bootable linux?)
>
> Any other point of view is really wellcome.
>
> Best Regards.

U-boot is the bootloader.  You must have it (or equivalent, but u-boot is probably your easiest option).  If you are truly using ppcboot, you should upgrade to u-boot (it is the successor of ppcboot).

U-boot lives in flash and boots the board.  You can build a linux image and put it also in flash.

READ the ELDK documentation for lots of useful help
  http://www.denx.de/twiki/bin/view/DULG/Faq
  http://www.denx.de/twiki/bin/view/DULG/Manual

U-boot image formats
  http://www.denx.de/twiki/bin/view/DULG/UBootImages

Making a linux image suitable for booting via u-boot
  http://www.denx.de/twiki/bin/view/DULG/LinuxConfiguration

  "The make target uImage uses the tool mkimage (from the U-Boot package) to create a Linux kernel image in arch/ppc/boot/images/uImage which is immediately usable for download and booting with U-Boot."

You should set up a TFTP server and booting your kernel off of the server until you are happy with it.
  http://www.denx.de/twiki/bin/view/DULG/LinuxNfsRoot
The following page is aimed at debian, but may be helpful.
  http://www.denx.de/twiki/bin/view/DULG/DebianOnPowerpcInstallationHowto

At that point, copy the uImage to flash somewhere (where it doesn't overwrite anything important, of course) and boot it directly from flash via u-boot's command prompt.  When you are happy with that, you can use u-boot's environment variables to create an "auto-execute" script to boot linux "hands off."
  http://www.denx.de/twiki/bin/view/DULG/LinuxBootIntro
  http://www.denx.de/twiki/bin/view/DULG/LinuxInFlash

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
