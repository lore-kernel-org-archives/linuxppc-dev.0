Return-Path: <linuxppc-dev+bounces-24072-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B4EC43458
	for <linuxppc-dev@archiver.kernel.org>; Sun, 12 Jul 2026 21:25:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gyzB73RqHz2y7W;
	Mon, 13 Jul 2026 07:25:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783891519;
	cv=none; b=LhUR6hMlKy7zmba9SpWH7DgyruNxVFBxiq4n3FMx7QqGYn67pYI3Z/PtgpfR2W4BuLkugxYAI+dvUcvCPMrxZiSUdBms3PJGLUqSNcAcRNrCwrzPJ82MW9XOn23jKBNyDCBYwVB+0FkiaI5TaYO6bmvb1/EMSId2GBfv+jHhoIIpA9GtEdO1V0dvrzrPojf68cf3KKmH1mNrdNTmiqtD3j5WAj6SgibXS1NGxxYI/oXfdaDOSOKt/PIDYBRM+jGVANHBI5Gte0F43jkGwwS6XvkG9dMhODs34AtnSn+d95zv1t0OOz7xaXKdqx3M0f1gYJTK1ozXpow5XwmYaJqEig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783891519; c=relaxed/relaxed;
	bh=lwBg36/x+UtK8CJqmuUc9WLztI2cbur8/uNJ6nqvy3A=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Ne10rqyo1Xj3+Jzt0P26GaKht/zXxWxezw6TqfVMKy+yDCpYkOzZnCRMptyxnP8ZvzAM75QMPrQNYWcxLclFzXKXkLWh8I1BfUgAz3BCgazP+UVoOeciTHBc8jnKlEFefjHOBOujqbyQ52/1LKY7FxRM/eJFrRx5O06q/844YhENmRjfRWN/hnLytPahIM4KQiBzaPWQ05dyf8wWpUxeUmknlqRVlSCTylyeLqZym4hQlEn+JVSWbH9Ein0DZBnAUYqYC6g6xW7EacchoarnAWkQnvhr2ch3O1C43v8Ns+/j377PB2i5+2vipm6fx0OnjiishZBUReBdEuzHvJSJsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUihrXXV; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUihrXXV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gyzB71SSHz2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 07:25:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8A67760018;
	Sun, 12 Jul 2026 21:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767DE1F000E9;
	Sun, 12 Jul 2026 21:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783891516;
	bh=lwBg36/x+UtK8CJqmuUc9WLztI2cbur8/uNJ6nqvy3A=;
	h=Date:From:To:Cc:Subject;
	b=iUihrXXVEGq2SYK9UQGaK/ixJHkvadpYQ4DOH4S/nAejgcD/b7GUWwBZ5jduOfGTp
	 i2GmHCBrjqnQqhqfy4uM2Nm1ZqAGGaYxEbfVavR0WHrnlVlBrqHw8lCXBF+I+H4UYL
	 rp//e3HRjshpQ+bNYw6Guvww3ARF7O7HJsAP1v+ktF8f16Gw0ufg7Kv+IvYnQqmnDd
	 nOouURl3ey8GIdW1RylaSmhjzQZmjZJj0NnC6v8qojx/WotJKtYEUPvgrJhaLKZf29
	 MvSWr2X6GY8DZQ/V7/XPuTag3oQfy5KgCPYjv4bZ3cYiQUKKlTvDFxz1jtaHpcPEp9
	 9manpI38rMBQQ==
Date: Sun, 12 Jul 2026 23:25:12 +0200
Message-ID: <20260712134433.549076055@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 x86@kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 Magnus Lindholm <linmag7@gmail.com>,
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Radu Rendec <radu@rendec.net>
Subject: [patch 0/4] entry: Rework syscall skip logic
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

This are the reworked leftovers of the larger entry logic rework series,
which can be found here:

  https://lore.kernel.org/lkml/20260707181957.433213175@kernel.org

The undisputed part of the series has been merged into:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry

After a fruitless discussion about the most resilent approach, I decided to
give up wasting my time and reworked the series so it caters to the desire
of powerpc and s390 to be special.

That results in almost identical behavior except for the case where
tracing/probe/BPF sets the syscall number to -1 (or any other out of range
value) and also sets the syscall return value to something different than
-ENOSYS.

PowerPC and S390 will overwrite that value with -ENOSYS.

Loongarch, RISC-V and x86 will not overwrite it because those architectures
preset the return value to -ENOSYS and skip out of range syscalls
completely. Loongarch and RISC-V always did the out of range skip. X86
gained that in the already applied rework, which means that the final patch
which splits the skip decision from the syscall number does not longer
change x86 behavior for the above case.

Documentation is also updated and describes the two implementation variants
and the subtle difference in the resulting behavior.

The series applies on top of:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry

and is also available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry/rework

Thanks,

	tglx
---
 Documentation/core-api/entry.rst |   45 +++++++++++++++++++++++-------
 arch/loongarch/kernel/syscall.c  |   14 ++++-----
 arch/powerpc/kernel/syscall.c    |    3 +-
 arch/riscv/kernel/traps.c        |   11 +++----
 arch/s390/kernel/syscall.c       |    7 +++-
 arch/x86/entry/syscall_32.c      |   25 ++++++++--------
 arch/x86/entry/syscall_64.c      |   12 ++++----
 include/linux/entry-common.h     |   58 +++++++++++++++++----------------------
 kernel/entry/syscall-common.c    |   19 ++++++++----
 9 files changed, 110 insertions(+), 84 deletions(-)


