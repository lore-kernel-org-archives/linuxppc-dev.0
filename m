Date: Wed, 14 May 2003 23:42:14 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] educate users about x86 specific kludges instead of hiding thier ignorance
Message-ID: <20030515074214.GA787@plato.local.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="kORqDWCi7qDJ0mEj"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

the phony bzImage target in the ppc Makefiles is not helping anything,
rather it just changes the confusion from `why doesn't make bzImage
work?' to `where is my bzImage?'

lets not hide users ignorance lets teach them instead.  the attached
patch replaces the phony bzImage target with a error explaining that
bzImage is x86 only and to use zImage instead.

please apply.

--
Ethan Benson
http://www.alaska.net/~erbenson/

--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Makefile.diff"

--- linux/arch/ppc/Makefile.orig	Wed May 14 23:33:00 2003
+++ linux/arch/ppc/Makefile	Wed May 14 23:35:24 2003
@@ -98,7 +98,8 @@
 BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd

 # All the instructions talk about "make bzImage".
-bzImage: zImage
+bzImage:
+	$(error bzImage is an x86 specific hack to work around broken design.  Try make zImage)

 $(BOOT_TARGETS): $(CHECKS) vmlinux
 	@$(MAKEBOOT) $@

--kORqDWCi7qDJ0mEj--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
