Return-Path: <jdl@jdl.com>
From: Jon Loeliger <linuxppc@jdl.com>
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
In-Reply-To: Your message of "Sat, 17 Sep 2005 10:31:52 CDT."
	<E1EGefQ-00072D-34@jdl.com>
References: <E1EGefQ-00072D-34@jdl.com> 
Date: Sat, 17 Sep 2005 10:38:23 -0500
Message-Id: <E1EGelj-00073E-GF@jdl.com>
Sender: Jon Loeliger <jdl@jdl.com>
Subject: Re: PATCH powerpc: 03/04 Remove section free() and linker script
	bits
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

diff --git a/arch/ppc/kernel/vmlinux.lds.S b/arch/ppc/kernel/vmlinux.lds.S
--- a/arch/ppc/kernel/vmlinux.lds.S
+++ b/arch/ppc/kernel/vmlinux.lds.S
@@ -149,32 +149,6 @@ SECTIONS
 
   . = ALIGN(4096);
   _sextratext = .;
-  __pmac_begin = .;
-  .pmac.text : { *(.pmac.text) }
-  .pmac.data : { *(.pmac.data) }
-  . = ALIGN(4096);
-  __pmac_end = .;
-
-  . = ALIGN(4096);
-  __prep_begin = .;
-  .prep.text : { *(.prep.text) }
-  .prep.data : { *(.prep.data) }
-  . = ALIGN(4096);
-  __prep_end = .;
-
-  . = ALIGN(4096);
-  __chrp_begin = .;
-  .chrp.text : { *(.chrp.text) }
-  .chrp.data : { *(.chrp.data) }
-  . = ALIGN(4096);
-  __chrp_end = .;
-
-  . = ALIGN(4096);
-  __openfirmware_begin = .;
-  .openfirmware.text : { *(.openfirmware.text) }
-  .openfirmware.data : { *(.openfirmware.data) }
-  . = ALIGN(4096);
-  __openfirmware_end = .;
   _eextratext = .;
 
   __bss_start = .;
diff --git a/arch/ppc/mm/init.c b/arch/ppc/mm/init.c
--- a/arch/ppc/mm/init.c
+++ b/arch/ppc/mm/init.c
@@ -74,10 +74,6 @@ unsigned long agp_special_page;
 extern char _end[];
 extern char etext[], _stext[];
 extern char __init_begin, __init_end;
-extern char __prep_begin, __prep_end;
-extern char __chrp_begin, __chrp_end;
-extern char __pmac_begin, __pmac_end;
-extern char __openfirmware_begin, __openfirmware_end;
 
 #ifdef CONFIG_HIGHMEM
 pte_t *kmap_pte;
@@ -167,14 +163,6 @@ void free_initmem(void)
 
 	printk ("Freeing unused kernel memory:");
 	FREESEC(init);
-	if (_machine != _MACH_Pmac)
-		FREESEC(pmac);
-	if (_machine != _MACH_chrp)
-		FREESEC(chrp);
-	if (_machine != _MACH_prep)
-		FREESEC(prep);
-	if (!have_of)
-		FREESEC(openfirmware);
  	printk("\n");
 	ppc_md.progress = NULL;
 #undef FREESEC
