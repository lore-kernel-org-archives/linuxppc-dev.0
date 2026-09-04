Return-Path: <linuxppc-dev+bounces-26534-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339ACC79F80
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 07:40:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbpKD1WGkz2y2K;
	Fri, 04 Sep 2026 17:40:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788507616;
	cv=none; b=mPdL7/WtrVrDbvxIvXUDXzCu9oR4CGlpXWW+KxuaqM3FKAdkvmBK/rJlopwopaD89eaROlAop4oIcSYmfnvJFjE6HxkkOv0hWg+LVFN+MLOm5x8OAcDZY9YN1nWPgwEOGFXmP38zfdGhP1vpwj/oozBFgnNgJvPO3gJrNrOCqd+FNRUqUajCxjg1lu/nqOgVFhhM3ztMLZOCgUorrInFrXRbA9TOfYViGw+L3n7k1FVEtQKiiudEuwdlIzb135xMkOnPO9huaDWEakeDxdvD/SwSrK/djePR71AceQGZTfJg9tppyoAEedZnN1NwDnZXnT6+jt2D13lNQ/isGf3c+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788507616; c=relaxed/relaxed;
	bh=72ynzHiTc95VhO2YRAcBofsU8g/uUHFw/2CDLg7zbiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jb2nCsROlmFbPvqedfLSeNOOkmerGY4KfaJnpjczMtlBA9t6GBIX42Fz1P7poweXPDnqLQT6VMZf3dfZdLuxsdbpSbJINTs99jA8TwpFapMbDzqwONhNPEyrk24kPEgDRrgSm038uBnhIJVBODMcifAayZsTzjdEVTlC0R8ziGOSlXze3WI07/7jR4jxuMtklSApFUGYIA27qQBilD6gb1Lr+Oqm9tLBliYX0IdXAVGgkxfKiyqCdDGPNfGYQO6R7JXop6pNwZAcoXvC8GI3LVQCHMycYzZOBo1tD/DA53hLqcINVUnVs/Rmeut5jq12cuVzSc0dHytdPyxEzk7Buw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yoKxESv8; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uUr94xSx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=TwbXDxL6; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GW8EBkUx; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yoKxESv8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uUr94xSx;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=TwbXDxL6;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GW8EBkUx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbpKB6vXjz2xZV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 17:40:14 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 15B981FAB9;
	Fri,  4 Sep 2026 07:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788507602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72ynzHiTc95VhO2YRAcBofsU8g/uUHFw/2CDLg7zbiY=;
	b=yoKxESv8E4R5tvT1UZjCFG//Ka9t51zCfMj5rGlBgDU9rJPCwr8eKHVs3aIs7njuGh5dXj
	40aDhnE3s/Yll9h/nYSZkn25RfGXud3OOgyrHPCGWn5EctCFE29CYbZAHC9U59OLMgp2KK
	P73HDCDNMK6C6U1q2GEmcNFeUmndfKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788507602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72ynzHiTc95VhO2YRAcBofsU8g/uUHFw/2CDLg7zbiY=;
	b=uUr94xSxN+alkWvJWLstdRgdxmuFm69aht4CIObDaHor+TpD0UG3ATthhmyDMCcmJLPDyB
	GgmoG4pqb8gilMAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TwbXDxL6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GW8EBkUx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788507598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72ynzHiTc95VhO2YRAcBofsU8g/uUHFw/2CDLg7zbiY=;
	b=TwbXDxL6EP0I+65nvnFqeCLlmrxeBCekzMZ8HNwY2nKhagugJxX1PnsoRaMOnHZr8VJk0J
	T7otVzTO3YqjGGAo3UbMGTFETnGdHZ7sH8Td/YoDBYfcNPIOYiHEJieknPofQTCdZFFLYH
	F9v6ewtFsLFr+CK7ZMUWoZSjmkcX0jM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788507598;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72ynzHiTc95VhO2YRAcBofsU8g/uUHFw/2CDLg7zbiY=;
	b=GW8EBkUxrUpdTq2kLnvBFnin+hWGvE2kmqBNfJ1yw0MP8d4aKxTmnaGVkgBAvJ49K9egAI
	6FNP9mYIeJ0jb7AQ==
Date: Fri, 4 Sep 2026 09:39:57 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
	mad skateman <madskateman@gmail.com>,
	Christian Zigotzky <info@xenosoft.de>,
	Amit Machhiwal <amachhiw@linux.ibm.com>,
	Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [Linux PPC] Disable PREEMPT
Message-ID: <app1zeEbx4PHfDlC@kunlun.suse.cz>
References: <8c6f2510-1dc5-4c45-9288-6b9c8f9b6b24@kernel.org>
 <aplDm-byYL79laYG@kunlun.suse.cz>
 <9a58d944-405c-4519-852e-8fa04c22c2db@linux.ibm.com>
 <aplZNFMJUkfs-BFs@kunlun.suse.cz>
 <d98e38cb-74d7-48b9-93f3-7c20ff910675@linux.ibm.com>
 <aplclgAsq1d6f5U-@kunlun.suse.cz>
 <1d83264f-8eda-4321-9200-f12897e38cda@linux.ibm.com>
 <aplnPuVk4LWgpu3n@kunlun.suse.cz>
 <e211e1fd-0923-4ab4-9e01-e9151807cf26@linux.ibm.com>
 <apl1-rm_-Hb_ROE4@kunlun.suse.cz>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apl1-rm_-Hb_ROE4@kunlun.suse.cz>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Rspamd-Queue-Id: 15B981FAB9
X-Spamd-Result: default: False [12.68 / 50.00];
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
	NEURAL_HAM_SHORT(-0.14)[-0.691];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b306:2000::2:from];
	FREEMAIL_ENVRCPT(0.00)[xtra.co.nz,yahoo.com.au,gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,xenosoft.de,lists.ozlabs.org,vger.kernel.org,infradead.org,xtra.co.nz,yahoo.com.au,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,kunlun.suse.cz:mid,kunlun.suse.cz:helo]
X-Spamd-Bar: ++++++++++++
X-Spam: Yes

On Thu, Sep 03, 2026 at 03:28:26PM +0200, Michal Suchánek wrote:
> On Thu, Sep 03, 2026 at 06:06:16PM +0530, Harsh Prateek Bora wrote:
> > + Amit, Gautam - since they recently came across a similar regression which
> > is seen with non KVM workload as well.
> > + Venkat - for CI improvement suggestion below.
> > 
> > Hi Michal,
> > 
> > On 03/09/26 5:55 pm, Michal Suchánek wrote:
> 
> > > 
> > > There is another problem that Linux 7.2.2 often locks up on boot inside
> > > the guest, and as a result a different kernel is needed in the guest to
> > > reproduce the host crash. This is more recent, linux 6.12 does not have
> > > this problem. Will try some different kernel combinations to see if I
> > > can narrow this down. For this the repro is merely booting the kernel in
> > > the VM, it typically fails early before userspace produces any messages.
> 
> This one regressed between 6.19.12
> https://github.com/openSUSE/kernel-source/blob/9f6830f/config/ppc64le/default
> and 7.0.12
> https://github.com/openSUSE/kernel-source/blob/2ebf0bc/config/ppc64le/default
> 
> Thanks
> 
> Michal
> 
> SLOF **********************************************************************
> QEMU Starting
>  Build Date = Aug 13 2026 14:47:36
>  FW Version = abuild@OBS release 20230918
>  Press "s" to enter Open Firmware.
> 
> Populating /vdevice methods
> Populating /vdevice/vty@30000000
> Populating /vdevice/nvram@71000000
> Populating /pci@800000020000000
> Loading Linux 7.0.12-1.g2ebf0bc-default ...
> Loading initial ramdisk ...                
> OF stdout device is: /vdevice/vty@30000000
> Preparing to boot Linux version 7.0.12-1.g2ebf0bc-default (geeko@buildhost) (gcc (SUSE Linux) 15.3.0, GNU ld (GNU Binutils; openSUSE Tumbleweed) 2.45.0.20251103-4) #1 SMP PREEMPT_DYNAMIC Mon Jun 15 08:39:32 UTC 2026 (2ebf0bc)
> Detected machine type: 0000000000000101
> command line: BOOT_IMAGE=/boot/vmlinux-7.0.12-1.g2ebf0bc-default root=UUID=304c7f07-efbb-1070-2f27-accd935ec088 rw quiet systemd.show_status=1 security=selinux selinux=1
> Max number of cores passed to firmware: 8192 (NR_CPUS = 8192)
> Calling ibm,client-architecture-support... done
> memory layout at init:
>   memory_limit : 0000000000000000 (16 MB aligned)
>   alloc_bottom : 00000000066b0000
>   alloc_top    : 0000000030000000
>   alloc_top_hi : 0000003e00000000
>   rmo_top      : 0000000030000000
>   ram_top      : 0000003e00000000
> instantiating rtas at 0x000000002fff0000... done
> prom_hold_cpus: skipped
> copying OF device tree...
> Building dt strings...
> Building dt structure...
> Device tree strings 0x00000000066c0000 -> 0x00000000066c0bec
> Device tree struct  0x00000000066d0000 -> 0x00000000066f0000
> Quiescing Open Firmware ...
> Booting Linux via __start() @ 0x0000000000250000 ...
> [    0.000000][    T0] ERROR: Failed to allocate trace buffer
> [    0.000000][    T0] ERROR: tracer: failed to allocate ring buffer!
> Linux ppc64le
> #1 SMP PREEMPT_D[    0.285758][  T673] BUG: Kernel NULL pointer dereference on read at 0x00000010
> [    0.285877][  T673] Faulting instruction address: 0xc000000000485bd0
> [    0.285903][    T1] VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
> [    0.285954][  T673] Oops: Kernel access of bad area, sig: 7 [#1]
> [    0.286133][  T673] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
> [    0.286240][  T673] Modules linked in:
> [    0.286288][  T673] CPU: 15 UID: 0 PID: 673 Comm: kworker/u531:0 Not tainted 7.0.12-1.g2ebf0bc-default #1 PREEMPT(full) openSUSE Tumbleweed (unreleased)  cf0846124d7853fab338aeae87203b36cac18419
> [    0.286527][  T673] Hardware name: IBM pSeries (emulated by qemu) Power11 (architected) 0x820200 0xf000007 of:SLOF,HEAD hv:linux,kvm pSeries
> [    0.286739][  T673] Workqueue: trace_init_wq tracer_init_tracefs_work_func
> [    0.286818][  T673] NIP:  c000000000485bd0 LR: c000000000448864 CTR: c0000000005a3420
> [    0.286906][  T673] REGS: c00000000a7a7960 TRAP: 0300   Not tainted  (7.0.12-1.g2ebf0bc-default)
> [    0.287014][  T673] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 44088404  XER: 00000000
> [    0.287122][  T673] CFAR: c000000000448860 DAR: 0000000000000010 DSISR: 00080000 IRQMASK: 0 
> [    0.287122][  T673] GPR00: c000000000448864 c00000000a7a7c00 c000000001f38100 c000000002a5c098 
> [    0.287122][  T673] GPR04: c0000000017dc5f0 c0000000017dc5e8 000000000000001f 0000000000000064 
> [    0.287122][  T673] GPR08: c0000000017dc628 00000000000005f0 00000000000005e8 0000000084000404 
> [    0.287122][  T673] GPR12: c0000000005a3420 c000003dfff43d80 c0000000018e5600 c0000000018e54f0 
> [    0.287122][  T673] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [    0.287122][  T673] GPR20: c0000000013ec418 c0000000013ef6d8 c0000000017dc5a0 c0000000017dc590 
> [    0.287122][  T673] GPR24: c000000001825330 c0000000017dc628 c000000014b52a05 0000000000000000 
> [    0.287122][  T673] GPR28: c0000000017dc5e8 0000000000000000 c0000000017dc5f0 c000000002a5e008 
> [    0.287970][  T673] NIP [c000000000485bd0] __find_event_file+0x70/0x3c0
> [    0.288046][  T673] LR [c000000000448864] init_tracer_tracefs+0x274/0xc80
> [    0.288122][  T673] Call Trace:
> [    0.288167][  T673] [c00000000a7a7c00] [c00000000a7a7c60] 0xc00000000a7a7c60 (unreliable)
> [    0.288258][  T673] [c00000000a7a7c60] [c000000000448864] init_tracer_tracefs+0x274/0xc80
> [    0.288348][  T673] [c00000000a7a7dc0] [c00000000203fcf0] tracer_init_tracefs_work_func+0x50/0x320
> [    0.288452][  T673] [c00000000a7a7e50] [c0000000002620e8] process_one_work+0x1e8/0x5c0
> [    0.288541][  T673] [c00000000a7a7f10] [c00000000026309c] worker_thread+0x1dc/0x3d0
> [    0.288630][  T673] [c00000000a7a7f90] [c00000000026fa34] kthread+0x194/0x1b0
> [    0.288721][  T673] [c00000000a7a7fe0] [c00000000000de58] start_kernel_thread+0x14/0x18
> [    0.288810][  T673] Code: fb410030 fb810040 fba10048 7cbc2b78 3ba00000 fbc10050 7d194378 7c9e2378 2e2a0fc0 2da90fc0 f8010070 60420000 <e93b0010> 81490058 e8890018 714a0208 
> [    0.289001][  T673] ---[ end trace 0000000000000000 ]---
> [    0.290718][  T673] pstore: backend (nvram) writing error (-1)

This crash might be relevant to the problem, and while qemu can dump the
memory content crash refuses to open it:

crash: incompatible arguments:
   /usr/lib/modules/7.2.2-5.g6824496-default/vmlinux is not SMP -- /scratch/vmcore is SMP

The problem is not 100% reproducible, bisecting it may be tricky.

Thanks

Michal

