MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16304.10740.446366.410358@cargo.ozlabs.ibm.com>
Date: Tue, 11 Nov 2003 11:14:44 +1100
From: Paul Mackerras <paulus@samba.org>
To: John Whitney <john.whitney@timesys.com>
Cc: "Mailing List: linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Bad code path in DoSyscall
In-Reply-To: <BBD51F48.2329%john.whitney@timesys.com>
References: <BBD51F48.2329%john.whitney@timesys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


John Whitney writes:

> There seems to be a bad code path in the assembly routine DoSyscall()
> (arch/ppc/kernel/entry.S).

You're right, good catch.  The patch below should fix it.

Paul.

diff -urN linux-2.5/arch/ppc/kernel/entry.S pmac-2.5/arch/ppc/kernel/entry.S
--- linux-2.5/arch/ppc/kernel/entry.S	2003-09-27 19:46:43.000000000 +1000
+++ pmac-2.5/arch/ppc/kernel/entry.S	2003-11-11 09:29:34.000000000 +1100
@@ -233,8 +233,8 @@
 	SYNC
 	RFI

-66:	li	r3,ENOSYS
-	b	22b
+66:	li	r3,-ENOSYS
+	b	ret_from_syscall

 	.globl	ret_from_fork
 ret_from_fork:

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
