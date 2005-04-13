Return-Path: <pstudencki@yahoo.com>
Received: from web51303.mail.yahoo.com (web51303.mail.yahoo.com
	[206.190.38.169]) by ozlabs.org (Postfix) with SMTP id 67BDD67A67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 01:55:06 +1000 (EST)
Message-ID: <20050413154824.62481.qmail@web51303.mail.yahoo.com>
Date: Wed, 13 Apr 2005 08:48:24 -0700 (PDT)
From: Pawel Studencki <pstudencki@yahoo.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Booting from cramfs with 2.6.11
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 hallo,
  
 after solving some problems I got 2.6.11 kernel
 booting on my board with
 8xx.
 Now I'm trying to mount cramfs root filesystem from
 flash. I've debuged this
 until inode->i_op->lookup in real_lookup function -
 I hoped to see here
 cramfs_lookup, but simple_lookup was called instead
 of that...
 
 From the beginning: mounting process starts in
 do_mount, where with call
 path_lookup it is looked for mount point. Actually
 it is function
 link_path_walk, where do_lookup is called - it
 returns a dentry using
 function real_lookup (and i_op->lookup is equal
 simple_lookup). inode of the
 returned dentry is NULL. So link_path_walk returns
 -ENOENT (-2), the same
 value returns than path_lookup and do_mount.
 
 I thought, the problem is wrong i_op->lookup
 function (simple_lookup instead
 of cramfs_looup). But the right values will be set
 first in do_new_mount
 calling do_kern_mount.
 
 here is a simple draft to help you understand...
 
 sys_mount(name, "/root", fs, flags, data);  - in my
 case fs is cramfs.
 |
 |-->do_mount()
 	|
 	|-- some checks...
 	|
 	|-- path_lookup()
 	|		|
 	|		|-- link_path_walk() (fs/namei.c)
 	|				|
 	|				|-- do_lookup() (returns
 next.dentry)
 	|				|	|
 	|				|	|-- __d_lookup
 	|				|	|
 	|				|	|-- real_lookup(nd->dentry,
 name, nd);
 	|				|	   |
 	|				|	   |-- dentry =
 d_alloc(parent, name);
 	
 (dentry->d_inode=NULL)
 	|				|	   |
 	|				|	   |- result =
 dir->i_op->lookup(dir, dentry, nd);
 							 !!! result is a
 dentry with inode = NULL !!!	
 	|				|
 	|				|
 	|				|
 	|				|
 	|				|
 	|				|-- follow_mount()
 	|				|
 	|				|
 	|				| inode = next.dentry->d_inode;
 (inode is NULL!!!!)
       |          	
 	|
 	|
 	|-- do_new_mount()
 		|
 		|-- do_kern_mount() (fs/super.c)
 			|
 			|-- type->get_sb (type is cramfs, and first
 get_sb
 sets i_op....
 						see fs/cramfs/inode.c )
 
 
 I don't understand all dependances, so perhaps
 someone could give me a hint,
 what is wrong here...is this normal that a dentry
 hat inode NULL? should the
 function cramfs_lookup be called here? If so, is
 there another place, where
 i_op is set?
 
 best regards 
 
 Pawel
 
 

----------------------------------------------------------------------------
> ------
> Linux version 2.6.11 (nb221330@nb2g156c) (gcc
> version 3.3.4) #29 Wed Apr 13
> 14:38:33 WEST 2005
> Built 1 zonelists
> Kernel command line: console=ttyCPM0, 57600
> root=/dev/mtdblock1
> rootfstype=cramfs ro
> PID hash table entries: 128 (order: 7, 2048 bytes)
> Decrementer Frequency = 187500000/60
> m8xx_wdt: wdt disabled (SYPCR: 0xFFFFFF88)
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 4096 (order: 2,
> 16384 bytes)
> Inode-cache hash table entries: 2048 (order: 1, 8192
> bytes)
> Memory: 14748k available (996k kernel code, 372k
> data, 60k init, 0k highmem)
> Mount-cache hash table entries: 512 (order: 0, 4096
> bytes)
> NET: Registered protocol family 16
> JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat,
> Inc.
> Serial: CPM driver $Revision: 0.01 $
> ttyCPM0 at MMIO 0xff000a60 (irq = 43) is a CPM UART
> io scheduler noop registered
> loop: loaded (max 8 devices)
> physmap flash device: 400000 at ffc00000
> phys_mapped_flash: Found 1 x16 devices at 0x0 in
> 16-bit bank
> Amd/Fujitsu Extended Query Table at 0x0040
> number of CFI chips: 1
> cfi_cmdset_0002: Disabling erase-suspend-program due
> to code brokenness.
> Creating 5 MTD partitions on "phys_mapped_flash":
> 0x00000000-0x000d0000 : "Kernel"
> mtd: Giving out device 0 to Kernel
> 0x000d0000-0x001d0000 : "RootFS"
> mtd: Giving out device 1 to RootFS
> 0x001d0000-0x00300000 : "ApplFS1"
> mtd: Giving out device 2 to ApplFS1
> 0x00300000-0x00330000 : "U-Boot"
> mtd: Giving out device 3 to U-Boot
> 0x00330000-0x00400000 : "ApplFS2"
> mtd: Giving out device 4 to ApplFS2
> slram: not enough parameters.
> 
> VFS: Cannot open root device "mtdblock1" or
> unknown-block(31,1)
> Please append a correct "root=" boot option
> Kernel panic - not syncing: VFS: Unable to mount
> root fs on
> unknown-block(31,1)
>
----------------------------------------------------------------------------


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
