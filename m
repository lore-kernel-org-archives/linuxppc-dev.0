Message-ID: <3A6F5059.B2CFE85D@mvista.com>
Date: Wed, 24 Jan 2001 13:59:53 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Meena Ramamoorthi <meena@stargateip.com>
CC: linuxppc-embedded@lists.linuxppc.org, frowand@mvista.com
Subject: Re: kernel thread
References: <NEBBJELJBMCNBHIPPOHFGEPOCAAA.meena@stargateip.com>
Content-Type: multipart/mixed;
 boundary="------------92874C6A0DD4E7FA4837D8D6"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------92874C6A0DD4E7FA4837D8D6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Meena Ramamoorthi wrote:
>
>   Hi all,
>
>  Has anybody tried using kernel_thread under montavista - IBM 405GP PPC
> hardhat LINUX kernel. ( 2.4 )  If so could you please reply to this. We have
> problem in exporting this. kernel_thread unresolved.
>
>   Early answer appreciated
>
>  Thanks and best regards,
>  Meenakshi

The symbol is there.  I'll attach a trivial module that accesses the symbol
successfully.

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc
--------------92874C6A0DD4E7FA4837D8D6
Content-Type: text/plain; charset=us-ascii;
 name="hello.c"
Content-Disposition: inline;
 filename="hello.c"
Content-Transfer-Encoding: 7bit

#include <linux/module.h>
#include <linux/version.h>
#include <asm/processor.h>

#define VUFX "00.12.12.b"

#ifdef MODULE
static int demo;
MODULE_PARM(demo, "i");
MODULE_PARM_DESC(demo ,"Demo of messages");
MODULE_DESCRIPTION("Demo driver");
MODULE_AUTHOR("Frank Rowand");
#endif

static int other_data;

void cleanup_module(void)
{
	printk("<1>\nGoodbye cruel world\n\n");
	other_data = 666;
}

int init_module(void)
{
	other_data = 333;
	printk("<1>\nHello World  " VUFX "\n");
	if (demo == 0) {
	    printk("<1>setting demo to default value\n");
	    demo = 42;
	}
	printk("<1>the demo var = %d\n",demo);
	printk("<1>\n");
	printk("kernel_thread() = 0x%p\n", kernel_thread);
	printk("<1>\n");
	return 0;
}

--------------92874C6A0DD4E7FA4837D8D6
Content-Type: text/plain; charset=us-ascii;
 name="Makefile"
Content-Disposition: inline;
 filename="Makefile"
Content-Transfer-Encoding: 7bit

CC=/opt/hardhat/devkit/ppc/4xx/bin/ppc_4xx-gcc
LD=/opt/hardhat/devkit/ppc/4xx/bin/ppc_4xx-ld

INCLUDEDIR=/opt/hardhat/devkit/ppc/4xx/powerpc-hardhat-linux/include

CFLAGS = -g -D__KERNEL__ -DMODULE  -o  -Wall  -I$(INCLUDEDIR)

INSTALL_ROOT=/opt/hardhat/devkit/ppc/4xx/target
INSTALL_USER_ROOT=$(INSTALL_ROOT)/home/$(USER)


# Extract version number from headers

VER = $(shell awk  -F\" '/REL/  {print $$2}' $(INCLUDEDIR)/linux/version.h)

OBJS = hello.o

all: hello_module.o

hello_module.o: $(OBJS)
	$(LD) -r  $^ -o $@

install:
	install -c hello_module.o $(INSTALL_USER_ROOT)
#	install -d $(INSTALL_ROOT)/lib/modules/misc
#	install -d $(INSTALL_ROOT)/lib/modules/$(VER)/misc
#	install -c hello_module.o $(INSTALL_ROOT)/lib/modules/$(VER)/misc
#	install -c hello_module.o $(INSTALL_ROOT)/lib/modules/misc

clean_target:
	rm $(INSTALL_USER_ROOT)/hello_module.o
#	rm $(INSTALL_ROOT)/lib/modules/$(VER)/misc/hello_module.o
#	rm $(INSTALL_ROOT)/lib/modules/misc/hello_module.o

clean: clean_target
	rm $(OBJS) hello_module.o

--------------92874C6A0DD4E7FA4837D8D6--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
