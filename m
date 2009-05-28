Return-Path: <nvbolhuis@aimvalley.nl>
Received: from smtp-vbr17.xs4all.nl (smtp-vbr17.xs4all.nl [194.109.24.37])
	by ozlabs.org (Postfix) with ESMTP id 92BEEDDEF5
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 20:33:32 +1000 (EST)
Message-ID: <4A1E6877.2060106@aimvalley.nl>
Date: Thu, 28 May 2009 12:33:27 +0200
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: Daniel Ng <daniel.ng1234@gmail.com>
Subject: Re: MPC8272- Porting HDLC driver from 2.6.14 to 2.6.27- "no_irq_chip"
	error
References: <547eba1b0905280037j3336d0av7cc5d4069622d8f4@mail.gmail.com>
In-Reply-To: <547eba1b0905280037j3336d0av7cc5d4069622d8f4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Daniel,

"Ethos" driver... hmm. sounds familiar!
(good to hear that it is still used in active development)

About your question.

Since almost 2 years (kernel 2.6.22 from july 2007) the rule is that you can't
directly map a hardware irq number because the powerpc kernel keeps a
mapping between hardware irq numbers and virtual irq numbers.
request_irq() expects a virtual irq number.

Here's some background info why the linux PowerPC kernel works this way:

The basic request_irq() function is generic, but the value of the
arguments (especially the number for the IRQ line) is architecture
specific in many ways. This is one difference between the i386 code
and the powerpc code inside Linux. Most i386 hardware is standard
PC hardware with very clearly defined interrupt sources. Because of
this, the mapping from the numeric IRQ value to a real hardware
interrupt source is defined pretty clearly.
(In fact, not even clearly anymore  :-)   IE, there are still some legacy
  interrupts at fixed numbers but most things are remapped on x86 too
  nowadays when using IO_APICs, the kernel obtains numbers from ACPI,
  remaps them etc...)
The powerpc architecture code has to support almost arbitrarily complex
hardware, and the embedded world is the source of most of the complexity.
Because of this, the powerpc code has to dynamically allocate those numeric
IRQ sources and tie them to a specific hardware interrupt.
This is why there's a mapping between hardware irq numbers and virtual
irq numbers.


this is an example of how a simple 8313 Periodic Interval Timer (PIT) kernel driver
registers for the PIT IRQ (Interrupt ID 65)

#define PIT_IRQ 65

     virq = irq_create_mapping(NULL, PIT_IRQ);
     set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);

     if(request_irq(virq, (irq_handler_t)timerEvent, 0, "timer2", (void *)0)) {
         printk(KERN_ERR "request_irq() returned error for irq=%d virq=%d\n", PIT_IRQ, virq);
     }

All the above info comes from this mailing (and the linuxppc-embedd list) though.
If you search these lists you'll find plenty of answers to similar questions.

---
N. van Bolhuis
AimValley




Daniel Ng wrote:
> Hi,
> 
> I'm attempting to port our Ethos HDLC driver from 2.6.14 to 2.6.27, on
> a MPC8272-based platform.
> 
> So far, the kernel crashes when the driver tries to open (see below).
> 
> It seems that the interrupt handler fails to register, with the
> following condition in setup_irq() in manage.c:
> 
> desc->chip == &no_irq_chip
> 
> I notice that the only place where desc->chip is assigned to anything
> else besides &no_irq_chip is in __set_irq_handler() in
> kernel/irq/chip.c
> 
> In that file, __set_irq_handler() assigns desc->chip to
> &dummy_irq_chip, but this seems to be done for a special ARM-specific
> case, according to the commenting:
> 
> /*
>  * Some ARM implementations install a handler for really dumb
>  * interrupt hardware without setting an irq_chip. This worked
>  * with the ARM no_irq_chip but the check in setup_irq would
>  * prevent us to setup the interrupt at all. Switch it to
>  * dummy_irq_chip for easy transition.
>  */
> 
> Should I try to somehow call __set_irq_handler(), or should I be
> looking elsewhere?
> 
> If I should be calling __set_irq_handler(), it seems the only relevant
> function that calls this is cpm2_pic_host_map().
> 
> The only relevant functions which call cpm2_pic_host_map() are
> irq_setup_virq() or irq_alloc_hosts() with the IRQ_HOST_MAP_LEGACY
> parameter. IRQ_HOST_MAP_LEGACY seems to be irrelevant. Can someone
> tell me what a virq is?
> 
> Cheers,
> Daniel
> 
> 
> 
> Badness at c00224ec [verbose debug info unavailable]
> NIP: c00224ec LR: c019b254 CTR: c01aa9f8
> REGS: c1a49c70 TRAP: 0700   Not tainted  (2.6.27.19-800-OS-03050107)
> MSR: 00021032 <ME,IR,DR>  CR: 22002022  XER: 00000000
> TASK = c1bda400[306] 'pppd' THREAD: c1a48000
> GPR00: 00000001 c1a49d20 c1bda400 00000000 c0318880 c19c4d80 c1b92211 00000000
> GPR08: 00001032 c02cb240 00000000 00000000 22002022 fffffffe 01ff8000 00000000
> GPR16: 10344020 00000000 00000002 10049ac0 c194f800 ffff8914 c18cd900 c18cd90c
> GPR24: c1a49e48 00009032 c1a48000 c02b5fdc 00000002 c19c4d80 c1a48000 c1a48000
> NIP [c00224ec] local_bh_enable+0x94/0xb4
> LR [c019b254] dev_queue_xmit+0x108/0x580
> Call Trace:
> [c1a49d20] [c19c4d80] 0xc19c4d80 (unreliable)
> [c1a49d30] [c019b254] dev_queue_xmit+0x108/0x580
> [c1a49d50] [c016ac98] sppp_flush_xmit+0x20/0x44
> [c1a49d60] [c016c0b4] sppp_open+0x80/0xac
> [c1a49d80] [c016a104] ppp_open+0x70/0x98
> --- Exception: bfd26bb0 at 0x8914
>     LR = 0xc1a49e90
> [c1a49da0] [c01699e0] hdlc_open+0x3c/0x104 (unreliable)
> [c1a49dc0] [c016cdd4] ethos_wan_genhdlc_open+0xb0/0xef8
> [c1a49df0] [c019c490] dev_open+0xbc/0x120
> [c1a49e00] [c019bbc8] dev_change_flags+0x8c/0x1d0
> [c1a49e20] [c01e1678] devinet_ioctl+0x700/0x7ac
> [c1a49e90] [c01e2538] inet_ioctl+0xcc/0xf8
> [c1a49ea0] [c018b584] sock_ioctl+0x60/0x268
> [c1a49ec0] [c0084ab0] vfs_ioctl+0x3c/0xc4
> [c1a49ee0] [c0084bb8] do_vfs_ioctl+0x80/0x454
> [c1a49f10] [c0084fcc] sys_ioctl+0x40/0x88
> [c1a49f40] [c000f928] ret_from_syscall+0x0/0x38
> --- Exception: c01 at 0x480af50c
>     LR = 0x480af5e4
> Instruction dump:
> 41a20008 482044e1 80010014 83e1000c 38210010 7c0803a6 4e800020 3d20c02d
> 3929b240 800900dc 7c000034 5400d97e <0f000000> 2f800000 41beff90 38000001
> hdlc2: Carrier detected
> setup_irq()- desc->chip == &no_irq_chip
> request_irq()- setup_irq() FAILED
> ethos_wan_genhdlc_open(): request_irq() FAILED! ethos_wan->io_addr: 0xc5080000
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
