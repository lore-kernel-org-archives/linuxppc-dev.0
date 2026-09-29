Return-Path: <linuxppc-dev+bounces-28491-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C149BCA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 12:19:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvHKG4MQtz2yvy;
	Tue, 29 Sep 2026 22:18:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790684338;
	cv=none; b=EV3cdn1odZw4UMqXKGiwltmawDYhaznQUm8gOlWRpI0qKytkYeiFHNq2/x2To6XmdsZsOFQzJT7k0gqkTLKS1DndhR3RlfC0o03rviCb5bMnuErAstjqIAXktczAjOAETAoOWJLzKhL54McvJdiBsbk+P+GNY6RcsWcV+pTal+71id5FCRrqvxEygVptIHfmzEmRHJ0x+qEHyUdtGN7sIif/GlzGiTKbxGJCG0N7/gjrawHPv2mL2qc5xlEhDMjvpRysaAqWViFEHmymu2ntuGP0am5nguW5crPNvmrZkvfH79sOGxTjz3K0UVXqB8U/luKtJQ+WJQMdDDN3YG9axg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790684338; c=relaxed/relaxed;
	bh=9KGHDzGQ3oQ5Mw9JoRY+/JUc5vGQHcGtOEDEPwhZQr4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I249x+fuva+y+4g114Q/uLw2k3H/94bPmhatyuuEhC8LrB8azGlM3KRT0VIlX+pDqkmJBtOTNhuHyrzlbbZ4WU3rIGVAfEcNWLPx6cgvKM1XoWonyHs4aks65myob3PaOCqkof16GvMYLNQEZ9aMcnzIL7HVI0cXlCN059PHn4REhCefX7wb670Mo3hL88yFSVHA7Er4Qmpp6OOJVydU+oAmv6pdJMec73pBRgMiOusM7XAgzJk8kPx+HvpflStogMOe3KbqVP/Qfu8CVy5Hfy+DVvLpIo0lpJtrvCJo7d84oyAxvLZMlhpVMUOpUpEa4R8ptlcjI5eGBuA6OMmTTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=q+mz03Nc; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Bcoyl0b9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kLS052CZ; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Cs1GHDUE; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=q+mz03Nc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Bcoyl0b9;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kLS052CZ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Cs1GHDUE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvHKD6kJWz2xnn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 22:18:56 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E7311F399;
	Tue, 29 Sep 2026 12:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790684328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9KGHDzGQ3oQ5Mw9JoRY+/JUc5vGQHcGtOEDEPwhZQr4=;
	b=q+mz03NcSOZteIEtE0cR2Pu//K1w2yI+RqTarrMphddF0RPnXbM+iT2IAlrDdkDV1dJ1Mb
	y4xaPfDoyi9E3TxCr0c13c0wWLBE/eqUFkTd0q/e6qcG153Tt2RAd3HxL0owert4UB7Vri
	qhMMWo7e9iSP4bG3x/lfAb4lUA0Fsr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790684328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9KGHDzGQ3oQ5Mw9JoRY+/JUc5vGQHcGtOEDEPwhZQr4=;
	b=Bcoyl0b9aR1YKfOPJet7VZSaKCq4wt7GmHElrk2IQYGq7MDxoNRwzIeI/+356tGOW7Rir4
	RA/Jfl3rNkhmt9Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kLS052CZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Cs1GHDUE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790684324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9KGHDzGQ3oQ5Mw9JoRY+/JUc5vGQHcGtOEDEPwhZQr4=;
	b=kLS052CZ+nwxFkqvMy3DroplmM74D66ftCkzr7casd5XxwbjSJOzK/AmJYhrIuLPJUto/o
	946A3TkazXnicfoADf2nJ5ZGwXyrSPUXzHKZ1vtuVAcCYBa+6KP+aRdNu+awE4ZkDVhx0s
	3rqiLa1ndEOVk6rSE2+hTvy8ARjGzaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790684324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9KGHDzGQ3oQ5Mw9JoRY+/JUc5vGQHcGtOEDEPwhZQr4=;
	b=Cs1GHDUENss+rAV2g3gNAFnL14JMFjgi3gAFoNJx00X5N27JVMQtZ+aBBtboW2OlnCviR0
	rCRyQ4Qfdx4bbaBw==
Date: Tue, 29 Sep 2026 14:18:43 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org
Subject: Re: early boot crash in init_tracer_tracefs
Message-ID: <aruso0aJ4lsrERTb@kunlun.suse.cz>
References: <arYskzbiaNzBR9MD@kunlun.suse.cz>
 <20260928111234.faec09f7-8d-amachhiw@linux.ibm.com>
 <20260929093245.00008c9b-10-amachhiw@linux.ibm.com>
 <arubQ77S4mvvykaN@kunlun.suse.cz>
 <20260929163751.4923b819-9f-amachhiw@linux.ibm.com>
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
In-Reply-To: <20260929163751.4923b819-9f-amachhiw@linux.ibm.com>
X-Rspamd-Action: add header
X-Spamd-Result: default: False [15.55 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.81)[0.935];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	R_MIXED_CHARSET(0.56)[subject];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[buildhost:email,linux.it:email,133.3.45.0:email,suse.de:dkim];
	RCVD_COUNT_ZERO(0.00)[0];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:email,buildhost:email,suse.de:dkim]
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Queue-Id: 6E7311F399
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam: Yes

On Tue, Sep 29, 2026 at 04:39:05PM +0530, Amit Machhiwal wrote:
> On 2026/09/29 01:04 PM, Michal Suchánek wrote:
> > On Tue, Sep 29, 2026 at 09:36:05AM +0530, Amit Machhiwal wrote:
> > > On 2026/09/28 11:43 AM, Amit Machhiwal wrote:
> > > > Hi Michal,
> > > > 
> > > > Thanks for the report.  We have been looking at the crash and have some findings
> > > > and follow-up questions.
> > > > 
> > > > On 2026/09/25 10:10 AM, Michal Suchánek wrote:
> > > > > Hello,
> > > > > 
> > > > > There appears to be a regression between
> > > 
> > > < snip >
> > > 
> > > > > 
> > > > > Linux 7.0.12
> > > > > https://github.com/openSUSE/kernel/tree/4c9922875554ec191166ba6c0145f12d8ff9d4fc
> > > > > https://github.com/openSUSE/kernel-source/blob/2ebf0bc/config/ppc64le/default
> > > 
> > > I have been trying to recreate the issue with this kernel and config but I
> > > haven't been able to.  The L2 KVM guest boots fine everytime.
> > > 
> > > In addition to the requested information, could you please also share your qemu
> > > cmdline/guest xml you used?
> > 
> > The XML of the VM is below. What other information do you require?
> 
> Thanks for sharing the guest XML.  I had requested some more info [1].  Could
> you please share that?
> 
> [1] https://lore.kernel.org/all/20260928111234.faec09f7-8d-amachhiw@linux.ibm.com/

Hello,

full log below.

host:

numactl --hardware
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55
node 0 size: 122139 MB
node 0 free: 103635 MB
node 1 cpus: 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119
node 1 size: 139516 MB
node 1 free: 128483 MB
node distances:
node     0    1 
   0:   10   20 
   1:   20   10 

The patch does indeed make it possible to boot when the buffer
allocation fails.

Thanks

Michal


Loading Linux 7.2.8-2.g9b36732-default ...
Loading initial ramdisk ...               
OF stdout device is: /vdevice/vty@30000000
Preparing to boot Linux version 7.2.8-2.g9b36732-default (geeko@buildhost) (gcc (SUSE Linux) 16.2.0, GNU ld (GNU Binutils; openSUSE Tumbleweed) 2.45.0.20251103-4) #1 SMP PREEMPT_DYNAMIC Sat Sep 26 07:00:58 UTC 2026 (9b36732)
Detected machine type: 0000000000000101
command line: BOOT_IMAGE=/boot/vmlinux-7.2.8-2.g9b36732-default root=UUID=304c7f07-efbb-1070-2f27-accd935ec088 rw ignore_loglevel systemd.show_status=1 security=selinux selinux=1
Max number of cores passed to firmware: 8192 (NR_CPUS = 8192)
Calling ibm,client-architecture-support... done
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 00000000076d0000
  alloc_top    : 0000000030000000
  alloc_top_hi : 0000003e00000000
  rmo_top      : 0000000030000000
  ram_top      : 0000003e00000000
instantiating rtas at 0x000000002fff0000... done
prom_hold_cpus: skipped
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x00000000076e0000 -> 0x00000000076e0bec
Device tree struct  0x00000000076f0000 -> 0x0000000007710000
Quiescing Open Firmware ...
Booting Linux via __start() @ 0x0000000000250000 ...
[    0.000000][    T0] random: crng init done
[    0.000000][    T0] printk: debug: ignoring loglevel setting.
[    0.000000][    T0] radix-mmu: Page sizes from device-tree:
[    0.000000][    T0] radix-mmu: Page size shift = 12 AP=0x0
[    0.000000][    T0] radix-mmu: Page size shift = 16 AP=0x5
[    0.000000][    T0] radix-mmu: Page size shift = 21 AP=0x1
[    0.000000][    T0] radix-mmu: Page size shift = 30 AP=0x2
[    0.000000][    T0] Activating Kernel Userspace Access Prevention
[    0.000000][    T0] Activating Kernel Userspace Execution Prevention
[    0.000000][    T0] radix-mmu: Mapped 0x0000000000000000-0x0000000003800000 with 2.00 MiB pages (exec)
[    0.000000][    T0] radix-mmu: Mapped 0x0000000003800000-0x0000000040000000 with 2.00 MiB pages
[    0.000000][    T0] radix-mmu: Mapped 0x0000000040000000-0x0000003e00000000 with 1.00 GiB pages
[    0.000000][    T0] lpar: Using radix MMU under hypervisor
[    0.000000][    T0] Linux version 7.2.8-2.g9b36732-default (geeko@buildhost) (gcc (SUSE Linux) 16.2.0, GNU ld (GNU Binutils; openSUSE Tumbleweed) 2.45.0.20251103-4) #1 SMP PREEMPT_DYNAMIC Sat Sep 26 07:00:58 UTC 2026 (9b36732)
[    0.000000][    T0] OF: reserved mem: Reserved memory: No reserved-memory node in the DT
[    0.000000][    T0] Found initrd at 0xc000000006200000:0xc0000000076c986e
[    0.000000][    T0] Hardware name: IBM pSeries (emulated by qemu) Power11 (architected) 0x820200 0xf000007 of:SLOF,HEAD hv:linux,kvm pSeries
[    0.000000][    T0] printk: legacy bootconsole [udbg0] enabled
[    0.000000][    T0] Partition configured for 120 cpus.
[    0.000000][    T0] CPU maps initialized for 1 thread per core
[    0.000000][    T0]  (thread shift is 0)
[    0.000000][    T0] Allocated 4288 bytes for 120 pacas
[    0.000000][    T0] numa: Partition configured for 1 NUMA nodes.
[    0.000000][    T0] -----------------------------------------------------
[    0.000000][    T0] phys_mem_size     = 0x3e00000000
[    0.000000][    T0] dcache_bsize      = 0x80
[    0.000000][    T0] icache_bsize      = 0x80
[    0.000000][    T0] cpu_features      = 0x003c00eb8f4f9183
[    0.000000][    T0]   possible        = 0x003ffbebcf5fb187
[    0.000000][    T0]   always          = 0x0000000380008181
[    0.000000][    T0] cpu_user_features = 0xdc0065c2 0xaef60000
[    0.000000][    T0] mmu_features      = 0x3c007641
[    0.000000][    T0]   possible        = 0x00000000fe00fe41
[    0.000000][    T0]   always          = 0x0000000000000000
[    0.000000][    T0] firmware_features = 0x00000a85455a445f
[    0.000000][    T0] vmalloc start     = 0xc008000000000000
[    0.000000][    T0] IO start          = 0xc00a000000000000
[    0.000000][    T0] vmemmap start     = 0xc00c000000000000
[    0.000000][    T0] -----------------------------------------------------
[    0.000000][    T0] NODE_DATA(0) allocated [mem 0x3dff6e9b80-0x3dff6f197f]
[    0.000000][    T0] rfi-flush: fallback displacement flush available
[    0.000000][    T0] rfi-flush: ori type flush available
[    0.000000][    T0] rfi-flush: mttrig type flush available
[    0.000000][    T0] rfi-flush: patched 12 locations (ori+mttrig type flush)
[    0.000000][    T0] count-cache-flush: hardware flush enabled.
[    0.000000][    T0] link-stack-flush: software flush enabled.
[    0.000000][    T0] entry-flush: patched 61 locations (ori+mttrig type flush)
[    0.000000][    T0] uaccess-flush: patched 1 locations (ori+mttrig type flush)
[    0.000000][    T0] stf-barrier: eieio barrier available
[    0.000000][    T0] stf-barrier: patched 61 entry locations (eieio barrier)
[    0.000000][    T0] stf-barrier: patched 12 exit locations (eieio barrier)
[    0.000000][    T0] PPC64 nvram contains 65536 bytes
[    0.000000][    T0] barrier-nospec: using ORI speculation barrier
[    0.000000][    T0] barrier-nospec: patched 164 locations
[    0.000000][    T0] Top of RAM: 0x3e00000000, Total RAM: 0x3e00000000
[    0.000000][    T0] Memory hole size: 0MB
[    0.000000][    T0] Zone ranges:
[    0.000000][    T0]   Normal   [mem 0x0000000000000000-0x0000003dffffffff]
[    0.000000][    T0]   Device   empty
[    0.000000][    T0] Movable zone start for each node
[    0.000000][    T0] Early memory node ranges
[    0.000000][    T0]   node   0: [mem 0x0000000000000000-0x0000003dffffffff]
[    0.000000][    T0] Initmem setup node 0 [mem 0x0000000000000000-0x0000003dffffffff]
[    0.000000][    T0] percpu: Embedded 4 pages/cpu s127000 r0 d135144 u262144
[    0.000000][    T0] pcpu-alloc: s127000 r0 d135144 u262144 alloc=4*65536
[    0.000000][    T0] pcpu-alloc: [0] 000 [0] 001 [0] 002 [0] 003 
[    0.000000][    T0] pcpu-alloc: [0] 004 [0] 005 [0] 006 [0] 007 
[    0.000000][    T0] pcpu-alloc: [0] 008 [0] 009 [0] 010 [0] 011 
[    0.000000][    T0] pcpu-alloc: [0] 012 [0] 013 [0] 014 [0] 015 
[    0.000000][    T0] pcpu-alloc: [0] 016 [0] 017 [0] 018 [0] 019 
[    0.000000][    T0] pcpu-alloc: [0] 020 [0] 021 [0] 022 [0] 023 
[    0.000000][    T0] pcpu-alloc: [0] 024 [0] 025 [0] 026 [0] 027 
[    0.000000][    T0] pcpu-alloc: [0] 028 [0] 029 [0] 030 [0] 031 
[    0.000000][    T0] pcpu-alloc: [0] 032 [0] 033 [0] 034 [0] 035 
[    0.000000][    T0] pcpu-alloc: [0] 036 [0] 037 [0] 038 [0] 039 
[    0.000000][    T0] pcpu-alloc: [0] 040 [0] 041 [0] 042 [0] 043 
[    0.000000][    T0] pcpu-alloc: [0] 044 [0] 045 [0] 046 [0] 047 
[    0.000000][    T0] pcpu-alloc: [0] 048 [0] 049 [0] 050 [0] 051 
[    0.000000][    T0] pcpu-alloc: [0] 052 [0] 053 [0] 054 [0] 055 
[    0.000000][    T0] pcpu-alloc: [0] 056 [0] 057 [0] 058 [0] 059 
[    0.000000][    T0] pcpu-alloc: [0] 060 [0] 061 [0] 062 [0] 063 
[    0.000000][    T0] pcpu-alloc: [0] 064 [0] 065 [0] 066 [0] 067 
[    0.000000][    T0] pcpu-alloc: [0] 068 [0] 069 [0] 070 [0] 071 
[    0.000000][    T0] pcpu-alloc: [0] 072 [0] 073 [0] 074 [0] 075 
[    0.000000][    T0] pcpu-alloc: [0] 076 [0] 077 [0] 078 [0] 079 
[    0.000000][    T0] pcpu-alloc: [0] 080 [0] 081 [0] 082 [0] 083 
[    0.000000][    T0] pcpu-alloc: [0] 084 [0] 085 [0] 086 [0] 087 
[    0.000000][    T0] pcpu-alloc: [0] 088 [0] 089 [0] 090 [0] 091 
[    0.000000][    T0] pcpu-alloc: [0] 092 [0] 093 [0] 094 [0] 095 
[    0.000000][    T0] pcpu-alloc: [0] 096 [0] 097 [0] 098 [0] 099 
[    0.000000][    T0] pcpu-alloc: [0] 100 [0] 101 [0] 102 [0] 103 
[    0.000000][    T0] pcpu-alloc: [0] 104 [0] 105 [0] 106 [0] 107 
[    0.000000][    T0] pcpu-alloc: [0] 108 [0] 109 [0] 110 [0] 111 
[    0.000000][    T0] pcpu-alloc: [0] 112 [0] 113 [0] 114 [0] 115 
[    0.000000][    T0] pcpu-alloc: [0] 116 [0] 117 [0] 118 [0] 119 
[    0.000000][    T0] Kernel command line: BOOT_IMAGE=/boot/vmlinux-7.2.8-2.g9b36732-default root=UUID=304c7f07-efbb-1070-2f27-accd935ec088 rw ignore_loglevel systemd.show_status=1 security=selinux selinux=1
[    0.000000][    T0] printk: log_buf_len individual max cpu contribution: 32768 bytes
[    0.000000][    T0] printk: log_buf_len total cpu_extra contributions: 3899392 bytes
[    0.000000][    T0] printk: log_buf_len min size: 524288 bytes
[    0.000000][    T0] printk: log buffer data + meta data: 8388608 + 35651584 = 44040192 bytes
[    0.000000][    T0] printk: early log buf free: 518504(98%)
[    0.000000][    T0] Dentry cache hash table entries: 16777216 (order: 11, 134217728 bytes, linear)
[    0.000000][    T0] Inode-cache hash table entries: 8388608 (order: 10, 67108864 bytes, linear)
[    0.000000][    T0] Fallback order for Node 0: 0 
[    0.000000][    T0] Built 1 zonelists, mobility grouping on.  Total pages: 4063232
[    0.000000][    T0] Policy zone: Normal
[    0.000000][    T0] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000][    T0] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=120, Nodes=1
[    0.000000][    T0] ftrace: allocating 44890 entries in 17 pages
[    0.000000][    T0] ftrace: allocated 17 pages with 2 groups
[    0.000000][    T0] ERROR: Failed to allocate trace buffer
[    0.000000][    T0] ERROR: tracer: failed to allocate ring buffer!
[    0.000000][    T0] Dynamic Preempt: full
[    0.000000][    T0] rcu: Preemptible hierarchical RCU implementation.
[    0.000000][    T0] rcu: 	RCU event tracing is enabled.
[    0.000000][    T0] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=120.
[    0.000000][    T0] 	Trampoline variant of Tasks RCU enabled.
[    0.000000][    T0] 	Rude variant of Tasks RCU enabled.
[    0.000000][    T0] 	Tracing variant of Tasks RCU enabled.
[    0.000000][    T0] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000][    T0] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=120
[    0.000000][    T0] RCU Tasks: Setting shift to 7 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=120.
[    0.000000][    T0] RCU Tasks Rude: Setting shift to 7 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=120.
[    0.000000][    T0] NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
[    0.000000][    T0] xive: Using IRQ range [0-77]
[    0.000000][    T0] xive: Interrupt handling initialized with spapr backend
[    0.000000][    T0] xive: Using priority 6 for all interrupts
[    0.000000][    T0] xive: Using 64kB queues
[    0.000000][    T0] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000][    T0] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.000000][    T0] time_init: decrementer frequency = 512.000000 MHz
[    0.000000][    T0] time_init: processor frequency   = 2800.000000 MHz
[    0.000001][    T0] time_init: 56 bit decrementer (max: 7fffffffffffff)
[    0.001053][    T0] clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x761537d007, max_idle_ns: 440795202126 ns
[    0.002809][    T0] clocksource: timebase mult[1f40000] shift[24] registered
[    0.003930][    T0] clockevent: decrementer mult[83126f] shift[24] cpu[0]
[    0.005371][    T0] Console: colour dummy device 80x25
[    0.006213][    T0] printk: legacy console [hvc0] enabled
[    0.006213][    T0] printk: legacy console [hvc0] enabled
[    0.007133][    T0] printk: legacy bootconsole [udbg0] disabled
[    0.007133][    T0] printk: legacy bootconsole [udbg0] disabled
[    0.008252][    T0] pid_max: default: 122880 minimum: 960
[    0.008855][    T0] landlock: Up and running.
[    0.008923][    T0] Yama: becoming mindful.
[    0.008988][    T0] SELinux:  Initializing.
[    0.009888][    T0] LSM support for eBPF active
[    0.010417][    T0] Mount-cache hash table entries: 262144 (order: 5, 2097152 bytes, linear)
[    0.010650][    T0] Mountpoint-cache hash table entries: 262144 (order: 5, 2097152 bytes, linear)
[    0.011174][    T0] VFS: Finished mounting rootfs on nullfs
[    0.012508][    T1] Power11 performance monitor hardware support registered
[    0.012658][    T1] rcu: Hierarchical SRCU implementation.
[    0.012718][    T1] rcu: 	Max phase no-delay instances is 1000.
[    0.012835][    T1] Timer migration: 3 hierarchy levels; 8 children per group; 3 crossnode level
[    0.014144][    T1] smp: Bringing up secondary CPUs ...
[    0.106463][    T1] smp: Brought up 1 node, 120 CPUs
[    0.106558][    T1] numa: Node 0 CPUs: 0-119
[    0.149312][  T743] node 0 deferred pages initialised in 20ms
[    0.149492][    T1] Memory: 259300352K/260046848K available (20352K kernel code, 4608K rwdata, 28800K rodata, 7872K init, 2163K bss, 639744K reserved, 0K cma-reserved)
[    0.156625][    T1] devtmpfs: initialized
[    0.162536][    T1] PCI host bridge /pci@800000020000000  ranges:
[    0.162635][    T1]   IO 0x0000200000000000..0x000020000000ffff -> 0x0000000000000000
[    0.162725][    T1]  MEM 0x0000200080000000..0x00002000ffffffff -> 0x0000000080000000 
[    0.162813][    T1]  MEM 0x0000210000000000..0x000021ffffffffff -> 0x0000210000000000 
[    0.163498][    T1] posixtimers hash table entries: 65536 (order: 4, 1048576 bytes, linear)
[    0.163947][    T1] futex hash table entries: 32768 (4194304 bytes on 1 NUMA nodes, total 4096 KiB, linear).
[    0.164925][    T1] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.165296][    T1] audit: initializing netlink subsys (disabled)
[    0.165763][  T750] audit: type=2000 audit(1790681581.160:1): state=initialized audit_enabled=0 res=1
[    0.174857][    T1] thermal_sys: Registered thermal governor 'fair_share'
[    0.174860][    T1] thermal_sys: Registered thermal governor 'bang_bang'
[    0.175066][    T1] thermal_sys: Registered thermal governor 'step_wise'
[    0.175159][    T1] thermal_sys: Registered thermal governor 'user_space'
[    0.175781][    T1] cpuidle: using governor ladder
[    0.176356][    T1] cpuidle: using governor menu
[    0.176554][    T1] RTAS daemon started
[    0.176961][    T1] pstore: Using crash dump compression: deflate
[    0.177039][    T1] pstore: Registered nvram as persistent store backend
Linux ppc64le
#1 SMP PREEMPT_D[    0.177970][    T1] EEH: pSeries platform initialized
[    0.212558][    T1] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.225791][    T1] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.225922][    T1] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    0.226062][    T1] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.226172][    T1] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
[    0.229547][    T1] iommu: Default domain type: Translated
[    0.229642][    T1] iommu: DMA domain TLB invalidation policy: strict mode
[    0.247237][    T1] pps_core: LinuxPPS API ver. 1 registered
[    0.247334][    T1] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.247453][    T1] PTP clock support registered
[    0.247520][    T1] EDAC MC: Ver: 3.0.0
[    0.248675][    T1] NetLabel: Initializing
[    0.248729][    T1] NetLabel:  domain hash size = 128
[    0.248788][    T1] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.248901][    T1] NetLabel:  unlabeled traffic allowed by default
[    0.248977][    T1] mctp: management component transport protocol core
[    0.249048][    T1] NET: Registered PF_MCTP protocol family
[    0.249146][    T1] PCI: Probing PCI hardware
[    0.250643][    T1] PCI host bridge to bus 0000:00
[    0.250714][    T1] pci_bus 0000:00: root bus resource [io  0x10000-0x1ffff] (bus address [0x0000-0xffff])
[    0.250818][    T1] pci_bus 0000:00: root bus resource [mem 0x200080000000-0x2000ffffffff] (bus address [0x80000000-0xffffffff])
[    0.250945][    T1] pci_bus 0000:00: root bus resource [mem 0x210000000000-0x21ffffffffff 64bit]
[    0.251046][    T1] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.251348][    T1] pci 0000:00:01.0: No hypervisor support for SR-IOV on this device, IOV BARs disabled.
[    0.252338][    T1] pci 0000:00:02.0: No hypervisor support for SR-IOV on this device, IOV BARs disabled.
[    0.252998][    T1] pci 0000:00:03.0: No hypervisor support for SR-IOV on this device, IOV BARs disabled.
[    0.254045][    T1] pci 0000:00:04.0: No hypervisor support for SR-IOV on this device, IOV BARs disabled.
[    0.255125][    T1] pci 0000:00:05.0: No hypervisor support for SR-IOV on this device, IOV BARs disabled.
[    0.256231][    T1] pci 0000:00:06.0: No hypervisor support for SR-IOV on this device, IOV BARs disabled.
[    0.257309][    T1] pci 0000:00:07.0: No hypervisor support for SR-IOV on this device, IOV BARs disabled.
[    0.262428][    T1] IOMMU table initialized, virtual merging enabled
[    0.262728][    T1] PCI 0000:00 Cannot reserve Legacy IO [io  0x10000-0x10fff]
[    0.262824][    T1] pci_bus 0000:00: resource 4 [io  0x10000-0x1ffff]
[    0.262896][    T1] pci_bus 0000:00: resource 5 [mem 0x200080000000-0x2000ffffffff]
[    0.262982][    T1] pci_bus 0000:00: resource 6 [mem 0x210000000000-0x21ffffffffff 64bit]
[    0.263156][    T1] pci 0000:00:01.0: ibm,query-pe-dma-windows(2026) 800 8000000 20000000 returned 0, lb=2000000000 ps=107 wn=1
[    0.263297][    T1] pci 0000:00:01.0: Adding to iommu group 0
[    0.264251][    T1] pci 0000:00:02.0: Adding to iommu group 0
[    0.265231][    T1] pci 0000:00:03.0: Adding to iommu group 0
[    0.266076][    T1] pci 0000:00:04.0: Adding to iommu group 0
[    0.266920][    T1] pci 0000:00:05.0: Adding to iommu group 0
[    0.267736][    T1] pci 0000:00:06.0: Adding to iommu group 0
[    0.268556][    T1] pci 0000:00:07.0: Adding to iommu group 0
[    0.269377][    T1] EEH: No capable adapters found: recovery disabled.
[    0.269458][    T1] PCI: Probing PCI hardware done
[    0.269698][    T1] vgaarb: loaded
[    0.305281][    T1] clocksource: Switched to clocksource timebase
[    0.305844][    T1] VFS: Disk quotas dquot_6.6.0
[    0.305938][    T1] VFS: Dquot-cache hash table entries: 8192 (65536 bytes)
[    0.306588][  T715] Could not create tracefs directory 'options'
[    0.306689][  T715] BUG: Kernel NULL pointer dereference on read at 0x00000010
[    0.306845][  T715] Faulting instruction address: 0xc0000000004a0470
[    0.306936][  T715] Oops: Kernel access of bad area, sig: 7 [#1]
[    0.307158][  T715] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
[    0.307306][  T715] Modules linked in:
[    0.307353][  T715] CPU: 92 UID: 0 PID: 715 Comm: kworker/u573:0 Not tainted 7.2.8-2.g9b36732-default #1 PREEMPT(full) openSUSE Tumbleweed (unreleased)  03932d3ccf6ccfe58e0684743c65e360adc8d044
[    0.307539][  T715] Hardware name: IBM pSeries (emulated by qemu) Power11 (architected) 0x820200 0xf000007 of:SLOF,HEAD hv:linux,kvm pSeries
[    0.307681][  T715] Workqueue: trace_init_wq tracer_init_tracefs_work_func
[    0.307760][  T715] NIP:  c0000000004a0470 LR: c000000000460f38 CTR: c0000000005d6b70
[    0.307846][  T715] REGS: c00000000bacb960 TRAP: 0300   Not tainted  (7.2.8-2.g9b36732-default)
[    0.307946][  T715] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 44088204  XER: 0000005b
[    0.308051][  T715] CFAR: c000000000460f34 DAR: 0000000000000010 DSISR: 00080000 IRQMASK: 0 
[    0.308051][  T715] GPR00: c000000000460f38 c00000000bacbc00 c00000000205ad00 c000000003abc210 
[    0.308051][  T715] GPR04: c0000000018da480 c0000000018da478 00000000000000b9 0000000000000064 
[    0.308051][  T715] GPR08: c0000000018da4b8 0000000000000480 0000000000000478 0000000084000204 
[    0.308051][  T715] GPR12: c0000000005d6b70 c000003dffee4300 c00000000145d128 c0000000014603a8 
[    0.308051][  T715] GPR16: c000000001883210 c0000000014604b8 c0000000019e65d8 c0000000018da418 
[    0.308051][  T715] GPR20: c0000000018bc060 c0000000019e5e68 c0000000019e5d58 c0000000018da368 
[    0.308051][  T715] GPR24: c0000000018da358 c0000000018da4b8 c000000003bfd4a0 0000000000000000 
[    0.308051][  T715] GPR28: c0000000018da478 0000000000000000 c0000000018da480 c000000003abe180 
[    0.308882][  T715] NIP [c0000000004a0470] __find_event_file+0x70/0x3f0
[    0.308957][  T715] LR [c000000000460f38] init_tracer_tracefs+0x7b8/0xc80
[    0.309031][  T715] Call Trace:
[    0.309075][  T715] [c00000000bacbc00] [c00000000bacbc60] 0xc00000000bacbc60 (unreliable)
[    0.309174][  T715] [c00000000bacbc60] [c000000000460f38] init_tracer_tracefs+0x7b8/0xc80
[    0.309261][  T715] [c00000000bacbdc0] [c00000000304b7c8] tracer_init_tracefs_work_func+0x60/0x304
[    0.309362][  T715] [c00000000bacbe50] [c000000000262878] process_one_work+0x1e8/0x560
[    0.309450][  T715] [c00000000bacbf10] [c0000000002637ec] worker_thread+0x1ec/0x3e0
[    0.309538][  T715] [c00000000bacbf90] [c00000000027224c] kthread+0x19c/0x1b0
[    0.309626][  T715] [c00000000bacbfe0] [c00000000000de58] start_kernel_thread+0x14/0x18
[    0.309713][  T715] Code: fb410030 fb810040 fba10048 7cbc2b78 3ba00000 fbc10050 7d194378 7c9e2378 2e2a0fc0 2da90fc0 f8010070 60420000 <e93b0010> 81490058 e8890018 714a0208 
[    0.309892][  T715] ---[ end trace 0000000000000000 ]---
[    0.311618][  T715] pstore: backend (nvram) writing error (-1)
[    0.311702][  T715] 
[    0.311735][  T715] note: kworker/u573:0[715] exited with irqs disabled
[    0.324507][    T1] NET: Registered PF_INET protocol family
[    0.324815][    T1] IP idents hash table entries: 262144 (order: 5, 2097152 bytes, linear)
[    0.328240][    T1] tcp_listen_portaddr_hash hash table entries: 65536 (order: 4, 1048576 bytes, linear)
[    0.328480][    T1] Table-perturb hash table entries: 65536 (order: 2, 262144 bytes, linear)
[    0.328595][    T1] TCP established hash table entries: 524288 (order: 6, 4194304 bytes, linear)
[    0.329240][    T1] TCP bind hash table entries: 65536 (order: 5, 2097152 bytes, linear)
[    0.329583][    T1] TCP: Hash tables configured (established 524288 bind 65536)
[    0.330131][    T1] MPTCP token hash table entries: 65536 (order: 5, 1572864 bytes, linear)
[    0.330339][    T1] UDP hash table entries: 65536 (order: 6, 4194304 bytes, linear)
[    0.331089][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.331247][    T1] NET: Registered PF_XDP protocol family
[    0.332150][    T1] PCI: CLS 0 bytes, default 128
[    0.332713][  T741] Trying to unpack rootfs image as initramfs...
[    0.336221][    T1] rtas_flash: no firmware flash support
[    0.339614][    T1] Initialise system trusted keyrings
[    0.339753][    T1] Key type blacklist registered
[    0.346290][    T1] workingset: timestamp_bits=38 (anon: 33) max_order=22 bucket_order=0 (anon: 0)
[    0.348685][    T1] integrity: Platform Keyring initialized
[    0.348792][    T1] integrity: Machine keyring initialized
[    0.348855][    T1] Allocating IMA blacklist keyring.
[    0.356845][    T1] Key type asymmetric registered
[    0.356916][    T1] Asymmetric key parser 'x509' registered
[    0.358009][    T1] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    0.358510][    T1] io scheduler mq-deadline registered
[    0.358577][    T1] io scheduler kyber registered
[    0.358684][    T1] io scheduler bfq registered
[    0.404683][    T1] ledtrig-cpu: registered to indicate activity on CPUs
[    0.404950][    T1] virtio-pci 0000:00:01.0: enabling device (0100 -> 0103)
[    0.406751][    T1] virtio-pci 0000:00:01.0: ibm,query-pe-dma-windows(2026) 800 8000000 20000000 returned 0, lb=2000000000 ps=107 wn=1
[    0.407544][    T1] virtio-pci 0000:00:01.0: ibm,create-pe-dma-window(2027) 800 8000000 20000000 18 26 returned 0 (liobn = 0x80000001 starting addr = 8000000 0)
[    0.410779][    T1] virtio-pci 0000:00:01.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.410894][    T1] virtio-pci 0000:00:01.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.411006][    T1] virtio-pci 0000:00:01.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.411110][    T1] virtio-pci 0000:00:01.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.412473][    T1] virtio-pci 0000:00:03.0: enabling device (0100 -> 0103)
[    0.413988][    T1] virtio-pci 0000:00:03.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.414090][    T1] virtio-pci 0000:00:03.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.414198][    T1] virtio-pci 0000:00:03.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.414295][    T1] virtio-pci 0000:00:03.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.416317][    T1] virtio-pci 0000:00:04.0: enabling device (0100 -> 0103)
[    0.418273][    T1] virtio-pci 0000:00:04.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.418380][    T1] virtio-pci 0000:00:04.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.418485][    T1] virtio-pci 0000:00:04.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.418583][    T1] virtio-pci 0000:00:04.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.419921][    T1] virtio-pci 0000:00:05.0: enabling device (0100 -> 0103)
[    0.421893][    T1] virtio-pci 0000:00:05.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.422001][    T1] virtio-pci 0000:00:05.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.422109][    T1] virtio-pci 0000:00:05.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.422211][    T1] virtio-pci 0000:00:05.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.423534][    T1] virtio-pci 0000:00:06.0: enabling device (0100 -> 0103)
[    0.425294][    T1] virtio-pci 0000:00:06.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.425410][    T1] virtio-pci 0000:00:06.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.425515][    T1] virtio-pci 0000:00:06.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.425614][    T1] virtio-pci 0000:00:06.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.427555][    T1] virtio-pci 0000:00:07.0: enabling device (0100 -> 0103)
[    0.429660][    T1] virtio-pci 0000:00:07.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.429765][    T1] virtio-pci 0000:00:07.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.429870][    T1] virtio-pci 0000:00:07.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 1
[    0.429968][    T1] virtio-pci 0000:00:07.0: iommu: 64-bit OK but direct DMA is limited by 800004000000000
[    0.433452][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.435876][  T741] Freeing initrd memory: 21248K
[    0.456548][    T1] Non-volatile memory driver v1.3
[    0.456628][    T1] pseries_rng: Registering IBM pSeries RNG driver
[    0.458556][    T1] mousedev: PS/2 mouse device common for all mice
[    0.460262][    T1] pseries_idle_driver registered
[    0.460402][    T1] hid: raw HID events driver (C) Jiri Kosina
[    0.460557][    T1] drop_monitor: Initializing network drop monitor service
[    0.460894][    T1] NET: Registered PF_INET6 protocol family
[    0.462331][    T1] Segment Routing with IPv6
[    0.462427][    T1] RPL Segment Routing with IPv6
[    0.462514][    T1] In-situ OAM (IOAM) with IPv6
[    0.462617][    T1] PFKEY is deprecated and scheduled to be removed in 2027, please contact the netdev mailing list
[    0.462736][    T1] NET: Registered PF_KEY protocol family
[    0.463182][    T1] secvar-sysfs: Failed to retrieve secvar operations
[    0.465966][    T1] registered taskstats version 1
[    0.488370][    T1] Loading compiled-in X.509 certificates
[    0.504872][    T1] Loaded X.509 cert 'Kernel OBS Project: 1fb41512acbc8eebdf828d877e4367bf6c719af3'
[    0.511066][    T1] Demotion targets for Node 0: null
[    0.511165][    T1] page_owner is disabled
[    0.542843][    T1] Key type .fscrypt registered
[    0.542917][    T1] Key type fscrypt-provisioning registered
[    0.543156][    T1] Key type big_key registered
[    0.557927][    T1] Key type encrypted registered
[    0.558126][    T1] Secure boot mode disabled
[    0.558201][    T1] ima: No TPM chip found, activating TPM-bypass!
[    0.558277][    T1] Loading compiled-in module X.509 certificates
[    0.558540][    T1] Loaded X.509 cert 'Kernel OBS Project: 1fb41512acbc8eebdf828d877e4367bf6c719af3'
[    0.558643][    T1] ima: Allocated hash algorithm: sha256
[    0.559731][    T1] Secure boot mode disabled
[    0.559834][    T1] Trusted boot mode disabled
[    0.559900][    T1] ima: No architecture policies found
[    0.559996][    T1] evm: Initialising EVM extended attributes:
[    0.560069][    T1] evm: security.selinux
[    0.560119][    T1] evm: security.SMACK64 (disabled)
[    0.560178][    T1] evm: security.SMACK64EXEC (disabled)
[    0.560236][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[    0.560309][    T1] evm: security.SMACK64MMAP (disabled)
[    0.560368][    T1] evm: security.apparmor
[    0.560412][    T1] evm: security.ima
[    0.560457][    T1] evm: security.capability
[    0.560515][    T1] evm: HMAC attrs: 0x1
[    0.569151][    T1] SED: plpks not available


