Return-Path: <pczanik@fang.fa.gau.hu>
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id 36B10DE532
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 01:52:58 +1000 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by b.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	A97D33887D9
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 17:44:11 +0200 (CEST)
Received: from [192.168.2.179] ([82.131.207.186])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0JZJ00AYI2DN88Q0@invitel.hu> for
	linuxppc-dev@ozlabs.org; Fri, 18 Apr 2008 17:44:11 +0200 (CEST)
Date: Fri, 18 Apr 2008 17:43:58 +0200
From: Peter Czanik <pczanik@fang.fa.gau.hu>
Subject: Re: RFC: MPC5200 PSC AC97 driver
In-reply-to: <200804171619.56615.jbe@pengutronix.de>
To: Juergen Beisert <jbe@pengutronix.de>
Message-id: <4808C1BE.1050607@fang.fa.gau.hu>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <47FDEF9B.5000506@semihalf.com>
	<200804151003.17865.jbe@pengutronix.de>
	<200804161324.15887.jbe@pengutronix.de>
	<200804171619.56615.jbe@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

Juergen Beisert írta:
> Hi,
>
> if someone is interested: Here the full patch to get sound support for
> MPC5200b and a current 2.6.25 kernel.
>   
First of all, thanks for fixing the driver. I just tested it on the 
EFIKA, it (almost) works. In its current state loading the kernel module 
results in a segfault and oops. The fix is to add a missing line to the 
device-tree. The forth version of the EFIKA fix works fine (taken from 
http://www.powerdeveloper.org/platforms/efika/devicetree ):

efika:~ # cat /mnt/sound.forth
\ FORTH

s" /builtin/sound" find-device
        \ Audio is on PSC2, just for informational purposes
        1 encode-int s" cell-index" property
device-end
efika:~ #

But trying to fix it up from prom_init.c does not seem to work, the 
missing 'cell-index' property does not show up. Please let me know, how 
to add it properly. Here is what I tried:

factory:/usr/src/linux-2.6.25 # diff -u 
arch/powerpc/kernel/prom_init.c.orig arch/powerpc/kernel/prom_init.c
--- arch/powerpc/kernel/prom_init.c.orig        2008-04-18 
13:55:07.000000000 +0200
+++ arch/powerpc/kernel/prom_init.c     2008-04-18 16:26:51.000000000 +0200
@@ -2212,6 +2212,7 @@

 static void __init fixup_device_tree_efika(void)
 {
+       int sound_ci = 1;
        int sound_irq[3] = { 2, 2, 0 };
        int bcomm_irq[3*16] = { 3,0,0, 3,1,0, 3,2,0, 3,3,0,
                                3,4,0, 3,5,0, 3,6,0, 3,7,0,
@@ -2257,6 +2258,8 @@
                rv = prom_getprop(node, "interrupts", prop, sizeof(prop));
                if (rv == PROM_ERROR) {
                        prom_printf("Adding sound interrupts property\n");
+                        prom_setprop(node, "/builtin/sound", "cell-index",
+                                     &sound_ci, sizeof(int));
                        prom_setprop(node, "/builtin/sound", "interrupts",
                                     sound_irq, sizeof(sound_irq));
                }
factory:/usr/src/linux-2.6.25 #

Bye,
CzP
