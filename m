Return-Path: <dmytro.bablinyuk@rftechnology.com.au>
Received: from mfep2.connect.com.au (fep2.mfe.bur.connect.com.au [203.63.86.2])
	by ozlabs.org (Postfix) with ESMTP id 94E07684FD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 17:01:44 +1000 (EST)
Message-ID: <434B635D.1000509@rftechnology.com.au>
Date: Tue, 11 Oct 2005 17:01:49 +1000
From: Dmytro Bablinyuk <dmytro.bablinyuk@rftechnology.com.au>
MIME-Version: 1.0
To: Robin Gilks <robin.gilks@tait.co.nz>
References: <20051010234614.1FE2A353D84@atlas.denx.de><434B12C5.2050809@tait	.co.nz>
	<434B2D23.2020208@rftechnology.com.au>
	<434B3072.1090008@tait.co.nz>
In-Reply-To: <434B3072.1090008@tait.co.nz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: boot-time partitions and bootargs for 2.6.14
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> In that case you should have a u-boot line of
> 
> mtdparts=physically_mapped_flash:1024k(Linux),4096k(FS),2048k(Unused),512k(U-Boot),512() 

Yep, I set
mtdparts=phys_mapped_flash:1024k(Linux),4096k(FS),2048k(Unused),512k(U-Boot),512()

I got flash discovery working and I set 'CONFIG_MTD_CMDLINE_PARTS=y' but 
kernel is not even attempting to parse 'mtdparts'. It's not calling 
'parse_cmdline_partitions' function. Even if I got wrong 'mtd-id', it 
still should attempt to parse 'mtdparts' (well, at least I think so).

Here is output:

Kernel command line: console=ttyCPM0,115200 root=31:01 rw rootfstype=jffs2
PID hash table entries: 512 (order: 9, 8192 bytes)
Warning: real time clock seems stuck!
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 62720k available (1572k kernel code, 408k data, 96k init, 0k 
highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
JFFS2: default compression mode: priority
fuse init (API version 7.2)
Initializing Cryptographic API
Generic RTC Driver v1.07
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xf0011a00 (irq = 40) is a CPM UART
ttyCPM1 at MMIO 0xf0011a20 (irq = 41) is a CPM UART
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: loaded (max 8 devices)
physmap flash device: 800000 at ff800000
Found: Intel I28F016S3
phys_mapped_flash: Found 4 x8 devices at 0x0 in 32-bit bank
RedBoot partition parsing not available
eth0: FCC ENET Version 0.3, 00:04:9f:91:22:33
mii_reg: 600eb881
eth0: Phy @ 0x0, type Davicom DM9161E (0x0181b881)
eth1: FCC ENET Version 0.3, 00:04:9f:51:22:33
mii_reg: 618eb881
eth1: Phy @ 0x3, type Davicom DM9161E (0x0181b881)
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17

Does anybody has any idea of why parsing of 'mtdparts' is not even started?

I have enabled debug macro:

/* debug macro */
#if 1
#define dbg(x) do { printk("DEBUG-CMDLINE-PART: "); printk x; } while(0)
#else
#define dbg(x)
#endif

Thank you
