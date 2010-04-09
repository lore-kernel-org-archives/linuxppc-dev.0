Return-Path: <SSparks@aclara.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id 02523B7CF5
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Apr 2010 05:20:16 +1000 (EST)
Received: from mail145-tx2 (localhost.localdomain [127.0.0.1])	by
	mail145-tx2-R.bigfish.com (Postfix) with ESMTP id A84281480F7	for
	<linuxppc-dev@ozlabs.org>; Fri,  9 Apr 2010 19:05:07 +0000 (UTC)
Received: from TX2EHSMHS036.bigfish.com (unknown [10.9.14.251])	by
	mail145-tx2.bigfish.com (Postfix) with ESMTP id 36528A00342	for
	<linuxppc-dev@ozlabs.org>; Fri,  9 Apr 2010 18:40:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: Upgrade to 2.6.26 results in Oops during request_irq
Date: Fri, 9 Apr 2010 13:39:44 -0500
Message-ID: <6011A7C9CD0EE74792C3ED2A8355608601707849@mail.twacs.com>
In-Reply-To: <6011A7C9CD0EE74792C3ED2A83556086B67190@mail.twacs.com>
References: <6011A7C9CD0EE74792C3ED2A83556086B67190@mail.twacs.com>
From: "Sparks, Sam" <SSparks@aclara.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>-----Original Message-----
>From: Sparks, Sam
>Sent: Thursday, April 08, 2010 4:15 PM

In the interest of making it easier for someone to help, I've been able
to replicate the problem with the following minimal kernel module:

#include <linux/interrupt.h>
#include <linux/irq.h>
#include <linux/module.h>

static unsigned int cpld_virq =3D NO_IRQ;
unsigned value =3D 0xdeadbeef;

static irqreturn_t cpld_isr(int irq, void *dev_id) {
    return IRQ_HANDLED;
}

void __exit cpld_cleanup(void) {
    irq_dispose_mapping(cpld_virq);
    return;
}

int __init cpld_init(void) {
    int retval;
    unsigned long cpld_interrupt =3D 23;

    cpld_virq =3D irq_create_mapping(NULL, cpld_interrupt);
    if (cpld_virq =3D=3D NO_IRQ) {
        printk(KERN_ERR "Could not map HW IRQ %lu\n", cpld_interrupt);
        return -EBUSY;
    }

    retval =3D  request_irq(cpld_virq, cpld_isr,
            IRQF_DISABLED | IRQF_SHARED | IRQF_TRIGGER_FALLING,
            "CPLD", &value);
    if (retval) {
        irq_dispose_mapping(cpld_virq);
        return retval;
    }

    return 0;
}

module_init(cpld_init);
module_exit(cpld_cleanup);
MODULE_LICENSE("Dual BSD/GPL");

It builds fine, but still gives me the same error when inserted into the
kernel:

# insmod /tmp/cpld.ko
Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0x00000000
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT SCPA-G2
Modules linked in: cpld(+) [last unloaded: immr]
NIP: 00000000 LR: c004bab8 CTR: 00000000
REGS: dfb13df0 TRAP: 0400   Not tainted  (2.6.26-twacs-100.0.0)
MSR: 20001032 <ME,IR,DR>  CR: 24244422  XER: 20000000
TASK =3D df8b6c00[559] 'insmod' THREAD: dfb12000
GPR00: 00000000 dfb13ea0 df8b6c00 00000017 00000001 00000001 00000000
c02d1fb4
GPR08: 0000361a 00000000 00000000 00000000 44244484 10073f68 1ffcb000
007ffeb0
GPR16: 00000000 00000000 00800000 00000000 bffff7f0 00000000 1006e3dc
00000000
GPR24: 00000002 20000000 00000000 00009032 df9da620 dfb12000 c02d40e4
00000017
NIP [00000000] 0x0
LR [c004bab8] setup_irq+0x4e0/0x510
Call Trace:
[dfb13ea0] [c004ba70] setup_irq+0x498/0x510 (unreliable)
[dfb13ed0] [c004bd64] request_irq+0xe0/0x130
[dfb13f00] [e107804c] cpld_init+0x4c/0xe8 [cpld]
[dfb13f10] [c0048c4c] sys_init_module+0x14c/0x1d8
[dfb13f40] [c0010008] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff27bb0
    LR =3D 0x10019ca8
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
Kernel panic - not syncing: Fatal exception

Please let me know if I should be providing some additional information.
Thanks,
Sam
