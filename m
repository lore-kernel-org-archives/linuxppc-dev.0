Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <607BF0A2B4F3D411A09500508BC225427E8329@mailctx.datum.com>
From: Geoff Wyche <GWyche@DATUM.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: MPC8xx + serial console on SCC 
Date: Fri, 19 Oct 2001 13:08:34 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

> Yes, we've tested this configuration once when we were re-working the
> UART driver for hardware-handshake support, configurable buffer sizes
> etc.
> We tested all 6 channels ( 2 x SMC, 4 x SCC) on a IP860 board.

I think I've found a bug related to SCCs and serial console IO.
Looks like this might have crept in as a result of two transposed lines.
A patch showing the difference is included at the end of this post.

> See the version of the UART driver in the kernel source tree  on  our
> FTP  server; I've sent patches against 2_4_devel to Tom Rini, waiting
> for a decision if these patches will make it into the official source
> tree...

Are you referring to ftp.denx.de or ftp.linuxppc.org?  I went to both and
couldn't find a kernel source tree in either of them.  Can you give me a
specific URL?

--Geoff
gwyche@datum.com


Here's the patch I mentioned (NOTE that it really only transposes two
lines):

*** arch/ppc/8xx_io/uart.c.ORIG Fri Oct 19 14:34:11 2001
--- arch/ppc/8xx_io/uart.c      Fri Oct 19 14:35:53 2001
***************
*** 1129,1142 ****
        idx = PORT_NUM(state->smc_scc_num);
        if (state->smc_scc_num & NUM_IS_SCC) {
                sccp = &cpmp->cp_scc[idx];
!               sccp->scc_gsmrl &= ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
  #ifdef CONFIG_SERIAL_CONSOLE
                /* We can't disable the transmitter if this is the
                 * system console.
                 */
                if ((state - rs_table) != CONFIG_SERIAL_CONSOLE_PORT)
  #endif
!                       sccp->scc_sccm &= ~(UART_SCCM_TX | UART_SCCM_RX);
        }
        else {
                smcp = &cpmp->cp_smc[idx];
--- 1129,1142 ----
        idx = PORT_NUM(state->smc_scc_num);
        if (state->smc_scc_num & NUM_IS_SCC) {
                sccp = &cpmp->cp_scc[idx];
!               sccp->scc_sccm &= ~(UART_SCCM_TX | UART_SCCM_RX);
  #ifdef CONFIG_SERIAL_CONSOLE
                /* We can't disable the transmitter if this is the
                 * system console.
                 */
                if ((state - rs_table) != CONFIG_SERIAL_CONSOLE_PORT)
  #endif
!                   sccp->scc_gsmrl &= ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
        }
        else {
                smcp = &cpmp->cp_smc[idx];


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
