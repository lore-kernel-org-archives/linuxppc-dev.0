Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6E2C8B7BAF
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Oct 2009 15:06:54 +1100 (EST)
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <alpine.LFD.2.01.0910290911550.31845@localhost.localdomain>
References: <1256627452.11607.90.camel@pasglop>
	<alpine.LFD.2.01.0910290911550.31845@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 30 Oct 2009 15:06:38 +1100
Message-ID: <1256875598.6372.62.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-10-29 at 09:14 -0700, Linus Torvalds wrote:
> 
> On Tue, 27 Oct 2009, Benjamin Herrenschmidt wrote:
> > 
> > Kumar Gala (7):
> >       powerpc: Add a Book-3E 64-bit defconfig
> >       powerpc: Fix compile errors found by new ppc64e_defconfig
> >       powerpc: Limit hugetlbfs support to PPC64 Book-3S machines
> 
> This is incredibly ugly. Why should the generic fs/Kconfig know about some 
> random odd architecture detail like PPC_BOOK3S_64?
> 
> I merged it, and noticed this because Super-H caused clashes by cleaning 
> up. I would suggest PowerPC do the same.
> 
> This patch is not signed-off, nor do I want any credit. But if it works on 
> ppc, please send me something like this back.

Pushed this to my merge branch:

(BTW. Where does this SYS_* form comes from ? We had ARCH_ now we have
SYS_ * ? Oic... it's a mips thing... oh well no big deal)

>From 5a1eb5c4453207ad9e7f6e8ca4f8db289743c993 Mon Sep 17 00:00:00 2001
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 30 Oct 2009 15:03:54 +1100
Subject: [PATCH] powerpc: Cleanup Kconfig selection of hugetlbfs support

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/Kconfig |    4 ++++
 fs/Kconfig           |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 10a0a54..2ba14e7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -414,6 +414,10 @@ config ARCH_SPARSEMEM_DEFAULT
 config ARCH_POPULATES_NODE_MAP
 	def_bool y
 
+config SYS_SUPPORTS_HUGETLBFS
+       def_bool y
+       depends on PPC_BOOK3S_64
+
 source "mm/Kconfig"
 
 config ARCH_MEMORY_PROBE
diff --git a/fs/Kconfig b/fs/Kconfig
index 2126078..64d44ef 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -135,7 +135,7 @@ config TMPFS_POSIX_ACL
 
 config HUGETLBFS
 	bool "HugeTLB file system support"
-	depends on X86 || IA64 || PPC_BOOK3S_64 || SPARC64 || (S390 && 64BIT) || \
+	depends on X86 || IA64 || SPARC64 || (S390 && 64BIT) || \
 		   SYS_SUPPORTS_HUGETLBFS || BROKEN
 	help
 	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
-- 
1.6.1.2.14.gf26b5
