Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc2-s9.bay0.hotmail.com (bay0-omc2-s9.bay0.hotmail.com
	[65.54.246.145]) by ozlabs.org (Postfix) with ESMTP id 52666DDEFB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 17:29:03 +1100 (EST)
Message-ID: <BAY115-W2200A3A1BBB454E05CFF40B2800@phx.gbl>
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
Subject: Re: Please help me with compiling the kernel for ML403
Date: Thu, 1 Mar 2007 06:29:02 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Glenn,

I studied your post carefuly,

You are using a patch: paulus,=20
I looked at some parts of these patches,=20
most of them are already applied to the kernel,=20
Do I really need to apply these patches?=20
Is this true for newer versions of the kernel , like 2.6.20? or the devel v=
ersion from montavista
You have applied these patches to 2.6.14 , from kernel.org, Yes?

one of the persons here, told me that I'm mixing different methods for buil=
ding the kernel,
I think that he may be true, Am I using a correct set of tools?

Thanks.


---------------------------------------------------------------------------=
---------------------
Date: Wed, 28 Feb 2007 16:53:39 -0500
From: Glenn.G.Hart@us.westinghouse.com
Subject: Re: Please help me with compiling the kernel for ML403
To: linuxppc-embedded@ozlabs.org
Message-ID:
=09
Content-Type: text/plain; charset=3D"us-ascii"
=20
=20
Mohammad,
=20
I didn't have much success copying the entire BSP into the kernel.  Please
see my post titled "Linux w/ML403 PLB TEMAC".  It is basically the tutorial
of how I got Linux working on an ML403 board.
=20
Glenn
=20
=20
=20
                                                                           =
                         =20
 (Embedded     Mohammad Sadegh Sadri @ozlabs.org                           =
  =20
 image moved   02/28/2007 04:21 PM                                         =
                         =20
 to file:                                                                  =
                         =20
 pic26924.pcx)                                                             =
                         =20
                                                                           =
                         =20
                                                                           =
                         =20
=20
=20
Sent by:
       linuxppc-embedded-bounces+glenn.g.hart=3Dus.westinghouse.com@ozlabs.=
org
=20
=20
To:   =20
cc:
Subject:    Please help me with compiling the kernel for ML403
=20
Security Level:?              Internal
=20
=20
=20
Hi
=20
It is some thing more than 2 weeks that I'm trying to compile the kernel
for ML403.
Posted to questions here, but unfortunately, didn't get any answer from the
experts here.
I have tested every thing I knew ( with my limited knowledge ) and now, I
really need your help.
=20
I'm using the following set of tools:
EDK 8.2.02,  ( Latest )
ELDK 4.1 ( Latest )
=20
-I want to compile the 2.6.20 kernel, downloaded from kernel.org
=20
-As the first step, in EDK, I choose linux 2.6 in software platform
generation settings,
=20
-I generate the BSP.
=20
-In the generated BSP , I convert all of the 40x strings to 403, also I
change the name of xparameters_ml40x to xparameters_ml403
=20
-I copy the 2.6.20 kernel /eldk/ppc_4xx/usr/src/linux , and set all of the
needed env variables for cross compile, and set the needed changes in the
linux Makefile. ( ARCH and
CROSS_COMPILE )
=20
-I copy the entire BSP into the root of the linux kernel.
=20
-I edit the linux/arch/ppc/Kconfig file, and add these lines into it:
config XILINX_OCP
 bool "Xilinx OCP"
 default y
=20
config XILINX_TEMAC
 bool "Xilinx TEMAC"
 default y
=20
config XILINX_SYSACE
 bool "Xilinx System ACE"
 default y
=20
config XILINX_EDK
 bool "Xilinx EDK Support"
 default y
=20
-In the linux folder I execute the cow.tcl script provided with the BSP
from EDK ( I execute tclsh cow.tcl )
=20
-I make a symbolic link , for config.h file, ( I go to linux/include/linux
and then ln -s autoconf.h config.h )
=20
-I begin the menuconfig and set all of the needed parameters
=20
-Now, I begin the make process by simply typing : make
=20
- I encounter the following error:
arch/ppc/platforms/4xx/virtex.c:20: error: array type has incomplete
element type
arch/ppc/platforms/4xx/virtex.c:60: error: field name not in record or
union initializer
arch/ppc/platforms/4xx/virtex.c:60: error: (near initialization for
'core_ocp')
make[1]: *** [arch/ppc/platforms/4xx/virtex.o] Error 1
make: *** [arch/ppc/platforms/4xx] Error 2
=20
- I can prevent this error by commenting these lines of
/arch/ppc/platforms/4xx/virtex.c file:
/* Have OCP take care of the serial ports. */
struct ocp_def core_ocp[] =3D {
#ifdef XPAR_UARTNS550_0_BASEADDR
 { .vendor  =3D OCP_VENDOR_XILINX,
   .function      =3D OCP_FUNC_16550,
   .index   =3D 0,
   .paddr   =3D XPAR_UARTNS550_0_BASEADDR,
   .irq           =3D XPAR_INTC_0_UARTNS550_0_VEC_ID,
   .pm            =3D OCP_CPM_NA
 },
#ifdef XPAR_UARTNS550_1_BASEADDR
 { .vendor  =3D OCP_VENDOR_XILINX,
   .function      =3D OCP_FUNC_16550,
   .index   =3D 1,
   .paddr   =3D XPAR_UARTNS550_1_BASEADDR,
   .irq           =3D XPAR_INTC_0_UARTNS550_1_VEC_ID,
   .pm            =3D OCP_CPM_NA
 },
#ifdef XPAR_UARTNS550_2_BASEADDR
 { .vendor  =3D OCP_VENDOR_XILINX,
   .function      =3D OCP_FUNC_16550,
   .index   =3D 2,
   .paddr   =3D XPAR_UARTNS550_2_BASEADDR,
   .irq           =3D XPAR_INTC_0_UARTNS550_2_VEC_ID,
   .pm            =3D OCP_CPM_NA
 },
#ifdef XPAR_UARTNS550_3_BASEADDR
 { .vendor  =3D OCP_VENDOR_XILINX,
   .function      =3D OCP_FUNC_16550,
   .index   =3D 3,
   .paddr   =3D XPAR_UARTNS550_3_BASEADDR,
   .irq           =3D XPAR_INTC_0_UARTNS550_3_VEC_ID,
   .pm            =3D OCP_CPM_NA
 },
#ifdef XPAR_UARTNS550_4_BASEADDR
#error Edit this file to add more devices.
#endif                  /* 4 */
#endif                  /* 3 */
#endif                  /* 2 */
#endif                  /* 1 */
#endif                  /* 0 */
 { .vendor  =3D OCP_VENDOR_INVALID
 }
};
=20
- Instead of the ebove lines, I just put one simple line: ( I use uart lite
and not the 16550 so there should be no problem commenting these lines? )
struct ocp_def * core_ocp;
=20
- now, I begin the make process again, The make process goes ahead but
  after a long time it generates another error:
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/ppc/syslib/built-in.o: In function `ppc_sys_device_remove':
: undefined reference to `ppc_sys_platform_devices'
arch/ppc/syslib/built-in.o: In function `ppc_sys_device_remove':
: undefined reference to `ppc_sys_platform_devices'
arch/ppc/syslib/built-in.o: In function `ppc_sys_device_initfunc':
: undefined reference to `ppc_sys_platform_devices'
arch/ppc/syslib/built-in.o: In function `ppc_sys_device_initfunc':
: undefined reference to `ppc_sys_platform_devices'
arch/ppc/syslib/built-in.o: In function `ppc_sys_device_setfunc':
: undefined reference to `ppc_sys_platform_devices'
arch/ppc/syslib/built-in.o:: more undefined references to
`ppc_sys_platform_devices' follow
make: *** [.tmp_vmlinux1] Error 1
=20
- If I do not add the BSP files from EDK to my kernel and compile the
kernel for ML403, every thing will be completely OK. ( But I want TEMAC )
=20
- when I look in the original virtex.c file, I see that it has defined
ppc_sys_platform_devices but when I look at the virtex.c generated by
Xilinx, I see that it has a completely different structure, it has no
definition of this variable. It is completely different from the original
virtex.c
=20
- I have tested the same things above, with different versions of 2.6
kernel, such as, 2.6.17.1 and 26-xilinx-devel ( which I download from
montavista using git near two weeks ago ) , I also changed the version of
eldk to 4.0 and to 3.5 ( with 3.5 I could not compile the kernel at all )
=20
Any idea, Any suggestion and any thing which can help even a litte, is
welcome,
I really do not know what to do more.
=20
Thanks.
=20
_________________________________________________________________
Discover the new Windows Vista
http://search.msn.com/results.aspx?q=3Dwindows+vista&mkt=3Den-US&form=3DQBR=
E=
