Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FF1C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 03:22:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D51E82082A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 03:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51E82082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vqYT5M1hzF3QD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 14:22:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmx.us
 (client-ip=212.227.17.21; helo=mout.gmx.net; envelope-from=cai@gmx.us;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.us
X-Greylist: delayed 316 seconds by postgrey-1.36 at bilbo;
 Wed, 14 Nov 2018 14:03:41 AEDT
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vq7x1jRmzDrPj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 14:03:40 +1100 (AEDT)
Received: from [192.168.1.153] ([74.104.183.64]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MhMg2-1g967H0bVy-00Maqt; Wed, 14
 Nov 2018 03:58:09 +0100
From: Qian Cai <cai@gmx.us>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Unable to handle kernel paging request for data at address
 0xc000000001da0000
Message-Id: <B26EE8AA-96E9-4E15-B0BF-751F455C883E@gmx.us>
Date: Tue, 13 Nov 2018 21:58:06 -0500
To: linux kernel <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.100.39)
X-Provags-ID: V03:K1:Dw3ZBUp5ClTy6bqRi/fJQB9Ozue3oFEZpOBq7Khhhq7yzLp+6ZY
 TOM7y09d9tWTGXH3U1sfyg6DqoybZ35f7kfzxpOiPMyl06seF8bGyq20cT+duNOItmR+8Kh
 ZMKKvv/eMW34UYhKji5GsWeZC8LcwazBSsnveRQKYs/rka/dihW3/JVKRN+lsrL2El2q2vp
 IS6gTOg7mYmlFJ+RN91aQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sI4Pdd1MzIQ=:ijhYJrciHjYbMVb3g6LpKv
 drBOgZiUwbEaC/K6SEl92XAR4FjrY2X9JRDsySm0fZKmVwf4RTtB+wxLcuMCIrvGoszb7AY+n
 HgaAU1KLCtJhv/Hd8HQ90BcTiCSrqqEOjS2Wn9ugom+MmEFpBsAkTQEB6PjZX4/jhCqGvLsjT
 gQE8PH2Km42/6DFlg1VkmNfyHipAr1kEI8XkC4dW9ZBMoEJmAiTWYc+JGitpdhJ40HmkH6uIo
 vZ3ebkW6JUPXCNW4IK/45DgcWIpgd1VqXLyzbulF7ajWBSaSfFe6Zbak/dHdjp+nE1MA2cRpM
 XhnDHLD8ns/qWTC+uNlln7WnGsV+KuaLhExoKDa24eg1c0T2J2pSpGKh2k2sIZ0yaC6kWTp+O
 5W+DNpPU3mXph19FIEGfdvjqvejtu2aGfFPkEnA+EdLR+USAGdQg52yrWHf/srmCvBqfSkpln
 jdVk5TJYoU1dDpxaCg+bMkD/FHXARD+re2KsQfJjPTyXnWkxa+VoneQyvrSAOvL5oUQSaEo0r
 0zyvJONUGgjjHDdv50kV/4d/E456ao+jmgE0OT68jXIPR/btTOkgu97QUIZXr/f53i7aGuWLJ
 OKeoIGkug0bZZCsR9eZo6qAkQGXVZ239WaA+tXKMSbg90EOUsjyMKFt9n3TZWBC++qtV/OA5I
 Bazp9ISrjMHXJAWVV0VTaAO31IPISkPMQzy+9ohnIJnx5QUBYSrxmC3GahijlexB/pTBcobH3
 uiQ+Qoi8YgpgM3l4kBAioEVYIHsOlF6H08a/6vkMg4FfZ47yaLcPW13nm//cBJgOY2BcasyKR
 /VXV6se7yeBDLgyQC9MnxYZmKRUu+pBlwBvgZzKwlVSve9Iat0fzpnts/cKAKRNBwYPd9zAuP
 PPzKdM7XjBvyyqpldXQ7WqTfgo1ArzT3Jv4b1+wiR4/UGpIUg/s34pJ+BTI/s4
X-Mailman-Approved-At: Wed, 14 Nov 2018 14:20:32 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: catalin Marinas <catalin.marinas@arm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Running some container workloads on an IBM power9 server with the latest =
mainline (rc2) triggered this,

[ 1283.894167] Unable to handle kernel paging request for data at =
address 0xc000000001da0000
[ 1283.894215] Faulting instruction address: 0xc000000000487ab8
[ 1283.894223] Oops: Kernel access of bad area, sig: 11 [#1]
[ 1283.894227] LE SMP NR_CPUS=3D2048 DEBUG_PAGEALLOC NUMA pSeries
[ 1283.894235] Modules linked in: nf_conntrack_netlink xt_mark tun =
udp_diag tcp_diag inet_diag netlink_diag af_packet_diag unix_diag =
nft_chain_nat_ipv6 nf_nat_ipv6 xt_conntrack ipt_MASQUERADE nft_counter =
xt_comment nft_compat nft_chain_nat_ipv4 nf_nat_ipv4 nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 nf_tables veth bridge stp llc nfnetlink =
overlay sg pseries_rng xfs libcrc32c sd_mod ibmvscsi ibmveth =
scsi_transport_srp dm_mirror dm_region_hash dm_log dm_mod
[ 1283.894275] CPU: 0 PID: 226 Comm: kmemleak Kdump: loaded Not tainted =
4.20.0-rc2+ #1
[ 1283.894281] NIP:  c000000000487ab8 LR: c000000000487ab0 CTR: =
0000000000000000
[ 1283.894287] REGS: c0000005e94f3970 TRAP: 0300   Not tainted  =
(4.20.0-rc2+)
[ 1283.894291] MSR:  800000010280b033 =
<SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 24000822  XER: 00000000
[ 1283.894302] CFAR: c000000000487a04 DAR: c000000001da0000 DSISR: =
40000000 IRQMASK: 1=20
GPR00: c000000000487ab0 c0000005e94f3bf8 c000000001c93400 =
0000000000000000=20
GPR04: c0000005d9380a90 0000000000000001 00000000e7d83172 =
c0000005d9380a90=20
GPR08: 0000000078811199 c0000005f1665ac8 c0000005d9380080 =
fffffffffce6b398=20
GPR12: 0000000000000000 c000000002de0000 c0000000001717b8 =
c0000005efa49ab8=20
GPR16: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
GPR20: 0000000000000000 0000000000000000 0000000000000000 =
c000000001b85220=20
GPR24: c00000046a1d8848 c00000046a1d1b88 0000000000000000 =
0000000000000000=20
GPR28: c000000001da0ff9 c000000000f3b620 c000000001b85108 =
c000000001da0000=20
[ 1283.894352] NIP [c000000000487ab8] scan_block+0xa8/0x190
[ 1283.894357] LR [c000000000487ab0] scan_block+0xa0/0x190
[ 1283.894361] Call Trace:
[ 1283.894365] [c0000005e94f3bf8] [c000000000487ab0] =
scan_block+0xa0/0x190 (unreliable)
[ 1283.894372] [c0000005e94f3c58] [c000000000487c00] =
scan_large_block+0x60/0xa0
[ 1283.894378] [c0000005e94f3c98] [c00000000048857c] =
kmemleak_scan+0x24c/0xa10
[ 1283.894384] [c0000005e94f3d48] [c000000000489960] =
kmemleak_scan_thread+0xec/0x12c
[ 1283.894391] [c0000005e94f3db8] [c00000000017196c] kthread+0x1bc/0x1d0
[ 1283.894397] [c0000005e94f3e28] [c00000000000b860] =
ret_from_kernel_thread+0x5c/0x7c
[ 1283.894402] Instruction dump:
[ 1283.894408] 7fa3eb78 4883847d 60000000 60000000 60000000 60000000 =
3bff0008 7fbcf840=20
[ 1283.894416] 409d00b8 4bfffeed 2fa30000 409e00ac <e87f0000> e93e0108 =
7fa91840 419dffdc=20
[ 1283.894425] ---[ end trace 8e9576ac10ae13a1 ]---
[ 1283.897274]=20
[ 1283.897288] Sending IPI to other CPUs
[ 1285.021354] IPI complete
[ 1285.042568] kexec: Starting switchover sequence.=
