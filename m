Mime-Version: 1.0
Message-Id: <a05101509b8c7dd36e820@[10.8.16.89]>
Date: Wed, 27 Mar 2002 14:51:11 -0600
To: linuxppc-embedded@lists.linuxppc.org
From: Greg Allen <gallen@arlut.utexas.edu>
Subject: serial.c patch for MPC8245 DUART
Cc: tytso@mit.edu
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The Motorola MPC8245 embedded PowerPC has an internal DUART, which
claims to be PC16550D compatible.

However, it has an additional EFR (Enhanced Feature Register) at
offset 0x2, like the Startech UARTS. The MPC8245 calls it the UART
Alternate Function Register (UAFR).

The serial.c driver in the current linuxppc_2_4_devel tree
incorrectly identifies the MPC8245 UART as an ST16650. This disallows
the use of the fifos.

This very small patch to serial.c causes the MPC8245 UART to be
identified as a 16550A.


===== drivers/char/serial.c 1.30 vs edited =====
*** /tmp/serial.c-1.30-23169    Mon Mar 11 23:07:32 2002
--- edited/drivers/char/serial.c        Wed Mar 27 14:27:20 2002
***************
*** 3738,3744 ****
                 /* Check for Startech UART's */
                 serial_outp(info, UART_LCR, UART_LCR_DLAB);
                 if (serial_in(info, UART_EFR) == 0) {
!                       state->type = PORT_16650;
                 } else {
                         serial_outp(info, UART_LCR, 0xBF);
                         if (serial_in(info, UART_EFR) == 0)
--- 3738,3749 ----
                 /* Check for Startech UART's */
                 serial_outp(info, UART_LCR, UART_LCR_DLAB);
                 if (serial_in(info, UART_EFR) == 0) {
!                       /* the MPC8245 has a 16550D with a EFR/UAFR
that is zero */
!                       /* a fifo size of 16 is *not* a ST16650 (it's 32) */
!                       int size = size_fifo(info);
!                       if (size != 16) {
!                               state->type = PORT_16650;
!                       }
                 } else {
                         serial_outp(info, UART_LCR, 0xBF);
                         if (serial_in(info, UART_EFR) == 0)

--
  Gregory E. Allen, MSEE Engineering Scientist
  Applied Research Laboratories:
  The University of Texas at Austin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
