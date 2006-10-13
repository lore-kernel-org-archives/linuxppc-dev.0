Return-Path: <rcorley@aegis-inc.net>
Received: from web56308.mail.re3.yahoo.com (web56308.mail.re3.yahoo.com
	[216.252.110.232]) by ozlabs.org (Postfix) with SMTP id C96CA67BD7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Oct 2006 06:44:44 +1000 (EST)
Message-ID: <20061013204442.52818.qmail@web56308.mail.re3.yahoo.com>
Date: Fri, 13 Oct 2006 13:44:42 -0700 (PDT)
From: Robert Corley <rcorley@aegis-inc.net>
Subject: uartlite with 2.6.17 kernel and kernel early text messages
To: linux linuxppc-embedded <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am still trying to get the UARTLITE to work with 2.6 and a plb_temac desi=
gn.  I am using EDK 7.1.  I have generated the edk files and copied xparame=
ters_ml300.h to arch/ppc/platforms/4xx/xparameters.xparameters_ml403.h=0A=
=0AIn an effort to get past the "Rebooting to System ACE Configuration Addr=
ess 6..." message, I have selected "support for early boot texts over seria=
l port" in kernel debugging.=0A=0AFYI, I'm using Peter's patches to create =
the uartlite.c and associated files and have selected the uartlite using ma=
ke menuconfig.=0A=0AThe first error is as follows:=0Aathena startup_network=
 # make ARCH=3Dppc zImage.initrd=0A  CHK     include/linux/version.h=0A  CH=
K     include/linux/compile.h=0Adnsdomainname: Unknown host=0A  CC      arc=
h/ppc/syslib/gen550_dbg.o=0Aarch/ppc/syslib/gen550_dbg.c:36: error: `RS_TAB=
LE_SIZE' undeclared here (not in a function)=0Aarch/ppc/syslib/gen550_dbg.c=
:38: error: empty scalar initializer=0Aarch/ppc/syslib/gen550_dbg.c:38: err=
or: (near initialization for `rs_table')=0Aarch/ppc/syslib/gen550_dbg.c:36:=
 error: storage size of `rs_table' isn't known=0Aarch/ppc/syslib/gen550_dbg=
.c:36: warning: 'rs_table' defined but not used=0Amake[1]: *** [arch/ppc/sy=
slib/gen550_dbg.o] Error 1=0Amake: *** [arch/ppc/syslib] Error 2=0A=0Aso, I=
 modified the gen550_dbg.c file to #include the xparameters.h, where the RS=
_TABLE_SIZE is defined=0A but still get more errors.  Here they are:=0A=0A =
 CHK     include/linux/version.h=0A  CHK     include/linux/compile.h=0Adnsd=
omainname: Unknown host=0A  CC      arch/ppc/syslib/gen550_dbg.o=0Aarch/ppc=
/syslib/gen550_dbg.c:37: error: `XPAR_UARTNS550_0_CLOCK_FREQ_HZ' undeclared=
 here (not in a function)=0Aarch/ppc/syslib/gen550_dbg.c:37: error: initial=
izer element is not constant=0Aarch/ppc/syslib/gen550_dbg.c:37: error: (nea=
r initialization for `rs_table[0].baud_base')=0Aarch/ppc/syslib/gen550_dbg.=
c:37: error: `XPAR_INTC_0_UARTNS550_0_VEC_ID' undeclared here (not in a fun=
ction)=0Aarch/ppc/syslib/gen550_dbg.c:37: error: initializer element is not=
 constant=0Aarch/ppc/syslib/gen550_dbg.c:37: error: (near initialization fo=
r `rs_table[0].irq')=0Aarch/ppc/syslib/gen550_dbg.c:37: error: `XPAR_UARTNS=
550_0_BASEADDR' undeclared here (not in a function)=0Aarch/ppc/syslib/gen55=
0_dbg.c:37: error: initializer element is not constant=0Aarch/ppc/syslib/ge=
n550_dbg.c:37: error: (near initialization for `rs_table[0].iomem_base')=0A=
arch/ppc/syslib/gen550_dbg.c:37: error: initializer element is not constant=
=0Aarch/ppc/syslib/gen550_dbg.c:37: error: (near initialization for `rs_tab=
le[0]')=0Amake[1]: *** [arch/ppc/syslib/gen550_dbg.o] Error 1=0Amake: *** [=
arch/ppc/syslib] Error 2=0A=0AQuestions:=0A=0A1.    Now, is this an issue w=
ith the UARTLITE driver or is it just not supported for early messaging?=0A=
2.   What am I missing w.r.t. getting something out of the serial port?=0A3=
.    I am assuming that the boot args for a initrd boot are:  "console=3Dtt=
yUL0 ip=3Doff root=3D/dev/ram rw", correct?=0A=0A-corley=0A=0A
