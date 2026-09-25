Return-Path: <linuxppc-dev+bounces-28190-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794FBC9830D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 08:11:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrk1G6Zcvz2yHT;
	Fri, 25 Sep 2026 18:11:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790323874;
	cv=none; b=HRQyUKcoLpmDhhWsoqRcpKYLmKaeTejNlrywh6K2cfFnQgS9jqzAdvfNDEipCo/Qhe6isS3OGFDt67fyDDVx/T/KU8pdaA1aPXTrW4SD5i4PCXK8rciIQtcY5vQNuramZQNI9+uyL547t8DhcL4aC0RnKmWgA3hMCkPRE2f3pImjymHg84uvOPeH+QjfjzEkz8NETXwuaBuY2DrNkHcvG4vRBMwkvdoFGRyqF3jVa8Cp8M/8axqR1Q65whDS14JWv62/wvInhROc88um1zPSUr4GvCKRTApR6mADHrKa4Lesf4QEMI+ogZhYNDkwm3+AdE5C35FSlYUoWVBvHhlqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790323874; c=relaxed/relaxed;
	bh=D8hds6JJ+XykN7VctCbIaA+MUoBFrKqSddX+3Qmp89M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VLjLTuQYXdgH1N8Imou7G9mhiNjTLku4iD+Fpnj2r/81DRcDkeBAQ6y8+UPMr4hnMy4EISxjgUow9rkwy6fZ7Kj84tIdETWdPZPEh9ZT93Cg8szizsyJx3tuTCFyDLxJIQoYbQPIDk3UhkMMrqMMeGM+0Tqvop9yg+io7qHaeNuenDCkg7vbmXXzn3I4jIEIxf2TYm4jtAHrBJWCpdgfL5u5GlV/tvRj6yZkQGqjwlEhG7iEHDlxaYlfxQ8LkygBit8PZAi1nMfnADKemP49jXqLIjcIK4S602QExFaYBNoNa1usmCJpszEhHjSkChWYvyPv6TJkgYQDhb+nDt2q/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0E2Xcygj; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ChGrk3HV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OIIWCwhW; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LvAI/rIa; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0E2Xcygj;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ChGrk3HV;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OIIWCwhW;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LvAI/rIa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrk1D3j4Nz2yDD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 18:11:12 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2AB142008D;
	Fri, 25 Sep 2026 08:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790323864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=D8hds6JJ+XykN7VctCbIaA+MUoBFrKqSddX+3Qmp89M=;
	b=0E2XcygjavRKYMgomClyFg504+Czs9bz0iIyIkV+Twlxlti8wi0a4P+MaV4Qm+/lyTAcpO
	aH+jnydcT+ykD6UBTr/NDRpyH54akF8RVuVJlFie6q3R1MRe1CtiwX8UyMMTraq8/Ex464
	WfObYvKGSQkmhdYLqxNb7UzSeahAbA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790323864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=D8hds6JJ+XykN7VctCbIaA+MUoBFrKqSddX+3Qmp89M=;
	b=ChGrk3HVTvp+1Rn98O1M4PHK/hDnaGyoh1AgkHTfsSgUP+OnaZ2Kblu9zsvHhOTuj/eVfT
	l5kefovzIZvp40DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OIIWCwhW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="LvAI/rIa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790323860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=D8hds6JJ+XykN7VctCbIaA+MUoBFrKqSddX+3Qmp89M=;
	b=OIIWCwhWQ4N8L1QlEe/7Xrw2BtbHmP/UHLGfi5j2LozQG6w7+ekCGjY394eEikYM35Kf6T
	dAQoESCqgspgPdSPCVU3qieUDsSQzvGd57BaFPkg3Xt2Z/ZgetcoMzb4s5/jSopN+n8qhd
	iBXgFs/M1AplQkK5sGWvgshjZCZoMe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790323860;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=D8hds6JJ+XykN7VctCbIaA+MUoBFrKqSddX+3Qmp89M=;
	b=LvAI/rIaMwAqpkP4qlgM6Rqb4tcd2wiJBRPopr+hDH9EmTW7kKydo1CtIJq8+9252xRmgL
	muitO8kJ+vTrbnBg==
Date: Fri, 25 Sep 2026 10:10:59 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org
Subject: early boot crash in init_tracer_tracefs
Message-ID: <arYskzbiaNzBR9MD@kunlun.suse.cz>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Rspamd-Queue-Id: 2AB142008D
X-Spamd-Result: default: False [12.81 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	R_MIXED_CHARSET(0.63)[subject];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	NEURAL_HAM_SHORT(-0.01)[-0.039];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spamd-Bar: ++++++++++++
X-Spam: Yes

Hello,

There appears to be a regression between

Linux 6.19.12
https://github.com/openSUSE/kernel/tree/7a15f44a1b293702f2b6a93f8fe792ab46d2cb3d
https://github.com/openSUSE/kernel-source/blob/9f6830f/config/ppc64le/default


Linux 7.0.12
https://github.com/openSUSE/kernel/tree/4c9922875554ec191166ba6c0145f12d8ff9d4fc
https://github.com/openSUSE/kernel-source/blob/2ebf0bc/config/ppc64le/default

With 7.0 being the first kernel version that forces preemtion it was
suspected that perhaps this is due to preemption but same result with
6.19, same config + PREEMPT=y, and 7.0, same config. That is preemption
does not make any difference, the code change between 6.19 and 7.0 does.

The crash happens about 50% of the time when booting the kernel as
NestedV2 KVM guest. Bisection did not lead to anything. Changing config
such as disabling some code that could not possibly get used (drm,
sound, hid) makes the problem unreproducible. As the bisection descends
into some fairly old revisions it is possible that due to code changes
the problem becomes too difficult to reproduce.

There was recently a fix posted for preemtion in ftrace code but it does
not help.

It is possible to save the memory from qemu after the failed boot but
crash tool refuses to open it because of SMP mismatch between the dump
and vmlinux.

Any idea how to futher diagnose this problem?

Thanks

Michal

Typical boot log when the problem is seen:

SLOF **********************************************************************
QEMU Starting
 Build Date = Aug 13 2026 14:47:36
 FW Version = abuild@OBS release 20230918
 Press "s" to enter Open Firmware.

Populating /vdevice methods
Populating /vdevice/vty@30000000
Populating /vdevice/nvram@71000000
Populating /pci@800000020000000
Loading Linux 7.0.12-1.g2ebf0bc-default ...
Loading initial ramdisk ...                
OF stdout device is: /vdevice/vty@30000000
Preparing to boot Linux version 7.0.12-1.g2ebf0bc-default (geeko@buildhost) (gcc (SUSE Linux) 15.3.0, GNU ld (GNU Binutils; openSUSE Tumbleweed) 2.45.0.20251103-4) #1 SMP PREEMPT_DYNAMIC Mon Jun 15 08:39:32 UTC 2026 (2ebf0bc)
Detected machine type: 0000000000000101
command line: BOOT_IMAGE=/boot/vmlinux-7.0.12-1.g2ebf0bc-default root=UUID=304c7f07-efbb-1070-2f27-accd935ec088 rw quiet systemd.show_status=1 security=selinux selinux=1
Max number of cores passed to firmware: 8192 (NR_CPUS = 8192)
Calling ibm,client-architecture-support... done
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 00000000066b0000
  alloc_top    : 0000000030000000
  alloc_top_hi : 0000003e00000000
  rmo_top      : 0000000030000000
  ram_top      : 0000003e00000000
instantiating rtas at 0x000000002fff0000... done
prom_hold_cpus: skipped
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x00000000066c0000 -> 0x00000000066c0bec
Device tree struct  0x00000000066d0000 -> 0x00000000066f0000
Quiescing Open Firmware ...
Booting Linux via __start() @ 0x0000000000250000 ...
[    0.000000][    T0] ERROR: Failed to allocate trace buffer
[    0.000000][    T0] ERROR: tracer: failed to allocate ring buffer!
Linux ppc64le
#1 SMP PREEMPT_D[    0.285758][  T673] BUG: Kernel NULL pointer dereference on read at 0x00000010
[    0.285877][  T673] Faulting instruction address: 0xc000000000485bd0
[    0.285903][    T1] VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
[    0.285954][  T673] Oops: Kernel access of bad area, sig: 7 [#1]
[    0.286133][  T673] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
[    0.286240][  T673] Modules linked in:
[    0.286288][  T673] CPU: 15 UID: 0 PID: 673 Comm: kworker/u531:0 Not tainted 7.0.12-1.g2ebf0bc-default #1 PREEMPT(full) openSUSE Tumbleweed (unreleased)  cf0846124d7853fab338aeae87203b36cac18419
[    0.286527][  T673] Hardware name: IBM pSeries (emulated by qemu) Power11 (architected) 0x820200 0xf000007 of:SLOF,HEAD hv:linux,kvm pSeries
[    0.286739][  T673] Workqueue: trace_init_wq tracer_init_tracefs_work_func
[    0.286818][  T673] NIP:  c000000000485bd0 LR: c000000000448864 CTR: c0000000005a3420
[    0.286906][  T673] REGS: c00000000a7a7960 TRAP: 0300   Not tainted  (7.0.12-1.g2ebf0bc-default)
[    0.287014][  T673] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 44088404  XER: 00000000
[    0.287122][  T673] CFAR: c000000000448860 DAR: 0000000000000010 DSISR: 00080000 IRQMASK: 0 
[    0.287122][  T673] GPR00: c000000000448864 c00000000a7a7c00 c000000001f38100 c000000002a5c098 
[    0.287122][  T673] GPR04: c0000000017dc5f0 c0000000017dc5e8 000000000000001f 0000000000000064 
[    0.287122][  T673] GPR08: c0000000017dc628 00000000000005f0 00000000000005e8 0000000084000404 
[    0.287122][  T673] GPR12: c0000000005a3420 c000003dfff43d80 c0000000018e5600 c0000000018e54f0 
[    0.287122][  T673] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
[    0.287122][  T673] GPR20: c0000000013ec418 c0000000013ef6d8 c0000000017dc5a0 c0000000017dc590 
[    0.287122][  T673] GPR24: c000000001825330 c0000000017dc628 c000000014b52a05 0000000000000000 
[    0.287122][  T673] GPR28: c0000000017dc5e8 0000000000000000 c0000000017dc5f0 c000000002a5e008 
[    0.287970][  T673] NIP [c000000000485bd0] __find_event_file+0x70/0x3c0
[    0.288046][  T673] LR [c000000000448864] init_tracer_tracefs+0x274/0xc80
[    0.288122][  T673] Call Trace:
[    0.288167][  T673] [c00000000a7a7c00] [c00000000a7a7c60] 0xc00000000a7a7c60 (unreliable)
[    0.288258][  T673] [c00000000a7a7c60] [c000000000448864] init_tracer_tracefs+0x274/0xc80
[    0.288348][  T673] [c00000000a7a7dc0] [c00000000203fcf0] tracer_init_tracefs_work_func+0x50/0x320
[    0.288452][  T673] [c00000000a7a7e50] [c0000000002620e8] process_one_work+0x1e8/0x5c0
[    0.288541][  T673] [c00000000a7a7f10] [c00000000026309c] worker_thread+0x1dc/0x3d0
[    0.288630][  T673] [c00000000a7a7f90] [c00000000026fa34] kthread+0x194/0x1b0
[    0.288721][  T673] [c00000000a7a7fe0] [c00000000000de58] start_kernel_thread+0x14/0x18
[    0.288810][  T673] Code: fb410030 fb810040 fba10048 7cbc2b78 3ba00000 fbc10050 7d194378 7c9e2378 2e2a0fc0 2da90fc0 f8010070 60420000 <e93b0010> 81490058 e8890018 714a0208 
[    0.289001][  T673] ---[ end trace 0000000000000000 ]---
[    0.290718][  T673] pstore: backend (nvram) writing error (-1)
[    0.290805][  T673] 
[    0.290839][  T673] note: kworker/u531:0[673] exited with irqs disabled
[    0.304261][    T1] NET: Registered PF_INET protocol family
[    0.304602][    T1] IP idents hash table entries: 262144 (order: 5, 2097152 bytes, linear)
[    0.315892][    T1] tcp_listen_portaddr_hash hash table entries: 65536 (order: 4, 1048576 bytes, linear)
[    0.316104][    T1] Table-perturb hash table entries: 65536 (order: 2, 262144 bytes, linear)
[    0.316224][    T1] TCP established hash table entries: 524288 (order: 6, 4194304 bytes, linear)
[    0.316873][    T1] TCP bind hash table entries: 65536 (order: 5, 2097152 bytes, linear)
[    0.317199][    T1] TCP: Hash tables configured (established 524288 bind 65536)
[    0.317748][    T1] MPTCP token hash table entries: 65536 (order: 5, 1572864 bytes, linear)
[    0.317970][    T1] UDP hash table entries: 65536 (order: 6, 4194304 bytes, linear)
[    0.318402][    T1] UDP-Lite hash table entries: 65536 (order: 6, 4194304 bytes, linear)
[    0.319148][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.319249][    T1] NET: Registered PF_XDP protocol family
[    0.320019][    T1] PCI: CLS 0 bytes, default 128
[    0.320281][    T1] rtas_flash: no firmware flash support
[    0.320967][  T770] Trying to unpack rootfs image as initramfs...
[    0.331385][    T1] Initialise system trusted keyrings
[    0.331739][    T1] Key type blacklist registered
[    0.332191][    T1] workingset: timestamp_bits=38 max_order=22 bucket_order=0
[    0.333804][    T1] integrity: Platform Keyring initialized
[    0.333875][    T1] integrity: Machine keyring initialized
[    0.333935][    T1] Allocating IMA blacklist keyring.
[    0.343039][    T1] Key type asymmetric registered
[    0.343109][    T1] Asymmetric key parser 'x509' registered
[    0.344215][    T1] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    0.344623][    T1] io scheduler mq-deadline registered
[    0.344688][    T1] io scheduler kyber registered
[    0.344800][    T1] io scheduler bfq registered
[    0.380554][    T1] ledtrig-cpu: registered to indicate activity on CPUs
[    0.380794][    T1] virtio-pci 0000:00:01.0: enabling device (0100 -> 0103)
[    0.382384][    T1] virtio-pci 0000:00:01.0: ibm,query-pe-dma-windows(2026) 800 8000000 20000000 returned 0, lb=2000000000 ps=107 wn=1
[    0.383175][    T1] virtio-pci 0000:00:01.0: ibm,create-pe-dma-window(2027) 800 8000000 20000000 18 26 returned 0 (liobn = 0x80000001 starting addr = 8000000 0)
[    0.386395][    T1] virtio-pci 0000:00:01.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.386509][    T1] virtio-pci 0000:00:01.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.386621][    T1] virtio-pci 0000:00:01.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.386723][    T1] virtio-pci 0000:00:01.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.388040][    T1] virtio-pci 0000:00:03.0: enabling device (0100 -> 0103)
[    0.390005][    T1] virtio-pci 0000:00:03.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.390111][    T1] virtio-pci 0000:00:03.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.390216][    T1] virtio-pci 0000:00:03.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.390316][    T1] virtio-pci 0000:00:03.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.392116][    T1] virtio-pci 0000:00:04.0: enabling device (0100 -> 0103)
[    0.394076][    T1] virtio-pci 0000:00:04.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.394184][    T1] virtio-pci 0000:00:04.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.394288][    T1] virtio-pci 0000:00:04.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.394389][    T1] virtio-pci 0000:00:04.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.395729][    T1] virtio-pci 0000:00:05.0: enabling device (0100 -> 0103)
[    0.397705][    T1] virtio-pci 0000:00:05.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.397814][    T1] virtio-pci 0000:00:05.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.397919][    T1] virtio-pci 0000:00:05.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.398024][    T1] virtio-pci 0000:00:05.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.399426][    T1] virtio-pci 0000:00:06.0: enabling device (0100 -> 0103)
[    0.401288][    T1] virtio-pci 0000:00:06.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.401396][    T1] virtio-pci 0000:00:06.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.401502][    T1] virtio-pci 0000:00:06.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.401604][    T1] virtio-pci 0000:00:06.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.403644][    T1] virtio-pci 0000:00:07.0: enabling device (0100 -> 0103)
[    0.405723][    T1] virtio-pci 0000:00:07.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.405830][    T1] virtio-pci 0000:00:07.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.405936][    T1] virtio-pci 0000:00:07.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.406044][    T1] virtio-pci 0000:00:07.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.409460][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.427929][  T770] Freeing initrd memory: 21120K
[    0.431965][    T1] Non-volatile memory driver v1.3
[    0.432069][    T1] pseries_rng: Registering IBM pSeries RNG driver
[    0.433884][    T1] mousedev: PS/2 mouse device common for all mice
[    0.435769][    T1] pseries_idle_driver registered
[    0.435912][    T1] hid: raw HID events driver (C) Jiri Kosina
[    0.436062][    T1] drop_monitor: Initializing network drop monitor service
[    0.436412][    T1] NET: Registered PF_INET6 protocol family
[    0.437731][    T1] Segment Routing with IPv6
[    0.437819][    T1] RPL Segment Routing with IPv6
[    0.437897][    T1] In-situ OAM (IOAM) with IPv6
[    0.438002][    T1] PFKEY is deprecated and scheduled to be removed in 2027, please contact the netdev mailing list
[    0.438125][    T1] NET: Registered PF_KEY protocol family
[    0.438508][    T1] secvar-sysfs: Failed to retrieve secvar operations
[    0.441215][    T1] registered taskstats version 1
[    0.464617][    T1] Loading compiled-in X.509 certificates
[    0.481670][    T1] Loaded X.509 cert 'home:tiwai OBS Project: 466e10c6490242bdd3a9985914c1906197b53a81'
[    0.487739][    T1] Demotion targets for Node 0: null
[    0.487834][    T1] page_owner is disabled
[    0.518088][    T1] Key type .fscrypt registered
[    0.518163][    T1] Key type fscrypt-provisioning registered
[    0.518473][    T1] Key type big_key registered
[    0.536738][    T1] Key type encrypted registered
[    0.536916][    T1] Secure boot mode disabled
[    0.536994][    T1] ima: No TPM chip found, activating TPM-bypass!
[    0.537070][    T1] Loading compiled-in module X.509 certificates
[    0.537347][    T1] Loaded X.509 cert 'home:tiwai OBS Project: 466e10c6490242bdd3a9985914c1906197b53a81'
[    0.537451][    T1] ima: Allocated hash algorithm: sha256
[    0.538132][    T1] Secure boot mode disabled
[    0.538236][    T1] Trusted boot mode disabled
[    0.538303][    T1] ima: No architecture policies found
[    0.538448][    T1] evm: Initialising EVM extended attributes:
[    0.538523][    T1] evm: security.selinux
[    0.538569][    T1] evm: security.SMACK64 (disabled)
[    0.538629][    T1] evm: security.SMACK64EXEC (disabled)
[    0.538689][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[    0.538762][    T1] evm: security.SMACK64MMAP (disabled)
[    0.538822][    T1] evm: security.apparmor
[    0.538868][    T1] evm: security.ima
[    0.538915][    T1] evm: security.capability
[    0.538983][    T1] evm: HMAC attrs: 0x1
[    0.553344][    T1] SED: plpks not available


