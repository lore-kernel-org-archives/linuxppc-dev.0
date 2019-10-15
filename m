Return-Path: <SRS0=Pmlw=YI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BBAC10F14
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Oct 2019 11:35:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A6421848
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Oct 2019 11:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="n2ZMZZbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A6421848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46stf04dqGzDqyw
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Oct 2019 22:35:36 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46stVv2LCyzDqw4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Oct 2019 22:29:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="n2ZMZZbY"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 46stVt19SQz9sPZ; Tue, 15 Oct 2019 22:29:26 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46stVs0wDCz9sPF;
 Tue, 15 Oct 2019 22:29:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1571138965;
 bh=+qtiJDQHIVgW7tXXW/HVWZwkwKeRnLqlcLW63HvWG/8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=n2ZMZZbYotjEqToIdWSDZdwaKWnLHNlsJPwlSUVmj99HeC6ZdGjDKDvUs/cwgt0Hn
 vYakpTyPLYfphaVNY/WHGsfKOzAaEmhE2MLHXPs9xOyjsLS38W92Z9Z/nV0QLW0XKO
 MPCyiPjD1l5WpY57Tc3IYGR0dDrAqXrQKwNNfQrzjLsE1LA8PDoJZ11f6nfQxx3RY1
 NAdcTD8pn7sErX1DiAQbjCT4y0ED4W5ENyy/QVO+Ik+pltUfFd06yJN2zx26+4yiiR
 XksLrhtxVT4qp9Gt8HS42o2ZCZ0zAoDVqpPmxXeAcDKBh9UnHAW6vxnaYXlMnXEw30
 yUDS05LhJQScQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v7 2/8] powerpc: add support to initialize ima policy rules
In-Reply-To: <1570497267-13672-3-git-send-email-nayna@linux.ibm.com>
References: <1570497267-13672-1-git-send-email-nayna@linux.ibm.com>
 <1570497267-13672-3-git-send-email-nayna@linux.ibm.com>
Date: Tue, 15 Oct 2019 22:29:17 +1100
Message-ID: <871rveuu0i.fsf@mpe.ellerman.id.au>
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Eric Ricther <erichte@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>,
 linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 Claudio Carvalho <cclaudio@linux.ibm.com>,
 Matthew Garret <matthew.garret@nebula.com>, Paul Mackerras <paulus@samba.org>,
 Jeremy Kerr <jk@ozlabs.org>, Elaine Palmer <erpalmer@us.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oliver O'Halloran <oohall@gmail.com>, George Wilson <gcwilson@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nayna Jain <nayna@linux.ibm.com> writes:
> PowerNV systems uses kernel based bootloader, thus its secure boot
> implementation uses kernel IMA security subsystem to verify the kernel
> before kexec. Since the verification policy might differ based on the
> secure boot mode of the system, the policies are defined at runtime.
>
> This patch implements the arch-specific support to define the IMA policy
> rules based on the runtime secure boot mode of the system.
>
> This patch provides arch-specific IMA policies if PPC_SECURE_BOOT
> config is enabled.
...
> diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
> new file mode 100644
> index 000000000000..c22d82965eb4
> --- /dev/null
> +++ b/arch/powerpc/kernel/ima_arch.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 IBM Corporation
> + * Author: Nayna Jain
> + */
> +
> +#include <linux/ima.h>
> +#include <asm/secure_boot.h>
> +
> +bool arch_ima_get_secureboot(void)
> +{
> +	return is_powerpc_os_secureboot_enabled();
> +}
> +
> +/* Defines IMA appraise rules for secureboot */
> +static const char *const arch_rules[] = {
> +	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
> +#if !IS_ENABLED(CONFIG_MODULE_SIG_FORCE)
> +	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
> +#endif

This confuses me.

If I spell it out we get:

#if IS_ENABLED(CONFIG_MODULE_SIG_FORCE)
	// nothing
#else
	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
#endif

Which is just:

#ifdef CONFIG_MODULE_SIG_FORCE
	// nothing
#else
	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
#endif

But CONFIG_MODULE_SIG_FORCE enabled says that we *do* require modules to
have a valid signature. Isn't that the inverse of what the rules say?

Presumably I'm misunderstanding something :)

cheers
