From: "dong in kang" <dkang@east.isi.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: gdb configuration for powerpc target on pentium pc
Date: Fri, 6 Jun 2003 14:02:16 -0400
Message-ID: <000801c32c55$c415ef40$45a97241@Minjoo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3439AB3A99ECD5409F3A52ACF814744D158D23@norcom2.norcom.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 I'm trying to debug Linux kernel on the Sandpoint X3 with MPC755 CPU board.
I'm using BDI 2000 with GDB.
I configured gdb v.5.3 as follows

  configure --prefix=/usr/local/cross-ppc/host/intel/ --target=powerpc-linux


 While I used the gdb with BDI, the breakpoints set by gdb do not work well.
It doesn't stop.
After a while, I typed Ctrl-C to stop it. Then it shows the messages shown
below.
And then it terminates. Could it be GDB configuration problem?
Has anybody got similar problem?

 Thanks in advance.

 Dong-In

-------------------
Program received signal SIGSTOP, Stopped (signal).
0x0000d048 in todc_mc146818_read_val (addr=255)
    at
/opt/hardhat/previewkit/kernel/linux-2.4.17_mvl21/include/asm/io.h:299
299             __asm__ __volatile__("lbz%U1%X1 %0,%1; eieio" : "=r" (ret) :
"m" (*addr));
(gdb) s
Cannot remove breakpoints because program is no longer writable.
It might be running in another process.
Further execution is probably impossible.
todc_mc146818_read_val (addr=32) at todc_time.c:119
119             return inb(todc_info->nvram_data);
--------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
