Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Subodh Nijsure <subodh@best.com>
Message-Id: <200103230550.VAA03749@shell9.ba.best.com>
Subject: request_irq in a module casues kernel crash
To: linuxppc-embedded@lists.linuxppc.org
Date: Thu, 22 Mar 2001 21:50:11 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to write a module where I am trying to register an interrupt
handler using request_irq() sample code for which appears below, when
I try to load this module, I am getting kernel panic. Anybody knows reason
why?
I have compiled the kernel with  CONFIG_MODULES=y CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

I am using  2.4.2-pre3 on a 860 platform.


void handler(int irq, void *dev_id, struct pt_regs * regs)
{
    printk("Interrupt handler invoked for irq %d \n",irq);
}

/* load the module */
int init_module(void)
{
    int result;
    result = request_irq (SIU_IRQ7, my_handler,SA_INTERRUPT,
		"cxeHandler",NULL);
    if ( result )
        printk("Interrupt not assigned");
    else
        printk("Interrupt  assigned");
    return 0;
}

/* remove the module */
void cleanup_module(void)
{
    return;
}

/Subodh Nijsure

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
