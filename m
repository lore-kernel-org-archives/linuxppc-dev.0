Return-Path: <Glenn.G.Hart@us.westinghouse.com>
Received: from swec9607.wecnq.com (swec9607.wecnq.com [147.72.234.65])
	by ozlabs.org (Postfix) with ESMTP id 60992DDEFB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Mar 2007 02:48:18 +1100 (EST)
Subject: Re: Please help me with compiling the kernel for ML403
To: linuxppc-embedded@ozlabs.org
Message-ID: <OFC20D38B5.96F4EB96-ON85257291.005683D5-85257291.0056D389@ct.wec.com>
From: Glenn.G.Hart@us.westinghouse.com
Date: Thu, 1 Mar 2007 10:48:20 -0500
MIME-Version: 1.0
Content-type: multipart/mixed;
	Boundary="0__=0ABBF802DFC505458f9e8a93df938690918c0ABBF802DFC50545"
Cc: mamsadegh@hotmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0__=0ABBF802DFC505458f9e8a93df938690918c0ABBF802DFC50545
Content-type: text/plain; charset=us-ascii


Mohammad,

The patches were not in the kernel version I was using (2.6.19).  They are
for the TEMAC only, so they only need to be applied for networking support.
I have not used the montavista version, this is the free version of the
Linux kernel from kernel.org.

It did seem like you were mixing different methods.  If you follow my steps
you should not have any problems.

Glenn



                                                                                                     
 (Embedded     Mohammad Sadegh Sadri <mamsadegh@hotmail.com>                                         
 image moved   03/01/2007 01:29 AM                                                                   
 to file:                                                                                            
 pic31673.pcx)                                                                                       
                                                                                                     
                                                                                                     



To:    Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
cc:    <glenn.g.hart@us.westinghouse.com>
Subject:    Re: Please help me with compiling the kernel for ML403

Security Level:?              Internal



Glenn,

I studied your post carefuly,

You are using a patch: paulus,
I looked at some parts of these patches,
most of them are already applied to the kernel,
Do I really need to apply these patches?
Is this true for newer versions of the kernel , like 2.6.20? or the devel
version from montavista
You have applied these patches to 2.6.14 , from kernel.org, Yes?

one of the persons here, told me that I'm mixing different methods for
building the kernel,
I think that he may be true, Am I using a correct set of tools?

Thanks.


------------------------------------------------------------------------------------------------

Date: Wed, 28 Feb 2007 16:53:39 -0500
From: Glenn.G.Hart@us.westinghouse.com
Subject: Re: Please help me with compiling the kernel for ML403
To: linuxppc-embedded@ozlabs.org
Message-ID:

Content-Type: text/plain; charset="us-ascii"


Mohammad,

I didn't have much success copying the entire BSP into the kernel.  Please
see my post titled "Linux w/ML403 PLB TEMAC".  It is basically the tutorial
of how I got Linux working on an ML403 board.

Glenn




 (Embedded     Mohammad Sadegh Sadri @ozlabs.org
 image moved   02/28/2007 04:21 PM
 to file:
 pic26924.pcx)




Sent by:
       linuxppc-embedded-bounces+glenn.g.hart=us.westinghouse.com@ozlabs.org


To:
cc:
Subject:    Please help me with compiling the kernel for ML403

Security Level:?              Internal



Hi

It is some thing more than 2 weeks that I'm trying to compile the kernel
for ML403.
Posted to questions here, but unfortunately, didn't get any answer from the
experts here.
I have tested every thing I knew ( with my limited knowledge ) and now, I
really need your help.

I'm using the following set of tools:
EDK 8.2.02,  ( Latest )
ELDK 4.1 ( Latest )

-I want to compile the 2.6.20 kernel, downloaded from kernel.org

-As the first step, in EDK, I choose linux 2.6 in software platform
generation settings,

-I generate the BSP.

-In the generated BSP , I convert all of the 40x strings to 403, also I
change the name of xparameters_ml40x to xparameters_ml403

-I copy the 2.6.20 kernel /eldk/ppc_4xx/usr/src/linux , and set all of the
needed env variables for cross compile, and set the needed changes in the
linux Makefile. ( ARCH and
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

-In the linux folder I execute the cow.tcl script provided with the BSP
from EDK ( I execute tclsh cow.tcl )

-I make a symbolic link , for config.h file, ( I go to linux/include/linux
and then ln -s autoconf.h config.h )

-I begin the menuconfig and set all of the needed parameters

-Now, I begin the make process by simply typing : make

- I encounter the following error:
arch/ppc/platforms/4xx/virtex.c:20: error: array type has incomplete
element type
arch/ppc/platforms/4xx/virtex.c:60: error: field name not in record or
union initializer
arch/ppc/platforms/4xx/virtex.c:60: error: (near initialization for
'core_ocp')
make[1]: *** [arch/ppc/platforms/4xx/virtex.o] Error 1
make: *** [arch/ppc/platforms/4xx] Error 2

- I can prevent this error by commenting these lines of
/arch/ppc/platforms/4xx/virtex.c file:
/* Have OCP take care of the serial ports. */
struct ocp_def core_ocp[] = {
#ifdef XPAR_UARTNS550_0_BASEADDR
 { .vendor  = OCP_VENDOR_XILINX,
   .function      = OCP_FUNC_16550,
   .index   = 0,
   .paddr   = XPAR_UARTNS550_0_BASEADDR,
   .irq           = XPAR_INTC_0_UARTNS550_0_VEC_ID,
   .pm            = OCP_CPM_NA
 },
#ifdef XPAR_UARTNS550_1_BASEADDR
 { .vendor  = OCP_VENDOR_XILINX,
   .function      = OCP_FUNC_16550,
   .index   = 1,
   .paddr   = XPAR_UARTNS550_1_BASEADDR,
   .irq           = XPAR_INTC_0_UARTNS550_1_VEC_ID,
   .pm            = OCP_CPM_NA
 },
#ifdef XPAR_UARTNS550_2_BASEADDR
 { .vendor  = OCP_VENDOR_XILINX,
   .function      = OCP_FUNC_16550,
   .index   = 2,
   .paddr   = XPAR_UARTNS550_2_BASEADDR,
   .irq           = XPAR_INTC_0_UARTNS550_2_VEC_ID,
   .pm            = OCP_CPM_NA
 },
#ifdef XPAR_UARTNS550_3_BASEADDR
 { .vendor  = OCP_VENDOR_XILINX,
   .function      = OCP_FUNC_16550,
   .index   = 3,
   .paddr   = XPAR_UARTNS550_3_BASEADDR,
   .irq           = XPAR_INTC_0_UARTNS550_3_VEC_ID,
   .pm            = OCP_CPM_NA
 },
#ifdef XPAR_UARTNS550_4_BASEADDR
#error Edit this file to add more devices.
#endif                  /* 4 */
#endif                  /* 3 */
#endif                  /* 2 */
#endif                  /* 1 */
#endif                  /* 0 */
 { .vendor  = OCP_VENDOR_INVALID
 }
};

- Instead of the ebove lines, I just put one simple line: ( I use uart lite
and not the 16550 so there should be no problem commenting these lines? )
struct ocp_def * core_ocp;

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

- If I do not add the BSP files from EDK to my kernel and compile the
kernel for ML403, every thing will be completely OK. ( But I want TEMAC )

- when I look in the original virtex.c file, I see that it has defined
ppc_sys_platform_devices but when I look at the virtex.c generated by
Xilinx, I see that it has a completely different structure, it has no
definition of this variable. It is completely different from the original
virtex.c

- I have tested the same things above, with different versions of 2.6
kernel, such as, 2.6.17.1 and 26-xilinx-devel ( which I download from
montavista using git near two weeks ago ) , I also changed the version of
eldk to 4.0 and to 3.5 ( with 3.5 I could not compile the kernel at all )

Any idea, Any suggestion and any thing which can help even a litte, is
welcome,
I really do not know what to do more.

Thanks.

_________________________________________________________________
Discover the new Windows Vista
http://search.msn.com/results.aspx?q=windows+vista&mkt=en-US&form=QBRE




--0__=0ABBF802DFC505458f9e8a93df938690918c0ABBF802DFC50545
Content-type: application/octet-stream;
	name="pic31673.pcx"
Content-Disposition: attachment; filename="pic31673.pcx"
Content-Transfer-Encoding: base64

CgUBCAAAAABBADEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAABQgABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAA=


--0__=0ABBF802DFC505458f9e8a93df938690918c0ABBF802DFC50545--
