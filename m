Return-Path: <j.glisse@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.199])
	by ozlabs.org (Postfix) with ESMTP id B111E67A7A
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Apr 2005 20:39:21 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 37so1096939wra
	for <linuxppc-dev@ozlabs.org>; Mon, 04 Apr 2005 03:39:20 -0700 (PDT)
Message-ID: <4240b916050404033230db0551@mail.gmail.com>
Date: Mon, 4 Apr 2005 11:32:39 +0100
From: Jerome Glisse <j.glisse@gmail.com>
To: linuxppc-dev@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: linux 2.6.12-rc1-bk5 compilation error
Reply-To: Jerome Glisse <j.glisse@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Once again i face an error that i got with a previous
2.6 kernel (i already posted about this in january
i think).

My config G5 bi 2Ghz and you can grab my kernel
config here : http://dj.planet-d.net/config

When compiling  2.6.12-rc1-bk5 i first get unknown
symbol _flush_disable_L1. This is in arch/ppc/kernel/l2cr.S
I changed the makefile in arch/ppc/kernel to have this :
obj-$(CONFIG_POWER4) += cpu_setup_power4.o
into :
obj-$(CONFIG_POWER4) += l2cr.o cpu_setup_power4.o

I am not sure this is good but with this i can go on.

And finaly i face back the same unknown function
than in my previous mail :
disable_6xx_mmu
used in :
arch/ppc/boot/simple/misc-prep.c

At that time i done some test defining CONFIG_6xx
which give others erros or undefining PPC_PREP
which give some others errors.

I finaly used a stupid patch to make it works (below)
Signed-off-by: Jerome Glisse <j.glisse@gmail.com>

But it seems that at some stage it gots forgotten.
Anyway what puzzle me is that it seems i am the
only one to face this ? Am i alone :) ?

diff -Naur a/arch/ppc/boot/simple/misc-prep.c
b/arch/ppc/boot/simple/misc-prep.c
--- a/arch/ppc/boot/simple/misc-prep.c      2004-12-24 22:33:51.000000000 +0100
+++ b/arch/ppc/boot/simple/misc-prep.c       2005-01-21
12:09:50.976426672 +0100
@@ -34,7 +34,11 @@
extern void serial_fixups(void);
extern struct bi_record *decompress_kernel(unsigned long load_addr,
               int num_words, unsigned long cksum);
+#ifdef CONFIG_6XX
extern void disable_6xx_mmu(void);
+#elif
+static inline void disable_6xx_mmu(void) {}
+#endif
extern unsigned long mpc10x_get_mem_size(void);

static void
