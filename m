Return-Path: <linuxppc-dev+bounces-18946-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B1F10F2875
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 23:11:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjGbj1W78z2yfs;
	Sat, 28 Mar 2026 10:11:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774620532;
	cv=none; b=bsMLpQYHJjYotFX+NfiCPwy1mf18vc81VXeVA31YQktZ+XBdQaHk2hkrodqEzBsgKSF31beyA462fGQqPc0gVmcOd9fm04MNEMA00/lI9Nyb8IWdtmtVyfnApxEx7V1AmQsXHbacDvI9NjyE+4+FC4b5iH8IFTOmQQJADaVBAYyUIwsK8xUHw/+Dv6mj6bGcC77t1UpP8TBoGpXwCwgMYokyDx20A+DBvS0gZ8eL/me5L8d5B4bdEAAcK7sTfMCeh/Z01Hu0r96SMhrGMwp7aqJDylsVFhbfWpukoP56CofJ+aof2u6dm9tsPVY3i0Lw6Ukf5IKWvblyt4hjf3N7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774620532; c=relaxed/relaxed;
	bh=b5WNyX5o+g15xOHk9Vvq0Jm9HTCv4IG83yFDt6da/xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ij6WkH2GgB0Tg5BCs+wbILaLFLp4pgcfg10YOCU/6v3Z3cCKHTsAhvG1m4YrkzOTK/YSJLp1S0yNLDWdIB1eG9OswicisB7Q/nWq7v+SIa8fINFpfKHtczcK5V+Mx7m17utl5qk0DYLlpZ2XLTeRualRXUb7+/XqyrzukcOofaGHERaq3BbwdYTlOL+sXpx11+IQJVrn+VvXlwlGPgYe9FN6y7b7bvXrW7+QyX7pMoB7t+H2l08Ay/vC9/FPxD2JxKtwAB/cT0nvETdIiSs2tP3/bLe/BnjAzWeAUNtiVKTXGLh4MQG8ETtjVyGtELjZidffUnlNjnUNCppizKiG/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.a=rsa-sha256 header.s=s29768273 header.b=hQJGGf48; dkim-atps=neutral; spf=pass (client-ip=212.227.15.4; helo=mout.web.de; envelope-from=spasswolf@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.a=rsa-sha256 header.s=s29768273 header.b=hQJGGf48;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.15.4; helo=mout.web.de; envelope-from=spasswolf@web.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 431 seconds by postgrey-1.37 at boromir; Sat, 28 Mar 2026 01:08:48 AEDT
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fj2Yr5qPCz2xQr
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 01:08:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1774620524; x=1775225324; i=spasswolf@web.de;
	bh=b5WNyX5o+g15xOHk9Vvq0Jm9HTCv4IG83yFDt6da/xw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hQJGGf48aGvqPmGh+060yl+Ap5HRe2yapzf2w3lTQ1XHnLy/RtiMTtwf1KfWF6/E
	 K3r/RVleDJndcw5HtHcgCcYkRDq3yM09oJ9UTn0wY2gDVvKdvfVgwlQB9qHi3rNxe
	 9/4clKJekqDaRNNt0dCCifJFD8FlDNOuhcMzQlflRyxuEOg3rQWfQc7BgBZaiZjCO
	 uBDjr5lQuHZAvjhws4HVkOkH08FRqjiKKvxmxcvAqmjdoSbodXCsGTcQJ6S+SjXcF
	 vbWjS1n19p1Fo/4tkCiUd3nAUoCZyJmrIiyg3yQCjZF6LO7KGteVSuMIW4WLSGgKK
	 F3H+l7blKiq9vRAKYg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIL0C-1wIGpE1PSG-000jY3; Fri, 27
 Mar 2026 15:01:16 +0100
From: Bert Karwatzki <spasswolf@web.de>
To: Mike Rapoport <rppt@kernel.org>
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-kernel@vger.kernel.org,
	Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	andreas@gaisler.com,
	ardb@kernel.org,
	bp@alien8.de,
	brauner@kernel.org,
	catalin.marinas@arm.com,
	chleroy@kernel.org,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	david@kernel.org,
	devicetree@vger.kernel.org,
	dvyukov@google.com,
	elver@google.com,
	glider@google.com,
	hannes@cmpxchg.org,
	hpa@zytor.com,
	ilias.apalodimas@linaro.org,
	iommu@lists.linux.dev,
	jack@suse.cz,
	jackmanb@google.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lorenzo.stoakes@oracle.com,
	m.szyprowski@samsung.com,
	maddy@linux.ibm.com,
	mhiramat@kernel.org,
	mhocko@suse.com,
	mingo@redhat.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	robh@kernel.org,
	robin.murphy@arm.com,
	saravanak@kernel.org,
	sparclinux@vger.kernel.org,
	surenb@google.com,
	tglx@kernel.org,
	vbabka@kernel.org,
	viro@zeniv.linux.org.uk,
	will@kernel.org,
	x86@kernel.org,
	ziy@nvidia.com
Subject: Warning from free_reserved_area() in next-20260325+
Date: Fri, 27 Mar 2026 15:01:08 +0100
Message-ID: <20260327140109.7561-1-spasswolf@web.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323074836.3653702-10-rppt@kernel.org> 
References: 
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jwEpGLTFv6lxOcQdrUyNC0xH05pvVO5X2lpgj2DKPAX3uJursNt
 rMMU5c9UYBeudcXm3uROLBUlLd91P7V68GG4LyDXEcXT6VaLDh0LZ1YG+XCaPdVoYoOLcoM
 6ALUn81ZBMWLAA1p/4bNmu+esn5JDVrdhOgeNUENyKINGIMiDu1TfLAFkxXs79H5JA1EM2S
 zXdMZt1RvAhW2Infl9yLg==
UI-OutboundReport: notjunk:1;M01:P0:PjiO/Yrzmao=;raUTeOHll6auW5i6Kjw3K9dyBIr
 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
 zS9RDVNLEp1

Starting with linux next-20260325 I see the following warning early in the
boot process of a machine running debian stable (trixie) (except for the ke=
rnel):

[    0.027118] [      T0] ------------[ cut here ]------------
[    0.027118] [      T0] Cannot free reserved memory because of deferred i=
nitialization of the memory map
[    0.027119] [      T0] WARNING: mm/memblock.c:904 at __free_reserved_are=
a+0xa9/0xc0, CPU#0: swapper/0/0
[    0.027122] [      T0] Modules linked in:
[    0.027123] [      T0] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted =
7.0.0-rc5-next-20260326-master #385 PREEMPT_RT=20
[    0.027125] [      T0] Hardware name: ASUS System Product Name/ROG STRIX=
 B850-F GAMING WIFI, BIOS 1627 02/05/2026
[    0.027125] [      T0] RIP: 0010:__free_reserved_area+0xa9/0xc0
[    0.027126] [      T0] Code: 48 89 df 48 89 ee e8 06 fe ff ff 48 89 c3 4=
8 39 e8 72 a0 5b 4c 89 e8 5d 41 5c 41 5d 41 5e c3 cc cc cc cc 48 8d 3d 97 c=
2 c6 00 <67> 48 0f b9 3a 45 31 ed eb df 66 66 2e 0f 1f 84 00 00 00 00 00 66
[    0.027127] [      T0] RSP: 0000:ffffffff9b203e98 EFLAGS: 00010202
[    0.027128] [      T0] RAX: 0000000e91c00001 RBX: ffffffff9b100c0f RCX: =
0000000080000001
[    0.027128] [      T0] RDX: 00000000000000cc RSI: 0000000e2d42d000 RDI: =
ffffffff9b32ef60
[    0.027128] [      T0] RBP: ffff9eeafdd6fbc0 R08: 0000000000000000 R09: =
0000000000000001
[    0.027129] [      T0] R10: 0000000000001000 R11: 8000000000000163 R12: =
000000000000006f
[    0.027129] [      T0] R13: 0000000000000000 R14: 0000000000000045 R15: =
000000005c8a1000
[    0.027129] [      T0] FS:  0000000000000000(0000) GS:ffff9eeb21c05000(0=
000) knlGS:0000000000000000
[    0.027130] [      T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.027130] [      T0] CR2: ffff9ee8ad801000 CR3: 0000000e2ce1e000 CR4: =
0000000000f50ef0
[    0.027131] [      T0] PKRU: 55555554
[    0.027131] [      T0] Call Trace:
[    0.027132] [      T0]  <TASK>
[    0.027132] [      T0]  free_reserved_area+0x89/0xd0
[    0.027133] [      T0]  alternative_instructions+0xee/0x110
[    0.027136] [      T0]  arch_cpu_finalize_init+0x10f/0x160
[    0.027138] [      T0]  start_kernel+0x686/0x710
[    0.027140] [      T0]  x86_64_start_reservations+0x24/0x30
[    0.027141] [      T0]  x86_64_start_kernel+0xd4/0xe0
[    0.027142] [      T0]  common_startup_64+0x13e/0x141
[    0.027143] [      T0]  </TASK>
[    0.027144] [      T0] ---[ end trace 0000000000000000 ]---

The Hardware used is this:

$ cat /proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 26
model		: 68
model name	: AMD Ryzen 9 9950X 16-Core Processor
stepping	: 0
microcode	: 0xb404035
cpu MHz		: 3607.683
cache size	: 1024 KB
physical id	: 0
siblings	: 32
core id		: 0
cpu cores	: 16
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 16
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtsc=
p lm constant_tsc rep_good amd_lbr_v2 nopl xtopology nonstop_tsc cpuid extd=
_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 =
movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_l=
egacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext p=
erfctr_core perfctr_nb bpext perfctr_llc mwaitx cpuid_fault cpb cat_l3 cdp_=
l3 hw_pstate ssbd mba perfmon_v2 ibrs ibpb stibp ibrs_enhanced vmmcall fsgs=
base tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a avx512f avx512dq=
 rdseed adx smap avx512ifma clflushopt clwb avx512cd sha_ni avx512bw avx512=
vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_m=
bm_local user_shstk avx_vnni avx512_bf16 clzero irperf xsaveerptr rdpru wbn=
oinvd cppc arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasi=
d decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif x2avic v_=
spec_ctrl vnmi avx512vbmi umip pku ospke avx512_vbmi2 gfni vaes vpclmulqdq =
avx512_vnni avx512_bitalg avx512_vpopcntdq rdpid bus_lock_detect movdiri mo=
vdir64b overflow_recov succor smca fsrm avx512_vp2intersect flush_l1d amd_l=
br_pmc_freeze
bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass srso spectr=
e_v2_user vmscape
bogomips	: 8599.98
TLB size	: 192 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

$ lspci
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Root Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge IOM=
MU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Dummy Host Bridge
00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e GPP Bridge
00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e GPP Bridge
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Dummy Host Bridge
00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e GPP Bridge
00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Dummy Host Bridge
00:04.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Dummy Host Bridge
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Dummy Host Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e Internal GPP Bridge to Bus [C:A]
00:08.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e Internal GPP Bridge to Bus [C:A]
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev=
 71)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev =
51)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 7
01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Upstr=
eam Port of PCI Express Switch (rev 25)
02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Downs=
tream Port of PCI Express Switch (rev 25)
03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] N=
avi 44 [RX 9060 XT] (rev c0)
03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Navi 48 HDMI/D=
P Audio Controller
04:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD=
 9100 PRO [PM9E1]
05:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Upstream Port (rev 01)
06:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)
06:06.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)
06:07.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)
06:08.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)
06:0c.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)
06:0d.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)
08:00.0 Ethernet controller: Intel Corporation Ethernet Controller I226-V (=
rev 06)
09:00.0 Network controller: MEDIATEK Corp. Device 7925
0b:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] 800 Series Chips=
et USB 3.x XHCI Controller (rev 01)
0c:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] 600 Series Chip=
set SATA Controller (rev 01)
0d:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. =
[AMD] Raphael/Granite Ridge PCIe Dummy Function (rev c1)
0d:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 19=
h PSP/CCP
0d:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Raphael/Granite =
Ridge USB 3.1 xHCI
0d:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Raphael/Granite =
Ridge USB 3.1 xHCI
0e:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] Raphael/Granite =
Ridge USB 2.0 xHCI

Memory used is 64G:
$ LANG=3DC free
               total        used        free      shared  buff/cache   avai=
lable
Mem:        65500068     3584080    56709424       70916     5912256    619=
15988
Swap:       78125052           0    78125052


Bert Karwatzki

