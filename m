Return-Path: <d.dusha@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 44553B70F4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 11:31:53 +1000 (EST)
MIME-Version: 1.0
Date: Fri, 3 Jul 2009 11:23:52 +1000
Message-ID: <c788c1220907021823y384b78c1x2bb9e0fc3268c0e0@mail.gmail.com>
Subject: mpc52xx_uart.c - Port Overruns
From: Damien Dusha <d.dusha@gmail.com>
To: Linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=0016362835a85d65bc046dc30220
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016362835a85d65bc046dc30220
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dear List,

I am writing to ask about some particular behaviour we saw with the MPC5121
PSC UART, using the 2.6.24 Freescle BSP kernel, although examining the code
of the linux-2.6-denx tree (git commit
7cb16ec2590815a67e5fb5c8994ead536613d922), the behavior is almost identical
except for incrementing an overrrun counter.

In particular, yesterday we observed a port overrun (from the overrun flags
being set when looking with the BDI) on one of our PSC Ports.   When it was
observed, we saw that every second byte coming from the serial port was
0x00.

Examining the interrupt routine of the mpc52xx_uart.c:

static inline int
mpc52xx_uart_int_rx_chars(struct uart_port *port)
{
<snip>
        tty_insert_flip_char(tty, ch, flag);
        if (status & MPC52xx_PSC_SR_OE) {
            /*
             * Overrun is special, since it's
             * reported immediately, and doesn't
             * affect the current character
             */
            tty_insert_flip_char(tty, 0, TTY_OVERRUN);
            port->icount.overrun++;
        }
<snip>
}

So, from my deduction, it is inserting a 0x00 for every overrun error that
occurs, however, the overrun flag is never cleared.  Therefore fro every
byte that is received, the overrup flag is still set and therefore we're
observing the 0x00 being inserted for every "real" byte coming into the port


Is there a particular reason why the overrun flag is not cleared? That is,
parity, framing and breaks are acknowledged with:

            /* Clear error condition */
            out_8(&PSC(port)->command, MPC52xx_PSC_RST_ERR_STAT);

But the overrun isn't cleared.   Is there are particular reason why?  Is
userspace meant to detect this condition and reset the port?  Was it
automatically cleared on the 5200 when reading the status, but the 5121 is
exhibiting strange behavior?

Best regards,
Damien Dusha.

--0016362835a85d65bc046dc30220
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear List,<br><br>I am writing to ask about some particular behaviour we sa=
w with the MPC5121 PSC UART, using the 2.6.24 Freescle BSP kernel, although=
 examining the code of the linux-2.6-denx tree (git commit 7cb16ec2590815a6=
7e5fb5c8994ead536613d922), the behavior is almost identical except for incr=
ementing an overrrun counter.<br>
<br>In particular, yesterday we observed a port overrun (from the overrun f=
lags being set when looking with the BDI) on one of our PSC Ports.=A0=A0 Wh=
en it was observed, we saw that every second byte coming from the serial po=
rt was 0x00.<br>
<br>Examining the interrupt routine of the mpc52xx_uart.c:<br><br>static in=
line int<br>mpc52xx_uart_int_rx_chars(struct uart_port *port)<br>{<br>&lt;s=
nip&gt;<br>=A0=A0=A0 =A0=A0=A0 tty_insert_flip_char(tty, ch, flag);<br>=A0=
=A0=A0 =A0=A0=A0 if (status &amp; MPC52xx_PSC_SR_OE) {<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /*<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0* Over=
run is special, since it&#39;s<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0* report=
ed immediately, and doesn&#39;t<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0* affec=
t the current character<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0*/<br>=A0=A0=A0=
 =A0=A0=A0 =A0=A0=A0 tty_insert_flip_char(tty, 0, TTY_OVERRUN);<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 port-&gt;icount.overrun++;<br>=A0=A0=A0 =A0=
=A0=A0 }<br>&lt;snip&gt;<br>}<br><br>So, from my deduction, it is inserting=
 a 0x00 for every overrun error that occurs, however, the overrun flag is n=
ever cleared.=A0 Therefore fro every byte that is received, the overrup fla=
g is still set and therefore we&#39;re observing the 0x00 being inserted fo=
r every &quot;real&quot; byte coming into the port <br>
<br>Is there a particular reason why the overrun flag is not cleared? That =
is, parity, framing and breaks are acknowledged with:<br><br>=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 /* Clear error condition */<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 out_8(&amp;PSC(port)-&gt;command, MPC52xx_PSC_RST_ERR_STAT);<br>
<br>But the overrun isn&#39;t cleared.=A0=A0 Is there are particular reason=
 why?=A0 Is userspace meant to detect this condition and reset the port?=A0=
 Was it automatically cleared on the 5200 when reading the status, but the =
5121 is exhibiting strange behavior?=A0 <br>
<br>Best regards,<br>Damien Dusha.<br><br><br><br><br><br><br><br><br>

--0016362835a85d65bc046dc30220--
