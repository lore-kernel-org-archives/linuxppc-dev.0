Date: Mon, 24 Apr 2000 05:48:50 -0400
From: root <abz@videotron.ca>
Subject: First try with module: need help
To: linuxppc-dev@lists.linuxppc.org
Message-id: <39041882.782A42CD@videotron.ca>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I try the very simple module (below) in "Linux device driver" by
Alessandro Rubini
and I get this error message:

couldn't find the kernel version the module was compiled for

even if the first line of the C source is

#define __NO_VERSION__

Do I need something special to complile the module


----------------- mod_1.c


#define MODULE
#define __NO_VERSION__
#include <linux/module.h>
#include <linux/version.h>

int init_module(void)
{
 printk("<1>This is a simple module\n");
 return 0;
}

void cleanup_module(void)
{
 printk("<1>The simple module is done\n");
}


-----------------  to compile

if test -f ./mod
 then
 rm ./mod
fi

gcc  -c mod_1.c -o mod.o

if test -f ./mod.o
 then
 insmod -f mod.o
 echo 'blablabla'
 rmmod  mod
fi


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
