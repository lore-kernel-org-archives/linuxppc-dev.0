Message-ID: <398178CF.6AEAF91E@raleigh.ibm.com>
Date: Fri, 28 Jul 2000 08:13:04 -0400
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: error in assumptions in the handling of interrupts.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I would like explain a bug which I found in the 4xx interrupt controller
code yesterday.
In the ppc4xx_pic.c code their is a routine called

ppcxxx_aic_disable_and_ack.

The purpose of this code is disable interrupts on the level and reset
the ISR.

This will NOT work because for Level interrupts, the ISR will cannot be
reset until
the interrupting source is cleared.

The ack to reset the ISR for interrupt must go in the

ppcxxx_aic_enable

routine which  irq.c  calls after the interrupt routine has been
cleared.



Chip Blach
IBM MicroElectronics
Raleigh, NC.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
