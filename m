Mime-Version: 1.0
Message-Id: <a05001901b5e90799c6e8@[192.168.240.10]>
Date: Sat, 16 Sep 2000 13:30:45 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Alain RICHARD <alain.richard@equation.fr>
Subject: NFSD module bug on ppc patch
Cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Paul Mackerras <paulus@linuxcare.com.au>
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi

this is a simple patch to a long standing bug : the kernel NFSD
server is unable to load when compiled as a module and fails with the
error :

nfssvc: Function not implemented

This bug is not present on the i386 side.

I have tracked the problem in arch/ppc/kernel/misc.S : there was a
conditional compilation that disables the nfsservctl call in case the
CONFIG_NFSD is not enabled. In the case of a module, it is disabled
(and CONFIG_NFSD_MODULE is enabled). But there is no need for such a
conditional compilation because the sys_nfsservctl is always defined
in all the cases (no NFSD, NFSD in kernel and NFSD as a module).

So the fix is very simple (this is a patch to the current
ppc.samba.org::linux-pmac-stable 2.2.17 kernel, but a similar patch
is necessary for the 2.2.18-benh kernel and 2.4.0-test8 devel kernel).

Paulus, let me know if you forward this fix to alan cox or if I
should to it myself.

Regards,


[root@sol linux-pmac-stable]# diff -u arch/ppc/kernel/misc.S.orig
arch/ppc/kernel/misc.S
--- arch/ppc/kernel/misc.S.orig Sat Sep 16 13:16:44 2000
+++ arch/ppc/kernel/misc.S      Sat Sep 16 13:16:59 2000
@@ -944,11 +944,7 @@
         .long sys_getresuid     /* 165 */
         .long sys_query_module
         .long sys_poll
-#ifdef CONFIG_NFSD
         .long sys_nfsservctl
-#else
-       .long sys_ni_syscall
-#endif
         .long sys_setresgid
         .long sys_getresgid     /* 170 */
         .long sys_prctl
--
-------------------------------------------------------
Alain RICHARD <mailto:alain.richard@equation.fr>
EQUATION SA <http://www.equation.fr/>
Tel : +33 477 79 48 00	 Fax : +33 477 79 48 01
Applications client/serveur, ingénierie réseau et Linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
