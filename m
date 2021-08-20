Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE751C4338F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Aug 2021 12:26:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF91610CA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Aug 2021 12:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1CF91610CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GrgqF5BS6z3cM0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Aug 2021 22:26:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=FZTLRhN6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=FZTLRhN6; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GrgpZ1l8Gz2xZR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Aug 2021 22:25:58 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GrgpY59Kxz9sXN;
 Fri, 20 Aug 2021 22:25:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1629462357;
 bh=ejqopAH8EAJ6uDbWxE0UAcCbAfDCZoI3Heu5jg1yW5E=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=FZTLRhN67lO37DWRRZ6DwmilOYCniMqwHRWxtK1Kr6LpG0stYAsxPddv4T/cP6WXC
 2xI+4xOeDOqUw7e/XM9o81qcC8SLUNl3gs8Xvw7Z35KeOc6qKnMb29ihfk2kZZK/Oc
 /D2pbKDlDXnx4wVL37TzJ2XPM8yeMj6lHKbGjNrsZZhlrgIAREBeVntCSCzuZE8Ybq
 r6pyqyQfFzRJuRu8KH2uUyQmE/8mhMgSZ3b/5T5CmSpxg/9s98l6IfAshQfTwJiE8W
 IWyXS7LamVpQ2DIfXKFAxiwu+XIkBooAwW2ViEfu8QrDLFZBLXVcLLj1S4ZdyGURcG
 wqMvxC+HMU1ug==
From: Michael Ellerman <mpe@ellerman.id.au>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 6/6] powerpc/compat_sys: Declare syscalls
In-Reply-To: <20210819125656.14498-7-clg@kaod.org>
References: <20210819125656.14498-1-clg@kaod.org>
 <20210819125656.14498-7-clg@kaod.org>
Date: Fri, 20 Aug 2021 22:25:57 +1000
Message-ID: <87sfz4cnfu.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

C=C3=A9dric Le Goater <clg@kaod.org> writes:
> This fixes a compile error with W=3D1.
>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/include/asm/syscalls.h | 31 +++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/syscalls.h b/arch/powerpc/include/a=
sm/syscalls.h
> index 398171fdcd9f..1d5f2abaa38a 100644
> --- a/arch/powerpc/include/asm/syscalls.h
> +++ b/arch/powerpc/include/asm/syscalls.h
> @@ -6,6 +6,7 @@
>  #include <linux/compiler.h>
>  #include <linux/linkage.h>
>  #include <linux/types.h>
> +#include <linux/compat.h>
>=20=20
>  struct rtas_args;
>=20=20
> @@ -18,5 +19,35 @@ asmlinkage long sys_mmap2(unsigned long addr, size_t l=
en,
>  asmlinkage long ppc64_personality(unsigned long personality);
>  asmlinkage long sys_rtas(struct rtas_args __user *uargs);
>=20=20
> +#ifdef CONFIG_COMPAT
> +unsigned long compat_sys_mmap2(unsigned long addr, size_t len,
> +			       unsigned long prot, unsigned long flags,
> +			       unsigned long fd, unsigned long pgoff);
> +
> +compat_ssize_t compat_sys_pread64(unsigned int fd, char __user *ubuf, co=
mpat_size_t count,
> +				  u32 reg6, u32 pos1, u32 pos2);
> +
> +compat_ssize_t compat_sys_pwrite64(unsigned int fd, const char __user *u=
buf, compat_size_t count,
> +				   u32 reg6, u32 pos1, u32 pos2);
> +
> +compat_ssize_t compat_sys_readahead(int fd, u32 r4, u32 offset1, u32 off=
set2, u32 count);
> +
> +asmlinkage int compat_sys_truncate64(const char __user *path, u32 reg4,
> +				     unsigned long len1, unsigned long len2);

asmlinkage does nothing, ie. it's an empty macro. Let's not add new uses
of it.

cheers
