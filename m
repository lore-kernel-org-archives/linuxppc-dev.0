Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (unknown [212.105.56.243])
	by ozlabs.org (Postfix) with ESMTP id 6138C686F8
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Nov 2005 22:07:31 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 9 Nov 2005 12:07:27 +0100
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D9393FD6A6@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: <linuxppc-embedded@ozlabs.org>
Subject: Possible improvements  for CPM UART
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Parts of these fixes in 2.4 doesn't seem to be in 2.6.
Maybe these are solved diffrently in 2.6 but I can't tell.
At least cpm_uart_console_write could use this.

http://linux.bkbits.net:8080/linux-2.4/diffs/arch/ppc/8xx_io/uart.c@1.23
?nav=3Dindex.html|src/.|src/arch|src/arch/ppc|src/arch/ppc/8xx_io|hist/ar=
c
h/ppc/8xx_io/uart.c

Another small improvement would to change:
#define RX_NUM_FIFO	4
#define RX_BUF_SIZE	32
#define TX_NUM_FIFO	4
#define TX_BUF_SIZE	32
to
#ifndef RX_NUM_FIFO
 #define RX_NUM_FIFO	4
#endif
#ifndef RX_BUF_SIZE
 #define RX_BUF_SIZE	32
#endif
#ifndef TX_NUM_FIFO
 #define TX_NUM_FIFO	4
#endif
#ifndef TX_BUF_SIZE
 #define TX_BUF_SIZE	32
#endif

This will allow custom changes to these constants

 Jocke
