Return-Path: <SRS0=tyeE=KO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC29C433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 May 2021 01:10:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7169461355
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 May 2021 01:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7169461355
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FlFCr73Kpz30G8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 May 2021 11:10:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=jNMRRWQ5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=jNMRRWQ5; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FlFCH4JpMz2xvT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2021 11:09:47 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4FlFCD2wYLz9sTD;
 Wed, 19 May 2021 11:09:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1621386586;
 bh=UCeiL9QFW+a7PCn8oeEp01d3KWoBysRALLIYZbpvvyE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=jNMRRWQ5yquDKv5DX8yudzgOyHyXimeCXk58EnQLYq8E47ViUTgZH9w+5HYVDjLF4
 mntXHpaeTTUZFgzsBaReFbLJf6trEFog30nCXNXdpx0x1gsPCRGT6CaM37uKpj2hgK
 QDATBwXulF1TDjeCzpMIxpGOswxnEUEg0uqMjh9RQbKRELZjt+RGu9RH6BUH9Osu6D
 k4TTNX7Y+eZ1oHS6UxOzZZOmUA3SQ/KhO5pZQ29763NNKcQy77CSQiQgQ4MN1D2gcb
 MWdS64ItBYLx7Z7q7y6ZBNd9kaZSkMrIfH76llm0HO0lP6OnYKXgK9g/vaiX0fzyJ4
 wGvrtp4K4Q1NQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexandre Ghiti <alex@ghiti.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 2/3] powerpc: Move script to check relocations at
 compile time in scripts/
In-Reply-To: <20210518101252.1484465-3-alex@ghiti.fr>
References: <20210518101252.1484465-1-alex@ghiti.fr>
 <20210518101252.1484465-3-alex@ghiti.fr>
Date: Wed, 19 May 2021 11:09:39 +1000
Message-ID: <877djvjzqk.fsf@mpe.ellerman.id.au>
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
Cc: Anup Patel <anup@brainfault.org>, Alexandre Ghiti <alex@ghiti.fr>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Alexandre Ghiti <alex@ghiti.fr> writes:
> Relocating kernel at runtime is done very early in the boot process, so
> it is not convenient to check for relocations there and react in case a
> relocation was not expected.
>
> Powerpc architecture has a script that allows to check at compile time
> for such unexpected relocations: extract the common logic to scripts/
> so that other architectures can take advantage of it.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/powerpc/tools/relocs_check.sh | 18 ++----------------
>  scripts/relocs_check.sh            | 20 ++++++++++++++++++++
>  2 files changed, 22 insertions(+), 16 deletions(-)
>  create mode 100755 scripts/relocs_check.sh

I'm not sure that script is really big/complicated enough to warrant
sharing vs just copying, but I don't mind either.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/tools/relocs_check.sh b/arch/powerpc/tools/relo=
cs_check.sh
> index 014e00e74d2b..e367895941ae 100755
> --- a/arch/powerpc/tools/relocs_check.sh
> +++ b/arch/powerpc/tools/relocs_check.sh
> @@ -15,21 +15,8 @@ if [ $# -lt 3 ]; then
>  	exit 1
>  fi
>=20=20
> -# Have Kbuild supply the path to objdump and nm so we handle cross compi=
lation.
> -objdump=3D"$1"
> -nm=3D"$2"
> -vmlinux=3D"$3"
> -
> -# Remove from the bad relocations those that match an undefined weak sym=
bol
> -# which will result in an absolute relocation to 0.
> -# Weak unresolved symbols are of that form in nm output:
> -# "                  w _binary__btf_vmlinux_bin_end"
> -undef_weak_symbols=3D$($nm "$vmlinux" | awk '$1 ~ /w/ { print $2 }')
> -
>  bad_relocs=3D$(
> -$objdump -R "$vmlinux" |
> -	# Only look at relocation lines.
> -	grep -E '\<R_' |
> +${srctree}/scripts/relocs_check.sh "$@" |
>  	# These relocations are okay
>  	# On PPC64:
>  	#	R_PPC64_RELATIVE, R_PPC64_NONE
> @@ -43,8 +30,7 @@ R_PPC_ADDR16_LO
>  R_PPC_ADDR16_HI
>  R_PPC_ADDR16_HA
>  R_PPC_RELATIVE
> -R_PPC_NONE' |
> -	([ "$undef_weak_symbols" ] && grep -F -w -v "$undef_weak_symbols" || ca=
t)
> +R_PPC_NONE'
>  )
>=20=20
>  if [ -z "$bad_relocs" ]; then
> diff --git a/scripts/relocs_check.sh b/scripts/relocs_check.sh
> new file mode 100755
> index 000000000000..137c660499f3
> --- /dev/null
> +++ b/scripts/relocs_check.sh
> @@ -0,0 +1,20 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +# Get a list of all the relocations, remove from it the relocations
> +# that are known to be legitimate and return this list to arch specific
> +# script that will look for suspicious relocations.
> +
> +objdump=3D"$1"
> +nm=3D"$2"
> +vmlinux=3D"$3"
> +
> +# Remove from the possible bad relocations those that match an undefined
> +#=C2=A0weak symbol which will result in an absolute relocation to 0.
> +# Weak unresolved symbols are of that form in nm output:
> +# "                  w _binary__btf_vmlinux_bin_end"
> +undef_weak_symbols=3D$($nm "$vmlinux" | awk '$1 ~ /w/ { print $2 }')
> +
> +$objdump -R "$vmlinux" |
> +	grep -E '\<R_' |
> +	([ "$undef_weak_symbols" ] && grep -F -w -v "$undef_weak_symbols" || ca=
t)
> --=20
> 2.30.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
