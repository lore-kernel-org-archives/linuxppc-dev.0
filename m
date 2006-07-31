Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B6373679FC
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Aug 2006 03:46:26 +1000 (EST)
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 45F30FA8C
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Jul 2006 19:46:17 +0200 (CEST)
Date: Mon, 31 Jul 2006 19:46:16 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: booting with BootX corrupts memory
Message-ID: <20060731174616.GA4167@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Booting an old Mac with BootX corrupts memory, the kernel seldom gets
into init. Even the built-in initramfs archive gets corrupted. So far I
havent figured out where the corruption starts. The only data point so
far is that a passed initrd gets overwritten with stuff that looks like
part of the device-tree after the call to free_area_init_node() from
paging_init(). Perhaps the virtual/real address mapping isnt handled
correctly.

This is broken since at least 2.6.15, 2.6.14 dies very early, 2.6.13 was
still ok.

Symptoms differ, depending on used .config and wether an initrd is passed.
This one is without CONFIG_BOOTX_TEXT.

.....
Using PowerMac machine description
Total memory = 72MB; using 256kB for hash table (at c0a80000)
Linux version 2.6.18-rc3 (olaf@g5) (gcc version 4.1.0 (SUSE Linux)) #39 Mon Jul 31 19:06:09 CEST 2006
1f8b0808 d4015944 0203696e 69747264 20313438 323100ec bd0f7c94 c5b92f3e Found initrd at 0xc04e0000:0xc0ac3b46
Found a Grand Central mac-io controller, rev: 2, mapped at 0xfdf00000
PowerMac motherboard: PowerMac 7200/7300
Cache coherency enabled for bandit/PSX
Found Bandit PCI host bridge at 0x00000000f2000000. Firmware bus number: 0->1
1f8b0808 d4015944 0203696e 69747264 20313438 323100ec bd0f7c94 c5b92f3e paging_init(334) exit
00000400 00000001 ffffffff 00000000 00000000 00000000 c04e0018 c04e0018 paging_init(344) exit
Built 1 zonelists.  Total pages: 18432
Kernel command line: ramdisk_size=8192 start_shell nosshkey console=ttyS0,38400 onsole=tty0 video=platinumfb:off minmemory=0 memyasttext=0
irq: Found primary Apple PIC /bandit/gc for 32 irqs
irq: System has 32 possible interrupts
PID hash table entries: 512 (order: 9, 2048 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 56688k/73728k available (2608k kernel code, 16976k reserved, 136k data, 2110k bss, 1472k init)
Mount-cache hash table entries: 512
Unpacking initramfs... done
Freeing initrd memory: 6030k freed
Bad page state in process 'swapper'
page:c04d8f00 flags:0x00000080 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Call Trace:
[C159DF20] [C0007A58] show_stack+0x50/0x184 (unreliable)
[C159DF40] [C0048EDC] bad_page+0x58/0x9c
[C159DF50] [C0049228] free_hot_cold_page+0xa0/0x15c
[C159DF70] [C0011F88] free_initrd_mem+0x70/0xac
[C159DF80] [C011F614] populate_rootfs+0x84/0xa0
[C159DFA0] [C000390C] init+0x2c/0x260
[C159DFF0] [C000F390] kernel_thread+0x44/0x60
Bad page state in process 'swapper'
page:c04d8f20 flags:0x00000080 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Call Trace:
[C159DF20] [C0007A58] show_stack+0x50/0x184 (unreliable)
[C159DF40] [C0048EDC] bad_page+0x58/0x9c
[C159DF50] [C0049228] free_hot_cold_page+0xa0/0x15c
[C159DF70] [C0011F88] free_initrd_mem+0x70/0xac
[C159DF80] [C011F614] populate_rootfs+0x84/0xa0
[C159DFA0] [C000390C] init+0x2c/0x260
[C159DFF0] [C000F390] kernel_thread+0x44/0x60
Bad page state in process 'swapper'
page:c04d8f40 flags:0x00000080 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Call Trace:
[C159DF20] [C0007A58] show_stack+0x50/0x184 (unreliable)
...
