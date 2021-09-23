Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C81C433F5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Sep 2021 13:22:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16FB66103D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Sep 2021 13:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 16FB66103D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HFbSB2HCLz2ywV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Sep 2021 23:22:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=kkrV52le;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=kkrV52le; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HFbRQ21kpz2yQ0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Sep 2021 23:21:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1632403312;
 bh=YGLTlXsTmeC/x5gt7oNUb0JVpJkVpjrf1XIfaJ9iQq8=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=kkrV52lerYc1pOJLVEpmCPb/uZrrlw8BPBXkwAegYneegU3Us4L6S7zTyTAbDRazU
 py2mDwHGeGFoTCZy+NpK7zGyuvdKjZ6MtsE1kr48LNbGiuI8FkDYdU90O/PyfFAAua
 zK35mAP1KO4523+yPIc55jToSddItCIDHR29tpOinElSDxPdXFodxfqVIracFrvhiQ
 wF8YYDsutjyp+3/52W8UHoyTUgFFfv7M7NuEXuwzy2vIKriAFqqvf4i/JHLa+RnBZp
 bhkIJ53g7ASDmOHx+Zl2RBCPC6AiaAfVO8LlGUQ9VfOkhWysrlm77e0FmMMpAAiDfM
 YaflrnMoMJCRQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HFbRK63bNz9sX3;
 Thu, 23 Sep 2021 23:21:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@canonical.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] powerpc/powermac: add missing
 g5_phy_disable_cpu1() declaration
In-Reply-To: <20210922160436.130931-1-krzysztof.kozlowski@canonical.com>
References: <20210922160436.130931-1-krzysztof.kozlowski@canonical.com>
Date: Thu, 23 Sep 2021 23:21:49 +1000
Message-ID: <87v92rl95e.fsf@mpe.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> writes:
> g5_phy_disable_cpu1() is used outside of platforms/powermac/feature.c,
> so it should have a declaration to fix W=3D1 warning:
>
>   arch/powerpc/platforms/powermac/feature.c:1533:6:
>     error: no previous prototype for =E2=80=98g5_phy_disable_cpu1=E2=80=
=99 [-Werror=3Dmissing-prototypes]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>
> ---
>
> Changes since v1:
> 1. Drop declaration in powermac/smp.c

Sorry I missed v1, so I'm going to ask for more changes :}

>  arch/powerpc/include/asm/pmac_feature.h | 4 ++++

Putting it here exposes it to the whole kernel, but it's only needed
inside arch/powerpc/platforms/powermac.

The right place for the prototype is arch/powerpc/platforms/powermac/pmac.h,
which is for platform internal prototypes.

>  arch/powerpc/platforms/powermac/smp.c   | 2 --
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pmac_feature.h b/arch/powerpc/inclu=
de/asm/pmac_feature.h
> index e08e829261b6..7703e5bf1203 100644
> --- a/arch/powerpc/include/asm/pmac_feature.h
> +++ b/arch/powerpc/include/asm/pmac_feature.h
> @@ -143,6 +143,10 @@
>   */
>  struct device_node;
>=20=20
> +#ifdef CONFIG_PPC64
> +void g5_phy_disable_cpu1(void);
> +#endif /* CONFIG_PPC64 */

The ifdef around the prototype doesn't gain much, and is extra visual
noise, so I'd rather without it.

cheers
