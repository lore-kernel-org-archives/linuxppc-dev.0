To: priyadk@future.futsoft.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Rpxlite Booting 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 20 Aug 2002 19:37:53 +0530."
             <000501c24852$fa3e4be0$1106140a@future.futsoft.com>
Date: Tue, 20 Aug 2002 17:24:41 +0200
Message-Id: <20020820152446.6F29D10DF8@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000501c24852$fa3e4be0$1106140a@future.futsoft.com> you wrote:
>
>    I am trying to recompile the Hardhat kernel for Embedded Planet rpxlite
> board and boot the target. But I have problems.

... which are  probably  caused  by  not  reading  the  mailing  list
archives and other documentation.

>    1) Are there any specific options I need to set/change while compiling
> the Hardhat kernel (with menuconfig or the compiler options)?

I guess you mean the Linux kernel.

>       One of the compiler options is mcpu=860. The Rpxlite board is based on
> MPC823e. Should the mcpu option be changed for it?

No.

ALl you need to do to get a working default configuration is:

	bash$ make mrproper
	bash$ make rpxlite_config
	bash$ make oldconfig
	bash$ make dep
	bash$ make pImage

The last step assumes that you have PPCBoot enabled  kernel  sources;
I'm  not  sure  what version of kernel tree you're using, so I cannot
comment on this.

>    2) What is the bfdformat of the image expected by the rpxlite board?

This depends on the boot loader you use.

> Should I build the kernel image in S record format?

If your bootloader needs S-records, then yes.

>    3) If so can I compress the image using gzip? Should the compression be
> done before mkimage or after mkimage?

Since you mention "mkimage" I assume you use PPCBoot as boot loader -
and actually this is the only reason I reply at all.

Why don't you just read the README that comes with PPCBoot?

If there is anything in this README file which is  not  clear  please
let me know, and I will try to improve it.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It all seemed, he thought, to be rather a lot of  trouble  to  go  to
just sharpen a razor blade.  - Terry Pratchett, _The Light Fantastic_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
