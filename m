From: sjhill@realitydiluted.com
To: linuxppc-dev@lists.linuxppc.org
Subject: 750/HIGHMEM/INITRD/1GB...
Cc: sjhill@realitydiluted.com
Message-Id: <E1BuCIr-0005bn-00@real.realitydiluted.com>
Date: Mon, 09 Aug 2004 10:43:13 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Greetings.

I am attempting to get HIGHMEM working on a 750Cxe based board that
has 1GB of physical memory. I am able to access 768MB of it just fine
without using HIGHMEM. I am currently using an INITRD and that appears
to be where it crashes when HIGHMEM is enabled. First, I use the
default config values:

   CONFIG_HIGHMEM_START=0xfe000000
   # CONFIG_LOWMEM_SIZE_BOOL is not set
   CONFIG_LOWMEM_SIZE=0x30000000
   # CONFIG_KERNEL_START_BOOL is not set
   CONFIG_KERNEL_START=0xc0000000
   # CONFIG_TASK_SIZE_BOOL is not set
   CONFIG_TASK_SIZE=0x80000000
   # CONFIG_BOOT_LOAD_BOOL is not set
   CONFIG_BOOT_LOAD=0x00800000

The boot messages show things okay:

   Total memory = 1024MB; using 2048kB for hash table (at c0400000)
   Linux version 2.6.7 (sjhill@twinkie) (gcc version 3.4.1)
   On node 0 totalpages: 262144
     DMA zone: 196608 pages, LIFO batch:16
     Normal zone: 0 pages, LIFO batch:1
     HighMem zone: 65536 pages, LIFO batch:16
   Built 1 zonelists
   ...
   Memory: 1032704k available (1520k kernel code, 584k data, 272k init,
   262144k hi)
   ...

The fun starts when we attempt to utilize the INITRD:

checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
kernel BUG in kmap_atomic at include/asm/highmem.h:91!
Oops: Exception in kernel mode, sig: 5 [#1]
NIP: C0034920 LR: C00348EC SP: EFFADD90 REGS: effadce0 TRAP: 0700    Not taintedMSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = effaf900[1] 'swapper' THREAD: effac000Last syscall: 120
GPR00: FE4035A9 EFFADD90 EFFAF900 00000004 000003DF FFFFFFFF 00000000 0000000D
GPR08: C0220000 00000001 00000000 FE4035A8 EFFE3F54 03DEC206 00000000 EFFBDA08
GPR16: C0220000 EFFADDF8 00001000 EFFD07E0 00000000 EFFADE04 EFFBD9E0 00000001
GPR24: C0904000 00001000 00000000 00000000 EFFD087C C12F7FE0 C12F7FE0 00000000
NIP [c0034920] generic_file_aio_write_nolock+0x75c/0xd54
LR [c00348ec] generic_file_aio_write_nolock+0x728/0xd54
Call trace:
 [c0035044] generic_file_write_nolock+0x4c/0x94
 [c00351d0] generic_file_write+0x5c/0xe8
 [c00540e8] vfs_write+0x114/0x13c
 [c00541bc] sys_write+0x3c/0x70
 [c01e1cd0] populate_rootfs+0xc4/0x10c
 [c0003994] init+0x28/0x22c
 [c00092c8] kernel_thread+0x44/0x60

The 'kmap_atomic' call that is failing is inside of the inlined function:

   mm/filemap.c(1605):filemap_copy_from_user

Are there some known issues with using INITRD and HIGHMEM together that
I should be aware of? Thanks.

-Steve

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
