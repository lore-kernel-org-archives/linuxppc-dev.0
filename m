Return-Path: <linuxppc-dev+bounces-24098-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86D8C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 07:02:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzCzd14C9z2xqM;
	Mon, 13 Jul 2026 17:02:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783926125;
	cv=none; b=DF0qeJ1TfR83WYp/RNbQPP/INQ3HeXZGqRA7qBoIZ7TgirFZMk8wwskYapHDCklM6HYGxY4duq8Q4oQK09sN5fVxR3HnDxzEQoBMwnwCxjYpJDBGIsvEsL2g2sQ5SIj9i/5zFGfw4EN/9973W9p8p1yF1UKkiV8g+DHS5RZygux6hXe2L1YU0RcvzdUn2oHx2004RdEw3Q6b+zW8bspgnab3X/mmgK5yepCDIXYzFeV9djBP6XQWcXdZaL0EGopVj68KnT6qPNXQd0lgFYtKYlK8bBd5lhM8t8IlEz4n/quUrRnFFHq660jkKbUlOfn1M27W4oXQA9X94u4s0nPDOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783926125; c=relaxed/relaxed;
	bh=gnmxNdHqKoh6xuYofsr73YiT+W94DI4jpIiM80uad1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTtAwWSb726V3uTcZIm+lisZM5TOulpeDWZvIJBj/mnWzWzUX0tT6EBlN01/cAcHWuKGunQbJaQuHAyxkIxPdAHtUmin4VWnA+JFMG6y78BBgAbUHzwdjQAt71aNhmzeArq4ROiVJNyIQ7W/KY3fuXtADgP04zievr/VGX8s8hv7sOSbPOQdck7862zKHKt9l7FpChtjeoAm7INDSyvxoXunXVzL8HyThrYGhRWwwUYZk20gDA+lO6Ar6THhCx5jmvAAxouFAV1HZlR0KEjoE45oFa9cN4409Z9x7bMenNMjniB4gczUcQBY7kBEnVlmzpgxsgfjMhypHYivBtx2kQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xuFdla/6; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=cXVv1a5z; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xuFdla/6;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=cXVv1a5z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzCzb5tyMz2xlv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 17:02:03 +1000 (AEST)
Date: Mon, 13 Jul 2026 09:01:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783926118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gnmxNdHqKoh6xuYofsr73YiT+W94DI4jpIiM80uad1k=;
	b=xuFdla/6ifWVxs+wZ/ziKIXPwTG8sNl1CvOxpSkj7lA5470k6wTgjpeu7/nlRL+oihS2Qs
	JADuHCTtvX5KsRBE+2BwukLfzUJWDi3WmNcefXD07sqWlxw7cq54WE1/rhAb0H08RGTG54
	NKVh6zGp+juLKf0xn/ZZ/iHAUAMgZL1Gz+AEf4FCljbY9Gs2UrRNV9CQfA9ZnvX7iuY/CR
	+eH0hO+UwyFjJgLhe6cGdJg9VIHjkyqxDiQcyzD1kAE21gJQJA90gnhj4aClj+bpR70P1/
	PyuEkKpTBKkI7DGLCZkpzwWyVeBOFCXJejv6p2QBYbd8qAfd3VxT9OjpsNrVgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783926118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gnmxNdHqKoh6xuYofsr73YiT+W94DI4jpIiM80uad1k=;
	b=cXVv1a5zXQlrcFC6I4GHPNC9QKNeWn00sP2uqrUVvBJohK68NTBxPt4JyPk2bcommOIhMi
	q3BAQe+PJhx4WPDw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, nathan@kernel.org, kees@kernel.org, 
	xur@google.com, arnd@arndb.de, peterz@infradead.org, gourry@gourry.net, 
	lukas.bulwahn@redhat.com, ryan.roberts@arm.com, yangtiezhu@loongson.cn, 
	mchauras@linux.ibm.com, sshegde@linux.ibm.com, austin.kim@lge.com, jchrist@linux.ibm.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH RESEND] syscall_user_dispatch: Introduce
 ARCH_SUPPORTS_SYSCALL_USER_DISPATCH
Message-ID: <20260713085930-c6e454ac-cb4d-4016-8971-49df521e1d8d@linutronix.de>
References: <20260713035422.582771-1-ruanjinjie@huawei.com>
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
In-Reply-To: <20260713035422.582771-1-ruanjinjie@huawei.com>

On Mon, Jul 13, 2026 at 11:54:22AM +0800, Jinjie Ruan wrote:
> Currently, only x86 genuinely implements and supports Syscall User
> Dispatch (SUD). Multiple architectures provide a stub
> arch_syscall_is_vdso_sigreturn() returning 'false' simply to satisfy
> GENERIC_ENTRY compilation, which creates a false impression of feature
> support.
> 
> Introduce ARCH_SUPPORTS_SYSCALL_USER_DISPATCH to decouple this mechanism
> from GENERIC_ENTRY. Select it exclusively on x86 and remove the redundant
> stub functions from other architectures.
> 
> Link: https://lore.kernel.org/linux-arm-kernel/akZgV0Y4YAmB43_g@J2N7QTR9R3.cambridge.arm.com/
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Gregory Price <gourry@gourry.net>
> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Cc: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

> ---
> v1 -> RESEND
> - Define missing ARCH_SUPPORTS_SYSCALL_USER_DISPATCH.

If code is changed it is not a resend. Instead it should have been v2.

> ---
>  arch/Kconfig                         | 4 ++++
>  arch/loongarch/include/asm/syscall.h | 6 ------
>  arch/powerpc/include/asm/syscall.h   | 5 -----
>  arch/riscv/include/asm/syscall.h     | 5 -----
>  arch/s390/include/asm/syscall.h      | 5 -----
>  arch/x86/Kconfig                     | 1 +
>  6 files changed, 5 insertions(+), 21 deletions(-)

(...)

