Return-Path: <jonandia@aotek.es>
Received: from sollube.sarenet.es (mx1.sarenet.es [194.30.0.37])
	by ozlabs.org (Postfix) with ESMTP id F120067B86
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 19:11:57 +1000 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by sollube.sarenet.es (Postfix) with ESMTP id EB4D2374E1
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 08:33:25 +0200 (CEST)
Message-ID: <44F7D4B8.1010600@fagorautomation.es>
Date: Fri, 01 Sep 2006 08:35:36 +0200
From: Josu Onandia <jonandia@fagorautomation.es>
MIME-Version: 1.0
To: Steven Kaiser <skaiser.uci@gmail.com>
Subject: Re: Simple module, but won't build
References: <000001c6cd50$8c0196f0$6e4ec880@volt>
In-Reply-To: <000001c6cd50$8c0196f0$6e4ec880@volt>
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Steven Kaiser wrote:

>Hi gurus:
>
>Newbie here.  I am using ELDK 3.1.1, 2.4.25 kernel, and a Lite5200b board.
>I run the kernel in RAM, and mount a filesystem via NFS.  So far so good,
>and I move on to trying to build a simple module to write to a few LEDs.
>
>Simple hello world modules compile and insmod/rmmod fine, but when I try to
>#include <asm/io.h>, here I have the exact same problem as Richard Danter
>did: CONFIG_KERNEL_START and CONFIG_TASK_SIZE are not defined anywhere in
>any headers-- just in the config files.
>
>http://ozlabs.org/pipermail/linuxppc-embedded/2004-May/014037.html
>
>My little wrinkle to add to this problem is I have recompiled the kernel, as
>advised in the replies to Richard's post, with the 'Set Custom Kernel Base
>Address' and 'Set Custom user task size' options enabled, but in my case I
>still I cannot find CONFIG_KERNEL_START and CONFIG_TASK_SIZE defined
>anywhere noteworthy.
>
>My 'include/linux/autoconf.h' file is empty, and I don't even have an
>'include/config/' directory at all.  Where in the steps of recompiling the
>kernel should these files and directories get generated?
>
>My process for building the kernel is:
>
>$ cd /opt/eldk/usr/src/linuxppc_2_4_devel
>$ make mrproper
>$ make lite5200b_config
>$ make menuconfig
>$ make dep
>$ make uImage
>$ cp arch/ppc/boot/images/uImage /tftpboot/MPC5200/uImage
>
>I can manually include CONFIG_KERNEL_START and CONFIG_TASK_SIZE in my module
>source, compile, insmod, and all goes well (except my LEDs don't light up
>but first things first).
>
>When my kernel boots, I get a few gripes which I think are related to this
>issue:
>
>Finding module dependencies:  depmod: Can't open
>/lib/modules/2.4.25/modules.deg [FAILED]
>modprobe: Can't open dependencies file /lib/modules/2.4.25/modules.dep (No
>such)
>
>Young and foolish, I figured maybe I should try:
>
>$ make modules
>$ make modules_install
>
>Oops.  That was bad.  Now I cannot even compile the simplest hello.c module
>without a page of errors, the first being a complaint of not being able to
>find linux/autoconf.h.  Before I only had trouble when I tried to #include
><asm/io.h>, now it happens 100% of the time.
>
>So I went back and turned off module support, recompiled the kernel, and
>still cannot compile hello.c.  I also tried recompiling the kernel after
>doing a "make oldconfig", and still cannot compile a simple module anymore.
>I think I am going to have to go back to square 1 and reinstall ELDK and
>everything from scratch.  But before I do:
>
>Any insight into the generation of autoconf.h, and whereabouts this file
>should come from?  I will watch for it when I redo the whole process.
>
>Steven Kaiser
>Chemistry Electronics Facility
>University of California, Irvine
>2347 Natural Sciences 2
>Irvine, CA  92697-2025
>(949)824-7520
>
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>  
>
I can help you with the leds part of your problem. Below is some simple 
code to manage the leds in a Lite5200b.

About the rest of the problem, I can't tell, because my linux/autoconf.h 
is OK, and I can include asm/io.h in my modules without problem. To 
reinstall everything from scratch is a good idea.

I'm writing modules for a Lite5200b right now, using RTAI. I use the 
leds to do some 'visual debugging'. You can contact me directly if you want.

#include <asm/mpc5xxx.h>

struct mpc5xxx_wu_gpio {
   volatile u32 enable;
   volatile u32 ode;
   volatile u32 dir;
   volatile u32 data;    }; 

static void configure_leds(void)
{
    struct mpc5xxx_gpio *gpio;
    struct mpc5xxx_wu_gpio *wu_gpio;

    gpio = (struct mpc5xxx_gpio*) MPC5xxx_GPIO;
    wu_gpio = (struct mpc5xxx_wu_gpio*)MPC5xxx_WU_GPIO;
    gpio->port_config &= ~(0x00f00000); 
    gpio->simple_gpioe |= 0x30000000;
    gpio->simple_ddr |= 0x30000000;
    gpio->simple_dvo |= 0x30000000;
   
    wu_gpio->enable |= 0x30000000;
    wu_gpio->ode &= ~0x30000000;
    wu_gpio->dir |= 0x30000000;  
}
static void led_off(int led)
{
    struct mpc5xxx_gpio *gpio;
    struct mpc5xxx_wu_gpio *wu_gpio;
    gpio = (struct mpc5xxx_gpio*) MPC5xxx_GPIO;
    wu_gpio = (struct mpc5xxx_wu_gpio*)MPC5xxx_WU_GPIO;
   
    switch( led)
    {
        case 1:
            wu_gpio->data |= 0x20000000;
            break;
        case 2:
            gpio->simple_dvo |= 0x10000000;
            break;
        case 3:
            wu_gpio->data |= 0x10000000;
            break;
        case 4:
            gpio->simple_dvo |= 0x20000000;
            break;
        default:
            break;
    }
}
static void led_on(int led)
{
    struct mpc5xxx_gpio *gpio;
    struct mpc5xxx_wu_gpio *wu_gpio;
    gpio = (struct mpc5xxx_gpio*) MPC5xxx_GPIO;
    wu_gpio = (struct mpc5xxx_wu_gpio*)MPC5xxx_WU_GPIO;
   
    switch(led)
    {
        case 1:
            wu_gpio->data &= ~0x20000000;
            break;
        case 2:
            gpio->simple_dvo &= ~0x10000000;
            break;
        case 3:
            wu_gpio->data &= ~0x10000000;
            break;
        case 4:
            gpio->simple_dvo &= ~0x20000000;
            break;
        default:
            break;
    }
}
