Message-Id: <20010711014136.Postino-029152@smtp01.highway.ne.jp>
Date: Wed, 11 Jul 2001 01:41:36 +0900
To: Kaoru Fukui <k_fukui@highway.ne.jp>,
	<Jean-Jacques.Levy@inria.fr>, <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: __divdi3 unresolved + X pointer blocks
In-Reply-To: <20010711010133.Postino-018213@smtp01.highway.ne.jp>
References: <20010711010133.Postino-018213@smtp01.highway.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> From: Jean-Jacques Levy <Jean-Jacques.Levy@inria.fr>
> To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Subject: Re: __divdi3 unresolved + X pointer blocks

> 2.4.6-pre6. It didn't boot. Open Firmware answer (called
> by yaboot): DEFAULT CATCH! code = 300 %SRR0 01016cf8 $SRR! 00003030
> I cannot decipher OF msgs.

Hi! Ben and JJ.
I also got same problem at kernel-2.4.7.pre  boot  which kernel be compiled
with gcc-3.0.1cvs,
But I tried kenel compilation continusly with kernel-2.2.19
when it needed the patch.
So I could take bootable kernel-2.2.19 which using gcc-3.0.1cvs.
Please look  my dmesg

I think boot problem which is in the kernel-2.4.x's source.
Please look the problem in kernel-2.4.x.

My using gcc-3.0.1 here is
ftp://ftp.linuxppc.org/users/kfukui/glibc-2.2.x-room/RPMS/

Thanks
Kaoru

 ------ dmesg ----------------
device tree used 41060 bytes
Total memory = 256MB; using 1024kB for hash table (at c0400000)
Linux version 2.2.19-0a (root@g4mpKFUKUI) (gcc version 3.0.1 20010707 (prerelease))
 #1 Wed Jul 11 00:39:55 JST 2001
PMU driver initialized for Core99
xmon uses screen and keyboard
PCI bus 0 controlled by pci at f0000000
PCI buses 0..1 controlled by pci at f2000000
PCI bus 0 controlled by pci at f4000000
Uni-N revision: 8, KeyLargo revision: 3

------- the patch to kernel-2.2.19 --------
diff -urN base/kernel/sched.c fixed/kernel/sched.c
--- base/kernel/sched.c	Tue Jun 26 07:12:15 2001
+++ fixed/kernel/sched.c	Wed Jul 11 00:29:08 2001
@@ -49,7 +49,7 @@
 long tick = (1000000 + HZ/2) / HZ;	/* timer interrupt period */

 /* The current time */
-volatile struct timeval xtime __attribute__ ((aligned (16)));
+struct timeval xtime __attribute__ ((aligned (16)));

 /* Don't completely fail for HZ > 500.  */
 int tickadj = 500/HZ ? : 1;		/* microsecs */


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
