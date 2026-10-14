Return-Path: <linuxppc-dev+bounces-29490-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60069CC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:36:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4Zzw5Ygpz2ynZ;
	Thu, 15 Oct 2026 02:36:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791992172;
	cv=none; b=JMuJjUyyL3tvVtxVTc9Kd4XTzBvPXoAItTEnS9GqutodY3VBElb5M8jH19m+rwRBh6Jd1bqelZuExS68qAtrzZXeriaRKnd0Afg4H1S0ScKbPyJu/9+wQR0K2rgQT+qs6hHAZc+USPXIcXwvVsew2cXElp+orpP8lGK3bVyjdmVscEcEcznxxvm6p7yWxACqh9PSGn0Lr+eWM0lBgcpbMYdUXqwhuWOthdMhOnOzGgMm6HO4osuYpAErh/dGI9+BTtjsnU6CKOnbmx/d8fqLG2ZVYpAKPZKPTUeUnOXGq1YCKpXlc0BG1Dv+c/wts1+VyQGTM2qMXRqcglNx93DV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791992172; c=relaxed/relaxed;
	bh=qA6YOwaVdkDe5WPMOWVzqY8zBl+ZRCOyb3XB7KK+18Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=adHHmobpm5lmRWoEaCwaWonrXjN6i5wyk97fCWjmzhKqPCCiw0Uug8IqyD4rEZNxf5wUc+eERMrUodPnkmNRzmqUUf5qPRVqVvl4A7YO0Wqpz34x5o+vjnTS2VbWKpDWcY4k2P1f4CrMiGXE7+X/pymx0HS4rKsoaHFa5IH2XfoFHuz1kZRvz/07l5CRP72Is4/KjtJ3LIxlMibTphLDF9AGAHs0IPQDoUPIWb7RWOuq+A/WbE1PwxLZfLpVpE7NR7vR6sSxIGe/w+rZcrNRcodqfqLmkcAoxeAyVX69yNcCWjT4P0MX+YUl7gDvW89/39XiVaYUijpnaYVikc9rdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fvQXGdjo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fvQXGdjo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com [IPv6:2607:f8b0:4864:20::132c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4Zzt2BvZz2yK7
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 02:36:09 +1100 (AEDT)
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-3535a54bed9so1607708eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 08:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791992168; x=1792596968; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qA6YOwaVdkDe5WPMOWVzqY8zBl+ZRCOyb3XB7KK+18Y=;
        b=fvQXGdjol8mr85oyIV/8sMn+u2gMfzzNDPiD4fmpztPMuqigOQ30+eAw5SF2k3J4yA
         dvlS+5TMHTXKhCkR0hnwsMz5r57xKIFSq/NlEHrKCrGhRmCQBHRsYCsf8quI0i8Wf06O
         +XcUiN1x8mZ0rE77jm4myC2i3PAJF8PNUKebDn+bYr0aPN/dHBvKOVSJ1OqqYEgN0Nzc
         W5UbuY3T6v8WEoRqXpt6CJc+/ohYVN4orQU1vu0dUbcofQl7PJq5G8lsTmNT3uc1EwT+
         CMLp89/wuqjBTRzSd1Dkxuks50cPpbCIkp0k28GbFVqmejpwnmqEm6pCgSX/6GY3yDLr
         vLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791992168; x=1792596968;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qA6YOwaVdkDe5WPMOWVzqY8zBl+ZRCOyb3XB7KK+18Y=;
        b=RUrL3ZzoF481UHZ53XI6EeatbQWVdu+Q6qbOBlyUCbS4pMN/dd6DiG9KabRLwbee5V
         zRRzREEKniKE1gh7GVqahsZvf83J3mkCjZjkPiCwJKkh1L04MME2psX4altqDQUpySSn
         T0QudK6NdUnMyS1E+6khMIqUOCNaz1LL6LPEVkw71eBdZXLc9fmTJNHU8TzjjPJP4yNF
         xkNfL7MpeSWqzoFPDiuX8IlbtRxSP1TTvy+pFZr4osg15Y7dBr8cVApj3KypoAHJdziP
         4+YE4mtZk5uB5j8XAh3Miat4aZ5CXf3b/pyohfLNvWrHkjrGlsDuGu9/p7PLYNznkZW+
         /EKA==
X-Forwarded-Encrypted: i=1; AKwUvBy08vb7jJjfNc639JzB0DyhuUtNYTlXiHatLwxGhG1BQ+2Qcc+sJ8diudDcqnaTp9tdi3zzBBH8t6a6DLY=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKA+hPF3l4znBbI6Lk0jmOUgzODWYVB0kjLK87YG7bxksB/pZ12
	O88vsV8DuTbL2hInLJlOt6KUcDRsOEBbaXXyIa91Bw/fjtgIkFwQn63D
X-Gm-Gg: AYBFou0uzzruhvOXtOtSodJdA2wYBjmkiqtIqPrWMadmY5+QXkwEQ33OrPZk1VTSlGV
	QpT3obmZrwDzz8fP883azTUEq4U7iiWxPHGS+JlJgQ2ogdTIebLP0tx3oIpb7B+bM2+3V+YUUH0
	RXPq6JjpXsNxKrMhcdJPJJ8cC/UhKC9PWH+J2lixj8X4qWEOiBiKV4Jd5NC77kJv/XahmNlm9QS
	lgbFsVMS5LRdoilYuLZe1je5ASmUinTCujJQ/JDs3nF9sL5EMBqm6/+YwOuloRHIkEJTghrk8iU
	a8aqs/f8aqRk3CCHsmeBUgyYXOj6TZzxt79zQcBAM2PrDf/VuRwwYbBckiBbVIPiL72G2+vT9sd
	M+Y1PqyTZ2qoSBA9Cqn8jZ4uaMGtz1onBRHH6UrsZwnb0l2WKl7F4M9Z2j9SVyDS11maMJ1y2GT
	8NtOn9SWusEZRuVXRamkrOHZQ8gvZEskBQqnOh4elbkeAMYaEBnGUcS4xybgX2MfzViO1z
X-Received: by 2002:a05:7300:e9d6:10b0:359:bdc8:c9d5 with SMTP id 5a478bee46e88-359bdd83104mr17479248eec.21.1791992167458;
        Wed, 14 Oct 2026 08:36:07 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca6d20dsm58172660eec.12.2026.10.14.08.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:36:06 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Muchun Song <songmuchun@bytedance.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Qi Zheng <qi.zheng@linux.dev>, Lance Yang <lance.yang@linux.dev>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>, muchun.song@linux.dev
Subject: Re: [PATCH v4 0/6] mm: Unify device DAX and HugeTLB vmemmap population paths
In-Reply-To: <20261010075755.83339-1-songmuchun@bytedance.com>
Date: Wed, 14 Oct 2026 20:19:23 +0530
Message-ID: <wlrkqqvg.ritesh.list@gmail.com>
References: <20261010075755.83339-1-songmuchun@bytedance.com>
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

Muchun Song <songmuchun@bytedance.com> writes:

> This v4 is based on mm-new commit d5207c6d152c, which contains v6 of
> "mm: Switch device DAX to section-based vmemmap optimization" [1].
>

Hi Muchun,

I was checking this patch series and seems like I am hitting an issue on
mm-new, which most likely is due to this patch series.
(Note that a similar issue was reported by Pavithra on PowerPC)

Let me first give the call stack:

[   79.930815] page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0x140000
[   79.930833] flags: 0x0(node=0|zone=0|lastcpupid=0x0)
[   79.930838] raw: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   79.930840] raw: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   79.930841] page dumped because: VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn))
[   79.931043] ------------[ cut here ]------------
[   79.931051] kernel BUG at mm/page_alloc.c:373!
[   79.931109] Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
[   79.940576] CPU: 2 UID: 0 PID: 743 Comm: ndctl Tainted: G                 N  7.3.0-rc5-01065-g45f4c1453cbe #23 PREEMPT(full)
[   79.942647] Tainted: [N]=TEST
[   79.943190] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   79.945080] RIP: 0010:__set_pfnblock_flags_mask.constprop.0+0xef/0x110
[   79.946231] Code: 48 8b 07 48 89 d1 48 f7 d1 48 89 c2 48 21 ca 48 09 f2 f0 48 0f b1 17 75 f0 c3 cc cc cc cc 48 c7 c6 b0 9b 5a 83 e8 91 be fa ff <0f> 0b ba 00 10 00 00 e9 7a ff ff ff 48 c7 c6 a8 b5 56 83 e8 79 be
[   79.949296] RSP: 0018:ffffc90011ebf7b0 EFLAGS: 00010246
[   79.950179] RAX: 000000000000004a RBX: 0000000000140000 RCX: 0000000000000000
[   79.951366] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffffffffff
[   79.952562] RBP: 0000000000180000 R08: 0000000000000001 R09: 0000000000000000
[   79.953759] R10: 0000000000000118 R11: 0000000000008000 R12: 0000000000000001
[   79.954948] R13: 0000000000000000 R14: 0000000000180000 R15: 0000000000190000
[   79.956151] FS:  00007ffff7e36d40(0000) GS:ffff8880f7f22000(0000) knlGS:0000000000000000
[   79.957490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   79.958464] CR2: 000055555572ce90 CR3: 0000000031130003 CR4: 0000000000172ef0
[   79.959657] Call Trace:
[   79.960096]  <TASK>
[   79.960487]  pageblock_migratetype_init_range.constprop.0+0x50/0x90
[   79.961561]  memmap_init_zone_device+0x2fb/0x380
[   79.962392]  pagemap_range+0x272/0x590
[   79.963069]  memremap_pages+0x125/0x210
[   79.963726]  ? lockdep_hardirqs_on+0x7d/0x100
[   79.964488]  devm_memremap_pages+0x21/0x70
[   79.965191]  dev_dax_probe+0x1db/0x300
[   79.965870]  dax_bus_probe+0x6f/0xa0
[   79.966495]  call_driver_probe+0x24/0xf0
[   79.967190]  really_probe+0xb6/0x310
[   79.967810]  ? __pfx___device_attach_driver+0x10/0x10
[   79.968667]  __driver_probe_device+0x87/0x190
[   79.969415]  ? __pfx___device_attach_driver+0x10/0x10
[   79.970270]  driver_probe_device+0x1f/0x90
[   79.970976]  __device_attach_driver+0x89/0x130
[   79.971734]  bus_for_each_drv+0x86/0xe0
[   79.972412]  __device_attach+0xb6/0x1d0
[   79.973078]  device_initial_probe+0x40/0x60
[   79.973791]  bus_probe_device+0x3d/0xa0
[   79.974453]  device_add+0x4f0/0x6c0
[   79.975068]  __devm_create_dev_dax+0x18b/0x3f0
[   79.975830]  devm_create_dev_dax+0x21/0x40
[   79.976530]  __dax_pmem_probe+0x1c3/0x200
[   79.977244]  dax_pmem_probe+0xe/0x20
[   79.977867]  nvdimm_bus_probe+0x89/0x250
[   79.978566]  call_driver_probe+0x24/0xf0
[   79.979242]  really_probe+0xb6/0x310
[   79.979868]  __driver_probe_device+0x87/0x190
[   79.980618]  device_driver_attach+0x47/0xb0
[   79.981336]  bind_store+0x76/0xc0
[   79.981922]  kernfs_fop_write_iter+0x152/0x200
[   79.982715]  vfs_write+0x276/0x520
[   79.983323]  ksys_write+0x6b/0xe0
[   79.983900]  do_syscall_64+0xa6/0x470
[   79.984543]  entry_SYSCALL_64_after_hwframe+0x76/0x7e


also - 

[    4.426995] BUG: kernel NULL pointer dereference, address: 0000000000000090
[    4.428266] #PF: supervisor read access in kernel mode
[    4.428266] #PF: error_code(0x0000) - not-present page
[    4.428266] PGD 0 P4D 0
[    4.428266] Oops: Oops: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
[    4.428266] CPU: 6 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc5-01065-g45f4c1453c
[    4.428266] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f04
[    4.428266] RIP: 0010:__set_pfnblock_flags_mask.constprop.0+0x3d/0x110
[    4.428266] Code: 84 e3 00 00 00 48 8b 17 48 89 d1 48 c1 ea 37 83 e2 07 48 c1 e9 3a 48 8d 14 52 40
[    4.428266] RSP: 0000:ffffc9000001b770 EFLAGS: 00010246
[    4.428266] RAX: 0000000000140000 RBX: 0000000000140000 RCX: 0000000000000020
[    4.428266] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffea0005000000
[    4.428266] RBP: 0000000000180000 R08: ffff8880093e1600 R09: 0000000000000040
[    4.428266] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
[    4.428266] R13: 0000000000000000 R14: 0000000000180000 R15: 0000000000190000
[    4.428266] FS:  0000000000000000(0000) GS:ffff8880f8722000(0000) knlGS:0000000000000000
[    4.428266] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.428266] CR2: 0000000000000090 CR3: 0000000003aac001 CR4: 0000000000172ef0
[    4.428266] Call Trace:
[    4.428266]  <TASK>
[    4.428266]  pageblock_migratetype_init_range.constprop.0+0x50/0x90
[    4.428266]  memmap_init_zone_device+0x2fb/0x380
[    4.428266]  pagemap_range+0x272/0x590
[    4.428266]  memremap_pages+0x125/0x210
[    4.428266]  ? lockdep_hardirqs_on+0x7d/0x100
[    4.428266]  devm_memremap_pages+0x21/0x70
[    4.428266]  dev_dax_probe+0x1db/0x300
[    4.428266]  dax_bus_probe+0x6f/0xa0
[    4.428266]  call_driver_probe+0x24/0xf0
[    4.428266]  really_probe+0xb6/0x310
[    4.428266]  ? __pfx___device_attach_driver+0x10/0x10
[    4.428266]  __driver_probe_device+0x87/0x190
[    4.428266]  ? __pfx___device_attach_driver+0x10/0x10
[    4.428266]  driver_probe_device+0x1f/0x90
[    4.428266]  __device_attach_driver+0x89/0x130
[    4.428266]  bus_for_each_drv+0x86/0xe0
[    4.428266]  __device_attach+0xb6/0x1d0
[    4.428266]  device_initial_probe+0x40/0x60
[    4.428266]  bus_probe_device+0x3d/0xa0
[    4.428266]  device_add+0x4f0/0x6c0
[    4.428266]  __devm_create_dev_dax+0x18b/0x3f0
[    4.428266]  devm_create_dev_dax+0x21/0x40
[    4.428266]  __dax_pmem_probe+0x1c3/0x200
[    4.428266]  dax_pmem_probe+0xe/0x20
[    4.428266]  nvdimm_bus_probe+0x89/0x250
[    4.428266]  call_driver_probe+0x24/0xf0
[    4.428266]  really_probe+0xb6/0x310
[    4.428266]  ? __pfx___driver_attach+0x10/0x10
[    4.428266]  __driver_probe_device+0x87/0x190
[    4.428266]  ? __pfx___driver_attach+0x10/0x10
[    4.428266]  driver_probe_device+0x1f/0x90
[    4.428266]  __driver_attach+0xd7/0x200
[    4.428266]  bus_for_each_dev+0x79/0xc0
[    4.428266]  bus_add_driver+0x127/0x250
[    4.428266]  driver_register+0x59/0x100
[    4.428266]  ? __pfx_dax_pmem_init+0x10/0x10
[    4.428266]  do_one_initcall+0x59/0x3a0
[    4.428266]  do_initcalls+0xdd/0x1b0
[    4.428266]  kernel_init_freeable+0x16f/0x2b0
[    4.428266]  ? __pfx_kernel_init+0x10/0x10
[    4.428266]  kernel_init+0x1f/0x1d0
[    4.428266]  ret_from_fork+0x244/0x280
[    4.428266]  ? __pfx_kernel_init+0x10/0x10
[    4.428266]  ret_from_fork_asm+0x1a/0x30
[    4.428266]  </TASK>


- I am hitting this issue on x86 kvm itself (and also on PowerPC)
- I am able to hit the issue with the following extra qemu params:
    -m 2G,slots=4,maxmem=16G
    -object memory-backend-file,id=mem1,mem-path=/tmp/nvdimm.img,size=2560M,share=on -device nvdimm,id=nvdimm0,memdev=mem1,label-size=256M,addr=0x100000000

    # then once the system comes up
    ndctl disable-region region0
    ndctl init-labels all
    ndctl enable-region region0

    ndctl create-namespace -r region0 -t pmem -m raw -s 256M
    ndctl create-namespace -r region0 -t pmem -m devdax -M mem -a 1G -s 2G 

I am still debugging this issue - but from the logs it looks like that
some struct page was never initialized which caused the VM_BUG_ON().

Can you take a look at this once?

Thanks!
-ritesh



