Return-Path: <SRS0=YHW0=BB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C307C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 00:54:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD7420771
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 00:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="UO3aCq3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD7420771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BBH6V0MVBzDqlW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 10:54:26 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BBH4L0MvFzDqN2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2020 10:52:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=UO3aCq3h; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BBH4K2PDGz9sR4;
 Wed, 22 Jul 2020 10:52:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1595379153;
 bh=leG4ZtKZGaOJvtTgBfAMmc+daahmASHUR7DSv0tvR0g=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=UO3aCq3hw9kbTM5j49pkUk8vbD7TqQKc64FCMw5ly4quHYe985cgAmVcL3Y8HU48N
 QtbTEm+dNpqUSsp7FER8g5pcBD5eVL712aQcVlVtPndpOKPaXzzMUjSVjN5Xg/4vML
 R2RvzXSsbMCK8j1wNlsarnAZ8mhaf69uqlUX9eDiGD5ZV4rKDTwUFpbL1abZp3stxg
 NjXRYpJ3ETx9ITphR3DZWEqOiDx9v9FIpztPPCu7A/bu7njn6Fvw27ENrwz+HCd5sA
 PjjMkxWvSY+dChWaoemK5Islpz7rvcPjOzOKUpVhhoS0/k+m8tyNqXqq8lATovYDE+
 s3F2qX3qPOg9g==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/3] powerpc: inline doorbell sending functions
In-Reply-To: <20200630115034.137050-2-npiggin@gmail.com>
References: <20200630115034.137050-1-npiggin@gmail.com>
 <20200630115034.137050-2-npiggin@gmail.com>
Date: Wed, 22 Jul 2020 10:52:32 +1000
Message-ID: <87a6zss75b.fsf@mpe.ellerman.id.au>
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
Cc: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Anton Blanchard <anton@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> These are only called in one place for a given platform, so inline them
> for performance.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/dbell.h | 63 ++++++++++++++++++++++++++++++--
>  arch/powerpc/kernel/dbell.c      | 55 ----------------------------
>  2 files changed, 60 insertions(+), 58 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/=
dbell.h
> index 4ce6808deed3..f19d2282e3f8 100644
> --- a/arch/powerpc/include/asm/dbell.h
> +++ b/arch/powerpc/include/asm/dbell.h
> @@ -13,6 +13,7 @@
>=20=20
>  #include <asm/ppc-opcode.h>
>  #include <asm/feature-fixups.h>
> +#include <asm/kvm_ppc.h>
>=20=20
>  #define PPC_DBELL_MSG_BRDCAST	(0x04000000)
>  #define PPC_DBELL_TYPE(x)	(((x) & 0xf) << (63-36))


This somehow breaks ppc40x_defconfig and others:

In file included from /home/michael/linux/arch/powerpc/include/asm/kvm_ppc.=
h:24,
                 from /home/michael/linux/arch/powerpc/include/asm/dbell.h:=
16,
                 from /home/michael/linux/arch/powerpc/kernel/asm-offsets.c=
:38:
/home/michael/linux/arch/powerpc/include/asm/kvm_booke.h: In function =E2=
=80=98kvmppc_get_fault_dar=E2=80=99:
/home/michael/linux/arch/powerpc/include/asm/kvm_booke.h:94:19: error: =E2=
=80=98struct kvm_vcpu_arch=E2=80=99 has no member named =E2=80=98fault_dear=
=E2=80=99
   94 |  return vcpu->arch.fault_dear;
      |                   ^
make[2]: *** [/home/michael/linux/scripts/Makefile.build:114: arch/powerpc/=
kernel/asm-offsets.s] Error 1
make[1]: *** [/home/michael/linux/Makefile:1175: prepare0] Error 2
make: *** [Makefile:185: __sub-make] Error 2

cheers
