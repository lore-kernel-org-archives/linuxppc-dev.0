Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zzgfY03WQzDrbH
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Mar 2018 23:39:16 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id a20so9511187wmd.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Mar 2018 05:39:16 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>,
 Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH v8 5/6] PCI: Add support for relative addressing in quirk
 tables
Date: Sun, 11 Mar 2018 12:38:14 +0000
Message-Id: <20180311123815.17916-6-ard.biesheuvel@linaro.org>
In-Reply-To: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
References: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allow the PCI quirk tables to be emitted in a way that avoids absolute
references to the hook functions. This reduces the size of the entries,
and, more importantly, makes them invariant under runtime relocation
(e.g., for KASLR)

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/pci/quirks.c | 12 +++++++++---
 include/linux/pci.h  | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8b14bd326d4a..24abfaccd2a0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3563,9 +3563,15 @@ static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
 		     f->vendor == (u16) PCI_ANY_ID) &&
 		    (f->device == dev->device ||
 		     f->device == (u16) PCI_ANY_ID)) {
-			calltime = fixup_debug_start(dev, f->hook);
-			f->hook(dev);
-			fixup_debug_report(dev, calltime, f->hook);
+			void (*hook)(struct pci_dev *dev);
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+			hook = offset_to_ptr(&f->hook_offset);
+#else
+			hook = f->hook;
+#endif
+			calltime = fixup_debug_start(dev, hook);
+			hook(dev);
+			fixup_debug_report(dev, calltime, hook);
 		}
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 024a1beda008..765044bb9e8e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1790,7 +1790,11 @@ struct pci_fixup {
 	u16 device;			/* Or PCI_ANY_ID */
 	u32 class;			/* Or PCI_ANY_ID */
 	unsigned int class_shift;	/* should be 0, 8, 16 */
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+	int hook_offset;
+#else
 	void (*hook)(struct pci_dev *dev);
+#endif
 };
 
 enum pci_fixup_pass {
@@ -1804,12 +1808,28 @@ enum pci_fixup_pass {
 	pci_fixup_suspend_late,	/* pci_device_suspend_late() */
 };
 
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				    class_shift, hook)			\
+	__ADDRESSABLE(hook)						\
+	asm(".section "	#sec ", \"a\"				\n"	\
+	    ".balign	16					\n"	\
+	    ".short "	#vendor ", " #device "			\n"	\
+	    ".long "	#class ", " #class_shift "		\n"	\
+	    ".long "	VMLINUX_SYMBOL_STR(hook) " - .		\n"	\
+	    ".previous						\n");
+#define DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				  class_shift, hook)			\
+	__DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				  class_shift, hook)
+#else
 /* Anonymous variables would be nice... */
 #define DECLARE_PCI_FIXUP_SECTION(section, name, vendor, device, class,	\
 				  class_shift, hook)			\
 	static const struct pci_fixup __PASTE(__pci_fixup_##name,__LINE__) __used	\
 	__attribute__((__section__(#section), aligned((sizeof(void *)))))    \
 		= { vendor, device, class, class_shift, hook };
+#endif
 
 #define DECLARE_PCI_FIXUP_CLASS_EARLY(vendor, device, class,		\
 					 class_shift, hook)		\
-- 
2.15.1
