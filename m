From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15522.26785.327257.209724@argo.ozlabs.ibm.com>
Date: Thu, 28 Mar 2002 11:49:37 +1100 (EST)
To: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel Module; globals badly initialized, help needed.
In-Reply-To: <6B546A602AD2D211BFF00008C7A4288905844015@hrtades2.atea.be>
References: <6B546A602AD2D211BFF00008C7A4288905844015@hrtades2.atea.be>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Goddeeris Frederic writes:

> I am having lots of problems with global variables that are badly
> initialized in a kernel
> module. I wrote some very simple code showing the problem. The compiler I
> use is gcc 2.95.3

Hmmm.  I just tried your test module and it worked fine.  It produced
the following output:

TestDriver 3 Loaded
MyMemSpace: 0xd18b92a0 0xd18b93a0
MemPointers: 0xd18b92a0 0xd18b93a0
First Char is MyStruct[0].szName A

which looks fine to me.  This was with a 2.4.18 kernel.

The command line I used to compile it was:

bash-2.05a$ gcc -D__KERNEL__ -I/home/paulus/kernel/pmac-2.4.18/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -I/home/paulus/kernel/pmac-2.4.18/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -DMODULE  -DKBUILD_BASENAME=modtest -c modtest.c

I got this by doing `make modules' in a kernel tree and taking the
command that it used for the first module it came across (which
happened to be serial.c) and substituting modtest for serial.

I did some minor cleanups to the code, the actual code I used is
below.

Paul.

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>

char MyMemSpace[2*0x100];
char *MemPointers[2] = {&(MyMemSpace[0]), &(MyMemSpace[0x100])};

typedef struct
{
	char *szName;
	char *szName2;
} MyStruct_t;

MyStruct_t MyStruct[] = {{"A", "A2"}, {"B", "B2"}};

int init_module(void)
{
	printk("TestDriver 3 Loaded\n");

	printk("MyMemSpace: 0x%lx 0x%lx \n",  (long)&(MyMemSpace[0]),
	       (long)&(MyMemSpace[0x100]));
	printk("MemPointers: 0x%lx 0x%lx \n", (long)(MemPointers[0]),
	       (long)(MemPointers[1]));

	printk("First Char is MyStruct[0].szName %c\n",
	       MyStruct[0].szName[0]);


	return -1;
}

void cleanup_module(void)
{
	return;
}

MODULE_LICENSE("GPL");

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
