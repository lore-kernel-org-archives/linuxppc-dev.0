Return-Path: <christophe.alayrac@cresitt.com>
Received: from ka.univ-orleans.fr (ka.univ-orleans.fr [193.49.83.5])
	by ozlabs.org (Postfix) with ESMTP id E672367E4B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Nov 2006 04:03:00 +1100 (EST)
Subject: RE: Modules Problem on ML403
From: alayrac <christophe.alayrac@cresitt.com>
To: Sharon Feldman <sharonf@scopus.net>, linuxppc-embedded@ozlabs.org
In-Reply-To: <8506C3905ED0764F889ADEB33E3A9E8062CF28@MAIA.scopus.net>
References: <8506C3905ED0764F889ADEB33E3A9E8062CF28@MAIA.scopus.net>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Nov 2006 16:39:41 +0100
Message-Id: <1163432381.15515.7.camel@Serge-Linux>
Mime-Version: 1.0
Reply-To: christophe.alayrac@cresitt.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thank you Sharon

I forget to precise that of course adapter.c should be corrected because
its is not compatible with last GPO IP of Xilinx (the last one is dual
port while old version was single port, thus API functions needs a port
number to be specified).
Unfortunalty even with correction then modules did not works.

With have included the gpio driver in ther kernel and a /dev/xgpio
et /dev/misc/xgpio are created but I've no idea then of how to use
theses GPIO from user space.

I suppose that it should be something like 
	int fgpoi;
	fgpio = open("/dev/misc/xgpio",O_RDWR);
	...
what are the functions to access the IO port in write or read mode?

The second question is why is there taht kernel version error when using
module?

Regards 

Chris

Re"
Le lundi 13 novembre 2006 à 10:52 +0200, Sharon Feldman a écrit :
> we had also problems with montavista gpio, it turnd out the montavista
> adaptor file need to be modified, since it is not suitable for latest
> xilinx libraries.
>  
>  
>         -----Original Message-----
>         From: linuxppc-embedded-bounces+sharonf=scopus.net@ozlabs.org
>         [mailto:linuxppc-embedded-bounces
>         +sharonf=scopus.net@ozlabs.org]On Behalf Of alayrac
>         Sent: Monday, November 13, 2006 9:47 AM
>         To: linuxppc-embedded@ozlabs.org
>         Subject: Modules Problem on ML403
>         
>         
>         Hi all,
>         
>          
>         
>         I succeed to port linux2-4.26 on ML403 board with Montavista
>         RFS on CF or NFS.
>         
>          
>         
>         Problems arise when I try to use modules.
>         
>         I have included gpio modules in the kernel and build follow
>         
>          
>         
>         make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- dep uImage
>         
>         make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- modules the
>         modules_install
>         
>          
>         
>         The last make command fail during depmod process because it
>         did not supports cross compiling
>         
>          
>         
>         I've then think to use the Klingauf scripts
>         (make_modules_install.sh,depmod.pl) but I was afraid that the
>         command 
>         
>         make modules_install copy modules in the host lib/modules
>         directory.
>         
>          
>         
>         So I manually proceed as follow from the kernel root :
>         
>         make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu-
>         modules_install INSTALL_MOD_PATH=/home/alayrac/
>         
>          
>         
>         and then 
>         
>         ./depmod.pl -k ./vmlinux -F ./System.map
>         -b /home/alayrac/lib/modules –n
>         > /home/alayrac/lib/modules/2.4.26/modules.dep
>         
>          
>         
>         Modules seems to be created properly but after board and linux
>         start up I receive the following error message:
>         
>          
>         
>         $>insmod xilinx_gpio
>         
>         Using /lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio/xilinx_gpio.o
>         
>         /lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio/xilinx_gpio.o:
>         
>         couldn't find the kernel version the module was compiled for
>         
>          
>         
>         $>modprobe xilinx_gpio
>         
>         /lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio/xilinx_gpio.o:
>         
>         couldn't find the kernel version the module was compiled
>         for/lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio/xilinx_gpio.o:
>         
>         insmod /lib/modules/2.4.26/kernel/drivers/char/xilinx_gpid/lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio.o: couldn't find the kernel version the module was compiled for
>         
>         /lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio.o:
>         
>         insmod /lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio.o
>         failed
>         
>         /lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio.o: insmod
>         xilinx_gpio failed
>         
>          
>         
>         Further more the date of files in /lib/modules/2.4.26 are
>         modified to old date during the boot process (I think its
>         because there is no real time clock on ML403). Thus the
>         modules.conf is declared as more recent than modules.dep.
>         
>          
>         
>         Any help would be appreciated .
>         
>          
>         
>         Kinds regards
>         
>          
>         
>         Chris
>         
>          
>         
>         _______________________________________________
>         
>         Linuxppc-embedded mailing list
>         
>         Linuxppc-embedded@ozlabs.org
>         https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>         
>         
