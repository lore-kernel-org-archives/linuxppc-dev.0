Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C549C61DF4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Nov 2023 05:00:08 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=WAGvIPhM;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sc2pt64l1z3dX3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Nov 2023 16:00:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=WAGvIPhM;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sc2nv0rtRz3d8t
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2023 15:59:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1700801948;
	bh=Q66wB5MhB4iivYOyhALqGoUT149l1Gvu6/eaYQnHlSU=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=WAGvIPhM5KHw/Bu+66EgTYeIOb72WnDf8q5Z+qppDZPZWtA0NB6zV2MHfn921zvD+
	 dJj02ihaofXO1F5uZBBk9IAXwzfMF4ykPe/OoEgvbLdrX4JShOZlx+3M+/EA1gifJT
	 jeXj7y/VS/bXI0b+WsMD2Il+5QHTGTrhZOCgDiy1inPl7kD5EtrnxJU8ajPie1FV2M
	 i2o0rfMALSxshqeVUxoK/uHpabXV1zGBbFtmxrKaB8VC1BYY8tZZnja5029ldBeosP
	 2G132zy+DQp8tVjI4kciCqwRSGA/EnYNeMRRk4MsOsQqa3dlueC6JYbiFmATyRuNVs
	 kL14kScDbeLSA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sc2nm1hMBz4wqN;
	Fri, 24 Nov 2023 15:59:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC] UBUNTU: [Config] y2038: Disable COMPAT and
 COMPAT_32BIT_TIME on ppc64le
In-Reply-To: <20231124002042.1741578-1-dimitri.ledkov@canonical.com>
References: <20231124002042.1741578-1-dimitri.ledkov@canonical.com>
Date: Fri, 24 Nov 2023 15:59:04 +1100
Message-ID: <87sf4vrbl3.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Dimitri John Ledkov <dimitri.ledkov@canonical.com> writes:
> BugLink: https://bugs.launchpad.net/bugs/2038587
>
> ppc64le is exclusively little endian and 64-bit, thus there is no need
> for COMPAT_32BIT_TIME, nor COMPAT.

To be pedantic, the ppc64le kernel does support running 32-bit little
endian userspace in compat mode (CONFIG_COMPAT=y). It's a distro choice
as to whether you support COMPAT. Notably there are two other major
distros that don't support COMPAT for ppc64le, and the set of 32-bit LE
software is effectively empty.

> diffconfig result of these changes is:
>
>  -ARCH_MMAP_RND_COMPAT_BITS 13
>  -ARCH_WANT_COMPAT_IPC_PARSE_VERSION y
>  -ARCH_WANT_OLD_COMPAT_IPC y
>  -COMPAT_BINFMT_ELF y
>  -COMPAT_NETLINK_MESSAGES y
>  -COMPAT_OLD_SIGACTION y
>  -HAVE_ARCH_MMAP_RND_COMPAT_BITS y
>  -KVM_COMPAT y
>  -NETFILTER_XTABLES_COMPAT y
>  -SYSVIPC_COMPAT y
>  -VDSO32 y
>   COMPAT y -> n
>   COMPAT_32BIT_TIME y -> n
>  +ARCH_HAS_SYSCALL_WRAPPER y
>  +INTERRUPT_SANITIZE_REGISTERS y
>
> What confused me, if the above combination is even valid or just pure
> dead code.
 
I don't entirely understand what that diff is saying, but I'll try and
answer anyway.

> Is it really possible to run 32bit big-endian KVM on a 64bit
> little-endian POWER?

Are you referring to KVM_COMPAT being disabled?

That's nothing to do with big-endian. It's just controlling whether the
KVM ioctls (which qemu calls) support compat handling, ie. whether you
can run a 32-bit qemu under a 64-bit kernel.

It's entirely expected that when COMPAT is turned off KVM_COMPAT also
gets turned off.

> Or is Kconfig slightly buggy and should be fixed up to prevent
> offering COMPAT options when little-endian 64bit POWER kernel is being
> configured?

No. Like I said at the top, the kernel does support 32-bit LE compat,
eventhough it's not very widely used.

cheers
