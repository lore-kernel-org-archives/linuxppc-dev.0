Message-ID: <012701c425e3$f1aeb8a0$14589edd@alpha>
From: =?utf-8?B?7LWc7Iq57ZiE?= <shchoi@airpoint.co.kr>
To: "Rune Torgersen" <runet@innovsys.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <DCEAAC0833DD314AB0B58112AD99B93B06DAB2@ismail.innsys.innovsys.com>
Subject: Re: Problems of kernel-2.6.4 for mpc8260
Date: Mon, 19 Apr 2004 16:57:20 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,,,
So so... sorry. I need to your process of module-init-tools-3.0 upgrade in detail.
Unfortunately, when i upgrade module-init-tools-3.0, I have a troble with module insert continuously.
Firstly, my test environment...

1) target : ppc8260 custom board.
2) kernel has compiled with module support
3) using kernel 2.6.5(also 2.6.3, 2.6.4)
4) using modutils 2.4.22
5) ELDK 3.0( cross compiler, NFS)

Following test message....

After booting of kernel 2.6.5..

bash-2.05b# ls
Makefile  Makefile.l  hello.c  hello.ko  hello.mod.c  hello.mod.o  hello.o
==> I  had to compile the modules using the recommended way of 2.6.x
( $(MAKE) -C /kernel_path CROSS_COMPILE=xx_xx SUBDIRS=$(PWD) modules)

bash-2.05b# insmod hello.ko
insmod: QM_MODULES: Function not implemented

bash-2.05b# depmod -V
depmod version 2.4.22
depmod: QM_MODULES: Function not implemented

I got to "module-init-tools-3.0.tar.gz'
After installing, boot process message is...

VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 76k init
request_module: runaway loop modprobe binfmt-4c46
request_module: runaway loop modprobe binfmt-4c46
request_module: runaway loop modprobe binfmt-4c46
request_module: runaway loop modprobe binfmt-4c46
request_module: runaway loop modprobe binfmt-4c46

Here stopped.

As you can see above, what's the reason of above error?
Any help would be appreciated.

Call me "Lone".
Thanks,

----- Original Message -----
From: "Rune Torgersen" <runet@innovsys.com>
To: "linuxppc" <linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, April 08, 2004 12:40 AM
Subject: RE: Problems of kernel-2.6.4 for mpc8260


>
> You need a newer version of modutils
>
> Try module-init-tools-3.0.tar.gz from
> http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
>
> This fixed that problem for me on 2.6.3 and 2.6.5 on a 8266. The other
> version is known not to work with the new module initialization stuff in
> the 2.6 kernels.
>
> > -----Original Message-----
> > From: owner-linuxppc-embedded@lists.linuxppc.org
> > [mailto:owner-linuxppc-embedded@lists.linuxppc.org] On Behalf
> > Of Wolfgang Grandegger
> > Sent: Wednesday, April 07, 2004 08:26
> > To: ???
> > Cc: linuxppc
> > Subject: Re: Problems of kernel-2.6.4 for mpc8260
> >
> >
> >
> > On 04/07/2004 09:51 AM ??? wrote:
> > > I got succeeded to port kernel 2.6.4 to out custom MPC8260
> > board with
> > > the help of DENX ELDK 3.0 tool. Thanks!! But there is some
> > problems to
> > > be solved.
> > >
> > > After booting, when I try to install module, following
> > error occured.
> > >
> > >       bash-2.05b# insmod dsrc_drv.o
> > >       insmod: QM_MODULES: Function not implemented
> >
> > Module support seems not to be enabled in your kernel.
> >
> > >
> > >       bash-2.05b# insmod -V
> > >       insmod version 2.4.22
> > >
> > > As you can see above, the version of modutils seems to be
> > fine. right?
> > > If so, what's the reason of above error? And one more
> > problem. At boot
> > > sequence(as following) lots of unexpected 'modprobe: xxx'
> > messages are
> > > issued.
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
