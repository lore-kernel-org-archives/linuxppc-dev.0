From: "Kwansuk Kim" <kskim@neowave.co.kr>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: Using request_8xxirq
Date: Thu, 23 Nov 2000 13:17:04 +0900
Message-ID: <NEBBKFENMLEDKDHMEHPJAEOCCBAA.kskim@neowave.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have redhat's embbed linux kernel 2.2.13.

I ported it on my custom board (which has MPC860 CPU), and for studying the device driver I recompiled the kernel with loadable module.

There were some error, because some unused modules symbols are exported ( e.g., PCI driving symbols). I think I can omit them.

But among the unused symbols there was request_irq.

I searched the request_irq, and I found there was request_8xxirq instead of request_irq. In DRIVERS\CHAR\SERIAL.C file I found this define state.

"#define request_irq request_8xxirq"

and in ARCH\PPC\KERNEL\IRQ.C,

#ifndef CONFIG_8xx
int request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *),
#else
int request_8xxirq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *),
#endif

I wonder whether request_8xxirq can work same as request_irq, and all modules work with request_8xxirq.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
