Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@vanet.com.br>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Kernel oops while routing
Date: Mon, 26 Nov 2001 19:54:19 +0300
MIME-Version: 1.0
Message-Id: <01112619541903.01018@scop.digitel.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm doing some performance tests with a proprietary Linuxppc-based box
configured as a routing system. The processor is  MPC8255 @ 133 MHz (33Mhz on
the bus) and Linux revision is 2.4.15pre8 rsync'ed from MVista linuxppc_2_4
repository.

We are using two other Linux workstations to exercise the router, both
running Netpipe 2.4, one as a client application, the other as a server. Each
one is connected to a different fast ethernet port of our router  box
(100MHz, full-duplex mode) using cross cables.

We're achieving throughputs around 40 Mbps with this setup, which is enough
for our purposes.

But, when we try a 30 MBytes' block in Netpipe,  the kernel in our Linux box
crashes big time (trace bellow, including ksymoops decode). We also tryed
Linux 2.4.4 version, but then the performance slows down to around 13 Mbps.

My questions are:

Has anyone observed this kind of crash?
Is there any workaround?

Any pointers or suggestions will be greatly appreciated.

Regards,

~Ricardo
R SCOP Consulting.

Crash trace:
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

Oops: kernel access of bad area, sig: 11
NIP: C00A9E78 XER: 00000000 LR: C00A9E54 SP: C1FADC00 REGS: c1fadb50 TRAP:
0300
   MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
   TASK = c1fac000[3] 'ksoftirqd_CPU0' Last syscall: -1
   last math c1f30000 last altivec 00000000
   GPR00: 00000000 C1FADC00 C1FAC000 00000001 00009032 C1FADCE0 00000004
0000001F
   GPR08: C0154680 00000025 40601801 08000000 C1FADD98 1001F5F0 01FDF000
00000000
   GPR16: 00000001 007FFF00 FFFFFFFF 01FD816C 00001032 01FADCD0 00000000
C0003F80
   GPR24: C0004F90 00000400 C1FA5200 C0180000 000005FA 00000020 C0178E20
C0FC9594
   Call backtrace:
   00000000 C00A558C C00A5234 C0004EEC C0004FD8 C0003F80 C00E9FB4
   C00B5B14 C00B5F74 C00BCA94 C00AED38 C0016548 C0005034 C0003F80
   C0016548 C0016C20 C0006464
Warning (Oops_read): Code line not seen, dumping what data is available

>>???; c00a9e78 <alloc_skb+d4/204>   <=====

Trace; 00000000 Before first symbol
Trace; c00a558c <fcc_enet_rx+e4/220>
Trace; c00a5234 <fcc_enet_interrupt+3c/2b0>
Trace; c0004eec <ppc_irq_dispatch_handler+190/234>
Trace; c0004fd8 <do_IRQ+48/bc>
Trace; c0003f80 <ret_from_intercept+0/8>
Trace; c00e9fb4 <ip_conntrack_in+248/318>
Trace; c00b5b14 <nf_iterate+64/e4>
Trace; c00b5f74 <nf_hook_slow+100/1cc>
Trace; c00bca94 <ip_rcv+450/4b0>
Trace; c00aed38 <net_rx_action+2b0/3e0>
Trace; c0016548 <do_softirq+88/100>
Trace; c0005034 <do_IRQ+a4/bc>
Trace; c0003f80 <ret_from_intercept+0/8>
Trace; c0016548 <do_softirq+88/100>
Trace; c0016c20 <ksoftirqd+84/a8>
Trace; c0006464 <kernel_thread+34/40>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
