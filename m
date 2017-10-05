Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y72yh2q9fzDr5C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 17:33:15 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v956TYYY015337
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Oct 2017 02:33:13 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ddbpa31wj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Oct 2017 02:33:13 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Thu, 5 Oct 2017 00:33:12 -0600
Subject: [linux-next][DLPAR CPU][Oops] Kernel crash with CPU hotunplug
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next <linux-next@vger.kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Rob
 Herring <robh@kernel.org>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 sachinp <sachinp@linux.vnet.ibm.com>
Date: Thu, 05 Oct 2017 12:03:05 +0530
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1507185185.3792.12.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

linux-next kernel panic while DLPAR CPU add/remove operation in a loop.

Test: CPU hot-unplug
Machine Type: Power8 PowerVM LPAR
kernel: 4.14.0-rc2-next-20170928
gcc : 5.2.1

trace logs
----------
cpu 10 (hwid 10) Ready to die...
cpu 11 (hwid 11) Ready to die...
cpu 12 (hwid 12) Ready to die...
cpu 13 (hwid 13) Ready to die...
cpu 14 (hwid 14) Ready to die...
cpu 15 (hwid 15) Ready to die...
Unable to handle kernel paging request for data at address 0xdead4ead00000030
Faulting instruction address: 0xc000000001af38e4
Oops: Kernel access of bad area, sig: 11 [#1]
LE SMP NR_CPUS=2048 NUMA pSeries
Modules linked in: rpadlpar_io rpaphp bridge stp llc xt_tcpudp ipt_REJECT nf_reject_ipv4 xt_conntrack nfnetlink iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iptable_filter vmx_crypto pseries_rng rng_core binfmt_misc nfsd ip_tables x_tables autofs4
CPU: 7 PID: 10657 Comm: systemd-udevd Not tainted 4.14.0-rc2-next-20170928-autotest #1
task: c000000271b7cc00 task.stack: c00000026d504000
NIP:  c000000001af38e4 LR: c000000001af3b48 CTR: c000000001af4270
REGS: c00000026d5079e0 TRAP: 0380   Not tainted  (4.14.0-rc2-next-20170928-autotest)
MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 22008882  XER: 20000000  
CFAR: c000000001af3b44 SOFTE: 1 
GPR00: c000000001af3b48 c00000026d507c60 c000000003572500 c00000026c0d4a80 
GPR04: c00000026c0d4a80 c00000026b56b310 c0000000037d2500 dead4ead00000030 
GPR08: 00000000000016f0 fffffffffffffff0 dead4ead00000000 c000000270b24420 
GPR12: c000000001af4270 c00000000fdc1f80 00000000000029a3 000000000aba9500 
GPR16: 000001000e4134f0 000000000aba9500 000000000000000f 0000000000000001 
GPR20: 0000000120ff68d8 0000000120ff68d0 0000000120ff6a48 0000000120ff33f0 
GPR24: 0000000120ff6550 c00000026b56b310 c00000027286d9b8 c0000000037d4d88 
GPR28: c0000002727b17a0 c00000026c0d4a80 c00000027286da38 c00000026c0d4a80 
NIP [c000000001af38e4] free_pipe_info+0x64/0x200
LR [c000000001af3b48] put_pipe_info+0xc8/0x140
Call Trace:
[c00000026d507c60] [c00000027286da38] 0xc00000027286da38 (unreliable)
[c00000026d507ca0] [c000000001af3b48] put_pipe_info+0xc8/0x140
[c00000026d507ce0] [c000000001af43fc] pipe_release+0x18c/0x1e0
[c00000026d507d20] [c000000001ae0efc] __fput+0x12c/0x4f0
[c00000026d507d80] [c000000001ae12ec] ____fput+0x2c/0x50
[c00000026d507da0] [c00000000178eb3c] task_work_run+0x17c/0x200
[c00000026d507e00] [c00000000160adb8] do_notify_resume+0x1f8/0x220
[c00000026d507e30] [c0000000015ebec4] ret_from_except_lite+0x70/0x74
Instruction dump:
81230070 e94300b0 39080001 7d2900d0 38ea0030 f9066d98 7c0004ac 3d020026 
e9086da0 3cc20026 39080001 f9066da0 <7d0038a8> 7d094214 7d0039ad 40c2fff4 
---[ end trace 4dcb6f2341ddb370 ]---

Kernel panic - not syncing: Fatal exception
Rebooting in 10 seconds..

Test logs:
----------
DLPAR remove cpu operation
Running 'drmgr -c cpu -d 5 -w 30 -r'

########## Oct 04 03:09:22 2017 ##########
drmgr: -c cpu -d 5 -w 30 -r
Validating CPU DLPAR capability...yes.
Expecting 20 threads...found 16.
Found cpu PowerPC,POWER8@8
Found cpu PowerPC,POWER8@0
Start CPU List.
10000008 : CPU 9
    thread: 8: /sys/devices/system/cpu/cpu8
    thread: 9: /sys/devices/system/cpu/cpu9
    thread: 10: /sys/devices/system/cpu/cpu10
    thread: 11: /sys/devices/system/cpu/cpu11
    thread: 12: /sys/devices/system/cpu/cpu12
    thread: 13: /sys/devices/system/cpu/cpu13
    thread: 14: /sys/devices/system/cpu/cpu14
    thread: 15: /sys/devices/system/cpu/cpu15
10000000 : CPU 1
    thread: 0: /sys/devices/system/cpu/cpu0
    thread: 1: /sys/devices/system/cpu/cpu1
    thread: 2: /sys/devices/system/cpu/cpu2
    thread: 3: /sys/devices/system/cpu/cpu3
    thread: 4: /sys/devices/system/cpu/cpu4
    thread: 5: /sys/devices/system/cpu/cpu5
    thread: 6: /sys/devices/system/cpu/cpu6
    thread: 7: /sys/devices/system/cpu/cpu7
Done.
Number of CPUs = 2
Releasing cpu "/cpus/PowerPC,POWER8@8"
Removed 1 of 1 requested cpu(s)
########## Oct 04 03:09:24 2017 ##########
Command 'drmgr -c cpu -d 5 -w 30 -r' finished with 0 after
2.20577907562s
[stdout] CPU 9
DLPAR add cpu operation
Running 'drmgr -c cpu -d 5 -w 30 -a'

########## Oct 04 03:09:24 2017 ##########
drmgr: -c cpu -d 5 -w 30 -a
Validating CPU DLPAR capability...yes.
Expecting 20 threads...found 16.
Found cpu PowerPC,POWER8@0
Start CPU List.
10000008 : CPU 9
10000000 : CPU 1
    thread: 0: /sys/devices/system/cpu/cpu0
    thread: 1: /sys/devices/system/cpu/cpu1
    thread: 2: /sys/devices/system/cpu/cpu2
    thread: 3: /sys/devices/system/cpu/cpu3
    thread: 4: /sys/devices/system/cpu/cpu4
    thread: 5: /sys/devices/system/cpu/cpu5
    thread: 6: /sys/devices/system/cpu/cpu6
    thread: 7: /sys/devices/system/cpu/cpu7
Done.
Probing cpu 0x10000008

Kernel panics after above operation.

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
