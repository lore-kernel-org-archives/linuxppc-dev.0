Date: Tue, 25 Feb 2003 15:03:33 -0800
From: Chris Zimman <chris@cryptoapps.com>
To: "William A. Gatliff" <bgat@billgatliff.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Unstable MPC8245 board
Message-ID: <20030225230333.GA20099@mail.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <20030225164619.B2761@saturn.billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030225164619.B2761@saturn.billgatliff.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Bill,

Just a few things to try before launching into kernel stuff:

I'm not familiar with uMON, but I would guess it has some memory tests
in it.  Can you do burst reads/writes inside of uMON reliably?

Without knowing anything else, from what I see here, I'm guessing that
your problem is related to memory.  But testing outside of the kernel
will definitely help to rule that out.

--Chris


On Tue, Feb 25, 2003 at 04:46:19PM -0600, William A. Gatliff wrote:
>
> Guys:
>
>
> I'm trying to run a recent (two weeks ago, Makefile has 2.4.21-pre4)
> MV kernel on a semi-custom MPC8245 board that looks a lot like a
> Cogent CSB281.  I'm using binutils-2.13.1, gcc-3.2.1, uClibc-0.9.17,
> busybox-0.60.4.  I'm also using the uMON bootloader from the CSB281.
>
> The kernel boots up fine, and mounts an initial ramdisk (romfs-0.3.1)
> containing a very minimal busybox environment.  After a few ls -lR's,
> the system freezes hard.
>
> According to my bdi2000, I usually end up in trap 700 before the CPU
> halts.  But sometimes I get pretty decent oops messages first:
>
> tulip_interrupt: ioaddr=c3000c00 tulip_debug=5
> Oops: kernel access of bad area, sig: 11
> NIP: C00F6EB4 XER: 20000000 LR: C00F7CE4 SP: C0117180 REGS: c01170d0 TRAP: 0300
>    Not tainted
> MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 504067FC, DSISR: 20000000
> TASK = c0115440[0] 'swapper' Last syscall: 120
> last math c0902000 last altivec 00000000
> GPR00: 00000004 C0117180 C0115440 504067FC FFFFFFFE C01052FD C0117220 0000000A
> GPR08: 00000000 504067FC FFFFFFFF C01171B8 C0140000 00000000 305C8801 B80688E6
> GPR16: D0040604 C3180200 00022412 00000000 00001032 00000000 00000000 00000019
> GPR24: 00000400 C0144FB4 C0117220 FFFFFFFF 504067FC C01453B3 00000000 C0144FB4
> Call backtrace:
> C0015F94 C0015D0C C008DAB4 C0006F4C C0007010 C0005FAC C0007558
> C000756C C0003B38 C01275DC 00003828
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
>  <0>Rebooting in 180 seconds..Initializing the MPC8245 PCI Bridge
>
> (Yes, I also have problems without _any_ ethernet drivers installed).
>
> The rest of the time, everything is simply scrambled by the time I
> type HALT on the bdi.
>
> I know what your answer will be, especially now that I've read the
> mailing list archives over and over: "memory interface problem".  I
> tend to agree--- it's my main theory at the moment, in fact.  I'm just
> not sure what to do about it.  Some questions:
>
> * Is there any reasonable explanation besides a memory problem?
>
> * I see the checksum for the kernel's .text region changing at
> runtime.  I'm pretty sure this isn't normal, is it?
>
> * Does anyone have a working CSB281 kernel (or similar) that I could
> borrow?  :^) Sandpoint won't get it, I don't have all the extra
> hardware onboard (I think I look more like a Muenski).
>
> * Can anyone suggest a really conservative memory interface setup to
> test with?  The MPC8245 is a bit of a stretch for me at the moment...
>
>
> Here's my .config.  For brevity, I omitted everything that's not set.
>
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_HAVE_DEC_LOCK=y
> CONFIG_EXPERIMENTAL=y
> CONFIG_ADVANCED_OPTIONS=y
> CONFIG_PPC=y
> CONFIG_PPC32=y
> CONFIG_6xx=y
> CONFIG_PPC_STD_MMU=y
> CONFIG_CSB281=y
> CONFIG_PPC_ISATIMER=y
> CONFIG_PCI=y
> CONFIG_NET=y
> CONFIG_SYSCTL=y
> CONFIG_SYSVIPC=y
> CONFIG_KCORE_ELF=y
> CONFIG_BINFMT_ELF=y
> CONFIG_KERNEL_ELF=y
> CONFIG_BINFMT_MISC=y
> CONFIG_PPC_RTC=y
> CONFIG_CMDLINE_BOOL=y
> CONFIG_CMDLINE="console=ttyS0,38400 root=/dev/ram"
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_SIZE=4096
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_UNIX=y
> CONFIG_INET=y
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> CONFIG_IP_PNP_BOOTP=y
> CONFIG_NET_ETHERNET=y
> CONFIG_NET_PCI=y
> CONFIG_PCNET32=y
> CONFIG_TULIP=y
> CONFIG_TULIP_MMIO=y
> CONFIG_NATSEMI=y
> CONFIG_NE2K_PCI=y
> CONFIG_8139CP=y
> CONFIG_SERIAL=y
> CONFIG_SERIAL_CONSOLE=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=256
> CONFIG_TMPFS=y
> CONFIG_RAMFS=y
> CONFIG_PROC_FS=y
> CONFIG_DEVPTS_FS=y
> CONFIG_ROMFS_FS=y
> CONFIG_NFS_FS=y
> CONFIG_ROOT_NFS=y
> CONFIG_SUNRPC=y
> CONFIG_LOCKD=y
> CONFIG_MSDOS_PARTITION=y
> CONFIG_DEBUG_KERNEL=y
> CONFIG_BDI_SWITCH=y
> CONFIG_MORE_COMPILE_OPTIONS=y
> CONFIG_COMPILE_OPTIONS="-g -ggdb"
>
>
>
>
> I'm stumped.  Thanks to _anyone_ who can help me make any progress on
> this...
>
>
>
>
> b.g.
> --
> Bill Gatliff
> http://billgatliff.com
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
