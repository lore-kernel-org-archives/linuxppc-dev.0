Date: Thu, 12 Jun 2003 22:37:20 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: PPC405GP Cache/MMU mystery
To: linuxppc-embedded@lists.linuxppc.org
Reply-To: tglx@linutronix.de
Message-id: <200306122237.20622.tglx@linutronix.de>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all !

We run into a strange Cache / MMU problem, when the init process is started.
In fs/bifmt_elf.c/create_elf_tables the setup of the arg / env pointers
failes.

The reason is, that the page, which is accessed via the virtual userspace
address contains no valid data.

The page is created and filled with data in /fs/exec.c/copy_strings(). The
data are correct there. The page is then given to userspace context by
creating a pte in /fs/exec.c/put_dirty_pages(), which is called from
/fs/exec.c/set_arg_pages().

We have dumped the corresponding TLB entries. The mapping there is correct.
TLB 63	Virt 0xc0000000	Phys 0x00000000, Zone 0
TLB 7 	Virt 0x7ffff0000	Phys 0x0014a000, Zone 1

if we dump the page via the virtual virtual userspace address  we see invalid
data.
0x7fffffda : 613bb1a7 5e861acf 5b2dce9f 6bce583b  a;..^...[-..k.X;
0x7fffffea : 19140130 dea63ed4 958de876 d52957e4  ...0..>....v.)W.

If we dump the page via the virtual kernel address we see the correct data.
0xc014afda : 696e6974 00484f4d 453d2f00 5445524d  init.HOME=/.TERM
0xc014afea : 3d6c696e 7578002f 7362696e 2f696e69  =linux./sbin/ini

Then we write some crap to the virtual userspace address and get the follwing,
when we read both addresses back

0x7fffffda : 67617267 656c7075 002dce9f 6bce583b  gargelpu.-..k.X;
0x7fffffea : 19140130 dea63ed4 958de876 d52957e4  ...0..>....v.)W.

0xc014afda : 67617267 656c4f4d 453d2f00 5445524d  gargelOME=/.TERM
0xc014afea : 3d6c696e 7578002f 7362696e 2f696e69  =linux./sbin/ini

We have already tried to flush and invalidate the dcache, but no change in
behaviour.

The real strange thing is, that the rest of the kernel is running stable, e.g.
it services a flood ping without complaints

Any ideas ?????

Bootloader: 	UBoot
Kernel 		2.4.21-rc2-powerpc (2003-05-15)

--
Thomas
________________________________________________________________________
linutronix - competence in embedded & realtime linux
http://www.linutronix.de
mail: tglx@linutronix.de


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
