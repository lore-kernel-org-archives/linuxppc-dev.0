From: "Prabhakar Kalasani" <kalasani@sena.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Software Flow Control Problem in UART.C 
Date: Tue, 20 Jul 2004 21:14:01 +0900
Message-ID: <ACEDKFIMODAHBNCONGOHEEOMCFAA.kalasani@sena.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

When I tried to use Software Flow Control it's not working with uart.c
driver in kernel 2.4.2 , I send Ctrl+S character to stop the flow but the
flow is not get stopped ,
I dig something into driver and find like,

static void rs_8xx_stop(struct tty_struct *tty)
{

static void rs_8xx_start(struct tty_struct *tty)
{

these two modules are handling with the flow stop(Ctrl+S) and start(Ctrl+Q)
,
I think there is a BUG in handling the Event(SCCE) and Mask Registers (SCCM)
somewhere like

	if (info->state->smc_scc_num & NUM_IS_SCC) {
		sccp = &cpmp->cp_scc[idx];
		sccp->scc_sccm &= ~UART_SCCM_TX;

Anybody got this problem and solved please let me know

Thanks in Advance,
KP


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
