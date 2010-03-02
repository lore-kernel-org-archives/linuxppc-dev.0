Return-Path: <jhansen@cardaccess-inc.com>
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	by ozlabs.org (Postfix) with ESMTP id E85B7B7D57
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  3 Mar 2010 08:11:59 +1100 (EST)
Received: from in01.mta.xmission.com ([166.70.13.51])
	by out02.mta.xmission.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <jhansen@cardaccess-inc.com>)
	id 1NmYSq-0002tl-Cj
	for linuxppc-dev@lists.ozlabs.org; Tue, 02 Mar 2010 13:13:08 -0700
Received: from 174-23-157-249.slkc.qwest.net ([174.23.157.249]
	helo=[172.9.0.2])
	by in01.mta.xmission.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <jhansen@cardaccess-inc.com>)
	id 1NmYSo-0001mg-HR
	for linuxppc-dev@lists.ozlabs.org; Tue, 02 Mar 2010 13:13:08 -0700
Message-ID: <4B8D714F.8040904@cardaccess-inc.com>
Date: Tue, 02 Mar 2010 13:13:03 -0700
From: Jeff Hansen <jhansen@cardaccess-inc.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: OProfile on the MPC8313 / e300 core
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I am running 2.6.31.4 on an MPC8313 (e300/PPC6xx core) platform running 
OpenWRT.  I am getting non-recoverable exceptions in random functions 
shortly after I start profiling using OProfile (within a few minutes).  
The exception usually happens in cpu_idle, but not always.  The oops 
usually shows that exception 0xf00 (performance counter) precedes the 
non-recoverable condition.  Even if it doesn't show the 0xf00 exception 
in the stack trace, the following entry_32.S's _switch function always 
detects the non-recoverable condition (when this happens):

    andi.    r10,r9,MSR_RI        /* check for recoverable interrupt */

The MSR's RI bit is not set, and so the kernel assumes the worst.  I've 
tried disabling the above check as well, but other strange oopses still 
occur, so something is definitely wrong with the CPU.  If I leave things 
alone I *always* get a non-recoverable exception within a few minutes.

This only occurs under heavy interrupt load (I do a short packet ping 
flood from three hosts on the Ethernet).  I don't think trying 2.6.33 
will help because I haven't seen any bug-fixes related to 
oprofile/ppc/e300 since 2.6.31.  But of course if somebody thinks 2.6.33 
will help, I can try it out.  I've also tried powersave=off and 
idle=poll on the kernel command line, with the same results.

Does anyone have any ideas as to why this is happening?  Is it a bug in 
the PowerPC oprofile implementation?  Or a bug in the performance 
counter core in the MPC8313?  It's making it very hard to profile things 
under heavy load since it oopses so soon.

Here is one of the oopses with a GPL-only kernel with heavy load on the 
gianfar driver:

Non-recoverable exception at PC=c0186704 MSR=1000
Oops: nonrecoverable exception, sig: 9 [#1]
MPC831x RDB
Modules linked in: oprofile nf_nat_tftp nf_conntrack_tftp nf_nat_irc 
nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp ipt_MASQUERADE iptable_nat 
nf_nat xt_NOTRACK iptable_raw xt_state nf_conntrack_ipv4 nf_defrag_ipv4 
nf_conntrack ipt_REJECT xt_TCPMSS ipt_LOG xt_multiport xt_mac xt_limit 
iptable_mangle iptable_filter ip_tables xt_tcpudp x_tables nfs ppp_async 
ppp_generic slhc auth_rpcgss lockd sunrpc crc_ccitt netconsole ipv6
NIP: c0186704 LR: c01866f4 CTR: 00000000
REGS: c036dc80 TRAP: 0f00   Not tainted  (2.6.31.4)
MSR: 00001000 <ME>  CR: 84004022  XER: 00000000
TASK = c03433e8[0] 'swapper' THREAD: c036c000
GPR00: 00000089 c036dd30 c03433e8 c7844190 00000000 00000000 c72d2f9c 
c03716dc
GPR08: 00000000 c7844180 c720e880 c720e840 44004022 ffff8000 000000ff 
00000000
GPR16: c02ef210 0000000a c02ef1fc c02ef1e8 00000001 00000000 c783eb64 
c1661800
GPR24: c036c000 00000000 0000003f c72d2f00 c1661c48 c783e800 c783eae0 
c783eae0
NIP [c0186704] gfar_clean_rx_ring+0xe0/0x4ec
LR [c01866f4] gfar_clean_rx_ring+0xd0/0x4ec
Call Trace:
[c036dd30] [c01866f4] gfar_clean_rx_ring+0xd0/0x4ec (unreliable)
[c036dd80] [c0186dc8] gfar_poll+0x2b8/0x3b4
[c036ddd0] [c01dbf64] net_rx_action+0x11c/0x2d8
[c036de30] [c00332f0] __do_softirq+0x130/0x23c
[c036de90] [c000661c] do_softirq+0x40/0x58
[c036dea0] [c0032d74] irq_exit+0x38/0x48
[c036deb0] [c00066c0] do_IRQ+0x8c/0xac
[c036ded0] [c00120f0] ret_from_except+0x0/0x14
--- Exception: 501 at cpu_idle+0xc8/0xe0
    LR = cpu_idle+0xdc/0xe0
[c036dfb0] [c0003fc8] rest_init+0x5c/0x74
[c036dfc0] [c03187f8] start_kernel+0x2b0/0x2d0
[c036dff0] [00003440] 0x3440
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX 3aa00000 XXXXXXXX XXXXXXXX XXXXXXXX 4bfffe95
XXXXXXXX XXXXXXXX XXXXXXXX 34690010 XXXXXXXX XXXXXXXX XXXXXXXX 7fcb002e

And another oops with the proprietary modules I am working with:

Non-recoverable exception at PC=c0009724 MSR=1000
Oops: nonrecoverable exception, sig: 9 [#1]
MPC831x RDB
Modules linked in: oprofile ... nf_nat_tftp nf_conntrack_tftp nf_nat_irc 
nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp ipt_MASQUERADE iptable_nat 
nf_nat xt_NOTRACK iptable_raw xt_state nf_conntrack_ipv4 nf_defrag_ipv4 
nf_conntrack ipt_REJECT xt_TCPMSS ipt_LOG xt_multiport xt_mac xt_limit 
iptable_mangle iptable_filter ip_tables xt_tcpudp x_tables nfs ppp_async 
ppp_generic slhc auth_rpcgss lockd sunrpc floader crc_ccitt netconsole ipv6
NIP: c0009724 LR: c0009724 CTR: c000cd20
REGS: c036dee0 TRAP: 0f00   Tainted: P ...  (2.6.31.4)
MSR: 00001000 <ME>  CR: 24002028  XER: 20000000
TASK = c03433e8[0] 'swapper' THREAD: c036c000
GPR00: 00000000 c036df90 c03433e8 00800000 8090c000 00e00000 8a23c64a 
00049032
GPR08: 00000001 c036c000 24002022 c1796000 ae8b6fd7 ffff8000 07ffb000 
09fbc000
GPR16: 00000000 00000000 00000000 00000000 00000000 00000002 00000002 
00000001
GPR24: 00000000 003ab000 40100000 00000020 c037465c c037465c 00000008 
c036c03c
NIP [c0009724] cpu_idle+0xa0/0xe0
LR [c0009724] cpu_idle+0xa0/0xe0
Call Trace:
[c036df90] [c0009760] cpu_idle+0xdc/0xe0 (unreliable)
[c036dfb0] [c0003fc8] rest_init+0x5c/0x74
[c036dfc0] [c03187f8] start_kernel+0x2b0/0x2d0
[c036dff0] [00003440] 0x3440
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX 7c0000a6 XXXXXXXX XXXXXXXX XXXXXXXX 70090004
XXXXXXXX XXXXXXXX XXXXXXXX 4e800421 XXXXXXXX XXXXXXXX XXXXXXXX 7c00f828
Kernel panic - not syncing: Fatal exception
Call Trace:
[c036de30] [c0008764] show_stack+0x78/0x1a4 (unreliable)
[c036de60] [c0258adc] panic+0x98/0x174
[c036deb0] [c000f748] die+0x15c/0x168
[c036ded0] [c0012330] nonrecoverable+0xa4/0xa8
--- Exception: f00 at cpu_idle+0xa0/0xe0
    LR = cpu_idle+0xa0/0xe0
[c036df90] [c0009760] cpu_idle+0xdc/0xe0 (unreliable)
[c036dfb0] [c0003fc8] rest_init+0x5c/0x74
[c036dfc0] [c03187f8] start_kernel+0x2b0/0x2d0
[c036dff0] [00003440] 0x3440
Rebooting in 3 seconds..

-Jeff
