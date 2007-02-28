Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc2-s13.bay0.hotmail.com (bay0-omc2-s13.bay0.hotmail.com
	[65.54.246.149]) by ozlabs.org (Postfix) with ESMTP id 9E5B1DDEBA
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 08:21:34 +1100 (EST)
Message-ID: <BAY115-W509068F8DB7774727EF71B2810@phx.gbl>
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Please help me with compiling the kernel for ML403
Date: Wed, 28 Feb 2007 21:21:33 +0000
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


Hi

It is some thing more than 2 weeks that I'm trying to compile the kernel fo=
r ML403.=20
Posted to questions here, but unfortunately, didn't get any answer from the=
 experts here.
I have tested every thing I knew ( with my limited knowledge ) and now, I r=
eally need your help.

I'm using the following set of tools:
EDK 8.2.02,  ( Latest )
ELDK 4.1 ( Latest )

-I want to compile the 2.6.20 kernel, downloaded from kernel.org

-As the first step, in EDK, I choose linux 2.6 in software platform generat=
ion settings,

-I generate the BSP.=20

-In the generated BSP , I convert all of the 40x strings to 403, also I cha=
nge the name of xparameters_ml40x to xparameters_ml403

-I copy the 2.6.20 kernel /eldk/ppc_4xx/usr/src/linux , and set all of the =
needed env variables for cross compile, and set the needed changes in the l=
inux Makefile. ( ARCH and=20
CROSS_COMPILE )

-I copy the entire BSP into the root of the linux kernel.

-I edit the linux/arch/ppc/Kconfig file, and add these lines into it:
config XILINX_OCP
	bool "Xilinx OCP"
	default y

config XILINX_TEMAC
	bool "Xilinx TEMAC"
	default y

config XILINX_SYSACE
	bool "Xilinx System ACE"
	default y

config XILINX_EDK
	bool "Xilinx EDK Support"
	default y

-In the linux folder I execute the cow.tcl script provided with the BSP fro=
m EDK ( I execute tclsh cow.tcl )=20

-I make a symbolic link , for config.h file, ( I go to linux/include/linux =
and then ln -s autoconf.h config.h )

-I begin the menuconfig and set all of the needed parameters

-Now, I begin the make process by simply typing : make

- I encounter the following error:
arch/ppc/platforms/4xx/virtex.c:20: error: array type has incomplete elemen=
t type
arch/ppc/platforms/4xx/virtex.c:60: error: field name not in record or unio=
n initializer
arch/ppc/platforms/4xx/virtex.c:60: error: (near initialization for 'core_o=
cp')
make[1]: *** [arch/ppc/platforms/4xx/virtex.o] Error 1
make: *** [arch/ppc/platforms/4xx] Error 2

- I can prevent this error by commenting these lines of /arch/ppc/platforms=
/4xx/virtex.c file:
/* Have OCP take care of the serial ports. */
struct ocp_def core_ocp[] =3D {
#ifdef XPAR_UARTNS550_0_BASEADDR
	{ .vendor	=3D OCP_VENDOR_XILINX,
	  .function	=3D OCP_FUNC_16550,
	  .index	=3D 0,
	  .paddr	=3D XPAR_UARTNS550_0_BASEADDR,
	  .irq		=3D XPAR_INTC_0_UARTNS550_0_VEC_ID,
	  .pm		=3D OCP_CPM_NA
	},
#ifdef XPAR_UARTNS550_1_BASEADDR
	{ .vendor	=3D OCP_VENDOR_XILINX,
	  .function	=3D OCP_FUNC_16550,
	  .index	=3D 1,
	  .paddr	=3D XPAR_UARTNS550_1_BASEADDR,
	  .irq		=3D XPAR_INTC_0_UARTNS550_1_VEC_ID,
	  .pm		=3D OCP_CPM_NA
	},
#ifdef XPAR_UARTNS550_2_BASEADDR
	{ .vendor	=3D OCP_VENDOR_XILINX,
	  .function	=3D OCP_FUNC_16550,
	  .index	=3D 2,
	  .paddr	=3D XPAR_UARTNS550_2_BASEADDR,
	  .irq		=3D XPAR_INTC_0_UARTNS550_2_VEC_ID,
	  .pm		=3D OCP_CPM_NA
	},
#ifdef XPAR_UARTNS550_3_BASEADDR
	{ .vendor	=3D OCP_VENDOR_XILINX,
	  .function	=3D OCP_FUNC_16550,
	  .index	=3D 3,
	  .paddr	=3D XPAR_UARTNS550_3_BASEADDR,
	  .irq		=3D XPAR_INTC_0_UARTNS550_3_VEC_ID,
	  .pm		=3D OCP_CPM_NA
	},
#ifdef XPAR_UARTNS550_4_BASEADDR
#error Edit this file to add more devices.
#endif			/* 4 */
#endif			/* 3 */
#endif			/* 2 */
#endif			/* 1 */
#endif			/* 0 */
	{ .vendor	=3D OCP_VENDOR_INVALID
	}
};

- Instead of the ebove lines, I just put one simple line: ( I use uart lite=
 and not the 16550 so there should be no problem commenting these lines? )
struct ocp_def * core_ocp;

- now, I begin the make process again, The make process goes ahead but afte=
r a long time it generates another error:
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
arch/ppc/syslib/built-in.o:: more undefined references to `ppc_sys_platform=
_devices' follow
make: *** [.tmp_vmlinux1] Error 1

- If I do not add the BSP files from EDK to my kernel and compile the kerne=
l for ML403, every thing will be completely OK. ( But I want TEMAC )

- when I look in the original virtex.c file, I see that it has defined ppc_=
sys_platform_devices but when I look at the virtex.c generated by Xilinx, I=
 see that it has a completely different structure, it has no definition of =
this variable. It is completely different from the original virtex.c

- I have tested the same things above, with different versions of 2.6 kerne=
l, such as, 2.6.17.1 and 26-xilinx-devel ( which I download from montavista=
 using git near two weeks ago ) , I also changed the version of eldk to 4.0=
 and to 3.5 ( with 3.5 I could not compile the kernel at all )=20

Any idea, Any suggestion and any thing which can help even a litte, is welc=
ome,=20
I really do not know what to do more.

Thanks.

_________________________________________________________________
Invite your mail contacts to join your friends list with Windows Live Space=
s. It's easy!=20
http://spaces.live.com/spacesapi.aspx?wx_action=3Dcreate&wx_url=3D/friends.=
aspx&mkt=3Den-us=
