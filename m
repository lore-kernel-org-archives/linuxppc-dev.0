Return-Path: <linuxppc-dev+bounces-29672-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB30CCA490
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 01:31:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7J0x3jC2z2xjN;
	Mon, 19 Oct 2026 12:31:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792372065;
	cv=none; b=OMRFoA2gNUNMaqbYvBXx4XzRkUNh/FHu/ffAv3Tz6AXzgp2nVEYYOys8JcCoDvdp2WlAugnw6re38gyzFCP4aQn6oQCyTUE9uWzLCZ7wb+R9xD4Vhh1ko89bdS0Lb9cCd+bRuHeNsfD2DTv57WIKtmZ7MB19oQ8PQlY+HX/d2sb/yZGgt8Uxdr+ZAbY4R2qSCP804BgmfnK7A5PV6WQi49/IhAQ169UJ0/s9dATCxYUxirYW98HEdzD4pXHE0nJvIfzMdKfpHP0jUDW7gtXVB5vIzxz4ip8XcYO785dOR0sJgSIYnRaN9QHDFhrlDT7E+Z5vBtSrvGeiGyg9HdHZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792372065; c=relaxed/relaxed;
	bh=KXa8VClVV3zTUm13w//5ENeNGANgXPJivcrzSLRe1dM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jWkMr1ofL8Uox2S5WIRokapkWBG4VwDr2tzXTUu8icStsw3/f1pbHqsmrfZQmVqu4VP0Y19aH7+egl+sbNayK3+GANOfhCHDeexSeMlAGqjlzajAooD1ql1w4jXD1xAxp7+EivnAC9mlL2wIDBEi5HcxhHzdDocFZjSuUQuHtJSL5x01Unz72lF5yZmMmGCfa1iNjMwZ7DUK2lTs0wR5j7Y3okJAf4BOUhNL+kek7ERyiqh516VMwbwfxXgJr7dh8dHD6qBA2dRU7trGOrt8H0MsKz+hxPo/w9ywxKno6bmRPlibTj16W4PGXNb6DEAKt1Suef7qZPg6TEhrZL/u3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EFVWzauE; dkim-atps=neutral; spf=pass (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=yi1.lai@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EFVWzauE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=yi1.lai@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 62 seconds by postgrey-1.37 at boromir; Mon, 19 Oct 2026 12:07:42 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7HTV6vsPz2xgv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 12:07:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792372064; x=1823908064;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=b9O3qjS3MEMdQZQ6wWAiJ6kHBkZeNvprfKQ5jOCCFJ0=;
  b=EFVWzauEN1o4Cy+6C6bMF4FCIVcboNHVA01romCLN1ZKawTj+N2+6AN4
   esG3WViown0xJvlUdvG49wXI1vAtmjeBxXplEhUr+0MR5nmzKpj74CQSo
   Qcn2etP+JHi5a30Qn9TEhW6ftRQt/cPpPKYzM5Xi4EReGUfken69e1KXD
   M5egsrBDEASB2yzkbfFKqgiYXLdCierTo7dAffOckgSCr2cAYihRi6tWZ
   ruxypzy+GfFxberrFTlJoWAHG1AHHi9+uTOZdde/TtWwoH4QteEqOOFs5
   t9rn02q2FB5CqECAgLi7vFuR3rxjVL2MdO0OCEwyoqZQBz2HT4wbiorvV
   Q==;
X-CSE-ConnectionGUID: OGbJQpPoTJSB0utRxyclyg==
X-CSE-MsgGUID: geIB2eYJSjqtYEbqARLsOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="957252"
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="957252"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 18:06:32 -0700
X-CSE-ConnectionGUID: qUoc8xwyTraRW04hp7SJDQ==
X-CSE-MsgGUID: RwW62x8nSeuqk1g+ycjMiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="2465662"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 18:06:26 -0700
Date: Mon, 19 Oct 2026 09:06:23 +0800
From: kernel test robot <yi1.lai@intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org, aubrey.li@linux.intel.com,
	yu.c.chen@intel.com, Peter Zijlstra <peterz@infradead.org>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-mips@vger.kernel.org, loongarch@lists.linux.dev,
	driver-core@lists.linux.dev,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, yi1.lai@intel.com
Subject: Re: [RFC PATCH v3 13/13] sched/fair: Switch nohz.idle_cpus to use sbm
Message-ID: <202610190859.d3459a50-lkp@intel.com>
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
In-Reply-To: <20261001192849.74788-14-kprateek.nayak@amd.com>


Hello,

kernel test robot noticed "kernel_BUG_at_kernel/smpboot.c" on:

commit: d7dd59cf6a0f621f224947f960403a747b0836f0 ("[RFC PATCH v3 13/13] sched/fair: Switch nohz.idle_cpus to use sbm")
url: https://github.com/intel-lab-lkp/linux/commits/K-Prateek-Nayak/lib-sbm-Introduce-helpers-for-architectures-to-configure-LLC-properties/20261001-192837
patch link: https://lore.kernel.org/all/20261001192849.74788-14-kprateek.nayak@amd.com/
patch subject: [RFC PATCH v3 13/13] sched/fair: Switch nohz.idle_cpus to use sbm

in testcase: boot

config: i386-randconfig-1006-20261010
compiler: clang-22
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 4 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202610190859.d3459a50-lkp@intel.com



[    2.426107][   T37] ------------[ cut here ]------------
[    2.430168][   T37] kernel BUG at kernel/smpboot.c:133!
[    2.433726][   T37] Oops: invalid opcode: 0000 [#1] SMP PTI
[    2.436546][   T37] CPU: 3 UID: 0 PID: 37 Comm: ksoftirqd/3 Tainted: G                T   7.3.0-rc1+ #1 PREEMPTLAZY
[    2.436546][   T37] Tainted: [T]=RANDSTRUCT
[    2.436546][   T37] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    2.436546][   T37] EIP: smpboot_thread_fn (smpboot.c:117)
[    2.436546][   T37] Code: 83 7e 04 00 74 13 8b 06 31 d2 0f a3 05 6c 07 59 84 0f 92 c2 e8 12 65 b7 01 89 f0 e8 4b e9 2e 00 31 c0 83 c4 08 5e 5f 5b 5d c3 <0f> 0b b8 08 52 f5 83 e8 75 85 e6 ff 0f 0b b8 f8 51 f5 83 e8 69 85
All code
========
   0:	83 7e 04 00          	cmpl   $0x0,0x4(%rsi)
   4:	74 13                	je     0x19
   6:	8b 06                	mov    (%rsi),%eax
   8:	31 d2                	xor    %edx,%edx
   a:	0f a3 05 6c 07 59 84 	bt     %eax,-0x7ba6f894(%rip)        # 0xffffffff8459077d
  11:	0f 92 c2             	setb   %dl
  14:	e8 12 65 b7 01       	call   0x1b7652b
  19:	89 f0                	mov    %esi,%eax
  1b:	e8 4b e9 2e 00       	call   0x2ee96b
  20:	31 c0                	xor    %eax,%eax
  22:	83 c4 08             	add    $0x8,%esp
  25:	5e                   	pop    %rsi
  26:	5f                   	pop    %rdi
  27:	5b                   	pop    %rbx
  28:	5d                   	pop    %rbp
  29:	c3                   	ret
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b8 08 52 f5 83       	mov    $0x83f55208,%eax
  31:	e8 75 85 e6 ff       	call   0xffffffffffe685ab
  36:	0f 0b                	ud2
  38:	b8 f8 51 f5 83       	mov    $0x83f551f8,%eax
  3d:	e8                   	.byte 0xe8
  3e:	69                   	.byte 0x69
  3f:	85                   	.byte 0x85

Code starting with the faulting instruction ===========================================
   0:	0f 0b                	ud2
   2:	b8 08 52 f5 83       	mov    $0x83f55208,%eax
   7:	e8 75 85 e6 ff       	call   0xffffffffffe68581
   c:	0f 0b                	ud2
   e:	b8 f8 51 f5 83       	mov    $0x83f551f8,%eax
  13:	e8                   	.byte 0xe8
  14:	69                   	.byte 0x69
  15:	85                   	.byte 0x85
[    2.436546][   T37] EAX: 00000003 EBX: 858ac510 ECX: 83e26f98 EDX: 83c50f80
[    2.436546][   T37] ESI: 8500dfb0 EDI: 00000000 EBP: 858e1f68 ESP: 858e1f54
[    2.436546][   T37] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010293
[    2.436546][   T37] CR0: 80050033 CR2: 00000000 CR3: 047ae000 CR4: 000006b0
[    2.436546][   T37] Call Trace:
[    2.436546][   T37]  kthread (kthread.c:436)
[    2.436546][   T37]  ? smpboot_unregister_percpu_thread (linux/list.h:261)
[    2.436546][   T37]  ? __do_trace_sched_kthread_stop_ret (trace/events/sched.h:38 (discriminator 13))
[    2.436546][   T37]  ret_from_fork (x86/kernel/process.c:158)
[    2.436546][   T37]  ? __do_trace_sched_kthread_stop_ret (trace/events/sched.h:38 (discriminator 13))
[    2.436546][   T37]  ret_from_fork_asm (x86/entry/entry_32.S:736)
[    2.436546][   T37]  entry_INT80_32 (x86/entry/entry_32.S:940)
[    2.436546][   T37] Modules linked in:
[    2.493945][   T37] ---[ end trace 0000000000000000 ]---
[    2.496265][   T37] EIP: smpboot_thread_fn (smpboot.c:117)
[    2.498528][   T37] Code: 83 7e 04 00 74 13 8b 06 31 d2 0f a3 05 6c 07 59 84 0f 92 c2 e8 12 65 b7 01 89 f0 e8 4b e9 2e 00 31 c0 83 c4 08 5e 5f 5b 5d c3 <0f> 0b b8 08 52 f5 83 e8 75 85 e6 ff 0f 0b b8 f8 51 f5 83 e8 69 85
All code
========
   0:	83 7e 04 00          	cmpl   $0x0,0x4(%rsi)
   4:	74 13                	je     0x19
   6:	8b 06                	mov    (%rsi),%eax
   8:	31 d2                	xor    %edx,%edx
   a:	0f a3 05 6c 07 59 84 	bt     %eax,-0x7ba6f894(%rip)        # 0xffffffff8459077d
  11:	0f 92 c2             	setb   %dl
  14:	e8 12 65 b7 01       	call   0x1b7652b
  19:	89 f0                	mov    %esi,%eax
  1b:	e8 4b e9 2e 00       	call   0x2ee96b
  20:	31 c0                	xor    %eax,%eax
  22:	83 c4 08             	add    $0x8,%esp
  25:	5e                   	pop    %rsi
  26:	5f                   	pop    %rdi
  27:	5b                   	pop    %rbx
  28:	5d                   	pop    %rbp
  29:	c3                   	ret
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b8 08 52 f5 83       	mov    $0x83f55208,%eax
  31:	e8 75 85 e6 ff       	call   0xffffffffffe685ab
  36:	0f 0b                	ud2
  38:	b8 f8 51 f5 83       	mov    $0x83f551f8,%eax
  3d:	e8                   	.byte 0xe8
  3e:	69                   	.byte 0x69
  3f:	85                   	.byte 0x85

Code starting with the faulting instruction ===========================================
   0:	0f 0b                	ud2
   2:	b8 08 52 f5 83       	mov    $0x83f55208,%eax
   7:	e8 75 85 e6 ff       	call   0xffffffffffe68581
   c:	0f 0b                	ud2
   e:	b8 f8 51 f5 83       	mov    $0x83f551f8,%eax
  13:	e8                   	.byte 0xe8
  14:	69                   	.byte 0x69
  15:	85                   	.byte 0x85


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261019/202610190859.d3459a50-lkp@intel.com


--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



