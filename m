Return-Path: <jrocnuck@hotmail.com>
Received: from bay0-omc1-s24.bay0.hotmail.com (bay0-omc1-s24.bay0.hotmail.com
	[65.54.246.96]) by ozlabs.org (Postfix) with ESMTP id 4C94C67BC9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Sep 2006 03:06:50 +1000 (EST)
Message-ID: <BAY117-F7B65B7B42CA20EDC301D2C8200@phx.gbl>
In-Reply-To: <BAY110-F240E99BA0EDF765EC09402B2230@phx.gbl>
From: "Eric Nuckols" <jrocnuck@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: RE: how an application program utilizes the driver.
Date: Thu, 21 Sep 2006 13:06:44 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

this probably isn't the level /topic to ask on the list, so I suggest 
reading the Linux Device Drivers book...

you'll want to access the device via ioctl() calls , but there has to be a 
little more involved to get to that point:

experiment with the scull device driver in this book

http://lwn.net/images/pdf/LDD3/ch06.pdf

----Original Message Follows----
From: "Ming Liu" <eemingliu@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: how an application program utilizes the driver.
Date: Wed, 20 Sep 2006 13:48:25 +0000

Dear all,
Maybe this question sounds stupid for most software engineers. But I really
have much confusion on this topic. So I have to ask for explanation.

My situation is: I want to write a driver for my custom device.(In the
driver there are some functions defined to read or write my device.) Then
in my application program, I use these defined functions to operate my
hardware device. I think this is a normal process to operate the hardware
with driver+app, right?

My driver is defined in drv_hello.c. I have compiled it into a module
drv_hello.ko and it could be insmoded or rmmoded correctly. It looks like:

//drv_hello.c
#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
MODULE_LICENSE("Dual BSD/GPL");

void show_hello(){
     printk("hello.\n");
}

static int hello_init(void){
     printk(KERN_ALERT "module starts.\n");
     return 0;
}

static void hello_exit(void){
     printk(KERN_ALERT "module exits.\n");
}

module_init(hello_init);
module_exit(hello_exit);

EXPORT_SYMBOL(show_hello);



In my application program app_hello.c, I use the function show_hello to
achieve the simple task: print "hello" on the console. Here is my app
program:

//app_hello.c
extern void show_hello();

int main(int argc, char** argv)
{
     show_hello();

     return 0;
}

Then, here comes my problem: I don't know how to compile my application
program and then it could dynamically refer to the function show_hello()
defined in the memory area of the driver module. How can I tell the
compiler and linker that the app program is expected to be linked with the
driver module dynamically? If possible, please give me a detailed
explanation.

Waiting for your suggestion. Thanks for your help.

Regards
Ming

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
