Return-Path: <SRS0=+pA4=RK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4938C4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 08:11:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D141020835
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 08:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D141020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44FNd871NnzDqGP
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 19:11:40 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44FNZx3mc8zDqCK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2019 19:09:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44FNZx2PBGz8t1q
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2019 19:09:45 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44FNZx1z45z9sMx; Thu,  7 Mar 2019 19:09:45 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sachinp@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44FNZw1Rbjz9sD4
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Mar 2019 19:09:43 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2789PJW056493
 for <linuxppc-dev@ozlabs.org>; Thu, 7 Mar 2019 03:09:40 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2r2w1kehx5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 07 Mar 2019 03:09:39 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sachinp@linux.vnet.ibm.com>;
 Thu, 7 Mar 2019 08:09:37 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 7 Mar 2019 08:09:34 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2789Xe433488974
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 Mar 2019 08:09:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D24E4C046;
 Thu,  7 Mar 2019 08:09:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 056F04C04A;
 Thu,  7 Mar 2019 08:09:32 +0000 (GMT)
Received: from sachins-mbp.in.ibm.com (unknown [9.124.35.94])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  7 Mar 2019 08:09:31 +0000 (GMT)
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_0C8C18F8-D6FA-40D6-9315-ADA61B2EC4A5"
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [5.0.0-next-20190306] [powerpc] kernel BUG at mm/page_alloc.c:3124
 while running stress
Date: Thu, 7 Mar 2019 13:39:30 +0530
To: linux-next@vger.kernel.org, linuxppc-dev@ozlabs.org
X-Mailer: Apple Mail (2.3445.102.3)
X-TM-AS-GCONF: 00
x-cbid: 19030708-0020-0000-0000-0000031FA777
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030708-0021-0000-0000-00002171B9D1
Message-Id: <E23E2FBC-499A-4FD2-91A9-A559526EF892@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-07_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903070060
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--Apple-Mail=_0C8C18F8-D6FA-40D6-9315-ADA61B2EC4A5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

While running stress test from avocado-misc-test against next-20190306 =
(SHA: cf08baa296)
on a POWER9 LPAR ran into following kernel bug followed by panic.
next-20190305 was good.

 (1/1) avocado-misc-tests/perf/stress.py:Stress.test:  [  947.743425] =
request_module: kmod_concurrent_max (0) close to 0 (max_modprobes: 50), =
for module net-pf-2-proto-33-type-6, throttling...
[ 2873.201865] ------------[ cut here ]------------
[ 2873.201907] kernel BUG at mm/page_alloc.c:3124!
[ 2873.201918] Oops: Exception in kernel mode, sig: 5 [#1]
[ 2873.201928] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA =
pSeries
[ 2873.201950] Dumping ftrace buffer:
[ 2873.201997]    (ftrace buffer empty)
[ 2873.202005] Modules linked in: unix_diag ip6t_rpfilter ipt_REJECT =
nf_reject_ipv4 ip6t_REJECT nf_reject_ipv6 xt_conntrack ip_set nfnetlink =
ebtable_nat ebtable_broute bridge stp llc ip6table_nat ip6table_mangle =
ip6table_raw iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 =
nf_defrag_ipv4 libcrc32c iptable_mangle iptable_raw ebtable_filter =
ebtables ip6table_filter ip6_tables iptable_filter sunrpc sg =
uio_pdrv_genirq uio pseries_rng ip_tables ext4 mbcache jbd2 sr_mod cdrom =
sd_mod ibmvscsi scsi_transport_srp ibmveth dm_mirror dm_region_hash =
dm_log dm_mod
[ 2873.202108] CPU: 17 PID: 180 Comm: kcompactd1 Not tainted =
5.0.0-next-20190306-autotest #1
[ 2873.202119] NIP:  c000000000327320 LR: c0000000002f1c10 CTR: =
c0000000002f1840
[ 2873.202131] REGS: c000000458eeb640 TRAP: 0700   Not tainted  =
(5.0.0-next-20190306-autotest)
[ 2873.202140] MSR:  8000000102029033 <SF,VEC,EE,ME,IR,DR,RI,LE,TM[E]>  =
CR: 24882088  XER: 20040000
[ 2873.202161] CFAR: c0000000002f1c0c IRQMASK: 1=20
[ 2873.202161] GPR00: c0000000002f1c10 c000000458eeb8d0 c0000000012b9500 =
c0000008bff1cb58=20
[ 2873.202161] GPR04: 0000000000000005 0000000000000308 c0000008bff1cc98 =
0000000000000780=20
[ 2873.202161] GPR08: c000000001478220 0000000000000001 0000000000000000 =
0000000000000000=20
[ 2873.202161] GPR12: 0000000024884082 c00000001ec54280 000000000006fd50 =
0000000000069b00=20
[ 2873.202161] GPR16: 000000000007ad00 0000000000000035 ff40000022ffc700 =
0000000000000040=20
[ 2873.202161] GPR20: c0000008bff1cc88 c0000008bff1cb58 0000000000000000 =
0000000000000000=20
[ 2873.202161] GPR24: 0000000000000001 0000000000000000 0000000000000000 =
0000000000000005=20
[ 2873.202161] GPR28: c0000008bff1c980 0000000000000000 0000000000000001 =
c0000008bff1cb58=20
[ 2873.202251] NIP [c000000000327320] __isolate_free_page+0x90/0x2c0
[ 2873.202263] LR [c0000000002f1c10] compaction_alloc+0x3d0/0xae0
[ 2873.202271] Call Trace:
[ 2873.202280] [c000000458eeb8d0] [f0000000011d9800] 0xf0000000011d9800 =
(unreliable)
[ 2873.202293] [c000000458eeb940] [c0000000002f1c10] =
compaction_alloc+0x3d0/0xae0
[ 2873.202305] [c000000458eeba20] [c00000000036cd5c] =
unmap_and_move+0x7c/0x9a0
[ 2873.202315] [c000000458eeba90] [c00000000036ef14] =
migrate_pages+0x224/0x870
[ 2873.202326] [c000000458eebb60] [c0000000002f3c9c] =
compact_zone+0x3ac/0x1020
[ 2873.202336] [c000000458eebc60] [c0000000002f4de8] =
kcompactd_do_work+0x188/0x350
[ 2873.202347] [c000000458eebd40] [c0000000002f5068] =
kcompactd+0xb8/0x2a0
[ 2873.202359] [c000000458eebdb0] [c0000000001429d0] kthread+0x160/0x1a0
[ 2873.202371] [c000000458eebe20] [c00000000000b64c] =
ret_from_kernel_thread+0x5c/0x70
[ 2873.202380] Instruction dump:
[ 2873.202388] 3d02001c 3908ed20 78e71f24 794a57a0 6d29f000 1f4a0680 =
7d290034 7f28382a=20
[ 2873.202401] 5529d97e 79290020 7fb9d214 69290001 <0b090000> 3fc2001b =
3bde92b8 38a00002=20
[ 2873.202418] ---[ end trace 65562a20cc8f8bc8 ]=E2=80=94

Have attached the console logs.

Thanks
-Sachin


--Apple-Mail=_0C8C18F8-D6FA-40D6-9315-ADA61B2EC4A5
Content-Disposition: attachment;
	filename=next-20190306.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="next-20190306.txt"
Content-Transfer-Encoding: quoted-printable

05:05:15 18:35:15 INFO | --- END kernel.build ---
05:05:15 18:35:15 INFO | 		GOOD	build	kernel.build	=
timestamp=3D1551915315	localtime=3DMar 06 18:35:15=09
05:05:15 18:35:15 INFO | TEST: install kernel
05:05:15 18:35:15 INFO | --- START kernel.install ---
05:05:26 18:35:26 INFO | --- START kernel.mkinitrd ---
05:05:26 18:35:26 ERROR| No directory 5.0.0-autotest found under =
/lib/modules. Initramfscreation will most likely fail and your new =
kernelwill fail to build
05:05:27 18:35:27 ERROR| [stderr] Kernel version 5.0.0-autotest has no =
module directory /lib/modules/5.0.0-autotest
05:05:57 18:35:57 INFO | --- END kernel.mkinitrd ---
05:06:03 18:36:03 INFO | 		GOOD	build	kernel.mkinitrd	=
timestamp=3D1551915357	localtime=3DMar 06 18:35:57=09
05:06:03 18:36:03 INFO | --- END kernel.install ---
05:06:03 18:36:03 INFO | 		GOOD	build	kernel.install	=
timestamp=3D1551915363	localtime=3DMar 06 18:36:03=09
05:06:03 18:36:03 INFO | 	END GOOD	----	kernel_build	=
timestamp=3D1551915363	localtime=3DMar 06 18:36:03=09
05:06:03 18:36:03 INFO | TEST: installing and booting the kernel
05:06:20 18:36:03 INFO | 	START	build	reboot	=
timestamp=3D1551915363	localtime=3DMar 06 18:36:03=09
05:06:20 18:36:03 INFO | 		GOOD	build	reboot.start	=
timestamp=3D1551915363	localtime=3DMar 06 18:36:03=09
05:06:20 18:36:04 INFO | --- STRIPPING VMLINUX AND INITRD ---
05:06:20 18:36:09 INFO | --- START kernel.mkinitrd ---
05:06:20 18:36:09 INFO | Existing /boot/initrd-autotest file, will =
remove it.
05:06:32 18:36:32 INFO | --- END kernel.mkinitrd ---
05:06:32 18:36:32 INFO | 		GOOD	build	kernel.mkinitrd	=
timestamp=3D1551915392	localtime=3DMar 06 18:36:32=09
05:06:32 18:36:32 ERROR| [stderr] Modified cmdline:rw =
****=3D/dev/mapper/rhel_ltc--zzci--2-****=20
05:06:33 [ 1147.230422] kexec_core: Starting new kernel
05:06:33=20

05:06:33 =07Message from syslogd@ltc-zzci-2 at Mar  6 18:36:33 ...

05:06:33  kernel:kexec_core: Starting new kernel
05:06:33=20
[ 1147.250504] kexec: waiting for cpu 28 (physical 28) to enter 1 state
05:06:33 [ 1147.250537] kexec: waiting for cpu 1 (physical 1) to enter 2 =
state
05:06:33 [ 1147.251453] kexec: waiting for cpu 5 (physical 5) to enter 2 =
state
05:06:33 [ 1147.251529] kexec: waiting for cpu 25 (physical 25) to enter =
2 state
05:06:33 [ 1147.251662] kexec: waiting for cpu 27 (physical 27) to enter =
2 state
05:06:33 [ 1147.251730] kexec: Starting switchover sequence.
05:06:34 I'm in purgatory
05:06:35 [    0.000000] hash-mmu: Page sizes from device-tree:
05:06:35 [    0.000000] hash-mmu: base_shift=3D12: shift=3D12, =
sllp=3D0x0000, avpnm=3D0x00000000, tlbiel=3D1, penc=3D0
05:06:35 [    0.000000] hash-mmu: base_shift=3D12: shift=3D16, =
sllp=3D0x0000, avpnm=3D0x00000000, tlbiel=3D1, penc=3D7
05:06:35 [    0.000000] hash-mmu: base_shift=3D12: shift=3D24, =
sllp=3D0x0000, avpnm=3D0x00000000, tlbiel=3D1, penc=3D56
05:06:35 [    0.000000] hash-mmu: base_shift=3D16: shift=3D16, =
sllp=3D0x0110, avpnm=3D0x00000000, tlbiel=3D1, penc=3D1
05:06:35 [    0.000000] hash-mmu: base_shift=3D16: shift=3D24, =
sllp=3D0x0110, avpnm=3D0x00000000, tlbiel=3D1, penc=3D8
05:06:35 [    0.000000] hash-mmu: base_shift=3D24: shift=3D24, =
sllp=3D0x0100, avpnm=3D0x00000001, tlbiel=3D0, penc=3D0
05:06:35 [    0.000000] hash-mmu: base_shift=3D34: shift=3D34, =
sllp=3D0x0120, avpnm=3D0x000007ff, tlbiel=3D0, penc=3D3
05:06:35 [    0.000000] Using 1TB segments
05:06:35 [    0.000000] hash-mmu: Initializing hash mmu with SLB
05:06:35 [    0.000000] Linux version 5.0.0-next-20190306-autotest =
(****@ltc-zzci-2.aus.stglabs.ibm.com) (gcc version 4.8.5 20150623 (Red =
Hat 4.8.5-28) (GCC)) #1 SMP Wed Mar 6 18:27:07 EST 2019
05:06:35 [    0.000000] Found initrd at =
0xc000000002ff0000:0xc00000000443c217
05:06:35 [    0.000000] Using pSeries machine description
05:06:35 [    0.000000] printk: bootconsole [udbg0] enabled
05:06:35 [    0.000000] Partition configured for 32 cpus.
05:06:35 [    0.000000] CPU maps initialized for 8 threads per core
05:06:35 [    0.000000] =
-----------------------------------------------------
05:06:35 [    0.000000] ppc64_pft_size    =3D 0x1c
05:06:35 [    0.000000] phys_mem_size     =3D 0x8c0000000
05:06:35 [    0.000000] dcache_bsize      =3D 0x80
05:06:35 [    0.000000] icache_bsize      =3D 0x80
05:06:35 [    0.000000] cpu_features      =3D 0x0000c07f8f5f91a7
05:06:35 [    0.000000]   possible        =3D 0x0000fbffcf5fb1a7
05:06:35 [    0.000000]   always          =3D 0x00000003800081a1
05:06:35 [    0.000000] cpu_user_features =3D 0xdc0065c2 0xefe00000
05:06:35 [    0.000000] mmu_features      =3D 0x7c006001
05:06:35 [    0.000000] firmware_features =3D 0x00000013c45bfc57
05:06:35 [    0.000000] htab_hash_mask    =3D 0x1fffff
05:06:35 [    0.000000] =
-----------------------------------------------------
05:06:35 [    0.000000] numa:   NODE_DATA [mem 0x45ff78980-0x45ff7ffff]
05:06:35 [    0.000000] numa:   NODE_DATA [mem 0x8bff1c980-0x8bff23fff]
05:06:35 [    0.000000] rfi-flush: fallback displacement flush available
05:06:35 [    0.000000] rfi-flush: mttrig type flush available
05:06:35 [    0.000000] count-cache-flush: full software flush sequence =
enabled.
05:06:35 [    0.000000] stf-barrier: eieio barrier available
05:06:35 [    0.000000] PPC64 nvram contains 15360 bytes
05:06:35 [    0.000000] barrier-nospec: using ORI speculation barrier
05:06:35 [    0.000000] Zone ranges:
05:06:35 [    0.000000]   Normal   [mem =
0x0000000000000000-0x00000008bfffffff]
05:06:35 [    0.000000]   Device   empty
05:06:35 [    0.000000] Movable zone start for each node
05:06:35 [    0.000000] Early memory node ranges
05:06:35 [    0.000000]   node   0: [mem =
0x0000000000000000-0x000000045fffffff]
05:06:35 [    0.000000]   node   1: [mem =
0x0000000460000000-0x00000008bfffffff]
05:06:35 [    0.000000] Initmem setup node 0 [mem =
0x0000000000000000-0x000000045fffffff]
05:06:35 [    0.000000] Initmem setup node 1 [mem =
0x0000000460000000-0x00000008bfffffff]
05:06:35 [    0.000000] random: get_random_u64 called from =
start_kernel+0xc0/0x670 with crng_init=3D0
05:06:35 [    0.000000] percpu: Embedded 4 pages/cpu @(____ptrval____) =
s168728 r0 d93416 u262144
05:06:35 [    0.000000] Built 2 zonelists, mobility grouping on.  Total =
pages: 572880
05:06:35 [    0.000000] Policy zone: Normal
05:06:35 [    0.000000] Kernel command line: rw =
****=3D/dev/mapper/rhel_ltc--zzci--2-****=20
05:06:35 [    0.000000] Memory: 36574912K/36700160K available (10496K =
kernel code, 1600K rwdata, 3264K rodata, 4160K init, 3802K bss, 125248K =
reserved, 0K cma-reserved)
05:06:35 [    0.000000] SLUB: HWalign=3D128, Order=3D0-3, MinObjects=3D0, =
CPUs=3D32, Nodes=3D32
05:06:35 [    0.000000] ftrace: allocating 28452 entries in 11 pages
05:06:35 [    0.000000] rcu: Hierarchical RCU implementation.
05:06:35 [    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=3D2048 =
to nr_cpu_ids=3D32.
05:06:35 [    0.000000] rcu: RCU calculated value of =
scheduler-enlistment delay is 10 jiffies.
05:06:35 [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, =
nr_cpu_ids=3D32
05:06:35 [    0.000000] NR_IRQS: 512, nr_irqs: 512, preallocated irqs: =
16
05:06:35 [    0.000000] rcu: 	Offload RCU callbacks from CPUs: (none).
05:06:35 [    0.000002] time_init: 56 bit decrementer (max: =
7fffffffffffff)
05:06:35 [    0.000066] clocksource: timebase: mask: 0xffffffffffffffff =
max_cycles: 0x761537d007, max_idle_ns: 440795202126 ns
05:06:35 [    0.000175] clocksource: timebase mult[1f40000] shift[24] =
registered
05:06:35 [    0.000295] Console: colour dummy device 80x25
05:06:35 [    0.000345] printk: console [hvc0] enabled
05:06:35 [    0.000345] printk: console [hvc0] enabled
05:06:35 [    0.000392] printk: bootconsole [udbg0] disabled
05:06:35 [    0.000392] printk: bootconsole [udbg0] disabled
05:06:35 [    0.000570] mempolicy: Enabling automatic NUMA balancing. =
Configure with numa_balancing=3D or the kernel.numa_balancing sysctl
05:06:35 [    0.000584] pid_max: default: 32768 minimum: 301
05:06:35 [    0.006136] Dentry cache hash table entries: 8388608 (order: =
10, 67108864 bytes)
05:06:35 [    0.008222] Inode-cache hash table entries: 4194304 (order: =
9, 33554432 bytes)
05:06:35 [    0.008411] Mount-cache hash table entries: 131072 (order: =
4, 1048576 bytes)
05:06:35 [    0.008482] Mountpoint-cache hash table entries: 131072 =
(order: 4, 1048576 bytes)
05:06:35 [    0.009378] *** VALIDATE proc ***
05:06:35 [    0.009517] *** VALIDATE cgroup1 ***
05:06:35 [    0.009522] *** VALIDATE cgroup2 ***
05:06:35 [    0.010360] EEH: pSeries platform initialized
05:06:35 [    0.010368] POWER9 performance monitor hardware support =
registered
05:06:35 [    0.010408] rcu: Hierarchical SRCU implementation.
05:06:35 [    0.011190] smp: Bringing up secondary CPUs ...
05:06:35 [    0.020149] smp: Brought up 2 nodes, 32 CPUs
05:06:35 [    0.020157] numa: Node 0 CPUs: 0-15
05:06:35 [    0.020161] numa: Node 1 CPUs: 16-31
05:06:35 [    0.020165] Using small cores at SMT level
05:06:35 [    0.020168] Using shared cache scheduler topology
05:06:35 [    0.024002] devtmpfs: initialized
05:06:35 [    0.027419] clocksource: jiffies: mask: 0xffffffff =
max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
05:06:35 [    0.027437] futex hash table entries: 8192 (order: 4, =
1048576 bytes)
05:06:35 [    0.028384] NET: Registered protocol family 16
05:06:35 [    0.028593] audit: initializing netlink subsys (disabled)
05:06:35 [    0.028644] audit: type=3D2000 audit(1551915396.020:1): =
state=3Dinitialized audit_enabled=3D0 res=3D1
05:06:35 [    0.028755] cpuidle: using governor menu
05:06:35 [    0.028952] pstore: Registered nvram as persistent store =
backend
05:06:35 [    0.034866] PCI: Probing PCI hardware
05:06:35 [    0.034871] EEH: No capable adapters found
05:06:35 [    0.034965] pseries-rng: Registering arch random hook.
05:06:35 [    0.036260] HugeTLB registered 16.0 MiB page size, =
pre-allocated 0 pages
05:06:35 [    0.036266] HugeTLB registered 16.0 GiB page size, =
pre-allocated 0 pages
05:06:35 [    0.037546] vgaarb: loaded
05:06:35 [    0.037707] SCSI subsystem initialized
05:06:35 [    0.037744] usbcore: registered new interface driver usbfs
05:06:35 [    0.037754] usbcore: registered new interface driver hub
05:06:35 [    0.037923] usbcore: registered new device driver usb
05:06:35 [    0.038153] EDAC MC: Ver: 3.0.0
05:06:35 [    0.038521] clocksource: Switched to clocksource timebase
05:06:35 [    0.050832] VFS: Disk quotas dquot_6.6.0
05:06:35 [    0.050949] VFS: Dquot-cache hash table entries: 8192 (order =
0, 65536 bytes)
05:06:35 [    0.051049] *** VALIDATE hugetlbfs ***
05:06:35 [    0.053807] NET: Registered protocol family 2
05:06:35 [    0.054027] tcp_listen_portaddr_hash hash table entries: =
32768 (order: 3, 524288 bytes)
05:06:35 [    0.054103] TCP established hash table entries: 524288 =
(order: 6, 4194304 bytes)
05:06:35 [    0.054995] TCP bind hash table entries: 65536 (order: 4, =
1048576 bytes)
05:06:35 [    0.055144] TCP: Hash tables configured (established 524288 =
bind 65536)
05:06:35 [    0.055187] UDP hash table entries: 32768 (order: 4, 1048576 =
bytes)
05:06:35 [    0.055318] UDP-Lite hash table entries: 32768 (order: 4, =
1048576 bytes)
05:06:35 [    0.055571] NET: Registered protocol family 1
05:06:35 [    0.055608] Unpacking initramfs...
05:06:35 [    0.345059] Freeing initrd memory: 20736K
05:06:35 [    0.345220] numa: Starting topology update prrn_enabled
05:06:35 [    0.347835] IOMMU table initialized, virtual merging enabled
05:06:35 [    0.368814] hv-24x7: read 1530 catalog entries, created 537 =
event attrs (0 failures), 275 descs
05:06:35 [    0.370557] workingset: timestamp_bits=3D38 max_order=3D20 =
bucket_order=3D0
05:06:35 [    0.371779] zbud: loaded
05:06:36 [    0.642526] alg: No test for lzo-rle (lzo-rle-generic)
05:06:36 [    0.643348] alg: No test for lzo-rle (lzo-rle-scomp)
05:06:36 [    0.671029] NET: Registered protocol family 38
05:06:36 [    0.671038] Key type asymmetric registered
05:06:36 [    0.671041] Asymmetric key parser 'x509' registered
05:06:36 [    0.671059] Block layer SCSI generic (bsg) driver version =
0.4 loaded (major 248)
05:06:36 [    0.671188] io scheduler mq-deadline registered
05:06:36 [    0.671193] io scheduler kyber registered
05:06:36 [    0.671857] atomic64_test: passed
05:06:36 [    0.671898] PowerPC PowerNV PCI Hotplug Driver version: 0.1
05:06:36 [    0.672288] Serial: 8250/16550 driver, 4 ports, IRQ sharing =
enabled
05:06:36 [    0.672560] Non-volatile memory driver v1.3
05:06:36 [    0.672593] Linux agpgart interface v0.103
05:06:39 [    3.998540] random: fast init done
05:06:41 [    6.308674] tpm_ibmvtpm 30000003: CRQ initialization =
completed
05:06:41 [    6.308685] tpm_ibmvtpm 30000003: ibmvtpm device is not =
ready
05:06:41 [    6.308688] tpm_ibmvtpm 30000003: ibmvtpm device is not =
ready
05:06:41 [    6.308904] rdac: device handler registered
05:06:41 [    6.308953] hp_sw: device handler registered
05:06:41 [    6.308957] emc: device handler registered
05:06:41 [    6.309083] alua: device handler registered
05:06:41 [    6.309119] libphy: Fixed MDIO Bus: probed
05:06:41 [    6.309169] ehci_hcd: USB 2.0 'Enhanced' Host Controller =
(EHCI) Driver
05:06:41 [    6.309180] ehci-pci: EHCI PCI platform driver
05:06:41 [    6.309188] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) =
Driver
05:06:41 [    6.309198] ohci-pci: OHCI PCI platform driver
05:06:41 [    6.309206] uhci_hcd: USB Universal Host Controller =
Interface driver
05:06:41 [    6.309239] usbcore: registered new interface driver =
usbserial_generic
05:06:41 [    6.309248] usbserial: USB Serial support registered for =
generic
05:06:41 [    6.309313] mousedev: PS/2 mouse device common for all mice
05:06:41 [    6.309406] rtc-generic rtc-generic: registered as rtc0
05:06:41 [    6.309759] nx_compress_pseries ibm,compression-v1: =
nx842_OF_upd: max_sync_size new:65536 old:0
05:06:41 [    6.309768] nx_compress_pseries ibm,compression-v1: =
nx842_OF_upd: max_sync_sg new:510 old:0
05:06:41 [    6.309774] nx_compress_pseries ibm,compression-v1: =
nx842_OF_upd: max_sg_len new:4080 old:0
05:06:41 [    6.309845] alg: No test for 842 (842-nx)
05:06:41 [    6.310956] hidraw: raw HID events driver (C) Jiri Kosina
05:06:41 [    6.311050] usbcore: registered new interface driver usbhid
05:06:41 [    6.311054] usbhid: USB HID core driver
05:06:41 [    6.311167] drop_monitor: Initializing network drop monitor =
service
05:06:41 [    6.311266] Initializing XFRM netlink socket
05:06:41 [    6.311853] NET: Registered protocol family 10
05:06:41 [    6.312286] Segment Routing with IPv6
05:06:41 [    6.312309] NET: Registered protocol family 17
05:06:41 [    6.312595] registered taskstats version 1
05:06:41 [    6.312635] zswap: loaded using pool lzo/zbud
05:06:41 [    6.312692] pstore: Using crash dump compression: deflate
05:06:41 [    6.316152] Key type big_key registered
05:06:41 [    6.316366] rtc-generic rtc-generic: setting system clock to =
2019-03-06T23:36:42 UTC (1551915402)
05:06:41 [    6.317457] Freeing unused kernel memory: 4160K
05:06:41 [    6.317462] This architecture does not have kernel memory =
protection.
05:06:41 [    6.317467] Run /init as init process
05:06:41 [    6.327584] random: systemd: uninitialized urandom read (16 =
bytes read)
05:06:41 [    6.328036] random: systemd: uninitialized urandom read (16 =
bytes read)
05:06:41 [    6.328053] random: systemd: uninitialized urandom read (16 =
bytes read)
05:06:41 [    6.336221] systemd[1]: systemd 219 running in system mode. =
(+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP =
+LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 -SECCOMP +BLKID +ELFUTILS =
+KMOD +IDN)
05:06:41 [    6.336393] systemd[1]: Detected architecture ppc64-le.
05:06:41 [    6.336399] systemd[1]: Running in initial RAM disk.
05:06:41=20
05:06:41 Welcome to =1B[0;34mRed Hat Enterprise Linux Server 7.5 (Maipo) =
dracut-033-535.el7 (Initramfs)=1B[0m!
05:06:41=20
05:06:41 [    6.336570] systemd[1]: Set hostname to =
<ltc-zzci-2.aus.stglabs.ibm.com>.
05:06:41 [=1B[32m  OK  =1B[0m] Reached target Timers.
05:06:41 [    6.369540] systemd[1]: Reached target Timers.
05:06:41 [    6.369554] systemd[1]: Starting Timers.
05:06:41 [=1B[32m  OK  =1B[0m] Reached target Swap.
05:06:41 [    6.369676] systemd[1]: Reached target Swap.
05:06:41 [    6.369689] systemd[1]: Starting Swap.
05:06:41 [=1B[32m  OK  =1B[0m] Reached target Local File Systems.
05:06:41 [    6.369811] systemd[1]: Reached target Local File Systems.
05:06:41 [    6.369824] systemd[1]: Starting Local File Systems.
05:06:41 [=1B[32m  OK  =1B[0m] Created slice Root Slice.
05:06:41 [=1B[32m  OK  =1B[0m] Created slice System Slice.
05:06:41 [=1B[32m  OK  =1B[0m] Reached target Slices.
05:06:41 [=1B[32m  OK  =1B[0m] Listening on Journal Socket.
05:06:41          Starting Journal Service...
05:06:41          Starting Setup Virtual Console...
05:06:41          Starting Apply Kernel Variables...
05:06:41          Starting Create list of required st... nodes for the =
current kernel...
05:06:41 [=1B[32m  OK  =1B[0m] Listening on udev Kernel Socket.
05:06:41 [=1B[32m  OK  =1B[0m] Listening on udev Control Socket.
05:06:41 [=1B[32m  OK  =1B[0m] Reached target Sockets.
05:06:41          Starting dracut cmdline hook...
05:06:41 [=1B[32m  OK  =1B[0m] Started Apply Kernel Variables.
05:06:41 [=1B[32m  OK  =1B[0m] Started Create list of required sta...ce =
nodes for the current kernel.
05:06:41          Starting Create Static Device Nodes in /dev...
05:06:41 [=1B[32m  OK  =1B[0m] Started Journal Service.
05:06:41 [=1B[32m  OK  =1B[0m] Started Create Static Device Nodes in =
/dev.
05:06:42 [=1B[32m  OK  =1B[0m] Started Setup Virtual Console.
05:06:42 [=1B[32m  OK  =1B[0m] Started dracut cmdline hook.
05:06:42          Starting dracut pre-udev hook...
05:06:42 [    6.479227] device-mapper: uevent: version 1.0.3
05:06:42 [    6.479404] device-mapper: ioctl: 4.40.0-ioctl (2019-01-18) =
initialised: dm-devel@redhat.com
05:06:42 [=1B[32m  OK  =1B[0m] Started dracut pre-udev hook.
05:06:42          Starting udev Kernel Device Manager...
05:06:42 [=1B[32m  OK  =1B[0m] Started udev Kernel Device Manager.
05:06:42          Starting udev Coldplug all Devices...
05:06:42          Mounting Configuration File System...
05:06:42 [=1B[32m  OK  =1B[0m] Mounted Configuration File System.
05:06:42 [    6.525284] synth uevent: /devices/vio: failed to send =
uevent
05:06:42 [    6.525295] vio vio: uevent: failed to send synthetic uevent
05:06:42 [    6.525365] synth uevent: /devices/vio/4000: failed to send =
uevent
05:06:42 [    6.525371] vio 4000: uevent: failed to send synthetic =
uevent
05:06:42 [    6.525385] synth uevent: /devices/vio/4001: failed to send =
uevent
05:06:42 [    6.525390] vio 4001: uevent: failed to send synthetic =
uevent
05:06:42 [    6.525404] synth uevent: /devices/vio/4002: failed to send =
uevent
05:06:42 [    6.525409] vio 4002: uevent: failed to send synthetic =
uevent
05:06:42 [    6.525422] synth uevent: /devices/vio/4004: failed to send =
uevent
05:06:42 [    6.525427] vio 4004: uevent: failed to send synthetic =
uevent
05:06:42 [=1B[32m  OK  =1B[0m] Started udev Coldplug all Devices.
05:06:42          Starting dracut initqueue hook...
05:06:42          Starting Show Plymouth Boot Screen...
05:06:42 [=1B[32m  OK  =1B[0m] Reached target System Initialization.
05:06:42 [    6.545663] ibmvscsi 30000066: SRP_VERSION: 16.a
05:06:42 [=1B[32m  OK  =1B[0m] Started Show Plymouth Boot Screen.

05:06:42 [=1B[32m  OK  =1B[0m] Reached target Paths.

05:06:42 [=1B[32m  OK  =1B[0m] Reached target Basic System.

05:06:42 =1B%G[   17.468610] ibmvscsi 30000066: SRP_VERSION: 16.a
05:06:53 [   17.468711] ibmvscsi 30000066: Maximum ID: 64 Maximum LUN: =
32 Maximum Channel: 3
05:06:53 [   17.468718] scsi host0: IBM POWER Virtual SCSI Adapter 1.5.9
05:06:53 [   17.469066] ibmvscsi 30000066: partner initialization =
complete
05:06:53 [   17.469125] ibmvscsi 30000066: host srp version: 16.a, host =
partition ltc-zzci-vios1 (100), OS 3, max io 1048576
05:06:53 [   17.469193] ibmvscsi 30000066: Client reserve enabled
05:06:53 [   17.469203] ibmvscsi 30000066: sent SRP login
05:06:53 [   17.469231] ibmvscsi 30000066: SRP_LOGIN succeeded
05:06:53 [   17.498946] scsi 0:0:1:0: Direct-Access     AIX      VDASD   =
         0001 PQ: 0 ANSI: 3
05:06:53 [   17.499361] scsi 0:0:2:0: CD-ROM            AIX      VOPTA   =
              PQ: 0 ANSI: 4
05:06:53 [   17.532445] sr 0:0:2:0: [sr0] scsi-1 drive
05:06:53 [   17.532456] cdrom: Uniform CD-ROM driver Revision: 3.20
05:06:53 [   17.532830] sd 0:0:1:0: [sda] 585105408 512-byte logical =
blocks: (300 GB/279 GiB)
05:06:53 [   17.532883] sd 0:0:1:0: [sda] Write Protect is off
05:06:53 [   17.532926] sd 0:0:1:0: [sda] Cache data unavailable
05:06:53 [   17.532932] sd 0:0:1:0: [sda] Assuming drive cache: write =
through
05:06:53 [   17.532982] sd 0:0:1:0: [sda] Optimal transfer size 0 bytes =
< PAGE_SIZE (65536 bytes)
05:06:53 [   17.539412]  sda: sda1 sda2 sda3
05:06:53 [   17.540207] sd 0:0:1:0: [sda] Attached SCSI disk
05:06:53 [=1B[32m  OK  =1B[0m] Found device =
/dev/mapper/rhel_ltc--zzci--2-****.

05:06:53          Starting File System Check on =
/dev/mapper/rhel_ltc--zzci--2-****...

05:06:53 [=1B[32m  OK  =1B[0m] Started dracut initqueue hook.

05:06:53 [=1B[32m  OK  =1B[0m] Reached target Remote File Systems (Pre).

05:06:53 [=1B[32m  OK  =1B[0m] Reached target Remote File Systems.

05:06:54 [   18.483474] random: crng init done
05:06:54 [   18.483485] random: 7 urandom warning(s) missed due to =
ratelimiting
05:06:56 [=1B[32m  OK  =1B[0m] Started File System Check on =
/dev/mapper/rhel_ltc--zzci--2-****.

05:06:56          Mounting /sys****...

05:06:56 [   21.269747] EXT4-fs (dm-0): mounted filesystem with ordered =
data mode. Opts: (null)
05:06:56 [=1B[32m  OK  =1B[0m] Mounted /sys****.

05:06:56 [=1B[32m  OK  =1B[0m] Reached target Initrd Root File System.

05:06:56          Starting Reload Configuration from the Real Root...

05:06:56 [=1B[32m  OK  =1B[0m] Started Reload Configuration from the =
Real Root.

05:06:56 [=1B[32m  OK  =1B[0m] Reached target Initrd File Systems.

05:06:56 [=1B[32m  OK  =1B[0m] Reached target Initrd Default Target.

05:06:56          Starting dracut pre-pivot and cleanup hook...

05:06:57 [=1B[32m  OK  =1B[0m] Started dracut pre-pivot and cleanup =
hook.

05:06:57          Starting Cleaning Up and Shutting Down Daemons...

05:06:57 [=1B[32m  OK  =1B[0m] Stopped Cleaning Up and Shutting Down =
Daemons.

05:06:57 [=1B[32m  OK  =1B[0m] Stopped dracut pre-pivot and cleanup =
hook.

05:06:57          Stopping dracut pre-pivot and cleanup hook...

05:06:57 [=1B[32m  OK  =1B[0m] Stopped target Remote File Systems.

05:06:57 [=1B[32m  OK  =1B[0m] Stopped target Remote File Systems (Pre).

05:06:57          Starting Plymouth switch **** service...

05:06:57 [=1B[32m  OK  =1B[0m] Stopped target Initrd Default Target.

05:06:57 [=1B[32m  OK  =1B[0m] Stopped target Basic System.

05:06:57 [=1B[32m  OK  =1B[0m] Stopped target Slices.

05:06:57 [=1B[32m  OK  =1B[0m] Stopped target Paths.

05:06:57 [=1B[32m  OK  =1B[0m] Stopped target System Initialization.

05:06:57 [=1B[32m  OK  =1B[0m] Stopped target Swap.

05:06:57 [=1B[32m  OK  =1B[0m] Stopped target Local File Systems.

05:06:57 [=1B[32m  OK  =1B[0m] Stopped Apply Kernel Variables.

05:06:57          Stopping Apply Kernel Variables...

05:06:57 [=1B[32m  OK  =1B[0m] Stopped target Sockets.

05:06:57 [=1B[32m  OK  =1B[0m] Stopped dracut initqueue hook.

05:06:57          Stopping dracut initqueue hook...

05:06:57 [=1B[32m  OK  =1B[0m] Stopped udev Coldplug all Devices.

05:06:57          Stopping udev Coldplug all Devices...

05:06:57 [=1B[32m  OK  =1B[0m] Stopped target Timers.

05:06:57          Stopping udev Kernel Device Manager...

05:06:57 [=1B[32m  OK  =1B[0m] Stopped udev Kernel Device Manager.

05:06:57 [=1B[32m  OK  =1B[0m] Stopped dracut pre-udev hook.

05:06:57          Stopping dracut pre-udev hook...

05:06:57 [=1B[32m  OK  =1B[0m] Stopped dracut cmdline hook.

05:06:57          Stopping dracut cmdline hook...

05:06:57 [=1B[32m  OK  =1B[0m] Stopped Create Static Device Nodes in =
/dev.

05:06:57          Stopping Create Static Device Nodes in /dev...

05:06:57 [=1B[32m  OK  =1B[0m] Stopped Create list of required sta...ce =
nodes for the current kernel.

05:06:57          Stopping Create list of required st... nodes for the =
current kernel...

05:06:57 [=1B[32m  OK  =1B[0m] Closed udev Control Socket.

05:06:57 [=1B[32m  OK  =1B[0m] Closed udev Kernel Socket.

05:06:57          Starting Cleanup udevd DB...

05:06:57 [=1B[32m  OK  =1B[0m] Started Plymouth switch **** service.

05:06:57 [=1B[32m  OK  =1B[0m] Started Cleanup udevd DB.

05:06:57 [=1B[32m  OK  =1B[0m] Reached target Switch Root.

05:06:57          Starting Switch Root...

05:06:57 [   21.677561] systemd-journald[360]: Received SIGTERM from PID =
1 (systemd).
05:06:57 [   21.759118] printk: systemd: 23 output lines suppressed due =
to ratelimiting
05:06:57 [   22.000422] systemd[1]: Inserted module 'ip_tables'
05:06:57=20

05:06:57 Welcome to =1B[0;31mRed Hat Enterprise Linux Server 7.5 =
(Maipo)=1B[0m!

05:06:57=20

05:06:58 [=1B[32m  OK  =1B[0m] Stopped Switch Root.

05:06:58 [=1B[32m  OK  =1B[0m] Stopped Journal Service.

05:06:58          Starting Journal Service...

05:06:58 [=1B[32m  OK  =1B[0m] Listening on LVM2 poll daemon socket.

05:06:58 [=1B[32m  OK  =1B[0m] Listening on LVM2 metadata daemon socket.

05:06:58 [=1B[32m  OK  =1B[0m] Listening on udev Kernel Socket.

05:06:58 [=1B[32m  OK  =1B[0m] Stopped target Switch Root.

05:06:58 [=1B[32m  OK  =1B[0m] Stopped target Initrd Root File System.

05:06:58          Starting Replay Read-Ahead Data...

05:06:58 [=1B[32m  OK  =1B[0m] Listening on Device-mapper event daemon =
FIFOs.

05:06:58          Starting Monitoring of LVM2 mirrors... dmeventd or =
progress polling...

05:06:58 [=1B[32m  OK  =1B[0m] Listening on Delayed Shutdown Socket.

05:06:58          Mounting Debug File System...

05:06:58 [=1B[32m  OK  =1B[0m] Set up automount Arbitrary Executab...ats =
File System Automount Point.

05:06:58 [=1B[32m  OK  =1B[0m] Created slice system-getty.slice.

05:06:58 [=1B[32m  OK  =1B[0m] Listening on /dev/initctl Compatibility =
Named Pipe.

05:06:58 [=1B[32m  OK  =1B[0m] Listening on udev Control Socket.

05:06:58 [=1B[32m  OK  =1B[0m] Created slice =
system-systemd\x2dfsck.slice.

05:06:58 [=1B[32m  OK  =1B[0m] Created slice User and Session Slice.

05:06:58 [=1B[32m  OK  =1B[0m] Reached target Slices.

05:06:58          Starting Read and set NIS domainname from =
/etc/sysconfig/network...

05:06:58 [=1B[32m  OK  =1B[0m] Stopped target Initrd File Systems.

05:06:58          Starting Create list of required st... nodes for the =
current kernel...

05:06:58 [=1B[32m  OK  =1B[0m] Created slice =
system-serial\x2dgetty.slice.

05:06:58          Starting Collect Read-Ahead Data...

05:06:58          Mounting Huge Pages File System...

05:06:58          Mounting POSIX Message Queue File System...

05:06:58 [=1B[32m  OK  =1B[0m] Created slice =
system-selinux\x2dpol...grate\x2dlocal\x2dchanges.slice.

05:06:58 [=1B[32m  OK  =1B[0m] Started Collect Read-Ahead Data.

05:06:58 [=1B[32m  OK  =1B[0m] Started Create list of required sta...ce =
nodes for the current kernel.

05:06:58 [=1B[32m  OK  =1B[0m] Started Replay Read-Ahead Data.

05:06:58          Starting Remount Root and Kernel File Systems...

05:06:58          Starting Create Static Device Nodes in /dev...

05:06:58          Starting Apply Kernel Variables...

05:06:58 [=1B[32m  OK  =1B[0m] Started Apply Kernel Variables.

05:06:58 [=1B[32m  OK  =1B[0m] Started Journal Service.

05:06:58 [=1B[32m  OK  =1B[0m] Started Create Static Device Nodes in =
/dev.

05:06:58          Starting udev Kernel Device Manager...

05:06:59 [=1B[32m  OK  =1B[0m] Mounted Huge Pages File System.

05:06:59 [   23.497772] EXT4-fs (dm-0): re-mounted. Opts: (null)
05:06:59 [=1B[32m  OK  =1B[0m] Started Read and set NIS domainname from =
/etc/sysconfig/network.

05:06:59 [=1B[32m  OK  =1B[0m] Mounted Debug File System.

05:06:59 [=1B[32m  OK  =1B[0m] Mounted POSIX Message Queue File System.

05:06:59 [=1B[32m  OK  =1B[0m] Started Remount Root and Kernel File =
Systems.

05:06:59          Starting Load/Save Random Seed...

05:06:59          Starting Flush Journal to Persistent Storage...

05:06:59          Starting Configure read-only **** support...

05:06:59          Starting udev Coldplug all Devices...

05:06:59 [=1B[32m  OK  =1B[0m] Started Load/Save Random Seed.

05:06:59 [   23.541657] systemd-journald[732]: Received request to flush =
runtime journal from PID 1
05:06:59 [   23.552632] synth uevent: /devices/vio: failed to send =
uevent
05:06:59 [   23.552642] vio vio: uevent: failed to send synthetic uevent
05:06:59 [   23.552888] synth uevent: /devices/vio/4000: failed to send =
uevent
05:06:59 [   23.552894] vio 4000: uevent: failed to send synthetic =
uevent
05:06:59 [   23.552907] synth uevent: /devices/vio/4001: failed to send =
uevent
05:06:59 [   23.552912] vio 4001: uevent: failed to send synthetic =
uevent
05:06:59 [   23.552925] synth uevent: /devices/vio/4002: failed to send =
uevent
05:06:59 [   23.552929] vio 4002: uevent: failed to send synthetic =
uevent
05:06:59 [   23.552941] synth uevent: /devices/vio/4004: failed to send =
uevent
05:06:59 [   23.552946] vio 4004: uevent: failed to send synthetic =
uevent
05:06:59 [=1B[32m  OK  =1B[0m] Started udev Coldplug all Devices.

05:06:59          Starting udev Wait for Complete Device =
Initialization...

05:06:59 [=1B[32m  OK  =1B[0m] Started Flush Journal to Persistent =
Storage.

05:06:59 [=1B[32m  OK  =1B[0m] Started LVM2 metadata daemon.

05:06:59          Starting LVM2 metadata daemon...

05:06:59 [=1B[32m  OK  =1B[0m] Started Configure read-only **** support.

05:06:59 [=1B[32m  OK  =1B[0m] Started udev Kernel Device Manager.

05:06:59 [=1B[32m  OK  =1B[0m] Found device /dev/hvc0.

05:06:59 [   24.058478] pseries_rng: Registering IBM pSeries RNG driver
05:06:59 =1B%G[   24.106651] sd 0:0:1:0: Attached scsi generic sg0 type =
0
05:06:59 [   24.106706] sr 0:0:2:0: Attached scsi generic sg1 type 5
05:06:59 [=1B[32m  OK  =1B[0m] Created slice =
system-lvm2\x2dpvscan.slice.

05:06:59          Starting LVM2 PV scan on device 8:3...

05:07:00 [=1B[32m  OK  =1B[0m] Found device =
/dev/mapper/rhel_ltc--zzci--2-swap.

05:07:00          Activating swap /dev/mapper/rhel_ltc--zzci--2-swap...

05:07:00 [   24.418603] Adding 40886208k swap on =
/dev/mapper/rhel_ltc--zzci--2-swap.  Priority:-2 extents:1 =
across:40886208k FS
05:07:00 [=1B[32m  OK  =1B[0m] Activated swap =
/dev/mapper/rhel_ltc--zzci--2-swap.

05:07:00 [=1B[32m  OK  =1B[0m] Reached target Swap.

05:07:00 [=1B[32m  OK  =1B[0m] Found device VDASD 2.

05:07:00 [=1B[32m  OK  =1B[0m] Started Monitoring of LVM2 mirrors,...ng =
dmeventd or progress polling.

05:07:00 [=1B[32m  OK  =1B[0m] Reached target Local File Systems (Pre).

05:07:00          Starting File System Check on =
/dev/...7-2846-4606-a8c3-2c10a13de684...

05:07:00 [=1B[32m  OK  =1B[0m] Started udev Wait for Complete Device =
Initialization.

05:07:00          Starting Activation of DM RAID sets...

05:07:00 [=1B[32m  OK  =1B[0m] Started Activation of DM RAID sets.

05:07:00 [=1B[32m  OK  =1B[0m] Reached target Local Encrypted Volumes.

05:07:00 [   24.872348] systemd-fsck[1483]: /dev/sda2: recovering =
journal

05:07:00 [   25.110769] systemd-fsck[1483]: /dev/sda2: clean, 306/655360 =
files, 177656/2621440 blocks

05:07:00 [=1B[32m  OK  =1B[0m] Started File System Check on =
/dev/d...1b7-2846-4606-a8c3-2c10a13de684.

05:07:00          Mounting /boot...

05:07:00 [   25.204678] EXT4-fs (sda2): mounted filesystem with ordered =
data mode. Opts: (null)
05:07:00 [=1B[32m  OK  =1B[0m] Mounted /boot.

05:07:00 [=1B[32m  OK  =1B[0m] Reached target Local File Systems.

05:07:00          Starting Preprocess NFS configuration...

05:07:00          Starting Tell Plymouth To Write Out Runtime Data...

05:07:00          Starting Import network configuration from =
initramfs...

05:07:00 [=1B[32m  OK  =1B[0m] Started Preprocess NFS configuration.

05:07:00 [=1B[32m  OK  =1B[0m] Started Tell Plymouth To Write Out =
Runtime Data.

05:07:00 [=1B[32m  OK  =1B[0m] Started Import network configuration from =
initramfs.

05:07:00          Starting Create Volatile Files and Directories...

05:07:01 [=1B[32m  OK  =1B[0m] Started Create Volatile Files and =
Directories.

05:07:01          Starting Security Auditing Service...

05:07:01          Mounting RPC Pipe File System...

05:07:01 [=1B[32m  OK  =1B[0m] Started Security Auditing Service.

05:07:01          Starting Update UTMP about System Boot/Shutdown...

05:07:01 [=1B[32m  OK  =1B[0m] Started Update UTMP about System =
Boot/Shutdown.

05:07:01 [=1B[32m  OK  =1B[0m] Reached target System Initialization.

05:07:01 [=1B[32m  OK  =1B[0m] Listening on RPCbind Server Activation =
Socket.

05:07:01          Starting RPC bind service...

05:07:01 [=1B[32m  OK  =1B[0m] Reached target Paths.

05:07:01 [=1B[32m  OK  =1B[0m] Listening on D-Bus System Message Bus =
Socket.

05:07:01 [=1B[32m  OK  =1B[0m] Listening on Open-iSCSI iscsiuio Socket.

05:07:01 [=1B[32m  OK  =1B[0m] Listening on Open-iSCSI iscsid Socket.

05:07:01 [=1B[32m  OK  =1B[0m] Reached target Sockets.

05:07:01 [=1B[32m  OK  =1B[0m] Reached target Basic System.

05:07:01          Starting Resets System Activity Logs...

05:07:01          Starting GSSAPI Proxy Daemon...

05:07:01 [=1B[32m  OK  =1B[0m] Started irqbalance daemon.

05:07:01          Starting irqbalance daemon...

05:07:01 [   25.629584] RPC: Registered named UNIX socket transport =
module.
05:07:01 [   25.629594] RPC: Registered udp transport module.
05:07:01 [   25.629598] RPC: Registered tcp transport module.
05:07:01 [   25.629604] RPC: Registered tcp NFSv4.1 backchannel =
transport module.
05:07:01          Starting NTP client/server...

05:07:01 [=1B[32m  OK  =1B[0m] Started D-Bus System Message Bus.

05:07:01          Starting D-Bus System Message Bus...

05:07:01          Starting Login Service...

05:07:01 [=1B[32m  OK  =1B[0m] Started ABRT Automated Bug Reporting =
Tool.

05:07:01          Starting ABRT Automated Bug Reporting Tool...

05:07:01 [=1B[32m  OK  =1B[0m] Started ABRT kernel log watcher.

05:07:01          Starting ABRT kernel log watcher...

05:07:01          Starting Install ABRT coredump hook...

05:07:01 [=1B[32m  OK  =1B[0m] Started Hardware RNG Entropy Gatherer =
Daemon.

05:07:01          Starting Hardware RNG Entropy Gatherer Daemon...

05:07:01          Starting Authorization Manager...

05:07:01          Starting Dump dmesg to /var/log/dmesg...

05:07:01 [=1B[32m  OK  =1B[0m] Started libstoragemgmt plug-in server =
daemon.

05:07:01          Starting libstoragemgmt plug-in server daemon...

05:07:01          Starting ppc64-diag rtas_errd (platform error =
handling) Service...

05:07:01 [=1B[32m  OK  =1B[0m] Started Self Monitoring and Reporting =
Technology (SMART) Daemon.

05:07:01          Starting Self Monitoring and Reporting Technology =
(SMART) Daemon...

05:07:01 [=1B[32m  OK  =1B[0m] Reached target Timers.

05:07:01 [=1B[32m  OK  =1B[0m] Mounted RPC Pipe File System.

05:07:01 [=1B[32m  OK  =1B[0m] Started RPC bind service.

05:07:01 [=1B[32m  OK  =1B[0m] Started Resets System Activity Logs.

05:07:01 [=1B[32m  OK  =1B[0m] Started GSSAPI Proxy Daemon.

05:07:01 [=1B[32m  OK  =1B[0m] Started Install ABRT coredump hook.

05:07:01 [=1B[32m  OK  =1B[0m] Started Dump dmesg to /var/log/dmesg.

05:07:01 [=1B[32m  OK  =1B[0m] Reached target rpc_pipefs.target.

05:07:01 [=1B[32m  OK  =1B[0m] Reached target NFS client services.

05:07:01 [=1B[32m  OK  =1B[0m] Started Login Service.

05:07:01 [=1B[32m  OK  =1B[0m] Started NTP client/server.

05:07:01 [=1B[32m  OK  =1B[0m] Started ppc64-diag rtas_errd (platform =
error handling) Service.

05:07:01 [=1B[32m  OK  =1B[0m] Started Authorization Manager.

05:07:01          Starting firewalld - dynamic firewall daemon...

05:07:01 [=1B[32m  OK  =1B[0m] Started LVM2 PV scan on device 8:3.

05:07:01 [=1B[32m  OK  =1B[0m] Started firewalld - dynamic firewall =
daemon.

05:07:01 [=1B[32m  OK  =1B[0m] Reached target Network (Pre).

05:07:01          Starting Network Manager...

05:07:02          Starting Hostname Service...

05:07:02 [=1B[32m  OK  =1B[0m] Started Hostname Service.

05:07:02 [=1B[32m  OK  =1B[0m] Started Network Manager.

05:07:02          Starting Network Manager Script Dispatcher Service...

05:07:02          Starting Network Manager Wait Online...

05:07:02 [=1B[32m  OK  =1B[0m] Started Network Manager Script Dispatcher =
Service.

05:07:02 [   26.555163] bridge: filtering via arp/ip/ip6tables is no =
longer available by default. Update your scripts to load br_netfilter if =
you need this.
05:07:02 [=1B[32m  OK  =1B[0m] Started Network Manager Wait Online.

05:07:02          Starting LSB: Bring up/down networking...

05:07:03 [=1B[32m  OK  =1B[0m] Started LSB: Bring up/down networking.

05:07:03 [=1B[32m  OK  =1B[0m] Reached target Network.

05:07:03          Starting Postfix Mail Transport Agent...

05:07:03          Starting Logout off all iSCSI sessions on shutdown...

05:07:03          Starting Enable periodic update of entitlement =
certificates....

05:07:03          Starting OpenSSH server daemon...

05:07:03          Starting Dynamic System Tuning Daemon...

05:07:03 [=1B[32m  OK  =1B[0m] Reached target Network is Online.

05:07:03          Starting System Logging Service...

05:07:03          Starting Notify NFS peers of a restart...

05:07:03 [=1B[32m  OK  =1B[0m] Started System Logging Service.

05:07:03 [=1B[32m  OK  =1B[0m] Started Logout off all iSCSI sessions on =
shutdown.

05:07:03 [=1B[32m  OK  =1B[0m] Started Enable periodic update of =
entitlement certificates..

05:07:03 [=1B[32m  OK  =1B[0m] Reached target Remote File Systems (Pre).

05:07:03 [=1B[32m  OK  =1B[0m] Reached target Remote File Systems.

05:07:03          Starting LSB: Starts the Spacewalk Daemon...

05:07:03          Starting Permit User Sessions...

05:07:03          Starting Crash recovery kernel arming...

05:07:03          Starting Availability of block devices...

05:07:03 [=1B[32m  OK  =1B[0m] Started Permit User Sessions.

05:07:03 [=1B[32m  OK  =1B[0m] Started Availability of block devices.

05:07:03 [=1B[32m  OK  =1B[0m] Started Job spooling tools.

05:07:03          Starting Job spooling tools...

05:07:03          Starting Terminate Plymouth Boot Screen...

05:07:03 [=1B[32m  OK  =1B[0m] Started Command Scheduler.

05:07:03          Starting Command Scheduler...

05:07:03          Starting Wait for Plymouth Boot Screen to Quit...

05:07:03 [=1B[32m  OK  =1B[0m] Started Notify NFS peers of a restart.

05:07:03 [=1B[32m  OK  =1B[0m] Started LSB: Starts the Spacewalk Daemon.

05:07:03          Starting (null)...

05:07:03 [=1B[1;31mFAILED=1B[0m] Failed to start Crash recovery kernel =
arming.

05:07:03 See 'systemctl status kdump.service' for details.

05:07:04=20

05:07:04 Red Hat Enterprise Linux Server 7.5 (Maipo)
05:07:04 Kernel 5.0.0-next-20190306-autotest on an ppc64le
05:07:04=20
05:07:04 ltc-zzci-2 login: ****
05:08:22=20
****

05:08:22 Password: ****
05:08:29=20

05:08:29 Last login: Wed Mar  6 18:21:20 on hvc0
05:08:35 PS1=3D[pexpect]#
05:08:36=20
[****@ltc-zzci-2 ~]# PS1=3D[pexpect]#
05:08:36 06:38:36 PM INFO  |   Shell prompt changed
05:08:36=20
05:08:36 06:38:36 PM INFO  |  Enable kernel ftrace:
05:08:39 sysctl -w kernel.ftrace_dump_on_oops=3D1
05:08:40=20

05:08:45 [pexpect]#sysctl -w kernel.ftrace_dump_on_oops=3D1
05:08:45 kernel.ftrace_dump_on_oops =3D 1
05:08:45 [pexpect]#./autotest/client/autotest-local =
./autotest/client/tests/kernelorg/kernel-build.py --continue
05:08:49=20
./autotest/client/autotest-local ./autotest/client/tests/kernelorg/ker=20=

nel-build.py --continue
05:08:54 18:38:49 INFO | Writing results to =
/****/autotest/client/results/default
05:08:54 18:38:50 INFO | 	END GOOD	build	reboot	patch8=3Db=
	kernel=3D5.0.0-next-20190306-autotest	patch9=3Do	patch0=3Dk=
	patch1=3De	patch2=3Dx	patch3=3De	patch4=3Dc	=
patch5=3D 	patch6=3Dr	patch7=3De	timestamp=3D1551915530	=
patch10=3Do	patch11=3Dt	localtime=3DMar 06 18:38:50=09
05:08:54 18:38:50 INFO | TEST: running host test
05:08:54 18:38:50 INFO | Test: running sleeptest tests
05:08:54 18:38:50 INFO | sleeptest
05:08:54 18:38:50 INFO | 	START	sleeptest	sleeptest	=
timestamp=3D1551915530	localtime=3DMar 06 18:38:50=09
05:08:54 18:38:51 INFO | 		GOOD	sleeptest	=
sleeptest	timestamp=3D1551915531	localtime=3DMar 06 18:38:51	=
completed successfully
05:08:54 18:38:51 INFO | 	END GOOD	sleeptest	=
sleeptest	timestamp=3D1551915531	localtime=3DMar 06 18:38:51=09
05:08:54 18:38:51 INFO | END GOOD	----	----	=
timestamp=3D1551915531	localtime=3DMar 06 18:38:51=09
05:08:54 18:38:51 INFO | Report successfully generated at =
/****/autotest/client/results/default/job_report.html
05:08:54 [pexpect]#/****/autotest/client/tools/results2junit.py =
/****/autotest/client/results/default/ > =
/****/autotest/client/results/default//results.xml
05:08:57=20
/****/autotest/client/tools/results2junit.py /****/autotest/client/res=20=

ults/default/ > /****/autotest/client/results/default//results.xml
05:09:02   ** Warning: The requested file =
(/****/autotest/client/results/default/kernel_build/debug/kernel_build.DEB=
UG) does not exist.
05:09:02 [pexpect]#mkdir -p /****/avocado-korg/
05:09:06=20
mkdir -p /****/avocado-korg/
05:09:11 [pexpect]#rm -rf /****/avocado-korg/*
05:09:15=20
rm -rf /****/avocado-korg/*
05:09:20 [pexpect]#cd avocado-fvt-wrapper
05:09:24=20
cd avocado-fvt-wrapper
05:09:29 [pexpect]#yes | cp -rf /boot/config-autotest =
/boot/config-$(uname -r)
05:09:33=20
yes | cp -rf /boot/config-autotest /boot/config-$(uname -r)
05:09:38 [pexpect]#mkdir -p /****/avocado-korg/korg_pvm
05:09:41=20
mkdir -p /****/avocado-korg/korg_pvm
05:09:46 [pexpect]#python avocado-setup.py --run-suite host_korg_pvm =
--output-dir /****/avocado-korg/korg_pvm --no-deps-check
05:09:50=20
python avocado-setup.py --run-suite host_korg_pvm --output-dir /****/a=20=

vocado-korg/korg_pvm --no-deps-check
05:09:55 18:39:50 INFO    : Check for environment
05:09:55 18:39:50 INFO    : Creating temporary mux dir
05:09:55 18:39:54 WARNING : Avocado vt plugin not installed
05:09:55 18:39:54 INFO    : Avocado vt plugin needs to installed
05:09:55 18:39:55 WARNING : Avocado vt-list plugin not installed
05:09:55 18:39:55 INFO    : Avocado vt-list plugin needs to installed
05:09:55 18:39:55 WARNING : Avocado vt-bootstrap plugin not installed
05:09:55 18:39:55 INFO    : Avocado vt-bootstrap plugin needs to =
installed
05:09:55 18:39:55 INFO    : Creating Avocado Config
05:09:55 18:39:55 INFO    : Uninstalling avocado and autotest from =
environment
05:09:58 18:39:58 INFO    : Bootstrapping
05:09:58 18:39:58 INFO    : Updating the repo: avocado in =
/****/avocado-fvt-wrapper/avocado
05:09:58 18:39:58 INFO    : Installing repo: =
/****/avocado-fvt-wrapper/avocado
05:10:00 18:40:00 INFO    : Updating the repo: avocado-vt in =
/****/avocado-fvt-wrapper/avocado-vt
05:10:00 18:40:00 INFO    : Installing repo: =
/****/avocado-fvt-wrapper/avocado-vt
05:10:08 18:40:08 INFO    : Bootstrapping vt libvirt
05:10:11 18:40:11 INFO    : Bootstrapping vt qemu
05:10:12 18:40:12 INFO    : creating test repo dir =
/****/avocado-fvt-wrapper/tests
05:10:12 18:40:12 INFO    : Updating the repo: avocado-misc-tests in =
/****/avocado-fvt-wrapper/tests/avocado-misc-tests
05:10:14 18:40:14 WARNING : Avocado varianter_yaml_to_mux plugin not =
installed
05:10:14 18:40:14 INFO    : Installing optional plugin: =
varianter_yaml_to_mux
05:10:21 18:40:21 INFO    :=20
05:10:21 18:40:21 INFO    : Running Host Tests Suite korg_pvm_cpustress
05:10:21 18:40:21 INFO    : Running: /bin/avocado run =
avocado-misc-tests/cpu/cpustress.py --force-job-id =
6a4bdec619023bae6d056de93bdc61a37dab9ed5  --job-results-dir =
/****/avocado-korg/korg_pvm/results
05:10:22 JOB ID     : 6a4bdec619023bae6d056de93bdc61a37dab9ed5
05:10:22 JOB LOG    : =
/****/avocado-korg/korg_pvm/results/job-2019-03-06T18.40-6a4bdec/job.log
05:10:22  (1/1) avocado-misc-tests/cpu/cpustress.py:cpustresstest.test:  =
[  588.553418] process 6383 (sh) no longer affine to cpu0
05:16:24 [  589.033416] process 6389 (sh) no longer affine to cpu1
05:16:25 [  589.763394] process 6395 (sh) no longer affine to cpu2
05:16:26 [  590.553430] process 6401 (sh) no longer affine to cpu3
05:16:26 [  591.233445] process 6407 (sh) no longer affine to cpu4
05:16:27 [  591.823487] process 6413 (sh) no longer affine to cpu5
05:16:28 [  592.613486] process 6419 (sh) no longer affine to cpu6
05:16:28 [  593.353537] process 6425 (sh) no longer affine to cpu7
05:16:29 [  594.083745] process 6431 (sh) no longer affine to cpu8
05:16:30 [  594.743762] process 6437 (sh) no longer affine to cpu9
05:16:31 [  595.423768] process 6443 (sh) no longer affine to cpu10
05:16:31 [  596.093802] process 6449 (sh) no longer affine to cpu11
05:16:32 [  596.813828] process 6455 (sh) no longer affine to cpu12
05:16:33 [  597.493860] process 6461 (sh) no longer affine to cpu13
05:16:34 [  598.513869] process 6467 (sh) no longer affine to cpu14
05:16:34 [  599.353918] process 6473 (sh) no longer affine to cpu15
05:16:35 [  600.094254] process 6479 (sh) no longer affine to cpu16
05:16:36 [  600.774217] process 6485 (sh) no longer affine to cpu17
05:16:37 [  601.484205] process 6491 (sh) no longer affine to cpu18
05:16:37 [  602.024241] process 6497 (sh) no longer affine to cpu19
05:16:38 [  602.814234] process 6503 (sh) no longer affine to cpu20
05:16:38 [  603.344255] process 6509 (sh) no longer affine to cpu21
05:16:39 [  603.934240] process 6515 (sh) no longer affine to cpu22
05:16:40 [  604.734298] process 6521 (sh) no longer affine to cpu23
05:16:40 [  605.294495] process 6527 (sh) no longer affine to cpu24
05:16:41 [  605.764509] process 6533 (sh) no longer affine to cpu25
05:16:41 [  606.284505] process 6539 (sh) no longer affine to cpu26
05:16:42 [  606.744548] process 6545 (sh) no longer affine to cpu27
05:16:42 [  607.284530] process 6551 (sh) no longer affine to cpu28
05:16:43 [  607.584541] process 6557 (sh) no longer affine to cpu29
05:16:43 [  607.974505] process 6563 (sh) no longer affine to cpu30
05:17:35 [  660.259248] cpu 24 (hwid 24) Ready to die...
05:17:35 [  660.408117] cpu 25 (hwid 25) Ready to die...
05:17:36 [  660.507990] cpu 26 (hwid 26) Ready to die...
05:17:36 [  660.608033] cpu 27 (hwid 27) Ready to die...
05:17:36 [  660.717963] cpu 28 (hwid 28) Ready to die...
05:17:36 [  660.797986] cpu 29 (hwid 29) Ready to die...
05:17:36 [  660.833700] cpu 30 (hwid 30) Ready to die...
05:17:36 [  660.898053] cpu 31 (hwid 31) Ready to die...
05:17:38 [  662.478178] cpu 24 (hwid 24) Ready to die...
05:17:38 [  662.558188] cpu 25 (hwid 25) Ready to die...
05:17:38 [  662.698174] cpu 26 (hwid 26) Ready to die...
05:17:38 [  662.818180] cpu 27 (hwid 27) Ready to die...
05:17:38 [  662.968147] cpu 28 (hwid 28) Ready to die...
05:17:38 [  663.088124] cpu 29 (hwid 29) Ready to die...
05:17:38 [  663.168107] cpu 30 (hwid 30) Ready to die...
05:17:38 [  663.248110] cpu 31 (hwid 31) Ready to die...
05:17:40 [  665.038326] cpu 24 (hwid 24) Ready to die...
05:17:40 [  665.148340] cpu 25 (hwid 25) Ready to die...
05:17:40 [  665.278310] cpu 26 (hwid 26) Ready to die...
05:17:40 [  665.388343] cpu 27 (hwid 27) Ready to die...
05:17:41 [  665.498322] cpu 28 (hwid 28) Ready to die...
05:17:41 [  665.598299] cpu 29 (hwid 29) Ready to die...
05:17:41 [  665.738268] cpu 30 (hwid 30) Ready to die...
05:17:41 [  665.818260] cpu 31 (hwid 31) Ready to die...
05:17:42 [  667.378493] cpu 24 (hwid 24) Ready to die...
05:17:43 [  667.498528] cpu 25 (hwid 25) Ready to die...
05:17:43 [  667.598509] cpu 26 (hwid 26) Ready to die...
05:17:43 [  667.718510] cpu 27 (hwid 27) Ready to die...
05:17:43 [  667.808443] cpu 28 (hwid 28) Ready to die...
05:17:43 [  667.918481] cpu 29 (hwid 29) Ready to die...
05:17:43 [  668.038438] cpu 30 (hwid 30) Ready to die...
05:17:43 [  668.138445] cpu 31 (hwid 31) Ready to die...
05:17:45 [  669.728623] cpu 24 (hwid 24) Ready to die...
05:17:45 [  669.848670] cpu 25 (hwid 25) Ready to die...
05:17:45 [  669.958655] cpu 26 (hwid 26) Ready to die...
05:17:45 [  670.038626] cpu 27 (hwid 27) Ready to die...
05:17:45 [  670.138614] cpu 28 (hwid 28) Ready to die...
05:17:45 [  670.238598] cpu 29 (hwid 29) Ready to die...
05:17:45 [  670.318563] cpu 30 (hwid 30) Ready to die...
05:17:45 [  670.428578] cpu 31 (hwid 31) Ready to die...
05:17:47 [  672.038764] cpu 24 (hwid 24) Ready to die...
05:17:47 [  672.138824] cpu 25 (hwid 25) Ready to die...
05:17:47 [  672.298803] cpu 26 (hwid 26) Ready to die...
05:17:47 [  672.408835] cpu 27 (hwid 27) Ready to die...
05:17:48 [  672.518774] cpu 28 (hwid 28) Ready to die...
05:17:48 [  672.668794] cpu 29 (hwid 29) Ready to die...
05:17:48 [  672.758728] cpu 30 (hwid 30) Ready to die...
05:17:48 [  672.838737] cpu 31 (hwid 31) Ready to die...
05:17:49 [  674.358925] cpu 24 (hwid 24) Ready to die...
05:17:50 [  674.438959] cpu 25 (hwid 25) Ready to die...
05:17:50 [  674.528931] cpu 26 (hwid 26) Ready to die...
05:17:50 [  674.608920] cpu 27 (hwid 27) Ready to die...
05:17:50 [  674.738903] cpu 28 (hwid 28) Ready to die...
05:17:50 [  674.818880] cpu 29 (hwid 29) Ready to die...
05:17:50 [  674.898866] cpu 30 (hwid 30) Ready to die...
05:17:50 [  674.988869] cpu 31 (hwid 31) Ready to die...
05:17:52 [  676.689086] cpu 24 (hwid 24) Ready to die...
05:17:52 [  676.769100] cpu 25 (hwid 25) Ready to die...
05:17:52 [  676.859092] cpu 26 (hwid 26) Ready to die...
05:17:52 [  676.959107] cpu 27 (hwid 27) Ready to die...
05:17:52 [  677.039054] cpu 28 (hwid 28) Ready to die...
05:17:52 [  677.139048] cpu 29 (hwid 29) Ready to die...
05:17:52 [  677.219013] cpu 30 (hwid 30) Ready to die...
05:17:52 [  677.309014] cpu 31 (hwid 31) Ready to die...
05:17:54 [  678.869251] cpu 24 (hwid 24) Ready to die...
05:17:54 [  678.959274] cpu 25 (hwid 25) Ready to die...
05:17:54 [  679.059256] cpu 26 (hwid 26) Ready to die...
05:17:54 [  679.159256] cpu 27 (hwid 27) Ready to die...
05:17:54 [  679.289208] cpu 28 (hwid 28) Ready to die...
05:17:54 [  679.389182] cpu 29 (hwid 29) Ready to die...
05:17:55 [  679.479170] cpu 30 (hwid 30) Ready to die...
05:17:55 [  679.579186] cpu 31 (hwid 31) Ready to die...
05:17:56 [  681.419420] cpu 24 (hwid 24) Ready to die...
05:17:57 [  681.539440] cpu 25 (hwid 25) Ready to die...
05:17:57 [  681.639422] cpu 26 (hwid 26) Ready to die...
05:17:57 [  681.759447] cpu 27 (hwid 27) Ready to die...
05:17:57 [  681.859377] cpu 28 (hwid 28) Ready to die...
05:17:57 [  681.969381] cpu 29 (hwid 29) Ready to die...
05:17:57 [  682.049340] cpu 30 (hwid 30) Ready to die...
05:17:57 [  682.159364] cpu 31 (hwid 31) Ready to die...
05:18:06 PASS (463.43 s)
05:18:06 RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | =
INTERRUPT 0 | CANCEL 0
05:18:06 JOB TIME   : 463.83 s
05:18:06 JOB HTML   : =
/****/avocado-korg/korg_pvm/results/job-2019-03-06T18.40-6a4bdec/results.h=
tml
05:18:06 18:48:06 INFO    :=20
05:18:06 18:48:06 INFO    :=20
05:18:06 18:48:06 INFO    : Running Host Tests Suite korg_pvm_ebizzy
05:18:06 18:48:06 INFO    : Running: /bin/avocado run =
avocado-misc-tests/cpu/ebizzy.py --force-job-id =
5d8da7a094cfe62d49ada09a14f0f57147b5b7ee  --job-results-dir =
/****/avocado-korg/korg_pvm/results
05:18:07 JOB ID     : 5d8da7a094cfe62d49ada09a14f0f57147b5b7ee
05:18:07 JOB LOG    : =
/****/avocado-korg/korg_pvm/results/job-2019-03-06T18.48-5d8da7a/job.log
05:18:07  (1/1) avocado-misc-tests/cpu/ebizzy.py:Ebizzy.test:  PASS =
(101.60 s)
05:19:49 RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | =
INTERRUPT 0 | CANCEL 0
05:19:49 JOB TIME   : 102.00 s
05:19:49 JOB HTML   : =
/****/avocado-korg/korg_pvm/results/job-2019-03-06T18.48-5d8da7a/results.h=
tml
05:19:49 18:49:49 INFO    :=20
05:19:49 18:49:49 INFO    :=20
05:19:49 18:49:49 INFO    : Running Host Tests Suite =
korg_pvm_hugepage_sanity
05:19:49 18:49:49 INFO    : Running: /bin/avocado run =
avocado-misc-tests/memory/hugepage_sanity.py --force-job-id =
bdefa024a31f027416b03df931fcdd9fb427aa93  --job-results-dir =
/****/avocado-korg/korg_pvm/results
05:19:49 JOB ID     : bdefa024a31f027416b03df931fcdd9fb427aa93
05:19:49 JOB LOG    : =
/****/avocado-korg/korg_pvm/results/job-2019-03-06T18.49-bdefa02/job.log
05:19:50  (1/1) =
avocado-misc-tests/memory/hugepage_sanity.py:HugepageSanity.test:  PASS =
(10.49 s)
05:20:00 RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | =
INTERRUPT 0 | CANCEL 0
05:20:00 JOB TIME   : 10.87 s
05:20:01 JOB HTML   : =
/****/avocado-korg/korg_pvm/results/job-2019-03-06T18.49-bdefa02/results.h=
tml
05:20:01 18:50:01 INFO    :=20
05:20:01 18:50:01 INFO    :=20
05:20:01 18:50:01 INFO    : Running Host Tests Suite =
korg_pvm_libhugetlbfs
05:20:01 18:50:01 INFO    : Running: /bin/avocado run =
avocado-misc-tests/memory/libhugetlbfs.py --force-job-id =
b969b09b2e130c5ea400729172d6598be49df4ef  --job-results-dir =
/****/avocado-korg/korg_pvm/results
05:20:01 JOB ID     : b969b09b2e130c5ea400729172d6598be49df4ef
05:20:01 JOB LOG    : =
/****/avocado-korg/korg_pvm/results/job-2019-03-06T18.50-b969b09/job.log
05:20:01  (1/1) =
avocado-misc-tests/memory/libhugetlbfs.py:libhugetlbfs.test:  [  =
812.464653] stack_grow_into[8964]: segfault (11) at 7efff83ab7d0 nip =
10001764 lr 1000173c code 1 in stack_grow_into_huge[10000000+10000]
05:20:08 [  812.464685] stack_grow_into[8964]: code: f93f0028 4bfff949 =
e8410018 3d40efff 39000001 614afff0 48000014 60000000=20
05:20:08 [  812.464693] stack_grow_into[8964]: code: 60000000 60000000 =
60420000 e9210000 <7d21516a> 39210020 91010020 7fa9f040=20
05:20:08 [  812.464746] Process 8964(stack_grow_into) has RLIMIT_CORE =
set to 1
05:20:08 [  812.464750] Aborting core
05:20:08 [  813.050257] linkhuge_rw[9026]: segfault (11) at 100129c8 nip =
100016b0 lr 100011b8 code 2 in linkhuge_rw[10000000+20000]
05:20:08 [  813.050281] linkhuge_rw[9026]: code: 81350018 2f890000 =
e9350008 419e001c 7d2903a6 7d2c4b78 f8410018 4e800421=20
05:20:08 [  813.050289] linkhuge_rw[9026]: code: e8410018 7c691b78 =
39400000 38600000 <99490000> 4bfff7fd e8410018 480005a5=20
05:20:08 [  813.130881] linkhuge_rw[9028]: segfault (11) at 100029c8 nip =
100016b0 lr 100011b8 code 2 in linkhuge_rw[10000000+20000]
05:20:08 [  813.130896] linkhuge_rw[9028]: code: 81350018 2f890000 =
e9350008 419e001c 7d2903a6 7d2c4b78 f8410018 4e800421=20
05:20:08 [  813.130904] linkhuge_rw[9028]: code: e8410018 7c691b78 =
39400000 38600000 <99490000> 4bfff7fd e8410018 480005a5=20
05:20:08 [  813.150077] linkhuge_rw[9031]: segfault (11) at 100016a0 nip =
100016b0 lr 100016a0 code 2 in linkhuge_rw[10000000+20000]
05:20:08 [  813.150089] linkhuge_rw[9031]: code: 81350018 2f890000 =
e9350008 419e001c 7d2903a6 7d2c4b78 f8410018 4e800421=20
05:20:08 [  813.150097] linkhuge_rw[9031]: code: e8410018 7c691b78 =
39400000 38600000 <99490000> 4bfff7fd e8410018 480005a5=20
05:20:08 [  813.169255] linkhuge_rw[9034]: segfault (11) at 100016a0 nip =
100016b0 lr 100016a0 code 2 in linkhuge_rw[10000000+20000]
05:20:08 [  813.169267] linkhuge_rw[9034]: code: 81350018 2f890000 =
e9350008 419e001c 7d2903a6 7d2c4b78 f8410018 4e800421=20
05:20:08 [  813.169274] linkhuge_rw[9034]: code: e8410018 7c691b78 =
39400000 38600000 <99490000> 4bfff7fd e8410018 480005a5=20
05:20:08 [  813.194897] linkhuge_rw[9042]: segfault (11) at 100129c8 nip =
100016b0 lr 100011b8 code 2 in libhugetlbfs.tmp.dDREut =
(deleted)[10000000+1000000]
05:20:08 [  813.194911] linkhuge_rw[9042]: code: 81350018 2f890000 =
e9350008 419e001c 7d2903a6 7d2c4b78 f8410018 4e800421=20
05:20:08 [  813.194919] linkhuge_rw[9042]: code: e8410018 7c691b78 =
39400000 38600000 <99490000> 4bfff7fd e8410018 480005a5=20
05:20:08 [  813.214277] linkhuge_rw[9045]: segfault (11) at 100029c8 nip =
100016b0 lr 100011b8 code 2 in libhugetlbfs.tmp.dDREut =
(deleted)[10000000+1000000]
05:20:08 [  813.214293] linkhuge_rw[9045]: code: 81350018 2f890000 =
e9350008 419e001c 7d2903a6 7d2c4b78 f8410018 4e800421=20
05:20:08 [  813.214301] linkhuge_rw[9045]: code: e8410018 7c691b78 =
39400000 38600000 <99490000> 4bfff7fd e8410018 480005a5=20
05:20:08 [  813.233868] linkhuge_rw[9047]: segfault (11) at 100016a0 nip =
100016b0 lr 100016a0 code 2 in libhugetlbfs.tmp.dDREut =
(deleted)[10000000+1000000]
05:20:08 [  813.233884] linkhuge_rw[9047]: code: 81350018 2f890000 =
e9350008 419e001c 7d2903a6 7d2c4b78 f8410018 4e800421=20
05:20:08 [  813.233892] linkhuge_rw[9047]: code: e8410018 7c691b78 =
39400000 38600000 <99490000> 4bfff7fd e8410018 480005a5=20
05:20:08 [  813.252819] linkhuge_rw[9049]: segfault (11) at 100016a0 nip =
100016b0 lr 100016a0 code 2 in libhugetlbfs.tmp.dDREut =
(deleted)[10000000+1000000]
05:20:08 [  813.252832] linkhuge_rw[9049]: code: 81350018 2f890000 =
e9350008 419e001c 7d2903a6 7d2c4b78 f8410018 4e800421=20
05:20:08 [  813.252840] linkhuge_rw[9049]: code: e8410018 7c691b78 =
39400000 38600000 <99490000> 4bfff7fd e8410018 480005a5=20
05:20:08 [  813.285682] linkhuge_rw[9057]: segfault (11) at 100129c8 nip =
100016b0 lr 100011b8 code 2 in linkhuge_rw[10000000+20000]
05:20:08 [  813.285703] linkhuge_rw[9057]: code: 81350018 2f890000 =
e9350008 419e001c 7d2903a6 7d2c4b78 f8410018 4e800421=20
05:20:08 [  813.285711] linkhuge_rw[9057]: code: e8410018 7c691b78 =
39400000 38600000 <99490000> 4bfff7fd e8410018 480005a5=20
05:21:54 PASS (112.27 s)
05:21:54 RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | =
INTERRUPT 0 | CANCEL 0
05:21:54 JOB TIME   : 112.67 s
05:21:54 JOB HTML   : =
/****/avocado-korg/korg_pvm/results/job-2019-03-06T18.50-b969b09/results.h=
tml
05:21:54 18:51:54 INFO    :=20
05:21:54 18:51:54 INFO    :=20
05:21:54 18:51:54 INFO    : Running Host Tests Suite =
korg_pvm_perf_genericevents
05:21:54 18:51:54 INFO    : Running: /bin/avocado run =
avocado-misc-tests/perf/perf_genericevents.py --force-job-id =
fc11066cff326d89599e8c6d9605cd92bde6d152  --job-results-dir =
/****/avocado-korg/korg_pvm/results
05:21:55 JOB ID     : fc11066cff326d89599e8c6d9605cd92bde6d152
05:21:55 JOB LOG    : =
/****/avocado-korg/korg_pvm/results/job-2019-03-06T18.51-fc11066/job.log
05:21:55  (1/1) =
avocado-misc-tests/perf/perf_genericevents.py:test_generic_events.test:  =
FAIL: Failed to verify generic PMU event codes (0.09 s)
05:21:55 RESULTS    : PASS 0 | ERROR 0 | FAIL 1 | SKIP 0 | WARN 0 | =
INTERRUPT 0 | CANCEL 0
05:21:55 JOB TIME   : 0.47 s
05:21:55 JOB HTML   : =
/****/avocado-korg/korg_pvm/results/job-2019-03-06T18.51-fc11066/results.h=
tml
05:21:55 18:51:55 INFO    :=20
05:21:55 18:51:55 INFO    :=20
05:21:55 18:51:55 INFO    : Running Host Tests Suite korg_pvm_perfmon
05:21:55 18:51:55 INFO    : Running: /bin/avocado run =
avocado-misc-tests/perf/perfmon.py --force-job-id =
ed945d164513823cb303d045faeb2af1f2c76c13  --job-results-dir =
/****/avocado-korg/korg_pvm/results
05:21:56 JOB ID     : ed945d164513823cb303d045faeb2af1f2c76c13
05:21:56 JOB LOG    : =
/****/avocado-korg/korg_pvm/results/job-2019-03-06T18.51-ed945d1/job.log
05:21:56  (1/1) avocado-misc-tests/perf/perfmon.py:Perfmon.test:  PASS =
(5.92 s)
05:22:02 RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | =
INTERRUPT 0 | CANCEL 0
05:22:02 JOB TIME   : 6.31 s
05:22:02 JOB HTML   : =
/****/avocado-korg/korg_pvm/results/job-2019-03-06T18.51-ed945d1/results.h=
tml
05:22:03 18:52:03 INFO    :=20
05:22:03 18:52:03 INFO    :=20
05:22:03 18:52:03 INFO    : Running Host Tests Suite =
korg_pvm_stress-ng_stress-ng-network
05:22:03 18:52:03 INFO    : Running: /bin/avocado run =
avocado-misc-tests/generic/stress-ng.py -m =
/****/avocado-fvt-wrapper/tests/avocado-misc-tests/generic/stress-ng.py.da=
ta/stress-ng-network.yaml --force-job-id =
61a968181e1afa3ebad75a4ba145fe155101f9bf  --job-results-dir =
/****/avocado-korg/korg_pvm/results
05:22:03 JOB ID     : 61a968181e1afa3ebad75a4ba145fe155101f9bf
05:22:03 JOB LOG    : =
/****/avocado-korg/korg_pvm/results/job-2019-03-06T18.52-61a9681/job.log
05:22:03  (1/1) =
avocado-misc-tests/generic/stress-ng.py:Stressng.test;exclude-stressors-wo=
rkers-a67d:  [  947.742277] request_module: kmod_concurrent_max (0) =
close to 0 (max_modprobes: 50), for module net-pf-2-proto-33-type-6, =
throttling...
05:22:23 [  947.742486] request_module: kmod_concurrent_max (0) close to =
0 (max_modprobes: 50), for module net-pf-2-proto-33-type-6, =
throttling...
05:22:23 [  947.742577] request_module: kmod_concurrent_max (0) close to =
0 (max_modprobes: 50), for module net-pf-2-proto-33-type-6, =
throttling...
05:22:23 [  947.742586] request_module: kmod_concurrent_max (0) close to =
0 (max_modprobes: 50), for module net-pf-2-proto-33-type-6, =
throttling...
05:22:23 [  947.742638] request_module: kmod_concurrent_max (0) close to =
0 (max_modprobes: 50), for module net-pf-2-proto-33-type-6, =
throttling...
05:22:23 [  947.742762] request_module: kmod_concurrent_max (0) close to =
0 (max_modprobes: 50), for module net-pf-2-proto-33-type-6, =
throttling...
05:22:23 [  947.742776] request_module: kmod_concurrent_max (0) close to =
0 (max_modprobes: 50), for module net-pf-2-proto-33, throttling...
05:22:23 [  947.743297] request_module: kmod_concurrent_max (0) close to =
0 (max_modprobes: 50), for module net-pf-2-proto-33-type-6, =
throttling...
05:22:23 [  947.743328] request_module: kmod_concurrent_max (0) close to =
0 (max_modprobes: 50), for module net-pf-2-proto-33-type-6, =
throttling...
05:33:23 PASS (679.79 s)
05:33:23 RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | =
INTERRUPT 0 | CANCEL 0
05:33:23 JOB TIME   : 680.21 s
05:33:24 JOB HTML   : =
/****/avocado-korg/korg_pvm/results/job-2019-03-06T18.52-61a9681/results.h=
tml
05:33:24 19:03:24 INFO    :=20
05:33:24 19:03:24 INFO    :=20
05:33:24 19:03:24 INFO    : Running Host Tests Suite =
korg_pvm_stress-ng_stress-ng-interrupt
05:33:24 19:03:24 INFO    : Running: /bin/avocado run =
avocado-misc-tests/generic/stress-ng.py -m =
/****/avocado-fvt-wrapper/tests/avocado-misc-tests/generic/stress-ng.py.da=
ta/stress-ng-interrupt.yaml --force-job-id =
8922dbc88c6453e9dc267171544c326f48e7ba14  --job-results-dir =
/****/avocado-korg/korg_pvm/results
05:33:24 JOB ID     : 8922dbc88c6453e9dc267171544c326f48e7ba14
05:33:24 JOB LOG    : =
/****/avocado-korg/korg_pvm/results/job-2019-03-06T19.03-8922dbc/job.log
05:33:24  (1/1) =
avocado-misc-tests/generic/stress-ng.py:Stressng.test;exclude-stressors-wo=
rkers-4d3c:  PASS (1200.30 s)
05:53:25 RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | =
INTERRUPT 0 | CANCEL 0
05:53:25 JOB TIME   : 1200.71 s
05:53:25 JOB HTML   : =
/****/avocado-korg/korg_pvm/results/job-2019-03-06T19.03-8922dbc/results.h=
tml
05:53:25 19:23:25 INFO    :=20
05:53:25 19:23:25 INFO    :=20
05:53:25 19:23:25 INFO    : Running Host Tests Suite korg_pvm_stress
05:53:25 19:23:25 INFO    : Running: /bin/avocado run =
avocado-misc-tests/perf/stress.py --force-job-id =
3351910945caf1b449f3565b78fd3b1401fb5551  --job-results-dir =
/****/avocado-korg/korg_pvm/results
05:53:26 JOB ID     : 3351910945caf1b449f3565b78fd3b1401fb5551
05:53:26 JOB LOG    : =
/****/avocado-korg/korg_pvm/results/job-2019-03-06T19.23-3351910/job.log
05:53:26  (1/1) avocado-misc-tests/perf/stress.py:Stress.test:  [  =
947.743425] request_module: kmod_concurrent_max (0) close to 0 =
(max_modprobes: 50), for module net-pf-2-proto-33-type-6, throttling...
05:54:28 [ 2873.201865] ------------[ cut here ]------------
05:54:28 [ 2873.201907] kernel BUG at mm/page_alloc.c:3124!
05:54:28 [ 2873.201918] Oops: Exception in kernel mode, sig: 5 [#1]
05:54:28 [ 2873.201928] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 =
NUMA pSeries
05:54:28 [ 2873.201950] Dumping ftrace buffer:
05:54:28 [ 2873.201997]    (ftrace buffer empty)
05:54:28 [ 2873.202005] Modules linked in: unix_diag ip6t_rpfilter =
ipt_REJECT nf_reject_ipv4 ip6t_REJECT nf_reject_ipv6 xt_conntrack ip_set =
nfnetlink ebtable_nat ebtable_broute bridge stp llc ip6table_nat =
ip6table_mangle ip6table_raw iptable_nat nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle iptable_raw =
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter sunrpc =
sg uio_pdrv_genirq uio pseries_rng ip_tables ext4 mbcache jbd2 sr_mod =
cdrom sd_mod ibmvscsi scsi_transport_srp ibmveth dm_mirror =
dm_region_hash dm_log dm_mod
05:54:28 [ 2873.202108] CPU: 17 PID: 180 Comm: kcompactd1 Not tainted =
5.0.0-next-20190306-autotest #1
05:54:28 [ 2873.202119] NIP:  c000000000327320 LR: c0000000002f1c10 CTR: =
c0000000002f1840
05:54:28 [ 2873.202131] REGS: c000000458eeb640 TRAP: 0700   Not tainted  =
(5.0.0-next-20190306-autotest)
05:54:28 [ 2873.202140] MSR:  8000000102029033 =
<SF,VEC,EE,ME,IR,DR,RI,LE,TM[E]>  CR: 24882088  XER: 20040000
05:54:28 [ 2873.202161] CFAR: c0000000002f1c0c IRQMASK: 1=20
05:54:28 [ 2873.202161] GPR00: c0000000002f1c10 c000000458eeb8d0 =
c0000000012b9500 c0000008bff1cb58=20
05:54:28 [ 2873.202161] GPR04: 0000000000000005 0000000000000308 =
c0000008bff1cc98 0000000000000780=20
05:54:28 [ 2873.202161] GPR08: c000000001478220 0000000000000001 =
0000000000000000 0000000000000000=20
05:54:28 [ 2873.202161] GPR12: 0000000024884082 c00000001ec54280 =
000000000006fd50 0000000000069b00=20
05:54:28 [ 2873.202161] GPR16: 000000000007ad00 0000000000000035 =
ff40000022ffc700 0000000000000040=20
05:54:28 [ 2873.202161] GPR20: c0000008bff1cc88 c0000008bff1cb58 =
0000000000000000 0000000000000000=20
05:54:28 [ 2873.202161] GPR24: 0000000000000001 0000000000000000 =
0000000000000000 0000000000000005=20
05:54:28 [ 2873.202161] GPR28: c0000008bff1c980 0000000000000000 =
0000000000000001 c0000008bff1cb58=20
05:54:28 [ 2873.202251] NIP [c000000000327320] =
__isolate_free_page+0x90/0x2c0
05:54:28 [ 2873.202263] LR [c0000000002f1c10] =
compaction_alloc+0x3d0/0xae0
05:54:28 [ 2873.202271] Call Trace:
05:54:28 [ 2873.202280] [c000000458eeb8d0] [f0000000011d9800] =
0xf0000000011d9800 (unreliable)
05:54:28 [ 2873.202293] [c000000458eeb940] [c0000000002f1c10] =
compaction_alloc+0x3d0/0xae0
05:54:28 [ 2873.202305] [c000000458eeba20] [c00000000036cd5c] =
unmap_and_move+0x7c/0x9a0
05:54:28 [ 2873.202315] [c000000458eeba90] [c00000000036ef14] =
migrate_pages+0x224/0x870
05:54:28 [ 2873.202326] [c000000458eebb60] [c0000000002f3c9c] =
compact_zone+0x3ac/0x1020
05:54:28 [ 2873.202336] [c000000458eebc60] [c0000000002f4de8] =
kcompactd_do_work+0x188/0x350
05:54:28 [ 2873.202347] [c000000458eebd40] [c0000000002f5068] =
kcompactd+0xb8/0x2a0
05:54:28 [ 2873.202359] [c000000458eebdb0] [c0000000001429d0] =
kthread+0x160/0x1a0
05:54:28 [ 2873.202371] [c000000458eebe20] [c00000000000b64c] =
ret_from_kernel_thread+0x5c/0x70
05:54:28 [ 2873.202380] Instruction dump:
05:54:28 [ 2873.202388] 3d02001c 3908ed20 78e71f24 794a57a0 6d29f000 =
1f4a0680 7d290034 7f28382a=20
05:54:28 [ 2873.202401] 5529d97e 79290020 7fb9d214 69290001 <0b090000> =
3fc2001b 3bde92b8 38a00002=20
05:54:28 [ 2873.202418] ---[ end trace 65562a20cc8f8bc8 ]---
05:54:28 [ 2873.203709]=20
05:54:29 [ 2874.203737] Kernel panic - not syncing: Fatal exception
05:54:29 [ 2874.211867] Dumping ftrace buffer:
05:54:29 [ 2874.211883]    (ftrace buffer empty)
05:54:29 [ 2874.213931] WARNING: CPU: 17 PID: 180 at =
drivers/tty/vt/vt.c:4227 do_unblank_screen+0x1dc/0x250
05:54:29 [ 2874.213939] Modules linked in: unix_diag ip6t_rpfilter =
ipt_REJECT nf_reject_ipv4 ip6t_REJECT nf_reject_ipv6 xt_conntrack ip_set =
nfnetlink ebtable_nat ebtable_broute bridge stp llc ip6table_nat =
ip6table_mangle ip6table_raw iptable_nat nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle iptable_raw =
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter sunrpc =
sg uio_pdrv_genirq uio pseries_rng ip_tables ext4 mbcache jbd2 sr_mod =
cdrom sd_mod ibmvscsi scsi_transport_srp ibmveth dm_mirror =
dm_region_hash dm_log dm_mod
05:54:29 [ 2874.214002] CPU: 17 PID: 180 Comm: kcompactd1 Tainted: G     =
 D           5.0.0-next-20190306-autotest #1
05:54:29 [ 2874.214011] NIP:  c00000000062085c LR: c000000000620844 CTR: =
c000000000a20af0
05:54:29 [ 2874.214020] REGS: c000000458eeb130 TRAP: 0700   Tainted: G   =
   D            (5.0.0-next-20190306-autotest)
05:54:29 [ 2874.214028] MSR:  8000000000021033 <SF,ME,IR,DR,RI,LE>  CR: =
28882042  XER: 20040009
05:54:29 [ 2874.214039] CFAR: c000000000191618 IRQMASK: 3=20
05:54:29 [ 2874.214039] GPR00: c000000000620844 c000000458eeb3c0 =
c0000000012b9500 0000000000000000=20
05:54:29 [ 2874.214039] GPR04: 0000000000000003 c0000004515c000e =
0000000000001dd7 c000000458eeb300=20
05:54:29 [ 2874.214039] GPR08: 0000000000000000 0000000000000000 =
0000000000000000 0000000000001001=20
05:54:29 [ 2874.214039] GPR12: 0000000088882048 c00000001ec54280 =
000000000006fd50 0000000000069b00=20
05:54:29 [ 2874.214039] GPR16: 000000000007ad00 0000000000000035 =
ff40000022ffc700 0000000000000040=20
05:54:29 [ 2874.214039] GPR20: c0000008bff1cc88 c0000008bff1cb58 =
0000000000000000 0000000000000000=20
05:54:29 [ 2874.214039] GPR24: 0000000000000001 0000000000000000 =
c000000001199fa0 c000000001485760=20
05:54:29 [ 2874.214039] GPR28: c000000001485738 0000000000000000 =
c000000000c33550 c000000001594178=20
05:54:29 [ 2874.214108] NIP [c00000000062085c] =
do_unblank_screen+0x1dc/0x250
05:54:29 [ 2874.214115] LR [c000000000620844] =
do_unblank_screen+0x1c4/0x250
05:54:29 [ 2874.214122] Call Trace:
05:54:29 [ 2874.214126] [c000000458eeb3c0] [c000000000620874] =
do_unblank_screen+0x1f4/0x250 (unreliable)
05:54:29 [ 2874.214138] [c000000458eeb440] [c000000000112754] =
panic+0x1dc/0x3b8
05:54:29 [ 2874.214146] [c000000458eeb4d0] [c0000000000288c4] =
oops_end+0x1e4/0x1f0
05:54:29 [ 2874.214155] [c000000458eeb550] [c00000000002b0cc] =
program_check_exception+0x2ac/0x3b0
05:54:29 [ 2874.214164] [c000000458eeb5d0] [c000000000008e00] =
program_check_common+0x130/0x140
05:54:29 [ 2874.214176] --- interrupt: 700 at =
__isolate_free_page+0x90/0x2c0
05:54:29 [ 2874.214176]     LR =3D compaction_alloc+0x3d0/0xae0
05:54:29 [ 2874.214187] [c000000458eeb8d0] [f0000000011d9800] =
0xf0000000011d9800 (unreliable)
05:54:29 [ 2874.214196] [c000000458eeb940] [c0000000002f1c10] =
compaction_alloc+0x3d0/0xae0
05:54:29 [ 2874.214205] [c000000458eeba20] [c00000000036cd5c] =
unmap_and_move+0x7c/0x9a0
05:54:29 [ 2874.214213] [c000000458eeba90] [c00000000036ef14] =
migrate_pages+0x224/0x870
05:54:29 [ 2874.214221] [c000000458eebb60] [c0000000002f3c9c] =
compact_zone+0x3ac/0x1020
05:54:29 [ 2874.214230] [c000000458eebc60] [c0000000002f4de8] =
kcompactd_do_work+0x188/0x350
05:54:29 [ 2874.214239] [c000000458eebd40] [c0000000002f5068] =
kcompactd+0xb8/0x2a0
05:54:29 [ 2874.214247] [c000000458eebdb0] [c0000000001429d0] =
kthread+0x160/0x1a0
05:54:29 [ 2874.214256] [c000000458eebe20] [c00000000000b64c] =
ret_from_kernel_thread+0x5c/0x70
05:54:29 [ 2874.214263] Instruction dump:
05:54:29 [ 2874.214269] 7c0803a6 4e800020 60000000 60000000 60420000 =
4bb70dc9 60000000 2fa30000=20
05:54:29 [ 2874.214280] 409efe88 813f0000 2f890000 409efe7c <0fe00000> =
4bfffe74 60000000 60000000=20
05:54:29 [ 2874.214291] ---[ end trace 65562a20cc8f8bc9 ]---
05:54:29 [ 2874.214299] Rebooting in 10 seconds..
05:54:42=20
05:54:42=20
05:54:42=20
05:54:42=20
05:54:42=20

--Apple-Mail=_0C8C18F8-D6FA-40D6-9315-ADA61B2EC4A5--

