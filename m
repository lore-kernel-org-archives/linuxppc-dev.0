Return-Path: <dwilder@us.ibm.com>
Message-ID: <4497445F.50700@us.ibm.com>
Date: Mon, 19 Jun 2006 17:42:07 -0700
From: David Wilder <dwilder@us.ibm.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: Unable to handle kernel paging request in show_instructions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I ran into the following problem during Oops processing:

Oops: Exception in kernel mode, sig: 4 [#1]
SMP NR_CPUS=128 NUMA PSERIES LPAR
Modules linked in: pitrace sg scsi_mod nfs lockd nfs_acl sunrpc ipv6 
apparmor aa match_pcre loop dm_mod tg3
NIP: D000000000022014 LR: C000000000018FE4 CTR: C00000000036C718
REGS: c00000000043faf0 TRAP: 0700   Tainted: G     U  
(2.6.16.16-1.6-ppc64-wilder)
MSR: 8000000000089432 <EE,ME,IR,DR>  CR: 24000088  XER: 000FFFFF
TASK = c00000000048a660[0] 'swapper' THREAD: c00000000043c000 CPU: 0
GPR00: C000000000018FE4 C00000000043FD70 C000000000624420 0000000000000000
GPR04: C00000000048A990 0000000000006DFF 0000000024000082 C00000000000F0B0
GPR08: 0000000000000000 C0000000004351C0 0000000001021A00 C000000001456BC0
GPR12: D0000000004CC2B8 C00000000048AE80 0000000000000000 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: 4000000000400000 C00000000042BA00 C00000000042BEA8 C00000000042BC70
GPR24: C00000000048AE80 000000000082BA00 0000000000000000 C000000000000000
GPR28: 00000000FFFFFFFF C000000000629070 C0000000004C7BC8 C00000000F9F89D0
NIP [D000000000022014] 0xd000000000022014
LR [C000000000018FE4] .default_idle+0x98/0xcc
Call Trace:
[C00000000043FD70] [C000000000018FE4] .default_idle+0x98/0xcc (unreliable)
[C00000000043FE00] [C000000000018F38] .cpu_idle+0x40/0x54
[C00000000043FE70] [C000000000009274] .rest_init+0x44/0x5c
[C00000000043FEF0] [C0000000003FC75C] .start_kernel+0x270/0x288
[C00000000043FF90] [C000000000008594] .start_here_common+0x88/0x8c
Instruction dump:
 >>>Unable to handle kernel paging request for data at address 
0xd000000000021fe4
 >>>Faulting instruction address: 0xc00000000036b960

I don't care about the original oops, only the second fault because it 
prevents kdump from starting.

The problem occures in show_instructions().  Show_instructions() takes 
the NIP (D00000000002201) and subtracts some number so it points several 
instructs before the failing instructions.  In this case the new value 
is on a previous page and that page is not valid (it is not mapped).  
When the new NIP is referenced we get a second fault.  

show_instructions tries to validate addresses by checking if it is the 
kernel segment (0xc.....) or the first vmalloc segment (0xD.......).  
But in this case the validation passes even though the address is 
invalid.   Any ideas how to fix this?  Is there a easy way to validate 
if a page is valid before accessing it?

-- 
David Wilder
IBM Linux Technology Center
Beaverton, Oregon, USA 
dwilder@us.ibm.com
(503)578-3789
