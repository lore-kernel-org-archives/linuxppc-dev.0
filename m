Date: Sun, 9 May 2004 10:04:42 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: partial boot progress with 2.6 kernel and MPC850 board
In-Reply-To: <BCEFJBPJCGFCNMMMIDBHMEOBCFAA.Joakim.Tjernlund@lumentis.se>
Message-ID: <Pine.LNX.4.58.0405090948480.22099@localhost.localdomain>
References: <BCEFJBPJCGFCNMMMIDBHMEOBCFAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, 9 May 2004, Joakim Tjernlund wrote:

> > Using anticipatory io scheduler
> > RPX Lite or CLLF flash device: 2000000 at fe000000
> > Oops: Kernel Mode Software FPU Emulation, sig: 8 [#1]
> > NIP: 00000200 LR: C010A270 SP: C04D3CF0 REGS: c04d3c40 TRAP: 1000    Not
> > tainted
> > MSR: 00000000 EE: 0 PR: 0 FP: 0 ME: 0 IR/DR: 00
> > TASK = c04d9870[1] 'swapper' THREAD: c04d2000Last syscall: 120
> > GPR00: 00F000F0 C04D3CF0 C04D9870 C01C2490 00000000 00000000 C04D3D58
> > 00000000
> > GPR08: 00000000 C3050000 00000004 00000004 C04D3D58 FA202210 814D9590
> > 04294A49
> > GPR16: 800C1000 86A18F36 01243440 8099A0B1 32901AA8 14C18630 4CCA2080
> > 181021E0
> > GPR24: 0E54A064 44810080 C04D3D58 00000002 C01C2444 C01C2490 00000000
> > 00000004
> > Call trace: [c010a270]  [c010a00c]  [c0109f38]  [c0103c60]  [c0102788]
> > [c01d58
> > Kernel panic: Attempted to kill init!
> >  <0>Rebooting in 180 seconds..
>
> Looks like you got an MachineCheck that could not be handled.
> NIP is 0x200, which is the Machine Check exception vector.
> Try changing the MachineCheck exception as I wrote earlier.
> Then you should get a better fault indication.

much simpler explanation -- given that the oops occurred right after the
reference to the flash device, i reconfigured the kernel and deselected

Device Drivers ->
	MTD ->
		Mapping drivers for chip access ->
			CFI Flash device mapped on RPX Lite or CLLF

we did have to hack that somewhat for our 2.4 kernel, so it made sense to
just take it out for now since it wasn't necessary for the boot.  at which
point, i now get (without having to do anything with the aforementioned
machine check exception):

>g
[Go 00400000]

loaded at:     00400000 0067D1F4
board data at: 0067A128 0067A144
relocated to:  00405314 00405330
zimage at:     0040583C 004D9196
initrd at:     004DA000 00679129
avail ram:     0067E000 02000000

Linux/PPC load: console=ttyS0,9600 rw root=/dev/ram0 init=/sbin/minit
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.6.6-rc3 (rpjday@localhost.localdomain) (gcc version 3.2.2
200304
On node 0 totalpages: 8192
  DMA zone: 8192 pages, LIFO batch:2
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: console=ttyS0,9600 rw root=/dev/ram0 init=/sbin/minit
PID hash table entries: 256 (order 8: 2048 bytes)
Decrementer Frequency = 187500000/60
Memory: 28800k available (1488k kernel code, 376k data, 76k init, 0k
highmem)
Calibrating delay loop... 46.72 BogoMIPS
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
Generic RTC Driver v1.07
RAMDISK driver initialized: 16 RAM disks of 6144K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Using anticipatory io scheduler
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
NET: Registered protocol family 1
NET: Registered protocol family 17
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 1660k freed
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 76k init
FIFOs opened successfully.           <-- where "minit" kicks in ...
About to start default service.

  at which point it hangs, but this is where i'm using "minit" to start
the initial services, and i should probably remove a bunch of
non-essential services just to see if i can complete the boot process.

  so this is pretty exciting -- the kernel booted, mounted the root
filesystem, and invoked minit which at least tried to start the list
of system services.

  i'll keep working on this and report back if anyone is interested in
whether i finally get a full boot.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
