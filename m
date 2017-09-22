Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xzChF6K4CzDqjC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 22:38:37 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8MCcDN5088403
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 08:38:35 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d4yxb3tba-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 08:38:34 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Fri, 22 Sep 2017 06:38:34 -0600
Subject: Re: [linux-next][DLPAR CPU][Oops] Bad kernel stack pointer
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Rob Herring <robh@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-next
 <linux-next@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 22 Sep 2017 18:08:26 +0530
In-Reply-To: <1506074224.17232.8.camel@abdul.in.ibm.com>
References: <1505729319.6990.5.camel@abdul.in.ibm.com>
 <878th9lhpe.fsf@concordia.ellerman.id.au>
 <1506074224.17232.8.camel@abdul.in.ibm.com>
Content-Type: multipart/mixed; boundary="=-YIqMPWa/Zt/DXx550G60"
Mime-Version: 1.0
Message-Id: <1506083906.17232.24.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-YIqMPWa/Zt/DXx550G60
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2017-09-22 at 15:27 +0530, Abdul Haleem wrote:
> On Wed, 2017-09-20 at 21:42 +1000, Michael Ellerman wrote:
> > Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
> > 
> > > Hi,
> > >
> > > Dynamic CPU remove operation resulted in Kernel Panic on today's
> > > next-20170915 kernel.
> > >
> > > Machine Type: Power 7 PowerVM LPAR
> > > Kernel : 4.13.0-next-20170915
> > > config : attached
> > > test: DLPAR CPU remove
> > >
> > >
> > > dmesg logs:
> > > ----------
> > > cpu 37 (hwid 37) Ready to die...
> > > cpu 38 (hwid 38) Ready to die...
> > > cpu 39 (hwid 39)
> > > ******* RTAS CReady to die...
> > > ALL BUFFER CORRUPTION *******
> > 
> > Cool. Does that come from RTAS itself? I have never seen that happen
> > before.
> 
> Not sure, the var logs does not have any messages captured. This is
> first time we hit this type of issue.
> > 
> > Is this easily reproducible?
> 
> I am unable to reproduce it again. I will keep an eye on our CI runs for
> few more runs.
> 

I was able to reproduce it again, the trace looks similar. except it
does not have RTAS 'ALL BUFFER CORRUPTION' message.

cpu 36 (hwid 36) Ready to die...
cpu 37 (hwid 37) Ready to die...
cpu 38 (hwid 38) Ready to die...
Bad kernel stack pointer fc7b120 at ee9fdc4
Bad kernel stack pointer fc7b220 at ee9da0c
Oops: Bad kernel stack pointer, sig: 6 [#1]
BE SMP NR_CPUS=2048 NUMA pSeries
Modules linked in: loop xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 tun bridge stp llc kvm_pr kvm rpadlpar_io rpaphp ebtable_filter ebtables ip6table_filter ip6_tables dccp_diag dccp tcp_diag udp_diag inet_diag unix_diag af_packet_diag iptable_filter netlink_diag sg nfsd auth_rpcgss nfs_acl lockd grace sunrpc binfmt_misc ip_tables ext4 mbcache jbd2 sd_mod ibmvscsi scsi_transport_srp ibmveth
CPU: 38 PID: 0 Comm: swapper/38 Not tainted 4.14.0-rc1-next-20170922 #2
task: c0000013f82ea300 task.stack: c0000013f8344000
NIP:  000000000ee9fdc4 LR: 000000000eea0f10 CTR: 000000000ee9fc64
REGS: c00000000eca7d40 TRAP: 0300   Not tainted  (4.14.0-rc1-next-20170922)
MSR:  8000000000001000 <SF,ME>  CR: 88000004  XER: 00000018
CFAR: 000000000ee9fd5c DAR: 003cf6eaa9e7225f DSISR: 42000000 SOFTE: -9223372036812787662
GPR00: 0000000000000038 000000000fc7b120 000000000ef68b00 000000000ef69000
GPR04: 000000000ef35ea8 000000000fc7b3a0 0000000000000800 0000000000000030
GPR08: 000000000f0f0110 0000000000000008 003cf6eaa9e7223f 0000000000000030
GPR12: 0000000000000000 c00000000e948f00 c0000013f8347f90 000000000eee8040
GPR16: 0000000000000000 c0000000013cfde8 c000000000e43a80 c000000000e43a80
GPR20: 0000000000000000 c000000000e43880 0000000000000098 0000000000000026
GPR24: 0000000000000026 c000000000e44f70 c000000000e44f74 0000000000000002
GPR28: c000000000e44f74 0000000000000001 0000000000000130 000000000fc7b120
NIP [000000000ee9fdc4] 0xee9fdc4
LR [000000000eea0f10] 0xeea0f10
Call Trace:
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
---[ end trace 59dc6eb8faf1d63f ]---
Unable to handle kernel paging request for unaligned access at address 0xc000000000e658be
Faulting instruction address: 0xc0000000009f1460
Unable to handle kernel paging request for data at address 0xa08cc8b63900000c
Faulting instruction address: 0xc00000000017c2e4
Unable to handle kernel paging request for unaligned access at address 0xc000000000e624ae
Faulting instruction address: 0xc00000000010cea8
Unable to handle kernel paging request for data at address 0x4d455f54494d45f3
Faulting instruction address: 0xc000000000133b04
Unable to handle kernel paging request for unaligned access at address 0xc000000000e658be
Faulting instruction address: 0xc0000000009f16a4
Unable to handle kernel paging request for unaligned access at address 0xc000000000e6633e
Faulting instruction address: 0xc00000000059414c

Please let me know if you need more logs.

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre



--=-YIqMPWa/Zt/DXx550G60
Content-Disposition: attachment; filename="dlparlogs.txt"
Content-Type: text/plain; name="dlparlogs.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

[stdout] cpu_dlpar=yes,mem_dlpar=yes,slot_dlpar=yes,phb_dlpar=yes,hea_dlpar=yes,pmig=yes,cpu_entitlement=yes,mem_entitlement=yes,slb_resize=yes,phib=yes
[stderr] Validating CPU DLPAR capability...yes.
[stderr] Validating Memory DLPAR capability...yes.
[stderr] Validating I/O DLPAR capability...yes.
[stderr] Validating PHB DLPAR capability...yes.
[stderr] Validating HEA DLPAR capability...yes.
[stderr] Validating partition migration capability...yes.
[stderr] Validating partition hibernation capability...yes.
Command 'drmgr -C' finished with 0 after 0.0599222183228s
DLPAR remove cpu operation
Running 'drmgr -c cpu -d 5 -w 30 -r'
[stderr] 
[stderr] ########## Sep 22 08:20:16 2017 ##########
[stderr] drmgr: -c cpu -d 5 -w 30 -r 
[stderr] Validating CPU DLPAR capability...yes.
[stderr] Expecting 44 threads...found 40.
[stderr] Found cpu PowerPC,POWER7@c
[stderr] Found cpu PowerPC,POWER7@18
[stderr] Found cpu PowerPC,POWER7@8
[stderr] Found cpu PowerPC,POWER7@24
[stderr] Found cpu PowerPC,POWER7@14
[stderr] Found cpu PowerPC,POWER7@4
[stderr] Found cpu PowerPC,POWER7@20
[stderr] Found cpu PowerPC,POWER7@10
[stderr] Found cpu PowerPC,POWER7@0
[stderr] Found cpu PowerPC,POWER7@1c
[stderr] Found cache l2-cache@2006
[stderr] Found cache l3-cache@3107
[stderr] Found cache l2-cache@2004
[stderr] Found cache l3-cache@3105
[stderr] Found cache l2-cache@2002
[stderr] Found cache l3-cache@3103
[stderr] Found cache l2-cache@2000
[stderr] Found cache l3-cache@3101
[stderr] Found cache l2-cache@2009
[stderr] Found cache l2-cache@2007
[stderr] Found cache l3-cache@3108
[stderr] Found cache l2-cache@2005
[stderr] Found cache l3-cache@3106
[stderr] Found cache l2-cache@2003
[stderr] Found cache l3-cache@3104
[stderr] Found cache l2-cache@2001
[stderr] Found cache l3-cache@3102
[stderr] Found cache l3-cache@3100
[stderr] Found cache l2-cache@2008
[stderr] Found cache l3-cache@3109
[stderr] Start CPU List.
[stderr] 10000024 : CPU 37
[stderr] 	thread: 36: /sys/devices/system/cpu/cpu36
[stderr] 	thread: 37: /sys/devices/system/cpu/cpu37
[stderr] 	thread: 38: /sys/devices/system/cpu/cpu38
[stderr] 	thread: 39: /sys/devices/system/cpu/cpu39
[stderr] 10000020 : CPU 33
[stderr] 	thread: 32: /sys/devices/system/cpu/cpu32
[stderr] 	thread: 33: /sys/devices/system/cpu/cpu33
[stderr] 	thread: 34: /sys/devices/system/cpu/cpu34
[stderr] 	thread: 35: /sys/devices/system/cpu/cpu35
[stderr] 1000001c : CPU 29
[stderr] 	thread: 28: /sys/devices/system/cpu/cpu28
[stderr] 	thread: 29: /sys/devices/system/cpu/cpu29
[stderr] 	thread: 30: /sys/devices/system/cpu/cpu30
[stderr] 	thread: 31: /sys/devices/system/cpu/cpu31
[stderr] 10000018 : CPU 25
[stderr] 	thread: 24: /sys/devices/system/cpu/cpu24
[stderr] 	thread: 25: /sys/devices/system/cpu/cpu25
[stderr] 	thread: 26: /sys/devices/system/cpu/cpu26
[stderr] 	thread: 27: /sys/devices/system/cpu/cpu27
[stderr] 10000014 : CPU 21
[stderr] 	thread: 20: /sys/devices/system/cpu/cpu20
[stderr] 	thread: 21: /sys/devices/system/cpu/cpu21
[stderr] 	thread: 22: /sys/devices/system/cpu/cpu22
[stderr] 	thread: 23: /sys/devices/system/cpu/cpu23
[stderr] 10000010 : CPU 17
[stderr] 	thread: 16: /sys/devices/system/cpu/cpu16
[stderr] 	thread: 17: /sys/devices/system/cpu/cpu17
[stderr] 	thread: 18: /sys/devices/system/cpu/cpu18
[stderr] 	thread: 19: /sys/devices/system/cpu/cpu19
[stderr] 1000000c : CPU 13
[stderr] 	thread: 12: /sys/devices/system/cpu/cpu12
[stderr] 	thread: 13: /sys/devices/system/cpu/cpu13
[stderr] 	thread: 14: /sys/devices/system/cpu/cpu14
[stderr] 	thread: 15: /sys/devices/system/cpu/cpu15
[stderr] 10000008 : CPU 9
[stderr] 	thread: 8: /sys/devices/system/cpu/cpu8
[stderr] 	thread: 9: /sys/devices/system/cpu/cpu9
[stderr] 	thread: 10: /sys/devices/system/cpu/cpu10
[stderr] 	thread: 11: /sys/devices/system/cpu/cpu11
[stderr] 10000004 : CPU 5
[stderr] 	thread: 4: /sys/devices/system/cpu/cpu4
[stderr] 	thread: 5: /sys/devices/system/cpu/cpu5
[stderr] 	thread: 6: /sys/devices/system/cpu/cpu6
[stderr] 	thread: 7: /sys/devices/system/cpu/cpu7
[stderr] 10000000 : CPU 1
[stderr] 	thread: 0: /sys/devices/system/cpu/cpu0
[stderr] 	thread: 1: /sys/devices/system/cpu/cpu1
[stderr] 	thread: 2: /sys/devices/system/cpu/cpu2
[stderr] 	thread: 3: /sys/devices/system/cpu/cpu3
[stderr] Done.
[stderr] Number of CPUs = 10
[stderr] Releasing cpu "/cpus/PowerPC,POWER7@24"


--=-YIqMPWa/Zt/DXx550G60--
