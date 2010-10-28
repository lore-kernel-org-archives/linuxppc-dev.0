Return-Path: <ppc.addon@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by ozlabs.org (Postfix) with ESMTP id 99E54B70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Oct 2010 03:21:45 +1100 (EST)
Received: by yws5 with SMTP id 5so1582139yws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Oct 2010 09:21:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTikf=ztL+wL7WvaUW4-4uvfeJUUaqMJWqdjwSzQK@mail.gmail.com>
References: <AANLkTikf=ztL+wL7WvaUW4-4uvfeJUUaqMJWqdjwSzQK@mail.gmail.com>
Date: Thu, 28 Oct 2010 18:21:42 +0200
Message-ID: <AANLkTinJjqvR9iM0zbRNnEtg4X4Fhjgt7d973eWQzkbk@mail.gmail.com>
Subject: mpc52xx_gpt breaks on linux-2.6.26
From: nello martuscielli <ppc.addon@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If i try to enable watchdog =A0it breaks linux kernel build when enabled.
I'm using an Efika MPC5200B with CRUX PPC 2.6 32bit.

CONFIG_WATCHDOG=3Dy
CONFIG_MPC5200_WDT=3Dy

That's compiling linux-2.6.36:


[..]
=A0LD =A0 =A0 =A0arch/powerpc/lib/built-in.o
=A0CC =A0 =A0 =A0arch/powerpc/sysdev/simple_gpio.o
=A0CC =A0 =A0 =A0arch/powerpc/sysdev/bestcomm/ata.o
=A0CC =A0 =A0 =A0arch/powerpc/sysdev/bestcomm/bcom_ata_task.o
=A0CC =A0 =A0 =A0arch/powerpc/sysdev/bestcomm/bestcomm.o
=A0CC =A0 =A0 =A0arch/powerpc/sysdev/bestcomm/sram.o
=A0LD =A0 =A0 =A0arch/powerpc/sysdev/bestcomm/bestcomm-core.o
=A0LD =A0 =A0 =A0arch/powerpc/sysdev/bestcomm/bestcomm-ata.o
=A0LD =A0 =A0 =A0arch/powerpc/sysdev/bestcomm/built-in.o
=A0CC [M] =A0arch/powerpc/sysdev/bestcomm/fec.o
=A0CC [M] =A0arch/powerpc/sysdev/bestcomm/bcom_fec_rx_task.o
=A0CC [M] =A0arch/powerpc/sysdev/bestcomm/bcom_fec_tx_task.o
=A0CC [M] =A0arch/powerpc/sysdev/bestcomm/gen_bd.o
=A0CC [M] =A0arch/powerpc/sysdev/bestcomm/bcom_gen_bd_rx_task.o
=A0CC [M] =A0arch/powerpc/sysdev/bestcomm/bcom_gen_bd_tx_task.o
=A0LD [M] =A0arch/powerpc/sysdev/bestcomm/bestcomm-fec.o
=A0LD [M] =A0arch/powerpc/sysdev/bestcomm/bestcomm-gen-bd.o
=A0CC =A0 =A0 =A0arch/powerpc/sysdev/mpc5xxx_clocks.o
=A0AS =A0 =A0 =A0arch/powerpc/sysdev/6xx-suspend.o
=A0LD =A0 =A0 =A0arch/powerpc/sysdev/built-in.o
=A0CC =A0 =A0 =A0arch/powerpc/platforms/52xx/mpc52xx_pic.o
=A0CC =A0 =A0 =A0arch/powerpc/platforms/52xx/mpc52xx_common.o
=A0CC =A0 =A0 =A0arch/powerpc/platforms/52xx/mpc52xx_gpt.o
arch/powerpc/platforms/52xx/mpc52xx_gpt.c: In function 'mpc52xx_wdt_write':
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:549: error: dereferencing
pointer to incomplete type
arch/powerpc/platforms/52xx/mpc52xx_gpt.c: In function 'mpc52xx_wdt_ioctl':
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:562: error: dereferencing
pointer to incomplete type
arch/powerpc/platforms/52xx/mpc52xx_gpt.c: In function 'mpc52xx_wdt_open':
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:635: error: dereferencing
pointer to incomplete type
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:636: error: implicit
declaration of function 'nonseekable_open'
arch/powerpc/platforms/52xx/mpc52xx_gpt.c: In function 'mpc52xx_wdt_release=
':
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:643: error: dereferencing
pointer to incomplete type
arch/powerpc/platforms/52xx/mpc52xx_gpt.c: At top level:
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:657: error: variable
'mpc52xx_wdt_fops' has initializer but incomplete type
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:658: error: unknown field
'owner' specified in initializer
cc1: warnings being treated as errors
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:658: error: excess elements
in struct initializer
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:658: error: (near
initialization for 'mpc52xx_wdt_fops')
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:659: error: unknown field
'llseek' specified in initializer
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:659: error: 'no_llseek'
undeclared here (not in a function)
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:659: error: excess elements
in struct initializer
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:659: error: (near
initialization for 'mpc52xx_wdt_fops')
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:660: error: unknown field
'write' specified in initializer
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:660: error: excess elements
in struct initializer
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:660: error: (near
initialization for 'mpc52xx_wdt_fops')
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:661: error: unknown field
'unlocked_ioctl' specified in initializer
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:661: error: excess elements
in struct initializer
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:661: error: (near
initialization for 'mpc52xx_wdt_fops')
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:662: error: unknown field
'open' specified in initializer
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:662: error: excess elements
in struct initializer
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:662: error: (near
initialization for 'mpc52xx_wdt_fops')
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:663: error: unknown field
'release' specified in initializer
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:663: error: excess elements
in struct initializer
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:663: error: (near
initialization for 'mpc52xx_wdt_fops')
make[2]: *** [arch/powerpc/platforms/52xx/mpc52xx_gpt.o] Error 1
make[1]: *** [arch/powerpc/platforms/52xx] Error 2
make: *** [arch/powerpc/platforms] Error 2



thanks for any advice.
Nello Martuscielli
