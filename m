Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3CB3268734
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Nov 2005 04:29:08 +1100 (EST)
Date: Sat, 19 Nov 2005 18:29:00 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051119172900.GA11829@suse.de>
References: <17277.28534.614112.962810@cargo.ozlabs.ibm.com>
	<20051118075158.GB14865@suse.de> <20051118221309.GA12724@suse.de>
	<17278.40894.898159.724090@cargo.ozlabs.ibm.com>
	<20051119102952.GA32273@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20051119102952.GA32273@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] generate COFF zImage in arch/powerpc/boot
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sat, Nov 19, Olaf Hering wrote:

> This patch on top of yours fixes it for me.

Another Makefile fix to actually include the kernel in the zImage.coff.

With this my 7200 almost works. There is one thing that I cant explain
right now. alloc_up calls prom_claim at some point, and it stores the
result in alloc_bottom. r30 holds the address where the code is running.
But this reg is 0 after returning from prom_claim. My debug patch below
adds checks for the value of r30, there is no way it can return with r30
being 0, according to the objdump output. But still it does. 
If I enable DEBUG_PROM, and add a 2 or 3 prom_debug calls, everything
works. Any idea what that means?

 arch/powerpc/boot/Makefile      |    2 ++
 arch/powerpc/boot/main.c        |    9 +++------
 arch/powerpc/kernel/prom_init.c |   21 +++++++++++++++++++++
 3 files changed, 26 insertions(+), 6 deletions(-)

Index: linux-2.6.15-rc1-olh/arch/powerpc/boot/Makefile
===================================================================
--- linux-2.6.15-rc1-olh.orig/arch/powerpc/boot/Makefile
+++ linux-2.6.15-rc1-olh/arch/powerpc/boot/Makefile
@@ -140,10 +140,12 @@ $(obj)/zImage.initrd.vmode: obj-boot += 
 $(obj)/zImage.initrd.vmode: $(call obj-sec, $(required) $(initrd)) $(obj-boot) $(srctree)/$(src)/zImage.lds
 	$(call cmd,bootld,$(obj-boot),zImage.lds)
 
+$(obj)/zImage.coff: obj-boot += $(call obj-sec, $(required))
 $(obj)/zImage: $(obj)/zImage.vmode $(obj)/zImage.coff $(obj)/addnote
 	@cp -f $< $@
 	$(call if_changed,addnote)
 
+$(obj)/zImage.initrd.coff: obj-boot += $(call obj-sec, $(required) $(initrd))
 $(obj)/zImage.initrd: $(obj)/zImage.initrd.vmode $(obj)/zImage.initrd.coff $(obj)/addnote
 	@cp -f $< $@
 	$(call if_changed,addnote)
Index: linux-2.6.15-rc1-olh/arch/powerpc/boot/main.c
===================================================================
--- linux-2.6.15-rc1-olh.orig/arch/powerpc/boot/main.c
+++ linux-2.6.15-rc1-olh/arch/powerpc/boot/main.c
@@ -299,15 +299,12 @@ void start(unsigned long a1, unsigned lo
 	flush_cache((void *)vmlinux.addr, vmlinux.size);
 
 	kernel_entry = (kernel_entry_t)vmlinux.addr;
-#ifdef DEBUG
+#if 1
 	printf( "kernel:\n\r"
 		"        entry addr = 0x%lx\n\r"
 		"        a1         = 0x%lx,\n\r"
-		"        a2         = 0x%lx,\n\r"
-		"        prom       = 0x%lx,\n\r"
-		"        bi_recs    = 0x%lx,\n\r",
-		(unsigned long)kernel_entry, a1, a2,
-		(unsigned long)prom, NULL);
+		"        a2         = 0x%lx,\n\r",
+		(unsigned long)kernel_entry, a1, a2);
 #endif
 
 	kernel_entry(a1, a2, prom, NULL);
Index: linux-2.6.15-rc1-olh/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-2.6.15-rc1-olh.orig/arch/powerpc/kernel/prom_init.c
+++ linux-2.6.15-rc1-olh/arch/powerpc/kernel/prom_init.c
@@ -144,6 +144,7 @@ struct mem_map_entry {
 typedef u32 cell_t;
 
 extern void __start(unsigned long r3, unsigned long r4, unsigned long r5);
+static inline unsigned long __init olh_reg30(void) { unsigned long reg; __asm__ __volatile__("mr %0,30\n" : "=r" (reg)); return reg; }
 
 #ifdef CONFIG_PPC64
 extern int enter_prom(struct prom_args *args, unsigned long entry);
@@ -242,9 +243,13 @@ static int __init call_prom(const char *
 	for (i = 0; i < nret; i++)
 		args.args[nargs+i] = 0;
 
+	if (!olh_reg30())
+		asm(".long 0x0\n");
 	if (enter_prom(&args, RELOC(prom_entry)) < 0)
 		return PROM_ERROR;
 
+	if (!olh_reg30())
+		asm(".long 0x0\n");
 	return (nret > 0) ? args.args[nargs] : 0;
 }
 
@@ -255,6 +260,8 @@ static int __init call_prom_ret(const ch
 	struct prom_args args;
 	va_list list;
 
+	if (!olh_reg30())
+		asm(".long 0x0\n");
 	args.service = ADDR(service);
 	args.nargs = nargs;
 	args.nret = nret;
@@ -274,6 +281,8 @@ static int __init call_prom_ret(const ch
 		for (i = 1; i < nret; ++i)
 			rets[i-1] = args.args[nargs+i];
 
+	if (!olh_reg30())
+		asm(".long 0x0\n");
 	return (nret > 0) ? args.args[nargs] : 0;
 }
 
@@ -364,6 +373,8 @@ static unsigned int __init prom_claim(un
 {
 	struct prom_t *_prom = &RELOC(prom);
 
+	if (!olh_reg30())
+		asm(".long 0x0\n");
 	if (align == 0 && (OF_WORKAROUNDS & OF_WA_CLAIM)) {
 		/*
 		 * Old OF requires we claim physical and virtual separately
@@ -375,21 +386,29 @@ static unsigned int __init prom_claim(un
 		ret = call_prom_ret("call-method", 5, 2, &result,
 				    ADDR("claim"), _prom->memory,
 				    align, size, virt);
+	if (!olh_reg30())
+		asm(".long 0x0\n");
 		if (ret != 0 || result == -1)
 			return -1;
 		ret = call_prom_ret("call-method", 5, 2, &result,
 				    ADDR("claim"), _prom->mmumap,
 				    align, size, virt);
+	if (!olh_reg30())
+		asm(".long 0x0\n");
 		if (ret != 0) {
 			call_prom("call-method", 4, 1, ADDR("release"),
 				  _prom->memory, size, virt);
+		asm(".long 0x0\n");
 			return -1;
 		}
 		/* the 0x12 is M (coherence) + PP == read/write */
 		call_prom("call-method", 6, 1,
 			  ADDR("map"), _prom->mmumap, 0x12, size, virt, virt);
+		if (!olh_reg30())
+			asm(".long 0x0\n");
 		return virt;
 	}
+		asm(".long 0x0\n");
 	return call_prom("claim", 3, 1, (prom_arg_t)virt, (prom_arg_t)size,
 			 (prom_arg_t)align);
 }
@@ -752,6 +771,8 @@ static unsigned long __init alloc_up(uns
 	    base = _ALIGN_UP(base + 0x100000, align)) {
 		prom_debug("    trying: 0x%x\n\r", base);
 		addr = (unsigned long)prom_claim(base, size, 0);
+	if (!olh_reg30())
+		asm(".long 0x0\n");
 		if (addr != PROM_ERROR && addr != 0)
 			break;
 		addr = 0;

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
