Message-ID: <819E3E914E0AD11194DE00805F0D100B0138B83C@fbi.infocom.dk>
From: Kim Jørgensen <KIJ@infocom.dk>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: Problems with serial ports
Date: Tue, 25 Apr 2000 09:39:59 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

I got a custom MPC823 board with 3 serial ports (smc1, smc2 and scc2), and a
2.2.13 kernel form mvista.

Linux runs fine on the board using smc1 as console, but I can't receive or
transmit anything on smc2 and scc2.

I am using the program miniterm to setup and test these ports; I have used
this program on my RH i686 machine without any problems.

I have used scc2 as console too, without any problem. But I still can't use
smc1 and smc2. I look like an initialisation problem to me. Can anyone help
with this?


Btw. There is a problem in m8xx_cpm_setbrg in commproc.c. I can't set any
serial port to run any lower than 1200 baud. This is caused by
BRG_UART_CLK/rate (clock divider) getting larger than 4096, which is the
maximum (at least on a mpc823).
I solved the problem like this:

#define BRG_INT_CLK		(((bd_t *)res)->bi_intfreq * 1000000)
#define BRG_UART_CLK		(BRG_INT_CLK/16)
#define BRG_UART_CLK_DIV16	(BRG_UART_CLK/16)

void
m8xx_cpm_setbrg(uint brg, uint rate)
{
	volatile uint	*bp;

	/* This is good enough to get SMCs running.....
	*/
	bp = (uint *)&cpmp->cp_brgc1;
	bp += brg;
	if((BRG_UART_CLK / rate) < 4096)
	    *bp = ((BRG_UART_CLK / rate) << 1) | CPM_BRG_EN;
	else
	    *bp = ((BRG_UART_CLK_DIV16 / rate) << 1) | CPM_BRG_EN |
CPM_BRG_DIV16;
}

Kim Jorgensen


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
