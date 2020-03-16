Return-Path: <SRS0=ASHh=5B=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CFEC0044D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2020 09:43:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF554205ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2020 09:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="DOf+CeQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF554205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48grvQ5DjFzDqNd
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2020 20:42:58 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48grsP3t3BzDqKj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2020 20:41:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=DOf+CeQI; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48grsM6VkJz9sP7;
 Mon, 16 Mar 2020 20:41:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1584351672;
 bh=0BJ3FURw+fjw50wR+e6LRkf2Tx726H888JVrSKrls5Y=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=DOf+CeQIRr9jP+zd801bgQ9LbD/TE+CByjPvWQvxtr5O+4o/uK2xFlU76UoHQRM1m
 PO1UW4Vu9Tn3ovq5neZhqoNPTofTuJvlkJdzuw73af6U6+M6OMMYOV5ATseJFLag1d
 eGFHtLkuRRd+l35uigGkppduH+zZfcCp+HEH5Ox0Lg6H5WOFmqhf3yKgYxTeypdh6d
 pHOnjPqwfPWJAnn4ZvO9glKgXR9NoACQZilm7+8n5WjERuDRAAt+e7zzdFJLFgKXIV
 CQsDHCnCtxvsQrpIyuKhAC4GTZJHC7VD8yOytmTWWGwHrRvIQ8hGEOiumZJOhsfWn+
 luLNejYRjYIaQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: WANG Wenhu <wenhu.wang@vivo.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, WANG Wenhu <wenhu.wang@vivo.com>,
 Allison Randal <allison@lohutok.net>, Richard Fontana <rfontana@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] powerpc/fsl-85xx: fix compile error
In-Reply-To: <20200314051035.64552-1-wenhu.wang@vivo.com>
References: <20200314051035.64552-1-wenhu.wang@vivo.com>
Date: Mon, 16 Mar 2020 20:41:12 +1100
Message-ID: <875zf4r613.fsf@mpe.ellerman.id.au>
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
Cc: kernel@vivo.com, trivial@kernel.org, stable <stable@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

WANG Wenhu <wenhu.wang@vivo.com> writes:
> Include "linux/of_address.h" to fix the compile error for
> mpc85xx_l2ctlr_of_probe() when compiling fsl_85xx_cache_sram.c.
>
>   CC      arch/powerpc/sysdev/fsl_85xx_l2ctlr.o
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c: In function =E2=80=98mpc85xx_l2ctl=
r_of_probe=E2=80=99:
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:90:11: error: implicit declaration =
of function =E2=80=98of_iomap=E2=80=99; did you mean =E2=80=98pci_iomap=E2=
=80=99? [-Werror=3Dimplicit-function-declaration]
>   l2ctlr =3D of_iomap(dev->dev.of_node, 0);
>            ^~~~~~~~
>            pci_iomap
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:90:9: error: assignment makes point=
er from integer without a cast [-Werror=3Dint-conversion]
>   l2ctlr =3D of_iomap(dev->dev.of_node, 0);
>          ^
> cc1: all warnings being treated as errors
> scripts/Makefile.build:267: recipe for target 'arch/powerpc/sysdev/fsl_85=
xx_l2ctlr.o' failed
> make[2]: *** [arch/powerpc/sysdev/fsl_85xx_l2ctlr.o] Error 1
>
> Fixes: commit 6db92cc9d07d ("powerpc/85xx: add cache-sram support")

The syntax is:

Fixes: 6db92cc9d07d ("powerpc/85xx: add cache-sram support")

> Cc: stable <stable@vger.kernel.org>

The commit above went into v2.6.37.

So no one has noticed this bug since then, how? Or did something else
change to expose the problem?

cheers
