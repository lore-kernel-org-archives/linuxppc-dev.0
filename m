Message-ID: <20030515145617.89401.qmail@web11005.mail.yahoo.com>
Date: Thu, 15 May 2003 07:56:17 -0700 (PDT)
From: Xupei Liang <tliang@yahoo.com>
Subject: Re: IDE driver support in PPC440
To: Eugene Surovegin <ebs@ebshome.net>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <5.1.0.14.2.20030514094842.029fc6c0@mail.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Eugene,

Thank you for pointing out this. I have updated
ibm440.h and ppc4xx_pic.c as well. Now, in
ppc405_disable_and_ack(), besides acking the
interrupt, it will clear UIC0_UIC1NC bit in the
UIC0_SR register as well. That works for my
board.

Thanks.

Regards,

Terry L.


--- Eugene Surovegin <ebs@ebshome.net> wrote:
>
> At 08:20 AM 5/14/2003, Xupei Liang wrote:
> >Hi, Eugene,
> >
> >The IRQ7 is setup as level trigger and active low.
>
> <snip>
>
> >This time, ppc405_pic_get_irq() returns irq 64
> because
> >the routine knows that all interrupts have been
> >disabled (I have looked at UIC_ER0 and UIC_ER1
> >and verified that is the case).
>
> No, this is not correct, it should return -1.
> Otherwise do_IRQ will spin forever (see
> arch/ppc/kernel/irq.c)
>
> Here is the code in question:
>
> int
> ppc405_pic_get_irq(struct pt_regs *regs)
> {
>
>         ........
>
>          if (irq == (NR_UIC_IRQS * NR_UICS))
>                  irq = -1;
>
> #ifdef UIC_DEBUG
>          printk("ppc405_pic_get_irq - irq %d bit
> 0x%x\n", irq, bits);
> #endif
>
>          return (irq);
> }
>
>
> Check, that NR_UIC_IRQS == 32 (defined in
> include/arch-ppc/irq.h)
> and NR_UICS == 2 (defined in
> /include/arch-ppc/ibm440.h) in your tree.
>
> They weren't set correctly in some early versions of
> 440GP code.
>
> Eugene
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
