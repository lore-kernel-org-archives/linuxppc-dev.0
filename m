Return-Path: <vb@vsbe.com>
Received: from mout.perfora.net (mout.perfora.net [74.208.4.195])
	by ozlabs.org (Postfix) with ESMTP id 63B20B7D56
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  3 Mar 2010 08:22:13 +1100 (EST)
Received: by pvg16 with SMTP id 16so183521pvg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 02 Mar 2010 13:22:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B8D3C59.4080504@windriver.com>
References: <1267212301-26851-1-git-send-email-paul.gortmaker@windriver.com>
	<f608b67d1003011503h57b88742md889ba8d6da652bc@mail.gmail.com>
	<4B8D3C59.4080504@windriver.com>
From: vb@vsbe.com
Date: Tue, 2 Mar 2010 13:21:49 -0800
Message-ID: <f608b67d1003021321h549cfb2bj1e3b217b94c3960c@mail.gmail.com>
Subject: Re: [PATCH] 8250: add workaround for MPC8[356]xx UART break IRQ storm
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 2, 2010 at 8:27 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> On 10-03-01 06:03 PM, vb@vsbe.com wrote:
>> sounds very much like this issue:
>>
>> http://linux.derkeiler.com/Mailing-Lists/Kernel/2010-02/msg09470.html
>
> Thanks for the link.
>
>>
>> (interrupt storm on the second port which is hit with breaks).
>>
>> It's not the uart driver problem per se, the below fixes it:
>
> Actually, it is a uart *hardware* problem -- see in this same
> thread where Scott Wood described an errata, and when I
> implemented his interpretation of what the fix should look
> like, things just worked. =A0You might want to try out that patch
> and see if it helps you, since from the link above, I see you
> are also on a powerpc board.
>
> Paul.
>

yeah, I was not aware of the hardware bug you are describing, it's
just the scenario I encountered is very similar: the serial interface
is flooded with breaks, after a while the prot generates an IRQ storm.
But the storm happens only after the port gets shut down (by getty in
my case).

In my case this behavior is due to a SW bug, you might be hitting the
HW problem, I have not seen it yet,

cheers,
/vb


>>
>> *** linux/drivers/serial/serial_core.c#1 =A0 =A0 =A0 =A0Wed Feb 24 17:46=
:22 2010
>> --- =A0linux/drivers/serial/serial_core.c#2 =A0 =A0 =A0 =A0Mon Mar =A01 =
15:00:29 2010
>> ***************
>> *** 622,632 ****
>> =A0 =A0 =A0 =A0 =A0struct uart_port *port =3D state->port;
>>
>> =A0 =A0 =A0 =A0 =A0if (I_IXOFF(tty)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (port->x_char)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port->x_char =3D 0;
>> ! =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart_send_xchar(tty, =
START_CHAR(tty));
>> =A0 =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0 =A0if (tty->termios->c_cflag& =A0CRTSCTS)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart_set_mctrl(port, TIOCM_RTS);
>> --- 622,632 ----
>> =A0 =A0 =A0 =A0 =A0struct uart_port *port =3D state->port;
>>
>> =A0 =A0 =A0 =A0 =A0if (I_IXOFF(tty)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (port->x_char)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port->x_char =3D 0;
>> ! =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (!(tty->flags& =A0(1<< =A0TTY_IO_E=
RROR)))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart_send_xchar(tty, =
START_CHAR(tty));
>> =A0 =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0 =A0if (tty->termios->c_cflag& =A0CRTSCTS)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart_set_mctrl(port, TIOCM_RTS);
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^
>>
>> I did not get to trying to submit it, but it sure gets rid o the storm.
>>
>> cheers,
>> /vb
>>
>> On Fri, Feb 26, 2010 at 11:25 AM, Paul Gortmaker
>> <paul.gortmaker@windriver.com> =A0wrote:
>>> Sending a break on the SOC UARTs found in some MPC83xx/85xx/86xx
>>> chips seems to cause a short lived IRQ storm (/proc/interrupts
>>> typically shows somewhere between 300 and 1500 events). =A0Unfortunatel=
y
>>> this renders SysRQ over the serial console completely inoperable.
>>> Testing with obvious things like ACKing the event doesn't seem to
>>> change anything vs. a completely dumb approach of just ignoring
>>> it and waiting for it to stop, so that is what is implemented here.
>>>
>>> Signed-off-by: Paul Gortmaker<paul.gortmaker@windriver.com>
>>> ---
>>>
>>> This is a refresh of a patch I'd done earlier -- I've tried to make
>>> the bug support as generic as possible to minimize having board
>>> specific ifdef crap in 8250.c -- any suggestions on how to further
>>> improve it are welcome.
>>>
>>> =A0 drivers/serial/8250.c =A0 =A0 =A0| =A0 =A06 ++++++
>>> =A0 drivers/serial/8250.h =A0 =A0 =A0| =A0 20 ++++++++++++++++++++
>>> =A0 drivers/serial/Kconfig =A0 =A0 | =A0 14 ++++++++++++++
>>> =A0 include/linux/serial_reg.h | =A0 =A02 ++
>>> =A0 4 files changed, 42 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
>>> index e9b15c3..850b0e9 100644
>>> --- a/drivers/serial/8250.c
>>> +++ b/drivers/serial/8250.c
>>> @@ -1531,6 +1531,11 @@ static void serial8250_handle_port(struct uart_8=
250_port *up)
>>>
>>> =A0 =A0 =A0 =A0 status =3D serial_inp(up, UART_LSR);
>>>
>>> + =A0 =A0 =A0 if ((up->bugs& =A0UART_BUG_PPC)&& =A0(status =3D=3D UART_=
LSR_RFE_ERROR_BITS)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&up->port.lock, fl=
ags);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>> + =A0 =A0 =A0 }
>>> +
>>> =A0 =A0 =A0 =A0 DEBUG_INTR("status =3D %x...", status);
>>>
>>> =A0 =A0 =A0 =A0 if (status& =A0(UART_LSR_DR | UART_LSR_BI))
>>> @@ -1948,6 +1953,7 @@ static int serial8250_startup(struct uart_port *p=
ort)
>>>
>>> =A0 =A0 =A0 =A0 up->capabilities =3D uart_config[up->port.type].flags;
>>> =A0 =A0 =A0 =A0 up->mcr =3D 0;
>>> + =A0 =A0 =A0 up->bugs |=3D UART_KNOWN_BUGS;
>>>
>>> =A0 =A0 =A0 =A0 if (up->port.iotype !=3D up->cur_iotype)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_io_from_upio(port);
>>> diff --git a/drivers/serial/8250.h b/drivers/serial/8250.h
>>> index 6e19ea3..2074ce1 100644
>>> --- a/drivers/serial/8250.h
>>> +++ b/drivers/serial/8250.h
>>> @@ -49,6 +49,7 @@ struct serial8250_config {
>>> =A0 #define UART_BUG_TXEN =A0(1<< =A01) =A0 =A0 =A0 =A0/* UART has bugg=
y TX IIR status */
>>> =A0 #define UART_BUG_NOMSR (1<< =A02) =A0 =A0 =A0 =A0/* UART has buggy =
MSR status bits (Au1x00) */
>>> =A0 #define UART_BUG_THRE =A0(1<< =A03) =A0 =A0 =A0 =A0/* UART has bugg=
y THRE reassertion */
>>> +#define UART_BUG_PPC =A0 (1<< =A04) =A0 =A0 =A0 =A0/* UART has buggy P=
PC break IRQ storm */
>>>
>>> =A0 #define PROBE_RSA =A0 =A0 =A0(1<< =A00)
>>> =A0 #define PROBE_ANY =A0 =A0 =A0(~0)
>>> @@ -78,3 +79,22 @@ struct serial8250_config {
>>> =A0 #else
>>> =A0 #define ALPHA_KLUDGE_MCR 0
>>> =A0 #endif
>>> +
>>> +/*
>>> + * The following UART bugs are currently dynamically detected and not
>>> + * required to be contingent on any particular compile time options.
>>> + */
>>> +#define HAS_BUG_QUOT =A0 0 =A0 =A0 =A0 /* assign UART_BUG_QUOT to enab=
le */
>>> +#define HAS_BUG_TXEN =A0 0 =A0 =A0 =A0 /* assign UART_BUG_TXEN to enab=
le */
>>> +#define HAS_BUG_NOMSR =A00 =A0 =A0 =A0 /* assign UART_BUG_NOMSR to ena=
ble */
>>> +#define HAS_BUG_THRE =A0 0 =A0 =A0 =A0 /* assign UART_BUG_THRE to enab=
le */
>>> +
>>> +#ifdef CONFIG_SERIAL_8250_PPC_BUG
>>> +#define HAS_BUG_PPC =A0 =A0UART_BUG_PPC
>>> +#else
>>> +#define HAS_BUG_PPC =A0 =A00
>>> +#endif
>>> +
>>> +#define UART_KNOWN_BUGS (HAS_BUG_QUOT | HAS_BUG_TXEN | HAS_BUG_NOMSR |=
 \
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HAS_BUG_THRE | HAS_BUG_PP=
C)
>>> +
>>> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
>>> index 9ff47db..e01a411 100644
>>> --- a/drivers/serial/Kconfig
>>> +++ b/drivers/serial/Kconfig
>>> @@ -70,6 +70,20 @@ config SERIAL_8250_CONSOLE
>>>
>>> =A0 =A0 =A0 =A0 =A0 If unsure, say N.
>>>
>>> +config SERIAL_8250_PPC_BUG
>>> + =A0 =A0 =A0 bool "Fix 8250/16550 to handle IRQ storm after receipt of=
 a break"
>>> + =A0 =A0 =A0 depends on SERIAL_8250&& =A0PPC32
>>> + =A0 =A0 =A0 ---help---
>>> + =A0 =A0 =A0 =A0 If you say Y here, addional checks will be added in t=
he handling of
>>> + =A0 =A0 =A0 =A0 interrupts on the serial ports which will prevent ill=
 effects of
>>> + =A0 =A0 =A0 =A0 an interrupt storm triggered by a break on the serial=
 line. Without
>>> + =A0 =A0 =A0 =A0 this enabled, a Sysrq via the serial console can be u=
nusable on
>>> + =A0 =A0 =A0 =A0 some systems.
>>> +
>>> + =A0 =A0 =A0 =A0 This is commonly observed on PPC32 MPC83xx/85xx/86xx =
based boards.
>>> +
>>> + =A0 =A0 =A0 =A0 If unsure, say N.
>>> +
>>> =A0 config FIX_EARLYCON_MEM
>>> =A0 =A0 =A0 =A0 bool
>>> =A0 =A0 =A0 =A0 depends on X86
>>> diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
>>> index cf9327c..010174f 100644
>>> --- a/include/linux/serial_reg.h
>>> +++ b/include/linux/serial_reg.h
>>> @@ -111,6 +111,7 @@
>>> =A0 #define UART_MCR_DTR =A0 =A0 =A0 =A0 =A0 0x01 /* DTR complement */
>>>
>>> =A0 #define UART_LSR =A0 =A0 =A0 5 =A0 =A0 =A0 /* In: =A0Line Status Re=
gister */
>>> +#define UART_LSR_RFE =A0 =A0 =A0 =A0 =A0 0x80 /* Rx FIFO Error (BE, FE=
, or PE) */
>>> =A0 #define UART_LSR_TEMT =A0 =A0 =A0 =A0 =A00x40 /* Transmitter empty =
*/
>>> =A0 #define UART_LSR_THRE =A0 =A0 =A0 =A0 =A00x20 /* Transmit-hold-regi=
ster empty */
>>> =A0 #define UART_LSR_BI =A0 =A0 =A0 =A0 =A0 =A00x10 /* Break interrupt =
indicator */
>>> @@ -119,6 +120,7 @@
>>> =A0 #define UART_LSR_OE =A0 =A0 =A0 =A0 =A0 =A00x02 /* Overrun error in=
dicator */
>>> =A0 #define UART_LSR_DR =A0 =A0 =A0 =A0 =A0 =A00x01 /* Receiver data re=
ady */
>>> =A0 #define UART_LSR_BRK_ERROR_BITS =A0 =A0 =A0 =A00x1E /* BI, FE, PE, =
OE bits */
>>> +#define UART_LSR_RFE_ERROR_BITS =A0 =A0 =A0 =A00xF1 /* RFE, TEMT, THRE=
, BI, DR bits */
>>>
>>> =A0 #define UART_MSR =A0 =A0 =A0 6 =A0 =A0 =A0 /* In: =A0Modem Status R=
egister */
>>> =A0 #define UART_MSR_DCD =A0 =A0 =A0 =A0 =A0 0x80 /* Data Carrier Detec=
t */
>>> --
>>> 1.6.5.2
>>>
>>> _______________________________________________
>>> Linuxppc-dev mailing list
>>> Linuxppc-dev@lists.ozlabs.org
>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>>
>
>
