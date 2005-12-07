Return-Path: <just4usai@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.193])
	by ozlabs.org (Postfix) with ESMTP id 7A2606884E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 15:43:54 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id s15so147767wxc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 06 Dec 2005 20:43:53 -0800 (PST)
Message-ID: <c6be647f0512062043u70d8dd21pfc0a4dae6c4c2ad7@mail.gmail.com>
Date: Wed, 7 Dec 2005 10:13:53 +0530
From: sairam k <just4usai@gmail.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Help !!!!!!!! Does this Bug fixed ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

1) I used linuxppc_2_4_devel PowerPC development tree source(from
ppc.bkbits.net) to build kernel for PowerPC
IBM405EP(evb405ep_defconfig) and montavista's gcc cross compiler for
ppc_405-

  2)I gave the following commands..
     make evb405ep_config
     make mrproper
     make clean
     make dep
     make zImage

  3) when i gave 'make zImage' command, the compilation stopped
abnormally and gave error that OPB_BASE_START symbol is unknown in
file ibm405ep.c
  (arch/ppc/platforms/ibm405ep.c)

  4) The point in source code where problem is arising is shown below....
  -----------------------------------------------------------------------

          ..................
     struct ocp_def core_ocp[]  __initdata =3D {
   { .vendor=09=3D OCP_VENDOR_IBM,
            .function=09=3D OCP_FUNC_OPB,
     .index=09=3D 0,
   =09  .paddr=09=3D OPB_BASE_START, // UNKOWN SYMBOL
     .irq=09=09=3D OCP_IRQ_NA,
     .pm=09=09=3D OCP_CPM_NA,

               .........
               ..........

  ----------------------------------------------------------------------
Suggestion   1) I fixed this bug by providing the OPB_BASE_START address.
  Since the core of ibm405EP is same as that of ibm405Gp & ibm405Gpr,
the OPB_BASE_START address will be same for all.

                   So just include the following line in ibm405ep.h
  (ie., in arch/ppc/platforms/ibm405ep.h)

   #define OPB_BASE_START 0x40000000

  2) After adding the above line, I recompiled the sources
again....and this time it compiled and i am able to work on IBM405Ep
board.

(configuration file for IBm405ep is 'evb405ep_defconfig' in configs folder)


 Does anyone fixed this bug........if so why it is not reflected in bkbits
