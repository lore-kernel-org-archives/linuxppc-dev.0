Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 072BB67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Feb 2005 22:22:38 +1100 (EST)
Message-ID: <42035D27.50901@ru.mvista.com>
Date: Fri, 04 Feb 2005 14:31:51 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Joshua Lamorie <jpl@xiphos.ca>
References: <4202E286.1010206@xiphos.ca>
In-Reply-To: <4202E286.1010206@xiphos.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Edge Interrupts (Virtex-II Pro)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Joshua Lamorie wrote:
> Gidday there,
> 
> Is there a cleaner way to specify that an interrupt is edge triggered 
> other than directly accessing irq_desc_t irq_desc []?

In case of ML300 (which is the only Virtex-II Pro board in the linux-2.5
tree so far) this is done in platforms/xilinx_ml300.c:ml300_init_irq()
based on XPAR_INTC_0_KIND_OF_INTR value defined in the xparameters.h:

         for (i = 0; i < NR_IRQS; i++) {
                 if (XPAR_INTC_0_KIND_OF_INTR & (0x80000000 >> i))
                         irq_desc[i].status &= ~IRQ_LEVEL;
                 else
                         irq_desc[i].status |= IRQ_LEVEL;
         }

As this code is not board specific at all,
I would move it to arch/ppc/syslib/xilinx_pic.c:ppc4xx_pic_init().
Does it sound reasonable (I'll prepare the patch this weekend then)?

Hmm...
Looks like I've forgotten to change the irq numbering here...
Must be
   if (XPAR_INTC_0_KIND_OF_INTR & (0x00000001 << i))
I think...
Will check.

Thanks,
Andrei

P.S.
Just in case you use 2.4.
2.4 kernel is almost the same to 2.6 in this sense.
But the irq numbering is different.

> In my module, when I request_irq, if it succeeds I do the following.
> 
>      irq_desc[iIRQ].status &= ~(IRQ_LEVEL);
> 
> Is there a better way?
>
> Thanks in advance
> 
> Joshua
> 
