Message-Id: <200002051456.JAA34961@borg.cmf.nrl.navy.mil>
cc: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: anyone build 2.3.42 for ppc?
In-reply-to: Your message of "Sat, 05 Feb 2000 08:37:37 EST."
             <200002051337.IAA03125@fermi.cmf.nrl.navy.mil>
Date: Sat, 05 Feb 2000 09:56:17 -0500
From: Chas Williams <chas@cmf.nrl.navy.mil>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>In message <Pine.LNX.3.96.1000204232520.15802L-100000@mandrakesoft.mandrakesoft.com>,Jeff Garzik writes:
>This patch is wrong.  I fixed nvram to use initcalls.
>If nvram doesn't load you have other problems.

ok, i see the problem, with __initcall, which is missing in
drivers/macintosh/nvram.c, so this patch is more correct, however it still
doesnt work after making this change.  i believe the reason is ld related,
when vmlinux is linked, __initcall_nvram_init resides in macintosh.a along
with another initcall function, __initcall_adb_init.  after linking
vmlinux only contains __initcall_adb_init:

% nm drivers/macintosh/macintosh.a | egrep initcall
00000000 ? __initcall_adb_init
00000000 ? __initcall_nvram_init

% nm vmlinux | egrep initcall
c0259068 ? __initcall_adb_init
c0259060 ? __initcall_adb_mouse_init
c0259044 ? __initcall_bdflush_init
c0259070 A __initcall_end
c025905c ? __initcall_ide_cdrom_init
c0259058 ? __initcall_init_autofs_fs
c025904c ? __initcall_init_elf_binfmt
c0259054 ? __initcall_init_ext2_fs
c0259048 ? __initcall_init_script_binfmt
c0259040 ? __initcall_kswapd_init
c0259050 ? __initcall_partition_setup
c0259064 ? __initcall_pci_proc_init
c0259040 A __initcall_start
c023166c t do_initcalls

i changed the makefile to list drivers/macintosh/nvram.o during the link
stage (after macintosh.a but that probbaly doesnt matter), and
__initcall_nvram_init found its way into the executable.

this leads me to believe that ld cannot merge the muliple initcall's
from a library.  my ld version is 2.9.4 so i dont think its a tool
'problem'.  the right way to fix this would be to list the various
bits of macintosh.a seperately during link?

here is the patch to add initcall it macintosh/nvram.c:

--- drivers/macintosh/nvram.c.000       Sat Feb  5 08:43:10 2000
+++ drivers/macintosh/nvram.c   Sat Feb  5 09:12:39 2000
@@ -102,14 +102,17 @@
        &nvram_fops
 };

-int nvram_init(void)
+int __init nvram_init(void)
 {
        printk(KERN_INFO "Macintosh non-volatile memory driver v%s\n",
                NVRAM_VERSION);
        misc_register(&nvram_dev);
        return 0;
 }
-#ifdef MODULE
+
+#ifndef MODULE
+__initcall(nvram_init);
+#else
 int init_module (void)
 {
         return( nvram_init() );

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
