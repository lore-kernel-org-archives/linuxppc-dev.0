Return-Path: <SRS0=m3RD=33=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2262FC35247
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Feb 2020 00:42:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EBE521741
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Feb 2020 00:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="I8KiOdsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBE521741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48DGjT3SgVzDqfB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Feb 2020 11:42:37 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48DGgj0hT9zDqcJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2020 11:41:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.a=rsa-sha256
 header.s=201811 header.b=I8KiOdsz; dkim-atps=neutral
Received: from neuling.org (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 48DGgg6Kwjz9sRK;
 Fri,  7 Feb 2020 11:41:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1581036063;
 bh=R+EdOB9Mr3TGXAVnLpWryHFyUDLgOMO50OZKLjJYU/o=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=I8KiOdszLieL2f6wCI90fpEw4P5GfRnA6ACn0yT6ED2aK5jNROx/VDGnAePfsKx5Z
 zUoyJ2Jqf7o3947v7Ya22DRHK++LYJIU21GphnwzxN3NfRhDoO9M0nI+xDfJ3dj9v4
 erOSPut1ZoaOOBaPN3KV0RsYSDUTY2739hm0jouv0DqRta6qyvXcuO2KU2sQDUdoYM
 HerrzV+7ombG+uP+7/9QvP1+LBnfbTZGlp2+sx5VI16NonQ6zSCBLA40hi2ziDyuim
 lj+n2aCvPbqCDomta1z0Q/eCFEqDdaCpL+zawb90duCzxJ6KuTBNqyFMxS8P1yogmR
 m7glyScn/eFaA==
Received: by neuling.org (Postfix, from userid 1000)
 id B8EAB2C019C; Fri,  7 Feb 2020 11:41:03 +1100 (AEDT)
Message-ID: <591eeed830ff58e9b01e3be18003e5751767cc15.camel@neuling.org>
Subject: Re: [PATCH v2 1/3] powerpc/tm: Clear the current thread's MSR[TS]
 after treclaim
From: Michael Neuling <mikey@neuling.org>
To: Gustavo Luiz Duarte <gustavold@linux.vnet.ibm.com>, Gustavo Luiz Duarte
 <gustavold@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 07 Feb 2020 11:41:03 +1100
In-Reply-To: <3cc875cb-a149-1d9b-5a4d-57c8c370d60e@linux.vnet.ibm.com>
References: <20200203160906.24482-1-gustavold@linux.ibm.com>
 <0af388c6a08d83ee7816fc3fc6053c905dc58344.camel@neuling.org>
 <3cc875cb-a149-1d9b-5a4d-57c8c370d60e@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
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
Cc: stable@vger.kernel.org, gromero@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2020-02-06 at 19:13 -0300, Gustavo Luiz Duarte wrote:
>=20
> On 2/5/20 1:58 AM, Michael Neuling wrote:
> > Other than the minor things below that I think you need, the patch good=
 with
> > me.
> >=20
> > Acked-by: Michael Neuling <mikey@neuling.org>
> >=20
> > > Subject: Re: [PATCH v2 1/3] powerpc/tm: Clear the current thread's MS=
R[TS]
> > > after treclaim
> >=20
> > The subject should mention "signals".
>=20
> How about "powerpc/tm: Clear the current thread's MSR[TS] when=20
> transaction is reclaimed on signal delivery"  ?

mpe also likes the word "fix" in the subject if it's a fix. So maybe:

 powerpc/tm: Fix clearing MSR[TS] in current when reclaiming on signal deli=
very

Thanks,
Mikey
