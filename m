Message-ID: <3E076EEF.9070808@embeddededge.com>
Date: Mon, 23 Dec 2002 15:15:43 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Omanakuttan <omanakuttan@tataelxsi.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org,
	kernelnewbies <kernelnewbies@nl.linux.org>
Subject: Re: doubt in arch/ppc/8260_io/uart.c
References: <3E05AC49.7080604@tataelxsi.co.in>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Omanakuttan wrote:

> Hi,
> in kernel 2.4.17, arch/ppc/8260/uart.c contains the following lines in
> rs_8xx_stop()
> {
> ....
> sccp->scc_sccm &= ~UART_SCCM_TX;
> ....
> }

The start/stop functions enable/disable interrupts.  Clearing the TX bit
in the interrupt mask causes that interrupt to be disabled.


> UART_SCCM_TX is defined to 0x00000020
> i.e, only the TX bit is 1
>
> Now the manual (MPC8260UM.pdf) states that clearing a bit is 1 for both
> SCCE and SCCM. Following it, what I understand is the above C statement
> clears all the bits of ccp->scc_sccm except TX bit.

No, the C statement above leaves all bits set (that were set) except
the TX bit.

> Then how does it stop the SCC/SCM?

It doesn't stop the SCC, it only stops the interrupt from being delivered
to the driver.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
