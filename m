Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 96C7767A7B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Mar 2005 19:38:58 +1100 (EST)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id 59FED403E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Mar 2005 09:39:01 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 3 Mar 2005 09:38:52 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200503030938.52397.david.jander@protonic.nl>
Subject: [PATCH] Include support for physmap driver in mpc8xx setup...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

I'd like to hear comments about this.
I am working with a fairly recent denx kernel tree (linuxppc_2_4_devel) and=
=20
have noticed that apparently support for physmap MTD mapping driver is=20
missing. Since physmap.c version 1.29 on, flash start address, size and=20
buswidth have to be setup by the board support package, but mpc8xx uses a=20
centralized .c file (arch/ppc/m8xx_setup.c) and include-files from=20
arch/platforms/*, so there is no way of specifying flash geometry.
I suggest something like this to solve the problem. If there is a better pl=
ace=20
to put this, please let me know.

=2D------------------------ begin patch --------------------------
=2D--=A0arch/ppc/kernel/m8xx_setup.c.orig
+++=A0arch/ppc/kernel/m8xx_setup.c
@@=A0-35,6=A0+35,9=A0@@
=A0#include=A0<linux/ioport.h>
=A0#include=A0<linux/bootmem.h>
=A0#include=A0<linux/seq_file.h>
+#if=A0defined(CONFIG_MTD_PHYSMAP)=A0&&=A0defined(CONFIG_MTD)=20
+#include=A0<linux/mtd/physmap.h>=20
+#endif=20
=A0
=A0#include=A0<asm/mmu.h>
=A0#include=A0<asm/processor.h>
@@=A0-510,4=A0+513,8=A0@@
=A0#if=A0defined(CONFIG_IDE_8xx_PCCARD)=A0||=A0defined(CONFIG_IDE_8xx_DIREC=
T)
=A0=A0=A0=A0     m8xx_ide_init();
=A0#endif
+#if=A0defined(CONFIG_MTD_PHYSMAP)=A0&&=A0defined(CONFIG_MTD)=20
+	/*=A0we=A0use=A0generic=A0physmap=A0mapping=A0driver=A0and=A0we=A0use=A0p=
artitions=A0*/
+	physmap_configure(CONFIG_MTD_PHYSMAP_START,=A0CONFIG_MTD_PHYSMAP_LEN,=A0
CONFIG_MTD_PHYSMAP_BUSWIDTH,=A0NULL);
+#endif=20
=A0}
=2D------------------------- end patch -------------------------------

Greetings,

=2D-=20
David Jander
Protonic Holland.
