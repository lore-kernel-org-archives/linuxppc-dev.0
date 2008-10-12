Return-Path: <atokhy@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.239])
	by ozlabs.org (Postfix) with ESMTP id 8027FDDDEE
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Oct 2008 15:33:18 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id s6so444076wxc.15
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 21:33:16 -0700 (PDT)
Message-ID: <48F17DE6.106@gmail.com>
Date: Sun, 12 Oct 2008 00:32:38 -0400
From: Aaron Tokhy <atokhy@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PROBLEM] Soft lockup on Linux 2.6.27, 2 patches, Cell/PPC64
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I recently built 2.6.27 with these patches on my PS3.

http://www.kernel.org/pub/linux/kernel/people/geoff/cell/ps3-linux-patches/ps3-wip/ps3vram-driver.patch
http://www.kernel.org/pub/linux/kernel/people/geoff/cell/ps3-linux-patches/ps3-wip/ps3vram-proc-fs.patch

These patches enable the 'ps3vram' module, which creates a MTD node
/dev/mtdblock0.  In addition to the 256 MB of XDR ram used by the
system, I can use 245 MB of the video ram as a fast swap (getting a
somewhat valuable 60 MB/s read/write speed on a random access device).
I was using the mtdblock0 as a swap space when the soft lockup occurred
while leaving the `top` program open.

Now I am not sure if the patch is the issue.  None of the functions in
that list are functions in the patch... but this is my first time at
debugging a kernel bug, some of the functions have the word 'page' so it
might be due to problems occurring while paging to that mtdblock0
device, but surely calls to the functions in that patch would appear.
How would I start debugging this?

The trace is also available in pastebin: http://pastebin.com/m2ea72e52

BUG: soft lockup - CPU#0 stuck for 61s! [top:22788]
Modules linked in: evdev hci_usb usbhid bluetooth usb_storage snd_ps3
ehci_hcd snd_pcm ohci_hcd snd_page_alloc snd_timer usbcore snd sg
ps3_lpm soundcore
irq event stamp: 5018780
hardirqs last  enabled at (5018779): [<c000000000007c1c>] restore+0x1c/0xe4
hardirqs last disabled at (5018780): [<c000000000003600>]
decrementer_common+0x100/0x180
softirqs last  enabled at (5018778): [<c000000000020928>]
.call_do_softirq+0x14/0x24
softirqs last disabled at (5018773): [<c000000000020928>]
.call_do_softirq+0x14/0x24
NIP: c000000000084110 LR: c000000000084468 CTR: c0000000003181d0
REGS: c000000006f37280 TRAP: 0901   Not tainted  (2.6.27)
MSR: 8000000000008032 <EE,IR,DR>  CR: 42004424  XER: 00000000
TASK = c000000007980000[22788] 'top' THREAD: c000000006f34000 CPU: 0
GPR00: 0000000000000001 c000000006f37500 c0000000005543d0 c000000006f37570
GPR04: 0000000000000000 c00000000008427c 0000000000000001 0000000000000000
GPR08: 0000000000000830 0000000000000001 0000000000000000 c000000000b96874
GPR12: 8000000000008032 c000000000586300
NIP [c000000000084110] .csd_flag_wait+0x14/0x1c
LR [c000000000084468] .smp_call_function_single+0x13c/0x164
Call Trace:
[c000000006f37500] [c000000000084468]
.smp_call_function_single+0x13c/0x164 (unreliable)
[c000000006f375c0] [c000000000084578] .smp_call_function_mask+0xe8/0x244
[c000000006f37720] [c00000000005809c] .on_each_cpu+0x24/0x9c
[c000000006f377c0] [c00000000009bde4] .drain_all_pages+0x24/0x3c
[c000000006f37840] [c00000000009c0c8] .__alloc_pages_internal+0x2cc/0x464
[c000000006f37950] [c0000000000c3d54] .__slab_alloc+0x1f8/0x6cc
[c000000006f37a10] [c0000000000c466c] .kmem_cache_alloc+0x74/0x108
[c000000006f37ab0] [c0000000000cd200] .get_empty_filp+0x98/0x1a0
[c000000006f37b40] [c0000000000d9fa0] .__path_lookup_intent_open+0x40/0xd0
[c000000006f37bf0] [c0000000000da294] .do_filp_open+0xc0/0x7f0
[c000000006f37d80] [c0000000000c9818] .do_sys_open+0x88/0x154
[c000000006f37e30] [c0000000000076dc] syscall_exit+0x0/0x40
Instruction dump:
2f880000 3860fff0 409e000c f88b0008 38600000 ebc1fff0 4e800020 7c0004ac
80030020 780907e1 4d820020 7c210b78 <7c421378> 4bffffe8 4e800020 7c0802a6

- --
- -Thanks
Aaron Tokhy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkjxfeYACgkQO3nEAs/Ru1mjtwCfW25E51GIAY5KOcpJOp2TeUrz
hhQAni7m4UM7ojCPnjEsmiAEVxpLoljh
=AVql
-----END PGP SIGNATURE-----
