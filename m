Return-Path: <happa@wmlab.csie.ncu.edu.tw>
Received: from wmlab.csie.ncu.edu.tw (wmlab.csie.ncu.edu.tw [140.115.155.134])
	by ozlabs.org (Postfix) with ESMTP id CBF92689AC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jan 2006 20:30:42 +1100 (EST)
Received: from 140.115.155.134 (localhost.csie.ncu.edu.tw [127.0.0.1])
	by wmlab.csie.ncu.edu.tw (Postfix) with SMTP id 069741100F0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jan 2006 16:58:08 +0800 (CST)
From: happa@wmlab.csie.ncu.edu.tw
To: linuxppc-embedded@ozlabs.org
Date: Tue, 10 Jan 2006 16:58:08 +0800(CST)
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--43C3772000000F8B@wmlab.csie.ncu.edu.tw"
Message-Id: <20060110085808.069741100F0@wmlab.csie.ncu.edu.tw>
Subject: Exceptin occurs after execute activate_mm()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

----43C3772000000F8B@wmlab.csie.ncu.edu.tw
Content-Type: text/plain; Charset=Big5;
Content-Transfer-Encoding: 8bit

Hi,
I am booting my linux kernel via NFS.

Here is my environment:
CPU:Motorola ppc8245
Linux version 2.6.14 
gcc version 3.3.3 (DENX ELDK 3.1.1 3.3.3-9)

The root file system is mounted via NFS, than it start to call "run_init_process("/sbin/init")".
After do this, the following error message will dump.
Oops: kernel access of bad area, sig: 11 [#2]
NIP: 00153884 LR: 0003AC7C SP: 00581390 REGS: 005812e0 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 11000F5A, DSISR: 08000000
TASK = 0057f730[1] 'init' THREAD: 00580000
Last syscall: 11
GPR00: 11000F5A 00581390 0057F730 00000003 00586000 00581420 00581460 0000000A
GPR08: 00274000 11000F00 00000000 00290000 0057F900 50482121 10016DB4 10016DB4
GPR16: 00000000 0A3421AD 00000000 00000801 00000074 00000000 0000007C 005D2AA0
GPR24: 00581420 00581420 00000003 00000003 00274060 00000000 00586000 005D2AA0
NIP [00153884] ipg_interrupt_handler+0x1c/0x114
LR [0003ac7c] __do_IRQ+0x164/0x214
Call trace:
 [0003ac7c] __do_IRQ+0x164/0x214
 [00006280] do_IRQ+0x3c/0x9c
 [00005050] ret_from_except+0x0/0x14
 [00005328] die+0x94/0x98
 [0000e6cc] bad_page_fault+0x48/0x5c
 [00004e30] handle_page_fault+0x7c/0x80
 [001797e8] __alloc_skb+0x64/0x12c
 [0018f9d0] qdisc_restart+0x100/0x1fc
 [00180a04] dev_queue_xmit+0x10c/0x258
 [0019eda4] ip_output+0x238/0x2a0
 [0019e82c] ip_push_pending_frames+0x334/0x438
 [001be790] udp_push_pending_frames+0x1dc/0x200
 [001bd78c] udp_sendmsg+0x528/0x600
 [001c6168] inet_sendmsg+0xb4/0xc8
 [00173510] sock_sendmsg+0xac/0xcc
Kernel panic - not syncing: Aiee, killing interrupt handler!
 <0>Rebooting in 180 seconds..

>From dump messages I ckeck the source code in function "ipg_interrupt_handler+0x1c/0x114", the exception 
is cause by access PCI memory space of my NIC device, but this access is fine before run_init_process("/sbin/init")
is called.
Here is my NIC device logical and physical mappping. 
The physical base address of this NIC is assign to 0xbffcff00 
The virtual memory is map to 0x11000F00


I also trace call stack for run_init_process("/sbin/init").
   
run_init_process("/sbin/init")
   |
   v
...wait until the file got from NFS .....     
   |
   v 
 load_elf_binary()
   |
   v
 flush_old_exec()
   |
   v
 exec_mmap()
   |
   v
 activate_mm() ---> After this function is called, to access PCI memory space of my NIC device the excepton will occur.
                    
I have also check "Segment Regiser" of mpc8245.
Before the activate_mm() called the "Segment Regiser" is list as follow:
SR0  : 20000000
SR1  : 20000111
SR2  : 20000222
SR3  : 20000333
SR4  : 20000444
SR5  : 20000555
SR6  : 20000666
SR7  : 20000777
SR8  : 20000888
SR9  : 20000999
SR10 : 20000AAA
SR11 : 20000BBB
SR12 : 20000CCC
SR13 : 20000DDD
SR14 : 20000EEE
SR15 : 20000FFF
                       
After the activate_mm() called the "Segment Regiser" is list as follow:
SR0  : 60003810
SR1  : 60003921
SR2  : 60003A32
SR3  : 60003B43
SR4  : 60003C45
SR5  : 60003D65
SR6  : 60003E76
SR7  : 60003F87
SR8  : 20000888
SR9  : 20000999
SR10 : 20000AAA
SR11 : 20000BBB
SR12 : 20000CCC
SR13 : 20000DDD
SR14 : 20000EEE
SR15 : 20000FFF

I think the memory translate have problem after call "activate_mm()".      

Is my MMU setting have problems, or someone would tell me which setting or configure I need to check?

/Wen


----43C3772000000F8B@wmlab.csie.ncu.edu.tw--
