To: "Graham Williams" <gwilliams@sbir.com>
Cc: "'saurosalomoni'" <saurosalomoni@bol.com.br>,
	"'linuxppc-embedded'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Lite5200 from RS232 to RS485 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 14 Jun 2004 07:47:33 PDT."
             <005801c4521e$86e0ea40$26c8a8c0@GMAN>
Date: Mon, 14 Jun 2004 17:37:23 +0200
Message-Id: <20040614153728.13AD1C13D3@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <005801c4521e$86e0ea40$26c8a8c0@GMAN> you wrote:
>
> I used tcgetattr and tcsetattr to set the termios settting like baud.  I
> also had to recompile the kernel using make menuconfig and in MPC8xx CPM
> Options-> I selected Use SCCx UART then Use SSC1 UART then selected PC15 for

Ummm... but the MPC8xx CPM options _definitely_ have  zero  influence
on  the  behaviour of the MPC5200 PSC UART driver. This is completely
different hardware.

> RTS on SCC1 UART.  Make sure the second UART device (ttyS1) is in the /dev
> directory and this should enable the RTS to work.  You can only use RTS with

No, it will NOT work. I repeat: the existing driver DOES NOT  SUPPORT
hardware  handshake, so no matter what you do (short of extending the
driver) - it will not work.

> the SCCs and NOT the SMCs.  Maybe the console ttyS0 is an SMC not an SCC at
> least that is the way my eval board was setup. I hope this helps.

Sorry, but it doesn't.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Our missions are peaceful -- not for conquest.  When we do battle, it
is only because we have no choice.
	-- Kirk, "The Squire of Gothos", stardate 2124.5

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
