Return-Path: <Schramel.Linux@go.bartec.de>
Received: from mail.bartec.de (mail.bartec.de [217.5.168.170])
	by ozlabs.org (Postfix) with SMTP id 2DE7567B6D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 16:58:18 +1000 (EST)
From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: "PPC_LINUX" <linuxppc-embedded@ozlabs.org>
Date: Thu, 14 Apr 2005 09:26:01 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200504140926.01775.Schramel.Linux@go.bartec.de>
Subject: CPM uart
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

on my target (MPC8270, 2.4.25) SCC1, SCC2 and SCC3 will work fine as ttyS0 .. ttyS2 with console at ttyS0.

It works with this code in arch/ppc/8260_io/uart.c
#define CONFIG_SERIAL_CONSOLE_PORT	0

#define SCC_NUM_BASE	0	/* SCC base tty "number" */
#define SCC_IDX_BASE	        0  	/* table index */
static struct serial_state rs_table[] = {
	/* UART CLK   PORT          IRQ      FLAGS  NUM   */
	{ 0,     0, PROFF_SCC1, SIU_INT_SCC1,   0, SCC_NUM_BASE},          /* SCC1 ttyS0 */
	{ 0,     0, PROFF_SCC2, SIU_INT_SCC2,   0, SCC_NUM_BASE + 1},    /* SCC2 ttyS1 */
	{ 0,     0, PROFF_SCC3, SIU_INT_SCC3,   0, SCC_NUM_BASE +2},     /* SCC3 ttyS2 */


Now i need the two SMC's.
I changed the source to:
#define CONFIG_SERIAL_CONSOLE_PORT	2
#define SCC_NUM_BASE	2	/* SCC base tty "number" */
#define SCC_IDX_BASE  	2	/* table index */
static struct serial_state rs_table[] = {
	/* UART CLK   PORT          IRQ      FLAGS  NUM   */
	{ 0,     0, PROFF_SMC1, SIU_INT_SMC1,   0, 0},    /* SMC1 ttyS0 */
	{ 0,     0, PROFF_SMC2, SIU_INT_SMC2,   0, 1},    /* SMC2 ttyS1 */	
	{ 0,     0, PROFF_SCC1, SIU_INT_SCC1,   0, SCC_NUM_BASE},    /* SCC1 ttyS2 */
	{ 0,     0, PROFF_SCC2, SIU_INT_SCC2,   0, SCC_NUM_BASE + 1},    /* SCC2 ttyS3 */
	{ 0,     0, PROFF_SCC3, SIU_INT_SCC3,   0, SCC_NUM_BASE + 2},    /* SCC3 ttyS4 */
and passed the bootloader the correct console=ttyS2.

During booting kernel hangs on initializing ttyS2 forever.

What could be wrong ? I only changed the io port configuration in the init function.

Thanks in advance
Marco





---------
Marco Schramel
