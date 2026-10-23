Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B6360A2604
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsxhMa+8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jB4061wSpz2yDr;
	Sat, 24 Oct 2026 00:40:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792762822;
	cv=none; b=MWHxr0rshR6Vb2aWDvgIIbkZAljCrbaQp7PM180SxIPOh+nGYJeFvVmgu48GHzrJyNKkSc6HLQHINkR6webLrh11Ef6qRzKNBYyuJJnEw0AgHbLxRVko3nI/RAI1KG9Bl7WzbkhOjSMa8T9CwBJtFn4E1FBbxUaFXafFnF9bpAS2dW9RGMWnhi0rXmHzSDLgfl2wTKVoeESJKwCxy7nvA5Ih6svXtzaeypA6TYbD50oF2jx7gVZ9jVAHUGlVa2fhoaZMNRDXPN7xSO4yzi+TuX8Jwk860byCvBe/RsmQWn0gKOoxzZcZ9DNFfv5+6GT3ewgYfsXqfK2cZhl4GaX4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792762822; c=relaxed/relaxed;
	bh=JSne534GRKySd/hPuhXIpMo4L1wNZz0o43yKbATYUSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBRl59P/0xS5u6F80zo2FOcapxtOM4SKK51hfQlE5Daby+fgr8Eq1KxwvKiBCbD0Oid91EltpNVAjy4/YhIuC724jDFPWfLZzVQuyyfmEeBSJzJPtiKlhS0ld1YAOHs0/2OcEgSQlMQqyDRjwdonJpvuJzupP9ygBSYXgfaUH7LTHaPr/t95luVKRMQBVeqOuLCIKPCpG1miim5F28Ooux9ShkoKre/mLmIHfZBmi9HL0h6GOLbNnu+TK3X2+SAGEC3vO1o/VTKkIzpSR9UhA6zTtHjVv4Dsug85oSXAG0O98koIChQbW3mJB+ahvCmu4zgma8EzCRTIskGuJzMimA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsxhMa+8; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsxhMa+8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jB4051NDKz2yDc
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 00:40:21 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B1E4760213;
	Fri, 23 Oct 2026 13:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9E21F01825;
	Fri, 23 Oct 2026 13:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792762817;
	bh=JSne534GRKySd/hPuhXIpMo4L1wNZz0o43yKbATYUSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MsxhMa+8RyiwJgrd29IwYvMrh1cHDsIzj8ShYsSP8l3MGgb0rGCLCUvRTv9kIxkte
	 t0VZKOUDGbmY6X4T3Gw7XtuUlrbLQGSBSRtT6ZMxixd1345kiDmZsRdQw7kjtVNwhX
	 yVbf1NZHIaJc+XOjIrrRoMJoY5ZgjxbvwdTadswH0wxvmeq8QB3Wt1/eZLhikw2cTA
	 a4/kqD8BG6/dlzLTUoTX8d7Y9YqGUyp6Uqr631ey4In10G1wo1cW7k33IEWmejIFHk
	 TOrqQvWrfH3PSsVDJzFucUAbvMtcO8eK/CiO0FoaiTl0NATRKo3vw3g+XN+zdK7puQ
	 Ev7oA1CQstKaQ==
Date: Fri, 23 Oct 2026 15:40:15 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Kees Cook <kees@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	Marc Zyngier <maz@kernel.org>,
	Pengjie Zhang <zhangpengjie2@huawei.com>,
	Thierry Reding <treding@nvidia.com>, Xi Ruoyao <xry111@xry111.site>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Rong Bao <rong.bao@csmantle.top>, Hui Wang <hui.wang@canonical.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH] sched/hotplug: Remove unused idle_task_exit
Message-ID: <attjv8zOftf9Hlqe@localhost.localdomain>
References: <20261016095711.1364609-1-srikar@linux.ibm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261016095711.1364609-1-srikar@linux.ibm.com>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le Fri, Oct 16, 2026 at 03:26:40PM +0530, Srikar Dronamraju a écrit :
> Commit 21641bd9a7a7 ("lazy tlb: fix hotplug exit race with
> MMU_LAZY_TLB_SHOOTDOWN") moved the handling previously performed by
> idle_task_exit() into the scheduler CPU hotplug path using
> sched_force_init_mm().
> 
> As a result, idle_task_exit() is now an empty stub and the remaining
> architecture call sites have no effect.
> 
> Remove the calls to idle_task_exit() and the now unused stub.
> 
> Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

