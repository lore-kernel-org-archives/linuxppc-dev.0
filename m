Message-ID: <3A5A16F1.283EA82E@mvista.com>
Date: Mon, 08 Jan 2001 11:37:21 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Jerry Van Baren <vanbaren_gerald@si.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MV kernel on 405GP
References: <4.3.2.20010108112126.00b95f00@falcon.si.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jerry Van Baren wrote:
>
> Sounds like you have one or more pending interrupts that you are not
> handling properly.  As soon as you enable external interrupts, you take
> the vector, but don't clear the pending interrupt(s).  Since you don't
> clear the interrupt, as soon as you leave the ISR, you get hit by
> another interrupt.  Viola, instant loop.
>
> Suggestions:
> 1) Check what interrupts are enabled and verify that they are handled
> properly.
> 2) Mask any external interrupt you don't need right now.
> 3) If that doesn't work, mask all external interrupts and see if you
> get further.
> 4) Re-enable the interrupts one at a time until you die again.
> 5) Repeat step #1 with the last interrupt you enabled :-).
>
> gvb
>
> At 06:12 PM 1/8/01 +0200, Juha Okkonen wrote:
>
> >         I have a custom board that uses IBM 405GP -prosessor. I have
> > already
> >         modified ppcboot-0.5.3 for booting. And am trying to get
> > Monta Vista's
> >         linux-2.4.0-test2 kernel to run on it also. But there is some
> > problem
> >         with exceptions. When start_kernel(void)-function calls sti()
> > to enable
> >         external interrupts, the prosessor hangs totally. I don't get any
> >register
> >         dumps or anything else either. I have been able to verify
> > with kgdb
> >that
> >         everything works until update of MSR-register.
> >
> >         If somebody has a version of the kernel modified for 405GP
> > and ppcboot
> >         both working, I would like to have the sources or at least
> > ideas about
> >         my problemn.
> >
> >                                                         'Okko
> >
> >
> >--
> >Juha
> >Okkonen/CTO                                 Juha.Okkonen@GreenCurrent.com
> >Green Current Oy                                Phone +358  9 2517 5525
> >Tekniikantie 21 E 226                                         +358
> >41  517 6542
> >02150 Espoo
> >
>


I assume you have the November 26 kernel (001126).  The following example is a
different version, but should work the same.

You can use kgdb to see what interrupts are being asserted.  This example shows
several different interrupts being asserted:




breakinst () at ppc-stub.c:895
895     }
Breakpoint 1 at 0xc0018038: file panic.c, line 54.
Breakpoint 2 at 0xc0037fcc: file buffer.c, line 318.
(gdb) l ppc4xx_pic_get_irq
153      */
154     int
155     ppc4xx_pic_get_irq(struct pt_regs *regs)
156     {
157             int irq;
158             unsigned long bits, mask = (1 << 31);
159
160             /*
161              * Only report the status of those interrupts that are actually
162              * enabled.
(gdb)
163              */
164
165     #ifdef CONFIG_IBM405
166             bits = mfdcr(DCRN_UICMSR);
167     #else
168             bits = mfdcr(DCRN_EXISR) & mfdcr(DCRN_EXIER);
169     #endif
170
171             /*
172              * Walk through the interrupts from highest priority to lowest, and
(gdb)
173              * report the first pending interrupt found.
174              */
175             /* ftr revisit - performance optimization */
176
177             for (irq = 0; irq < NR_IRQS; irq++, mask >>= 1) {
178                     if (bits & mask)
179                             break;
180             }
181
182             if (irq == NR_IRQS)
(gdb)
183                 irq = -1;
184
185             return (irq);
186     }
187
188     #ifdef CONFIG_IBM405
189
190     static void
191     ppc405_uic_enable(unsigned int irq)
192     {
(gdb) b 182
Breakpoint 3 at 0xc000ca1c: file ppc4xx_pic.c, line 182.
(gdb) c
Continuing.

Breakpoint 3, ppc4xx_pic_get_irq (regs=0x19) at ppc4xx_pic.c:182
182             if (irq == NR_IRQS)
(gdb) p bits
$1 = 0x40
(gdb) p/d irq
$3 = 25
(gdb) c
Continuing.
Breakpoint 3, ppc4xx_pic_get_irq (regs=0xb) at ppc4xx_pic.c:182
182             if (irq == NR_IRQS)
(gdb) p bits
$8 = 0x100000
(gdb) c
Continuing.

Breakpoint 3, ppc4xx_pic_get_irq (regs=0xc) at ppc4xx_pic.c:182
182             if (irq == NR_IRQS)
(gdb) p bits
$9 = 0x80000
(gdb) c
Continuing.

Breakpoint 3, ppc4xx_pic_get_irq (regs=0xa) at ppc4xx_pic.c:182
182             if (irq == NR_IRQS)
(gdb) p bits
$12 = 0x220000



-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
