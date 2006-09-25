Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id C44E267B64
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Sep 2006 06:36:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: ucmpdi2 and cmpdi2
Date: Mon, 25 Sep 2006 15:36:46 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0189DF91@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

I have a function that does a switch statement on a long long or
unsinged long long and get teh follwing compiler warnings when making a
module:

WARNING: "__ucmpdi2"
[/home/runet/source/hardware_1.1/cpu1/src/drivers/test_bug.ko]
undefined!
WARNING: "__cmpdi2"
[/home/runet/source/hardware_1.1/cpu1/src/drivers/test_bug.ko]
undefined!

And of course it fails to load.

The weird thingis that it works if I instead of using a long long, use a
[u]int64_t.
Is this a compiler error or something else?

gcc version: powerpc-604-linux-gnu-gcc (GCC) 3.4.3
target CPU: Freescale 826x.

Here is my module source:
#ifndef __KERNEL__
#  define __KERNEL__
#endif
#ifndef MODULE
#  define MODULE
#endif
#include <linux/config.h>
#include <linux/module.h>

#include <linux/kernel.h>   /* printk() */
#include <linux/types.h>    /* size_t */
#include <linux/ctype.h>

void TestFunc(char val)
{
    long long   t1;
    unsigned long long   t2;
   =20
    t1 =3D 0x100;
    t2 =3D 0x200;

    switch(t1)
    {
        case 0x01:=20
            printk("c1\n");
        break;  =20
        default:
            printk("def1\n");
        break;
    }

    switch(t2)
    {
        case 0x02:=20
            printk("c2\n");
        break;  =20
        default:
            printk("def2\n");
        break;
    }
}

static int __init tmp_init_module(void)
{
    return 0;
}

static void __exit tmp_cleanup_module(void)
{
}

module_init(tmp_init_module);
module_exit(tmp_cleanup_module);
