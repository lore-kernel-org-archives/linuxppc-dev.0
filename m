Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id 0024667D3B
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jul 2005 19:35:25 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 25 Jul 2005 11:35:22 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B45@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: Add my own Makefile 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody,
I'm developping both new system calls and modules, in order to achieve a =
project.
In order to group all those new files, I created new directories:

arch/ppc/myproj
arch/ppc/myproj/syscalls/
arch/ppc/myproj/modules/

Under the "syscalls" dir, I made a "Makefile" to compile all those =
files.
In this Makefile I want to compile a module "mymodule1". This module =
needs 3 files:
modShiDma.c + modShiDma.S + modShiDma.h
So looking at the other Makefiles of the linux tree, I wrote this one:

/************************************************************************=
********/
O_TARGET	:=3D my_environment.o

obj-y	    :=3D
obj-m	    :=3D
obj-n       :=3D

# Compile system calls
obj-$(CONFIG_MY_SOFT)	+=3D  my_sysmemutils.o
obj-$(CONFIG_MY_SOFT)	+=3D  my_sysclkutils.o
obj-$(CONFIG_MY_SOFT)	+=3D  my_sysuicutils.o
obj-$(CONFIG_MY_SOFT)	+=3D  my_syscardregutils.o
# Compile modules
obj-m +=3D ../modules/modDisplay.o
obj-m +=3D ../modules/modShiDma.o
obj-m +=3D ../modules/modHscx.o

include $(TOPDIR)/Rules.make

modShiDma.o: modShiDma.S modShiDma.c modShiDma.h

/************************************************************************=
**********/

When I execute the "make modules", only the "modShiDma.c" is compiled =
while the "modShiDma.S"
is ignored.=20

ppc_405-gcc -D__KERNEL__ -I/myWorks/en-cours/linux-2.4.20_mvl31/include =
-gdwarf-2 -Wall -Wstrict-prototypes -Wno-trigraphs -O2 =
-fno-strict-aliasing -fno-common -fomit-frame-pointer =
-I/myWorks/en-cours/linux-2.4.20_mvl31/arch/ppc -fsigned-char =
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring =
-Wa,-m405 -DMODULE -DMODVERSIONS -include =
/myWorks/en-cours/linux-2.4.20_mvl31/include/linux/modversions.h  =
-nostdinc -iwithprefix include -DKBUILD_BASENAME=3DmodShiDma  -c -o =
../modules/modShiDma.o ../modules/modShiDma.c

How to get a "modShiDma.o" object made from the three source files =
please??
