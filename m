Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAB3606A320
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 12:34:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVdFq27W4z2xnS;
	Thu, 19 Nov 2026 23:34:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=37.157.195.192
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795091679;
	cv=none; b=Ljcg96LSrgTFkPBjIMJZDWYRKK1mGCUGQiarVyOMP8p55nAz6kwPhmUj/mJRADrOeiuNY7lbUt36rHKehpz+bV7Niiqy+F6mJr1LVfIeEnxudnQI6b9YmsxVF77J0UCeFd0ZzJcLRTih7C4PGedcYHsXHH0TvPeO1H4WuUmp0dwXh43LBc8wQ7+tZW+KkpjTns/mmU+F1eLf/K7klyjNuWXAbMSOxqcfYrX7aq90WVT9/k9Xl3hGmzGlpUi1zE6lQIBkRX4Du0VTdIYB0GL8XDhYRV47ynoUV9+32azqAcfmK/o9213HxVYw49Y5R/w7OykLIBCO0tnb14jNHZPEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795091679; c=relaxed/relaxed;
	bh=/UL0Ly/aF504vkgxgd8XJjk5km6+XodRSirvI0SAbzk=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:Content-Type; b=a/RYO7tSeWM2mqQET+hNDP5f5MKw240izO/alvBTnVmGUE47ywTq58CvEsa36e8dEzqV/9ft1BcYe/G2eYh7gB/1wOfkyLeXksExnXf4LKxe5MEHGE2pquWjxn0tmdpODsbc+7IdDpf6DOLKwgw7QWgNNmhtLMzA4AtJZNsJgj4E6nuMJXBGl+D3hBOv3vMctod9jMrIJOMs2go13PDddTuxU9DykiW12Hg8DIH24xt2qmn2mS76V/tc+YbBqZnkJEwmKvNRSkM26GM2r/rBTX76dbjjgUyCfT33rqX7FxEoxfd9kLCon61gqJkW/OUK4aYyo4UK7DJP/EXpFFeqIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=danny.cz; spf=pass (client-ip=37.157.195.192; helo=redcrew.org; envelope-from=dan@danny.cz; receiver=lists.ozlabs.org) smtp.mailfrom=danny.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=danny.cz
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=danny.cz (client-ip=37.157.195.192; helo=redcrew.org; envelope-from=dan@danny.cz; receiver=lists.ozlabs.org)
X-Greylist: delayed 357 seconds by postgrey-1.37 at boromir; Thu, 19 Nov 2026 23:34:37 AEDT
Received: from redcrew.org (redcrew.org [37.157.195.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVdFn1l6Cz2xSl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 23:34:37 +1100 (AEDT)
Received: from server.danny.cz (85-71-161-19.rce.o2.cz [85.71.161.19])
	by redcrew.org (Postfix) with ESMTP id 2EA15E8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 13:28:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 redcrew.org 2EA15E8
Received: from talos.danny.cz (talos [IPv6:2001:470:5c11:160:47df:83f6:718e:218])
	by server.danny.cz (Postfix) with SMTP id E178A19A005
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 13:28:33 +0100 (CET)
Date: Thu, 19 Nov 2026 13:28:33 +0100
From: Dan =?UTF-8?B?SG9yw6Fr?= <dan@danny.cz>
To: linuxppc-dev@lists.ozlabs.org
Subject: WARNING: mm/slub.c:5459 at ___kmalloc_large_node in 7.4-rc3
Message-Id: <20261119132833.cf48ab8d95a8be3b900332e2@danny.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; powerpc64le-redhat-linux-gnu)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

I am seeing "WARNING: mm/slub.c:5459 at ___kmalloc_large_node" when
booting 7.4-rc3 on my Power9 based Talos system. The warning wasn't
present in 7.4-rc1. Is it something known or should I try bisecting?

...
lis 19 08:02:43 talos.danny.cz kernel: VFS: Dquot-cache hash table entries: 8192 (65536 bytes)
lis 19 08:02:43 talos.danny.cz kernel: Mount-cache hash table entries: 131072 (order: 4, 1048576 bytes, vmalloc)
lis 19 08:02:43 talos.danny.cz kernel: Mountpoint-cache hash table entries: 131072 (order: 4, 1048576 bytes, vmalloc)
lis 19 08:02:43 talos.danny.cz kernel: VFS: Finished mounting rootfs on nullfs
lis 19 08:02:43 talos.danny.cz kernel: ------------[ cut here ]------------
lis 19 08:02:43 talos.danny.cz kernel: WARNING: mm/slub.c:5459 at ___kmalloc_large_node+0x1a4/0x200, CPU#60: swapper/60/1
lis 19 08:02:43 talos.danny.cz kernel: Modules linked in:
lis 19 08:02:43 talos.danny.cz kernel: CPU: 60 UID: 0 PID: 1 Comm: swapper/60 Not tainted 7.4.0-0.rc3.26.fc46.ppc64le #1 PREEMPT(lazy) 
lis 19 08:02:43 talos.danny.cz kernel: Hardware name: T2P9D01 REV 1.00 POWER9 (raw) 0x4e1202 opal:skiboot-ecb1dc7 PowerNV
lis 19 08:02:43 talos.danny.cz kernel: NIP:  c000000000800f24 LR: c0000000008026ac CTR: c000000000067394
lis 19 08:02:43 talos.danny.cz kernel: REGS: c00000000cdb3770 TRAP: 0700   Not tainted  (7.4.0-0.rc3.26.fc46.ppc64le)
lis 19 08:02:43 talos.danny.cz kernel: MSR:  9000000002029033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000004  XER: 00000000
lis 19 08:02:43 talos.danny.cz kernel: CFAR: c000000000800d9c IRQMASK: 0 
                                       GPR00: c000000000813260 c00000000cdb3a10 c000000002a3a700 ffffffffffffffff 
                                       GPR04: 0000000000000dc0 ffffffffffffffff fffffffffffe0000 0000000000000000 
                                       GPR08: 0000000000000000 0000000000000001 c000000003f0a700 0000000000000000 
                                       GPR12: c000000000067394 c0000000041d0000 c0000000000116f0 0000000000000000 
                                       GPR16: 0000000000000000 0000000000000000 c0000000022e11d8 0000000000000000 
                                       GPR20: 0000000000000000 ffffffffffffffea c0000000032d0590 c000000002102dc8 
                                       GPR24: 0000000000000001 c0002007ff641900 c0000000030d3908 ffffffffffffffea 
                                       GPR28: c000000000813260 ffffffffffffffff 0000000000000dc0 ffffffffffffffff 
lis 19 08:02:43 talos.danny.cz kernel: NIP [c000000000800f24] ___kmalloc_large_node+0x1a4/0x200
lis 19 08:02:43 talos.danny.cz kernel: LR [c0000000008026ac] __kmalloc_large_node_noprof+0x3c/0x170
lis 19 08:02:43 talos.danny.cz kernel: Call Trace:
lis 19 08:02:43 talos.danny.cz kernel: [c00000000cdb3a10] [c0000000015c20b4] of_get_property+0x1f4/0x2c0 (unreliable)
lis 19 08:02:43 talos.danny.cz kernel: [c00000000cdb3a50] [c000000001b3cd9c] _raw_spin_unlock_irqrestore+0x4c/0xa0
lis 19 08:02:43 talos.danny.cz kernel: [c00000000cdb3aa0] [c000000000813260] __kmalloc_noprof+0x520/0x840
lis 19 08:02:43 talos.danny.cz kernel: [c00000000cdb3b30] [c0000000000673ac] _kzalloc_noprof.constprop.0+0x20/0x84
lis 19 08:02:43 talos.danny.cz kernel: [c00000000cdb3b50] [c00000000301da40] init_thread_group_cache_map+0x110/0x450
lis 19 08:02:43 talos.danny.cz kernel: [c00000000cdb3c20] [c00000000301ddfc] init_big_cores.isra.0+0x7c/0x1c4
lis 19 08:02:43 talos.danny.cz kernel: [c00000000cdb3cc0] [c00000000301e488] smp_prepare_cpus+0x4a0/0x61c
lis 19 08:02:43 talos.danny.cz kernel: [c00000000cdb3d50] [c00000000300f160] kernel_init_freeable+0x154/0x29c
lis 19 08:02:43 talos.danny.cz kernel: [c00000000cdb3df0] [c00000000001171c] kernel_init+0x34/0x1c8
lis 19 08:02:43 talos.danny.cz kernel: [c00000000cdb3e50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x1c
lis 19 08:02:43 talos.danny.cz kernel: ---- interrupt: 0 at 0x0
lis 19 08:02:43 talos.danny.cz kernel: Code: 7c0803a6 4e800020 60420000 7c234840 4081fea4 3d22014d 8929c335 2c090000 40820014 39200001 3d42014d 992ac335 <0fe00000> 39200000 38210040 7d3e4b7>
lis 19 08:02:43 talos.danny.cz kernel: ---[ end trace 0000000000000000 ]---
lis 19 08:02:43 talos.danny.cz kernel: POWER9 performance monitor hardware support registered
lis 19 08:02:43 talos.danny.cz kernel: rcu: Hierarchical SRCU implementation.
lis 19 08:02:43 talos.danny.cz kernel: rcu:         Max phase no-delay instances is 1000.
lis 19 08:02:43 talos.danny.cz kernel: Timer migration: 3 hierarchy levels; 8 children per group; 2 crossnode level


	Thanks,

		Dan

