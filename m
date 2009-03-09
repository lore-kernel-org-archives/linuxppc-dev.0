Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 32EBCDDFEC
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Mar 2009 18:47:05 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LgaCU-0001im-6k
	for linuxppc-dev@ozlabs.org; Mon, 09 Mar 2009 00:47:02 -0700
Message-ID: <22408005.post@talk.nabble.com>
Date: Mon, 9 Mar 2009 00:47:02 -0700 (PDT)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@ozlabs.org
Subject: Machine check in 4xx ethernet driver
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

I'm getting machine check exception when trying to dump
emac registers on 405EX Kilauea board. The kernel is 2.6.29-rc7
The problem seems not new, I can reproduce it on 2.6.25 Denx kernel

-bash-3.2# ethtool -d eth0
Data machine check in kernel mode.
Oops: Machine check, sig: 7 [#1]
Kilauea
Modules linked in:
NIP: c000e240 LR: c0158358 CTR: 00000004
REGS: cfffdf50 TRAP: 0202   Not tainted  (2.6.29-rc7)
MSR: 00029030 <EE,ME,CE,IR,DR>  CR: 22002044  XER: 2000005f
TASK = cfa79740[1011] 'ethtool' THREAD: cfa82000
GPR00: 00000001 cfa83d10 cfa79740 cf8d7a34 d105696c 00000004 cfa83d40
00000000
GPR08: 00000000 0000001b 00000004 00000004 22002022 1005f4d0 10010000
1000d9c4
GPR16: 1000d9bc 1000d9b4 1000fbec 10057650 100118a4 10010000 1000da10
100570ec
GPR24: bf90f790 00000000 cfa83d38 cf8d7800 10058008 cf8d7800 cf8d79c0
cf811360
NIP [c000e240] _memcpy_fromio+0x9c/0xc4
LR [c0158358] emac_ethtool_get_regs+0x68/0xc4
Call Trace:
[cfa83d10] [c015831c] emac_ethtool_get_regs+0x2c/0xc4 (unreliable)
[cfa83d30] [c017ed00] ethtool_get_regs+0xf8/0x1f8
[cfa83d60] [c018036c] dev_ethtool+0x10f4/0x13ac
[cfa83df0] [c017d7dc] dev_ioctl+0x430/0x700
[cfa83e70] [c016ad80] sock_ioctl+0x80/0x2ec
[cfa83e90] [c0088104] vfs_ioctl+0x34/0x98
[cfa83ea0] [c0088550] do_vfs_ioctl+0x3c0/0x734
[cfa83f10] [c0088904] sys_ioctl+0x40/0x74
[cfa83f40] [c000eb60] ret_from_syscall+0x0/0x3c
Instruction dump:
419c004c 80040000 90030000 7c0006ac 38840004 38630004 38a5fffc 4200ffe8
2f050000 41baffb4 7ca903a6 88040000 <98030000> 7c0006ac 38840001 38630001
---[ end trace 075752cbf5bce2a1 ]---
Bus error

Felix.
-- 
View this message in context: http://www.nabble.com/Machine-check-in-4xx-ethernet-driver-tp22408005p22408005.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
