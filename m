Return-Path: <bgat@billgatliff.com>
Received: from venus.billgatliff.com (venus.billgatliff.com [209.251.101.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4EA02DE132
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jul 2007 02:02:13 +1000 (EST)
Message-ID: <469B922D.3050701@billgatliff.com>
Date: Mon, 16 Jul 2007 10:43:41 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: gdb@sourceware.org,  linuxppc-embedded@ozlabs.org
Subject: Gdbserver syscall clobber
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Guys:


I'm trying to track down a problem where gdbserver is issuing a bogus 
syscall at the onset of a debugging session.  I'm using gdb-6.6, on an 
(ancient, I know) linux-2.4.16 kernel, pc603e machine.  Gcc-3.4.5, 
glibc-2.2.5 (both built with crosstools-0.43).  Gdbserver is statically 
linked.

When I run gdbserver under strace on the target, I see these in the log 
shortly after initiating the connection from my workstation:

...
ptrace(PTRACE_PEEKTEXT, 947, 0x10405394, [0x103e0cb0]) = 0
ptrace(PTRACE_PEEKTEXT, 947, 0x10405398, [0x103e0ce4]) = 0
ptrace(PTRACE_PEEKTEXT, 947, 0x1040539c, [0x103e0ce8]) = 0
send(4, "$103df2cc103df2e8103df2ec103df2f"..., 644, 0) = 644
recv(4, 0x7ffffd60, 1, 0)               = ? ERESTARTSYS (To be restarted)
--- SIGIO (I/O possible) @ 0 (0) ---
syscall_4294966784(0xa, 0x7ffffd34, 0x1, 0, 0x1008a3c7, 0x1008b5a3, 
0x1008b5a4, 0, 0x1, 0x80808080, 0x1008e778, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
0, 0, 0, 0x10080000, 0x10080000, 0x10080000, 0x1008b5a3, 0x10080000, 
0x1008b320, 0x100291a4, 0xd032, 0xa) = -1 (errno 38)
write(2, "putpkt(read): Function not imple"..., 39) = 39
...


Note the bogus syscall argument 4294966784.  It isn't *completely* 
bogus, interestingly, since if you google for that you come up with a 
few hits.  But no resolutions.

I'm stumped.  Does this problem sound familiar to anyone?  Had the same 
problem with gcc-2.95.3.


Kindest regards,


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
