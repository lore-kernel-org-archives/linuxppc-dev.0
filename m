From: kingseft@samsung.co.kr
Date: Wed, 2 May 2001 15:35:59 +0900
Message-Id: <H00002af04cc5233@MHS>
Subject: Question for module compile for ppc
MIME-Version: 1.0
To: wd@denx.de, linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hello.

 I use HHL CDK v1.2 and use linux-2.4.3-pre3-2001-03-11(W.Denk's patched kernel).
 When I compile small module program, I got following message.
 Could someone help me with this problem??

[root@ssljm 8xx_io]# make -f Makefile.test
/opt/hardhat/devkit/ppc/8xx/bin/ppc_8xx-gcc -O2 -D__KERNEL__ -DMODULE -DMODVERSIONS -D__powerpc__ -mcpu=860 -I/2ndhard/linux-2
.4.13-pre3-2001-03-11/include -Wall -Wstrict-prototypes -Wno-uninitialized -fomit-frame-pointer -fsigned-char -msoft-float -fn
o-builtin -ffixed-r2 -pipe -mmultiple -mstring -I/2ndhard/linux-2.4.3-pre3-2001-03-11/arch/ppc/8xx_io -I/2ndhard/linux-2.4.13-
pre3-2001-03-11/include/linux/modversions.h -c -o  test.o test.c

{standard input}: Assembler messages:
{standard input}:6: Warning: Ignoring changed section attributes for .modinfo
[root@ssljm 8xx_io]#

 although this warning, I got test.o object file and I could loading test.o by insmod test.o
 but I got another problem.

 Warning: Kernel module version mismatch
 test.o was compiled for kernel version 2.2.14
 while this kernel is version 2.4.3-pre3

 any comments will help us.
 thanks..


 here test.c file
 ------------------------------------
#include <linux/kernel.h>	/* We're doing kernel work	*/
#include <linux/module.h>	/* Specifically, a module	*/
#include <asm/uaccess.h>	/* for put_user			*/
#include <asm/init.h>		/* for __initfunc		*/
#include <asm/8xx_immap.h>

#undef  DEBUG

#ifdef	DEBUG
# define debugk(fmt,args...)	printk(fmt ,##args)
#else
# define debugk(fmt,args...)
#endif

/*
 * Deal with CONFIG_MODVERSIONS
 */
#if CONFIG_MODVERSIONS==1
#undef MODVERSIONS
#define MODVERSIONS
#include <linux/modversions.h>
#endif

/*
 * For character devices
 */
#include <linux/fs.h>		/* character device definitions	*/
#include <linux/wrapper.h>	/* wrapper for compatibility with future versions */

#ifndef KERNEL_VERSION
# define KERNEL_VERSION(a,b,c)	((a)*65536+(b)*256+(c))
#endif

int init_module (void)
{
	printk("\n Now Module function called. init_module()");
	printk("\n Programmed by kingseft\n");
	return 0;
}


void cleanup_module (void)
{
	printk("\nclean up module\n");
}


 Here is Makefile.test
 -------------------------------------------------------
 CFLAGS  =       -O2

CC	= /opt/hardhat/devkit/ppc/8xx/bin/ppc_8xx-gcc

MODULE_CFLAGS = -D__KERNEL__ -DMODULE -DMODVERSIONS \
	-D__powerpc__ -mcpu=860 \
	-I/2ndhard/linux-2.4.13-pre3-2001-03-11/include \
        -Wall -Wstrict-prototypes -Wno-uninitialized \
	-fomit-frame-pointer \
	-fsigned-char -msoft-float -fno-builtin -ffixed-r2 \
        -pipe -mmultiple -mstring \
	-I/2ndhard/linux-2.4.3-pre3-2001-03-11/arch/ppc/8xx_io \
        -I/2ndhard/linux-2.4.13-pre3-2001-03-11/include/linux/modversions.h


all:	test.o

ins:	all
	[ -c /dev/rtc ] || mknod /dev/test c 44 0
	-rmmod test.o
	/sbin/insmod ./test.o

test.o:	test.c
	$(CC) $(CFLAGS) $(MODULE_CFLAGS) -c -o  $@ $^

clean:
	rm -f test.o

-------------------------- end of list --------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
