Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id 14CCF67AB5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Jan 2005 14:04:26 +1100 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A6475BD@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>,
	"'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Thu, 27 Jan 2005 21:56:21 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Subject: RE: console_init() question 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

-----Original Message-----
>From: Dan Malek [mailto:dan@embeddededge.com]
>Sent: Thursday, January 27, 2005 9:38 PM
>To: Povolotsky, Alexander
>Cc: 'linuxppc-dev@lists.linuxppc.org'; 'linuxppc-embedded@ozlabs.org'
>Subject: Re: console_init() question=20

>Do you boot over a network?  Does your boot loader shut down
>the network controller and interrupts before jumping to the kernel?

No - also, please note that the serial works during the "simple =
bootloader
time" (see my "add on" question below)

>Everything looks OK until the CPM and serial port are reconfigured
>by Linux, so something is amiss with that.  Could be many reasons
>such as location of BDs and buffers, some part of the CPM still
>running a peripheral from the boot loader that Linux doesn't know
>about, and so on.

That why I asked (OK ..., may be I did not ask that ...)
 for some "CPM diagnostic" software, that could
be run upon kernel booting
 - (something what PPCbug might have already - not sure, though, just
guessing ...)

	-- Dan

Alternatively (or addionally) to my original questin - why not =
(optionally)
to
 allow for the kernel to use the simple serial console mechanism
(putc( ), puts( ), puthex( )) which is used (and, by the way, works in =
my
case - as one could=20
see from the quotted below booting output) in the "simple" bootloader =
(the
'middle-man' between the primary=20
bootloader and the kernel ) - may be by making it available to the =
kernel as
a library  ?

-----Original Message-----
>From: Andrew Williams [mailto:awilliam@nortelnetworks.com]
>Sent: Thursday, January 27, 2005 9:33 PM
>To: Povolotsky, Alexander; 'linuxppc-dev@lists.linuxppc.org';
'linuxppc-embedded@ozlabs.org'
>Subject: RE: console_init() question=20

>Here's a reference doc, that I found extremely usefull/interesting=20
>when working on board bring up.=20
>  <http://www.tldp.org/LDP/cpg/Custom-Porting-Guide.pdf>=20
>Andrew=20
Thanks - I have already look at that - those lucky guys had simple =
serial
UART (without CPM complexity)=20


>  -----Original Message-----
> From: 	Povolotsky, Alexander =20
> Sent:	Thursday, January 27, 2005 9:07 PM
> To:	'linuxppc-dev@lists.linuxppc.org'; 'linuxppc-embedded@ozlabs.org'
> Subject:	console_init() question=20
>=20
> Hi,
>=20
> I am struggling with bringing up the MPC 880 board on Linux =
2.6-10.rc3 ...
> I could see that only 3 characters (see below) from the linux_banner =
are
> printed
> in __init start_kernel() (init/main.c) upon booting.
> Then a lot of garbage is outputted and eventually kernel hangs ...
> ...
> after gunzip
> done.
> Now booting the kernel
> =
Lin=FF=FF=FF=FF=FF=FF=FF=FF=C0=FF=FF=FF=FF=FF=FF=FF=FF=C08=C0=FF=FF=FF=FF=
=FF=FF=FF=FF=C0X=C0=FF=FF=FF=FF=FF=FF=FF=FF=C0x=C0=FF=FF=FF=FF=FF=FF=FF=FF=
=C0~=C0=FF=FF=FF=FF=FF=FF=FF=FF=C0=B8=C0=FF=FF=FF=FF=FF=FF=FF
> =FF=C0=D8=C0=FF=FF
> <more garbage>
> <hangs> ...=20
> ...
>=20
> Very laborious debugging (without BDM and soft reset button - but =
with
> great help) shows that the hang is caused by the console
> serial driver at about (or just soon after)=20
>=20
>     console_drivers =3D console;
>=20
>  statement in
>=20
>  register_console(struct console * console)
>=20
> function (in kernel/printk.c )=20
> =20
> I can not find (so far ) any specific error in values supplied via =
bd_info
> from the ("custom" modified pSOS bootloader) causing above problem.
> =20
> The debug output showing my serial settings was saved into log buffer =
and
> read at "bootloader time" after=20
> "software stimulated" "soft reboot" - it is listed here.
> Could someone kindly spare 5 min examining supplied debug output  =
from
> both cpm_uart_set_termios()
> (in drivers/serial/cpm_uart/cpm_uart_core.c)  and cpm_setbrg() (in
> arch/ppc/8xx_io/commproc.c) and tell
> me what is wrong there   ?
> The output is supplied at the end of my e-mail after the listings of
> functions (with my print statements)
>=20
> Thanks,
> Alex
>=20
> PS - I noticed (with help and via "trial and error" way) that
> console_init() code is written to work only with
>        "boot" (unmapped) memory and therefore only could work if =
executed
> prior to mem_init().=20
>        Suppose I would disable (comment out in main.c ) the =
console_init()
> call
>        and suppose (I do not know yet since  did not tried that) the
> kernel booting
>        will continue without any additional problems and will =
sucessfully
> finish (just without the console ;-) )
>        - is there any existant "non-standard" "debugging" =
"experimental"
> code,
>        which I could integrate and execute with the aim to "late" =
launch
> my serial console at that point ?
>=20
> ***************** drivers/serial/cpm_uart/cpm_uart_core.c
> ******************
> ....
> #define DEBUG=20
> ....
> static void cpm_uart_set_termios(struct uart_port *port,
>                                  struct termios *termios, struct =
termios
> *old)
> {
>         int baud;
>         unsigned long flags;
>         u16 cval, scval, prev_mode;
>         int bits, sbits;
>         struct uart_cpm_port *pinfo =3D (struct uart_cpm_port *)port;
>         volatile smc_t *smcp =3D pinfo->smcp;
>         volatile scc_t *sccp =3D pinfo->sccp;
> #ifdef DEBUG
>         pr_debug("CPM uart[%d]:set_termios\n", port->line);
> #endif
>=20
>         baud =3D uart_get_baud_rate(port, termios, old, 0, =
port->uartclk /
> 16);
>=20
> #ifdef DEBUG
>         pr_debug("CPM uart baud=3D%d\n", baud);
> #endif
>         /* Character length programmed into the mode register is the
>          * sum of: 1 start bit, number of data bits, 0 or 1 parity =
bit,
>          * 1 or 2 stop bits, minus 1.
>          * The value 'bits' counts this for us.
>          */
>         cval =3D 0;
>         scval =3D 0;
>=20
>         /* byte size */
>         switch (termios->c_cflag & CSIZE) {
>         case CS5:
>                 bits =3D 5;
>                 break;
>         case CS6:
>                 bits =3D 6;
>                 break;
>         case CS7:
>                 bits =3D 7;
>                 break;
>         case CS8:
>                 bits =3D 8;
>                 break;
>                 /* Never happens, but GCC is too dumb to figure it =
out */
>         default:
>                 bits =3D 8;
>                 break;
>         }
>         sbits =3D bits - 5;
> #ifdef DEBUG
>         pr_debug("CPM uart bits=3D%d\n", bits);
>         pr_debug("CPM uart sbits=3D%d\n", sbits);
> #endif
>=20
>         if (termios->c_cflag & CSTOPB) {
>                 cval |=3D SMCMR_SL;       /* Two stops */
>                 scval |=3D SCU_PSMR_SL;
>                 bits++;
>         }
>=20
>         if (termios->c_cflag & PARENB) {
>                 cval |=3D SMCMR_PEN;
>                 scval |=3D SCU_PSMR_PEN;
>                 bits++;
>                 if (!(termios->c_cflag & PARODD)) {
>                         cval |=3D SMCMR_PM_EVEN;
>                         scval |=3D (SCU_PSMR_REVP | SCU_PSMR_TEVP);
>                 }
>         }
> #ifdef DEBUG
>         pr_debug("CPM uart bits=3D%d\n", bits);
>         pr_debug("CPM uart cval=3D%d\n", cval);
>         pr_debug("CPM uart scval=3D%d\n", scval);
> #endif
>=20
>         /*
>          * Set up parity check flag
>          */
> #define RELEVANT_IFLAG(iflag) (iflag &
> (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
>=20
>         port->read_status_mask =3D (BD_SC_EMPTY | BD_SC_OV);
>         if (termios->c_iflag & INPCK)
>                 port->read_status_mask |=3D BD_SC_FR | BD_SC_PR;
>         if ((termios->c_iflag & BRKINT) || (termios->c_iflag & =
PARMRK))
>                 port->read_status_mask |=3D BD_SC_BR;
>=20
>         /*
>          * Characters to ignore
>          */
>         port->ignore_status_mask =3D 0;
>         if (termios->c_iflag & IGNPAR)
>                 port->ignore_status_mask |=3D BD_SC_PR | BD_SC_FR;
>         if (termios->c_iflag & IGNBRK) {
>                 port->ignore_status_mask |=3D BD_SC_BR;
>                 /*
>                  * If we're ignore parity and break indicators, =
ignore
>                  * overruns too.  (For real raw support).
>                 */
>                if (termios->c_iflag & IGNPAR)
>                        port->ignore_status_mask |=3D BD_SC_OV;
> ifdef DEBUG
>               if (termios->c_iflag & IGNPAR)
>                pr_debug("CPM uart real raw support");
> endif
>        }
>        /*
>         * !!! ignore all characters if CREAD is not set
>         */
>        if ((termios->c_cflag & CREAD) =3D=3D 0)
>                port->read_status_mask &=3D ~BD_SC_EMPTY;
> ifdef DEBUG
>         if ((termios->c_cflag & CREAD) =3D=3D 0)
>          pr_debug("CPM uart CREAD is not set");
> endif
>=20
>        spin_lock_irqsave(&port->lock, flags);
>=20
>        /* Start bit has not been added (so don't, because we would =
just
>         * subtract it later), and we need to add one for the number =
of
>         * stops bits (there is always at least one).
>         */
>        bits++;
> ifdef DEBUG
>        pr_debug("CPM uart bits=3D%d\n", bits);
> endif
>        if (IS_SMC(pinfo)) {
>                /* Set the mode register.  We want to keep a copy of =
the
>                 * enables, because we want to put them back if they =
were
>                 * present.
>                 */
>                prev_mode =3D smcp->smc_smcmr;
>                smcp->smc_smcmr =3D smcr_mk_clen(bits) | cval |
> SMCMR_SM_UART;
>                smcp->smc_smcmr |=3D (prev_mode & (SMCMR_REN | =
SMCMR_TEN));
> ifdef DEBUG
>        pr_debug("CPM uart IS_SMCpinfo > 0 \n");
> endif
>        } else {
>                sccp->scc_psmr =3D (sbits << 12) | scval;
>        }
>=20
>        cpm_set_brg(pinfo->brg - 1, baud);
> ifdef DEBUG
>        pr_debug(" returned from cpm_set_brg");
> endif
>        spin_unlock_irqrestore(&port->lock, flags);
> ifdef DEBUG
>         pr_debug("after spin_unlock_irqrestore");
> #endif
>         *(int*)0 =3D 0xdeadbeef;  <=3D=3D=3D=3D  I have inserted here =
 to force
> crash and soft reboot - it works !
> #ifdef DEBUG
>         pr_debug("after deadbeef");  <<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
 I have inserted here
> for double check - never reached ...
> #endif
>=20
> }
>=20
> *****************************  arch/ppc/8xx_io/commproc.c
> ***********************************=20
>=20
> #define BRG_INT_CLK             (((bd_t *)__res)->bi_intfreq)
> #define BRG_UART_CLK            (BRG_INT_CLK/16)
> #define BRG_UART_CLK_DIV16      (BRG_UART_CLK/16)
>=20
> void
> cpm_setbrg(uint brg, uint rate)
> {
>         volatile uint   *bp;
>         unsigned long brgUrtClkDiv16 =3D BRG_UART_CLK_DIV16;
>=20
>         /* This is good enough to get SMCs running.....
>         */
>         bp =3D (uint *)&cpmp->cp_brgc1;
>=20
>         printk("cpm_setbrg: BRG_UART_CLK_DIV16  %lu",brgUrtClkDiv16);
>         printk("cpm_setbrg:  *bp came as %u",*bp);
>         printk("cpm_setbrg: rate came as  %u",rate);
>         bp +=3D brg;
>=20
>         printk("cpm_setbrg:  *bp is now %u",*bp);
>         /* The BRG has a 12-bit counter.  For really slow baud rates =
(or
>          * really fast processors), we may have to further divide by =
16.
>          */
>         if (((BRG_UART_CLK / rate) - 1) < 4096)
>                 *bp =3D (((BRG_UART_CLK / rate) - 1) << 1) | =
CPM_BRG_EN;
>         else
>                 *bp =3D (((BRG_UART_CLK_DIV16 / rate) - 1) << 1) |
>                                                 CPM_BRG_EN |
> CPM_BRG_DIV16;
>=20
>=20
>        printk("cpm_setbrg:  *bp is set to %u",*bp);
>=20
> }
>=20
> ****************************
> Now the output in the log buffer from both cpm_uart_set_termios() and
> cpm_setbrg() ) :
> *********************************************
>=20
> < 7>CPM uart[0]:set_termios.
> <7>CPM uart baud =3D115200.
> <7>CPM uart bits=3D8.
> .<7>CPM uart cval=3D0.
> .<7>CPM uart bits=3D9.
> .<4>cpm_setbrg: BRG_UART_CLK_DIV16  195312
>  cpm_setbrg: *bp came as 65588
> cpm_setbrg: rate came as  115200
> cpm_setbrg:  *bp is now 65588
> cpm_setbrg:  *bp is set to 65588
> <7>returned from cpm_set_brg
> <7>after spin_unlock_irqrestore
>=20
