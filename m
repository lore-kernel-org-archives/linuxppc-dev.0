From: k_fukui@highway.ne.jp
Message-Id: <200201132108.GAA26379@mail.highway.ne.jp>
Date: Mon, 14 Jan 2002 06:05:15 +0900 (JST)
Subject: problem prom.c
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi! Ben.

I got a compilation problem from your rsync tree(2.4.18.pre3).

Here is the error message.
I have questioon which is the patch correct?

Kaoru

gcc -D__KERNEL__ -I/usr/src/redhat/BUILD/linux/include -Wall -Wstrict-prototypes -Wno-trigra -fomit-frame-pointer -fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char -msoft-flpe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -DKBUILD_BASENAME=prom  -c -o prom.o
prom.c: In function `prom_hold_cpus':
prom.c:300: `offset' undeclared (first use in this function)
prom.c:300: (Each undeclared identifier is reported only once
prom.c:300: for each function it appears in.)
make[1]: *** [prom.o] Error 1
make[1]: Leaving directory `/usr/src/redhat/BUILD/linux/arch/ppc/kernel'
make: *** [_dir_arch/ppc/kernel] Error 2
error: Bad exit status from /var/tmp/rpm-tmp.55016 (%build)

diff -urN base/arch/ppc/kernel/prom.c fixed/arch/ppc/kernel/prom.c
--- base/arch/ppc/kernel/prom.c	Fri Jan 11 22:40:35 2002
+++ fixed/arch/ppc/kernel/prom.c	Mon Jan 14 05:50:14 2002
@@ -280,6 +280,7 @@
 {
 	extern void __secondary_hold(void);
 	unsigned long i;
+	unsigned long offset = reloc_offset();
 	int cpu;
 	phandle node;
 	char type[16], *path;


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
