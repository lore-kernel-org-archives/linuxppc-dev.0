Return-Path: <roland@redhat.com>
Received: from QMTA04.emeryville.ca.mail.comcast.net
	(qmta04.emeryville.ca.mail.comcast.net [76.96.30.40])
	by ozlabs.org (Postfix) with ESMTP id 7820BDDE9B
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 08:09:07 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH -mm] compat_binfmt_elf Kconfig
In-Reply-To: Sam Ravnborg's message of  Wednesday,
	2 January 2008 20:10:30 +0100
	<20080102191030.GA11217@uranus.ravnborg.org>
References: <20071223183920.GA13976@elte.hu>
	<20071223211603.3FFB126F8E7@magilla.localdomain>
	<20071230163614.GB1384@elte.hu>
	<20080102044157.A5CC526F99F@magilla.localdomain>
	<20080102111431.GD14731@elte.hu>
	<20080102191030.GA11217@uranus.ravnborg.org>
Message-Id: <20080102210831.9F80426F9A0@magilla.localdomain>
Date: Wed,  2 Jan 2008 13:08:31 -0800 (PST)
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch should go in immediately after:

	commit 5e45efc63e33ee2bae9ff4d500b53d3bf86d2b48
	Author: Roland McGrath <roland@redhat.com>

	    compat_binfmt_elf

Thanks,
Roland

---
[PATCH] compat_binfmt_elf Kconfig

This adds Kconfig and Makefile bits to build fs/compat_binfmt_elf.c,
just added.  Each arch that wants to use this file needs to add a
"select COMPAT_BINFMT_ELF" line in its Kconfig bits that enable COMPAT.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 fs/Kconfig.binfmt |    4 ++++
 fs/Makefile       |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index d4fc609..0000000 100644  
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -23,6 +23,10 @@ config BINFMT_ELF
 	  ld.so (check the file <file:Documentation/Changes> for location and
 	  latest version).
 
+config COMPAT_BINFMT_ELF
+	bool
+	depends on COMPAT && MMU
+
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y
diff --git a/fs/Makefile b/fs/Makefile
index 500cf15..0000000 100644  
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_BINFMT_MISC)	+= binfmt_misc
 obj-y				+= binfmt_script.o
 
 obj-$(CONFIG_BINFMT_ELF)	+= binfmt_elf.o
+obj-$(CONFIG_COMPAT_BINFMT_ELF)	+= compat_binfmt_elf.o
 obj-$(CONFIG_BINFMT_ELF_FDPIC)	+= binfmt_elf_fdpic.o
 obj-$(CONFIG_BINFMT_SOM)	+= binfmt_som.o
 obj-$(CONFIG_BINFMT_FLAT)	+= binfmt_flat.o
