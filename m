Return-Path: <SRS0=3S3E=UK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFF3C43218
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2019 07:00:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F892089E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2019 07:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="N4dHGgz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F892089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45NLVg1m8XzDqWh
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2019 17:00:27 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45NL850WbbzDqTR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2019 16:44:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.b="N4dHGgz2"; 
 dkim-atps=neutral
Received: from neuling.org (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 45NL833nd2z9s4V;
 Tue, 11 Jun 2019 16:44:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1560235459;
 bh=DPctIcSeu2y6GGMnN/ISZPY7wcRf5EPcjhfFCi3FB+M=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=N4dHGgz23W/X+fhQAk7R33rXlrFvtE9/W0y864cKcuwbxPq0+M+Vd4+KMRCRz5Hw4
 e4oTb6cxsTDGIedbmMpe4VqX4fgw0le0jF2hMO/Qf9z8KFJJORNJzJ8Le6SC2xFpDp
 FFITVQXsxMFX8M3zA6HZoSGdQdjb4y4klsPAVLDGKz7wJWf1lN//kt+CNDne4B8SB/
 0zwFknxzyWPFBuPmY/5Uuh9wbYNRNLUdCNSY8I9fGfmMEUeLJjm7l3w5jjCqFOlu7k
 HsOAukK5+P0QeD6BSYvicRX/EO9EnYOPyQGfrvWxzz0WbwWa8XnwwOlnUFQV2IWFt8
 E46jNjyi9shGA==
Received: by neuling.org (Postfix, from userid 1000)
 id 737542A0E2F; Tue, 11 Jun 2019 16:44:19 +1000 (AEST)
Message-ID: <287ab7092cc6128e1c0d25f6245eb5f1706c6cb0.camel@neuling.org>
Subject: Re: [PATCH v2] powerpc: Add force enable of DAWR on P9 option
From: Michael Neuling <mikey@neuling.org>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, mpe@ellerman.id.au
Date: Tue, 11 Jun 2019 16:44:19 +1000
In-Reply-To: <68f4f99d-4bb7-7d25-1e68-96c65dfbfbe9@kaod.org>
References: <20190401060312.22670-1-mikey@neuling.org>
 <68f4f99d-4bb7-7d25-1e68-96c65dfbfbe9@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
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
Cc: linuxppc-dev@lists.ozlabs.org, Cameron Kaiser <spectre@floodgap.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


> >  2:
> > -BEGIN_FTR_SECTION
> > -	/* POWER9 with disabled DAWR */
> > +	LOAD_REG_ADDR(r11, dawr_force_enable)
> > +	lbz	r11, 0(r11)
> > +	cmpdi	r11, 0
> >  	li	r3, H_HARDWARE
> > -	blr
> > -END_FTR_SECTION_IFCLR(CPU_FTR_DAWR)
> > +	beqlr
>=20
> Why is this a 'beqlr' ? Shouldn't it be a blr ?=20

I believe it's right and should be a beqlr.  It's to replace the FTR sectio=
n to
make it dynamic based on the dawr_force_enable bit.

Mikey

