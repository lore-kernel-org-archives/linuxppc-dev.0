Message-ID: <3ED3C82F.30402@cfl.rr.com>
Date: Tue, 27 May 2003 16:18:55 -0400
From: C <sorex@cfl.rr.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC8266ADS missing every other character on the console port; u-boot
 0.3.0, eldk, kernel 2.4.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've checked for a solution to this problem here, the ppcboot-user's mailing
list, and Google but I haven't found my answer yet.

The following link chronicles the same behavior but the answers don't seem to apply.

http://lists.linuxppc.org/linuxppc-embedded/200203/msg00238.html

This thread from the ppcboot-users mailing is relevant as well.
http://www.geocrawler.com/mail/thread.php3?subject=%5BPpcboot-users%5D+Linux+console+messages+garbled&list=4205

The problem is that I'm missing every other character on the console port which
looks like this (captured using Tera Term Pro's log function):

 >> ## Transferring control to Linux (at address 00000000) ...

 >> tlmmr  6B sn 4Bfrhs al a 070)iu eso .. ro@y)(c eso .532001 peees/rno2001) 8
u a 71:12 D 03nnd  oapgs 06oe0:49 ae.oe1:0pgs
 >> zn()  ae.enlcmadln:ro=dvrmr
 >> Wrig eltm lc em tc

I'm using u-boot-0.3.0 which has CONFIG_CONS_ON_SCC defined as opposed to
CONFIG_CONS_ON_SMC.  I presume the 'make MPC8266ADS_config' set that up.

I modified arch/ppc/8260_io/uart.c so that SCC1 corresponds with
CONFIG_SERIAL_CONSOLE_PORT.  However, this did not fix the problem.

my rs_table looks like this:

 >> #define CONFIG_SERIAL_CONSOLE_PORT  0
 >>
 >>    .
 >>    .
 >>    .
 >>
 >> static struct serial_state rs_table[] = {
 >>    { 0, 0, PROFF_SCC1, SIU_INT_SCC1, 0, SCC_NUM_BASE + 0},  /* SCC1 ttyS 2 */
 >>    { 0, 0, PROFF_SCC2, SIU_INT_SCC2, 0, SCC_NUM_BASE + 1},  /* SCC2 ttyS 3 */
 >>    { 0, 0, PROFF_SCC3, SIU_INT_SCC3, 0, SCC_NUM_BASE + 2},  /* SCC3 ttyS 4 */
 >>    { 0, 0, PROFF_SCC4, SIU_INT_SCC4, 0, SCC_NUM_BASE + 3},  /* SCC4 ttyS 5 */

Can anyone shed some light on this issue?

Thank you,
Chris Gembarowski
Semper-Ubi-Sub-Ubi


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
