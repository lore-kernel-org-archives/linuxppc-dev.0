Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 74036687A5
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Nov 2005 07:47:48 +1100 (EST)
Date: Sat, 19 Nov 2005 21:47:42 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051119204742.GA17604@suse.de>
References: <17277.28534.614112.962810@cargo.ozlabs.ibm.com>
	<20051118075158.GB14865@suse.de> <20051118221309.GA12724@suse.de>
	<17278.40894.898159.724090@cargo.ozlabs.ibm.com>
	<20051119102952.GA32273@suse.de> <20051119172900.GA11829@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20051119172900.GA11829@suse.de>
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

>  On Sat, Nov 19, Olaf Hering wrote:
> 
> > This patch on top of yours fixes it for me.
> 
> Another Makefile fix to actually include the kernel in the zImage.coff.

The kernel entry point should be printed unconditional. It helps
debugging the early init when it doesnt run at the link address.

My stack corruption was caused by a bug in call_prom_ret. It uses the
wrong pointer to clear the memory of the return values.

 arch/powerpc/boot/Makefile      |    2 ++
 arch/powerpc/boot/main.c        |   12 ++----------
 arch/powerpc/kernel/prom_init.c |    2 +-
 3 files changed, 5 insertions(+), 11 deletions(-)

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
@@ -299,16 +299,8 @@ void start(unsigned long a1, unsigned lo
 	flush_cache((void *)vmlinux.addr, vmlinux.size);
 
 	kernel_entry = (kernel_entry_t)vmlinux.addr;
-#ifdef DEBUG
-	printf( "kernel:\n\r"
-		"        entry addr = 0x%lx\n\r"
-		"        a1         = 0x%lx,\n\r"
-		"        a2         = 0x%lx,\n\r"
-		"        prom       = 0x%lx,\n\r"
-		"        bi_recs    = 0x%lx,\n\r",
-		(unsigned long)kernel_entry, a1, a2,
-		(unsigned long)prom, NULL);
-#endif
+	printf( "entering kernel at 0x%08x(%x/%x/%08x)\n\r",
+		(unsigned long)kernel_entry, a1, a2, prom);
 
 	kernel_entry(a1, a2, prom, NULL);
 
Index: linux-2.6.15-rc1-olh/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-2.6.15-rc1-olh.orig/arch/powerpc/kernel/prom_init.c
+++ linux-2.6.15-rc1-olh/arch/powerpc/kernel/prom_init.c
@@ -265,7 +265,7 @@ static int __init call_prom_ret(const ch
 	va_end(list);
 
 	for (i = 0; i < nret; i++)
-		rets[nargs+i] = 0;
+		args.args[nargs+i] = 0;
 
 	if (enter_prom(&args, RELOC(prom_entry)) < 0)
 		return PROM_ERROR;

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
