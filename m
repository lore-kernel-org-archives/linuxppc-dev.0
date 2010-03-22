Return-Path: <anton@ozlabs.org>
Date: Mon, 22 Mar 2010 17:47:59 +1100
From: Anton Blanchard <anton@samba.org>
To: Christoph Hellwig <hch@lst.de>, Ralf Baechle <ralf@linux-mips.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mundt <lethal@linux-sh.org>, Jeff Dike <jdike@addtoit.com>,
	Hirokazu Takata <takata@linux-m32r.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	"Luck, Tony" <tony.luck@intel.com>, James Morris <jmorris@namei.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	David Howells <dhowells@redhat.com>, Kyle McMartin <kyle@mcmartin.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: ppc64 sys_ipc breakage in 2.6.34-rc2
Message-ID: <20100322064759.GE24064@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I chased down a fail on ppc64 on 2.6.34-rc2 where an application that uses
shared memory was getting a SEGV.

Commit baed7fc9b580bd3fb8252ff1d9b36eaf1f86b670 (Add generic sys_ipc wrapper)
changed the second argument from an unsigned long to an int. When we call
shmget the system call wrappers for sys_ipc will sign extend second (ie the
size) which truncates it. It took a while to track down because the call
succeeds and strace shows the untruncated size :)

The patch below changes second from an int to an unsigned long which fixes
shmget on ppc64 (and I assume s390, sparc64 and mips64).

Signed-off-by: Anton Blanchard <anton@samba.org>
--

I assume the function prototypes for the other IPC methods would cause us
to sign or zero extend second where appropriate (avoiding any security
issues). Come to think of it, the syscall wrappers for each method should do
that for us as well.

diff --git a/ipc/syscall.c b/ipc/syscall.c
index 355a3da..1d6f53f 100644
--- a/ipc/syscall.c
+++ b/ipc/syscall.c
@@ -13,7 +13,7 @@
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 
-SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, int, second,
+SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
 		unsigned long, third, void __user *, ptr, long, fifth)
 {
 	int version, ret;
