Message-ID: <391FB289.D27AD998@research.canon.com.au>
Date: Mon, 15 May 2000 18:17:13 +1000
From: Coenraad Jacobsz <cjj@research.canon.com.au>
MIME-Version: 1.0
To: Linux PPC Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: SCC1 Serial on 855T
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

We are using the MPC855T on a dedicated board, using the FEC for 100
Mb/s and need SCC1 as an UART with hardware flow control.

I assume that 'm8xx_tty.c' sets up the console on SMC1 and should not be
altered.  I also want to limit change to uart.c to a minimum.  Since the
855T has only one SCC, I changed this table: (shrunken for clarity)

static struct serial_state rs_table[] = {
 {0, 0, PROFF_SMC1, CPMVEC_SMC1, 0, 0}, // SMC1 ttyS0
 {0, 0, PROFF_SMC2, CPMVEC_SMC2, 0, 1}, // SMC2 ttyS1
 {0, 0, PROFF_SCC2, CPMVEC_SCC2, 0, (NUM_IS_SCC | 1)}, // SCC2 ttyS2
 {0, 0, PROFF_SCC3, CPMVEC_SCC3, 0, (NUM_IS_SCC | 2)}, // SCC3 ttyS3
};

to this:

static struct serial_state rs_table[] = {
 {0, 0, PROFF_SMC1, CPMVEC_SMC1, 0, 0}, // SMC1 ttyS0
 {0, 0, PROFF_SMC2, CPMVEC_SMC2, 0, 1}, // SMC2 ttyS1
 {0, 0, PROFF_SCC1, CPMVEC_SCC1, 0, (NUM_IS_SCC | 0)}, // SCC1 ttyS2
};

added changes to the I/O settings (PAPAR, PADIR, PBPAR.. etc) to use the
dedicated CTS/RTS/CD functions (and GPIO for DSR), setting GSMR_L1 for
UART, div16, SICR1 for BRG3->SCC1, left PSMR1 as is (scp->scc_pmsr =
0x3000;) (8bit),  xx_NUM_FIFO = NR_PORTS (and as is) but the kernel
freezes on booting while initialising serial.

It seems that most of the flow control code inherited from the x86
driver and wrapped in
#ifdef modem_control
may be omitted if the SCC does all of this in microcode. (?)

With limited 8xx and kernel knowledge I've looked through the code and
cannot see other obvious changes to make, so before spending many days
in figuring out what's wrong, is there anybody that has done this
successfully, or know about something obvious missing/wrong?  Interrupt
vectors maybe?

Thanks,
Coenraad

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
