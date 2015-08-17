Return-Path: <ranshalit@gmail.com>
Received: from mail-ig0-x232.google.com (mail-ig0-x232.google.com
 [IPv6:2607:f8b0:4001:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D22FB1A0372
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 15:24:11 +1000 (AEST)
Received: by igbjg10 with SMTP id jg10so47835787igb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Aug 2015 22:24:09 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 17 Aug 2015 08:24:09 +0300
Message-ID: <CAJ2oMhJWVxnr4OPnMdFdYPYgpwh3Nxm4S13XXXV4GCpqP4YmTg@mail.gmail.com>
Subject: IRQ handler is not called with external IRQ
From: Ran Shalit <ranshalit@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,


I have strange behaviour with external IRQ:
The registration on external IRQ is successful, but on simulating
interrupt the interrupt handler called.
It seems that the interrupt was received according to SEPNR which
shows that IRQ #2 interrupt is pending, but the handler was not
called.

These are the steps I done:

1. in DTS (using all external IRQ #2):

  intc2@0{
  compatible = "intc2";
   #address-cells = <1>;
   #size-cells = <0>;
   reg = <0 0x1000>;
   interrupts = <2 0x8> ;
   interrupt-parent = <&ipic>;
  };

2. registration in kernel for all interrupts:

  np = of_find_node_by_name(NULL,"intc2");
  if (np == NULL)
  {
      printk("Error node not found\n");
  }
     printk("Node np = 0x%0x\n",np);
     virq = irq_of_parse_and_map(np,0);
     printk(KERN_INFO"IRQHandler: ISR Setup VIRQ: %d \n" , virq);
     if (0 > (error=request_irq(virq, &IRQHandler, 0, "intc2", &value))) {
     printk(KERN_WARNING"IRQHandler: Init: Unable to allocate IRQ
error = %d\n\n", error);
     return -1;
  }


3. interrupt handler code:

int newval = 0;
static irqreturn_t hello_IRQHandler(int irq, void *dev_id)
{
         unsigned int status;
         struct timespec curr_tm;
         printk("key_irq!!!!!\n");
         return IRQ_HANDLED;
}

4. in boot I get print which show success with request_irq():

intc_init
Node np = 0xdfffe288
IRQHandler: ISR Setup VIRQ: 22
NET: Registered protocol family 17

5. forcing interrupt in IRQ #2, or #4 result in SEPNR change, but
there is no printing from interrupt handler

6. validation in SEPNR register that interrupt was received:

# devmem2 0xe000072c
/dev/mem opened.
Memory mapped at address 0xb7b80000.
Value at address 0xE000072C (0xb7b8072c): 0x20000000


Thank you for any suggestion,

Ran
