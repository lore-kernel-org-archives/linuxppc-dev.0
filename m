Date: Tue, 4 Apr 2000 13:02:55 -0400 (EDT)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Minor formatting fix
Message-ID: <Pine.LNX.4.21.0004041257140.24038-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

When a non-handled floating point instruction is caught, the error message
doesn't end with a newline. Most printk() calls have newline at the end,
so it should be a good idea to add it here as well.

The patch also fixes formatting of the neighbouring lines. It has been
tested and is known to print well-formatted error messages.

By the way, where can I get up-to-date sources? I don't want to hack old
code.

Regards,
Pavel Roskin

=== cut here ===
--- arch/ppc/kernel/traps.c	2000/01/24 21:27:13	1.2
+++ arch/ppc/kernel/traps.c	2000/04/04 16:50:51
@@ -253,10 +253,10 @@
 #else
 		if ((errcode = Soft_emulate_8xx(regs))) {
 #endif
-printk("Software Emulation %s/%d NIP: %lx *NIP: 0x%x code: %x",
-       current->comm,current->pid,
-       regs->nip, *((uint *)regs->nip), errcode);
-/*print_8xx_pte(current->mm, regs->nip);*/
+	printk("Software Emulation %s/%d NIP: %lx *NIP: 0x%x code: %x\n",
+	       current->comm,current->pid,
+	       regs->nip, *((uint *)regs->nip), errcode);
+	/*print_8xx_pte(current->mm, regs->nip);*/
 			if (errcode == EFAULT)
 				_exception(SIGBUS, regs);
 			else
=== cut here ===


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
