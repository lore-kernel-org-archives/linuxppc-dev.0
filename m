Message-ID: <38A93FBC.7D983C3E@mpifr-bonn.mpg.de>
Date: Tue, 15 Feb 2000 12:59:56 +0100
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
CC: paulus@linuxcare.com
Subject: Missing declaration in 2.2.14-pmac sources?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I tried to compile the ieee1394 stuff I found at
http://eclipt.uni-klu.ac.at/ieee1394/ and had problems with Paul's
linux-pmac-stable sources as the symbol __ashldi3 could not be resolved.  I
_think_ the following patch to arch/ppc/kernel/ppc_ksyms.c will solve this
problem.  Is this correct?

Thanks, Albrecht.

---snip here-------------------------------------------------------------------
--- ppc_ksyms.c.orig    Tue Feb 15 10:43:40 2000
+++ ppc_ksyms.c Tue Feb 15 10:45:22 2000
@@ -47,6 +47,7 @@
 extern int do_signal(sigset_t *, struct pt_regs *);

 asmlinkage long long __ashrdi3(long long, int);
+asmlinkage long long __ashldi3(long long, int);
 asmlinkage long long __lshrdi3(long long, int);
 asmlinkage int abs(int);

@@ -218,6 +219,7 @@
 EXPORT_SYMBOL(abs);

 EXPORT_SYMBOL_NOVERS(__ashrdi3);
+EXPORT_SYMBOL_NOVERS(__ashldi3);
 EXPORT_SYMBOL_NOVERS(__lshrdi3);
 EXPORT_SYMBOL_NOVERS(memcpy);
 EXPORT_SYMBOL_NOVERS(memset);
---end patch-------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
