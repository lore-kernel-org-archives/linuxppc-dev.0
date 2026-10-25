Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67515606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Oct 2026 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6C08BAV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCQjp6Drrz2y2h;
	Mon, 26 Oct 2026 05:47:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792954062;
	cv=none; b=UI3pSkf9lzWZkACCd6/CjkdZ6aYyp9Q2DUA7STP23g7vSgp6vyNC5+rXW2ABa7CqyAtcvANvWVpKduGAMjNOXhF/8kjxzEaCBfWVpdpO+MdtEtZtozRpoqR0aPteyEgCJQE5Z+9+JM9MNIRG+MuaiNJkvoeT4VKfdLBquRDnR50eXRFivVGkzREW0G1mNcNTa7EAUzutQ4qASr0lzaQaVEh2zJuSylr/11HEaWXJNMuLD++sAVIqCukBzdGQij/m1rGy4kuag8azzlQGfY6DWbAmfiNTu0XtbymrhP3D9tEA3+CrUSkqUWt2Br+BLbfUaVTb4yrVm1GvkOP2qt4/tA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792954062; c=relaxed/relaxed;
	bh=5wnAqR12mDvQqCEE/MRBIlSMPEALxmmJZfIrTK2aMRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pr0/j8orsu3+mYf4A6uUSvUu0xTEDRhaTPYlXOey9CHuKmY+4WHu7M84A8iKDnC8NIqt1yWID3ddqvf0dpruPsmh1Ra6WCXJQH920MfX+B+Co9u0awGFUNNgKcivYiyPWultlcQ8mMc32Ubr5+xt3IljassFHdHIYDExTihz3bBas1CnqqJZw/WX8BCHUJJlWETcbMKWcuWoHb4bC+Jbd9QpNNDyKgBZXGGBdzpsrylTSqJWhLpLOrrrimUh/GslIiNMCCDQ/qKS5naSfmBwZxn01E8SAQ1h7xwKzEh18uxeL8L+ipK3UwPlcbP5ANinFenfAIiM8s+rYe2kJ399nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6C08BAV; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6C08BAV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCQjn5HTGz2xfK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 05:47:41 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 35C62600CB;
	Sun, 25 Oct 2026 18:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2E91F01828;
	Sun, 25 Oct 2026 18:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792954057;
	bh=5wnAqR12mDvQqCEE/MRBIlSMPEALxmmJZfIrTK2aMRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J6C08BAV+F3iiWM9FlcPNqjRNGrOHJtPKNVu3OUcI7HqHZFW2bJf7N0c8G+JK3kuC
	 Q9nwKr5QZZOaBx04tv6bryafAtS3l8ddZSESLreLqFOuH9yUyY5YFa2WLyjKrfokOY
	 I5aQbn4Z7ktlYAGGiVhADA+Z2owm484BBGS0MXEu9+8SJ1Xd+9nopeImLHezCjmbsI
	 l+b9jyQmwALbi3HX0Fd2Od6jLx4uuOwo/I0r78SNRDtzRGmz0Z0w8l5bueq5IOCdWr
	 lyimjYWJ1aQUhpScd4g5pAdhgA9k8TZ3KLStW1ngSWF9YCMs/TnFJYzxEr+8kDEq+3
	 1F+kG3xlNHiHw==
Date: Sun, 25 Oct 2026 19:47:34 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Srikar Dronamraju <srikar@linux.ibm.com>,
	Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <at5OxorR-UUIxlIe@pavilion.home>
References: <20261016095711.1364609-1-srikar@linux.ibm.com>
 <attjv8zOftf9Hlqe@localhost.localdomain>
 <20261023165434.GX2823843@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20261023165434.GX2823843@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le Fri, Oct 23, 2026 at 06:54:34PM +0200, Peter Zijlstra a écrit :
> On Fri, Oct 23, 2026 at 03:40:15PM +0200, Frederic Weisbecker wrote:
> > Le Fri, Oct 16, 2026 at 03:26:40PM +0530, Srikar Dronamraju a écrit :
> > > Commit 21641bd9a7a7 ("lazy tlb: fix hotplug exit race with
> > > MMU_LAZY_TLB_SHOOTDOWN") moved the handling previously performed by
> > > idle_task_exit() into the scheduler CPU hotplug path using
> > > sched_force_init_mm().
> > > 
> > > As a result, idle_task_exit() is now an empty stub and the remaining
> > > architecture call sites have no effect.
> > > 
> > > Remove the calls to idle_task_exit() and the now unused stub.
> > > 
> > > Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> > 
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Excellent; less is more and all that. Shall I take this through the
> scheduler tree?

Yes please :-)

-- 
Frederic Weisbecker
SUSE Labs

