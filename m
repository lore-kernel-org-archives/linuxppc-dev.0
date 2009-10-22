Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id 5EDB0B7BB9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Oct 2009 08:03:30 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 22 Oct 2009 14:57:29 -0600
Subject: Page map BUG on program exit
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0330707311@midas.usurf.usu.edu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All,

I am using a 405EX CPU on a custom board.  The layout and hardware is very =
similar to the AMCC Kilauea board.  Here is the output of uname -a:

Linux (none) 2.6.30.3-wolverine-dirty #3 PREEMPT Thu Sep 10 11:41:37 MDT 20=
09 ppc unknown

I am getting the following BUG output when my program exits:

BUG: Bad page map in process main  pte:980005d7 pmd:0d840400
addr:48000000 vm_flags:400844fb anon_vma:(null) mapping:cd8454f8 index:9800=
0
vma->vm_file->f_op->mmap: fpga_mmap+0x0/0x178 [fpgaDriver]
Call Trace:
[cd84dc40] [c0006f0c] show_stack+0x44/0x16c (unreliable)
[cd84dc80] [c00ba314] print_bad_pte+0x140/0x1d0
[cd84dcb0] [c00ba3ec] vm_normal_page+0x48/0x50
[cd84dcc0] [c00bb2ec] unmap_vmas+0x214/0x614
[cd84dd40] [c00bffe0] exit_mmap+0xd0/0x1b4
[cd84dd70] [c0031e40] mmput+0x50/0x134
[cd84dd80] [c0036470] exit_mm+0x114/0x13c
[cd84ddb0] [c0037d80] do_exit+0xc0/0x68c
[cd84de00] [c0038390] do_group_exit+0x44/0xd8
[cd84de10] [c0044468] get_signal_to_deliver+0x1f8/0x430
[cd84de70] [c0008224] do_signal+0x54/0x29c
[cd84df40] [c0010d5c] do_user_signal+0x74/0xc4

I have an FPGA on the PCIe bus that I am mapping BAR0 to user space with a =
call to mmap().  The mapping works just fine and I can access all the regis=
ters in the BAR without a problem.  However, on exit this comes up.

A Google search showed tons of people with similar problems in standard dis=
tributions (Ubuntu primarily), but no resolutions.

Has anyone seen this crop up before and know what the issue is?  I include =
any source code, if that is required.

Thanks!

Jonathan
