Message-ID: <20030508202012.37047.qmail@web41503.mail.yahoo.com>
Date: Thu, 8 May 2003 13:20:12 -0700 (PDT)
From: bhupinder sahran <bhup_sah@yahoo.com>
Subject: Re: Shared Interrupts Question (2.4)
To: Kent Borg <kentborg@borg.org>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030508160856.A18714@borg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

U r saying from the interrupt controller only one
physical line is coming to CPU to interrupt CPU.

SO in the do_irq routine u will have to read the
interrupt controller registers & find out who has
caused the interrupt & then invoke interrupt handler
corressponding to the interrupt number.

U should have a way, from the CPU to read the
interrupt controller registers & find out the
cause.....................


Bhupi
Linux+Hypertransport -->Silicon
www.gdatech.com
Good after beer -- Linux




--- Kent Borg <kentborg@borg.org> wrote:
>
> I am trying to understand "kinda shared" interrupts.
>
> There are various interrupts in my not-yet-released
> CPU, and I have
> interrupt code that knows how to talk to them.  So
> far so good.  I
> also have an external interrupt controller that
> groups together 18
> external interrupt sources and sends them in one CPU
> pin.  This
> external controller has a register for enabling
> interrupts, and a
> register for status/acknowledge.  Pretty standard.
>
> The CPU code doesn't know about the external
> controller.  It seems
> silly to rewrite the CPU-specific interrput code to
> accommodate this
> board-specific detail (besides then my code won't
> match Dale's).  So I
> figure I tell the kernel I am doing shared
> interrupts.
>
> So where do I enable, disable, and acknowledge these
> external bits?
> Specifically, I am trying to get a couple of serial
> ports working.  I
> can put conditional code in serial.c startup() to
> enable these
> interrupts, but how do I know which serial port?
> Add a conditionally
> compiled sub-IRQ number to serial_state structure?
>
> Is there a cleaner way?
>
>
> Thanks,
>
> -kb
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
