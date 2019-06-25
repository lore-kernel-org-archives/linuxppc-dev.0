Return-Path: <SRS0=GBvC=UY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6499C48BD4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Jun 2019 04:13:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5290420659
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Jun 2019 04:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="O/oi0O9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5290420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Xt725r4JzDqDl
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Jun 2019 14:13:02 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Xt4q59sFzDqRX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2019 14:11:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.b="O/oi0O9L"; 
 dkim-atps=neutral
Received: from neuling.org (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 45Xt4p1ZWLz9sCJ;
 Tue, 25 Jun 2019 14:11:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1561435866;
 bh=z0/ihHpiOuXsbcpJCDJR+F4nPEv0A8fBy1dW1ce5JiI=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=O/oi0O9LPR58IUljvbxMGkFpcxaf89ElJlcjefVtskrH35b6figdHO0wK4F3w79j/
 KgulxYc+Ovc/8/SormuKqOpXzsfdbkAyVJtzDOMqdm50gCxYxobrOe91kdynUCZXD0
 EPG6eLCxFWvdDFMx6og8l260r2DdG9mE3RNayOyQQ6isCRcUnS4hfY7teQuKzMZfxp
 UzgLdbW+5fU4AC8cO6FwMEbk44WhwrjLwBeyqdT40hgmKuCr+iSJvIABroDJQxktN7
 8ZtZLM5IpCav7scQYp1/Va7PsgtyrhcOkcmrLnsN3aaS9MFQ66PII9M5AK2lGp73nR
 tQUzC7XHa5BPQ==
Received: by neuling.org (Postfix, from userid 1000)
 id 0BD232A257E; Tue, 25 Jun 2019 14:11:06 +1000 (AEST)
Message-ID: <d30b3450fadab64705067cda56ddee5e06d60448.camel@neuling.org>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Fix CR0 setting in TM emulation
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 25 Jun 2019 14:11:05 +1000
In-Reply-To: <87tvcf8arn.fsf@concordia.ellerman.id.au>
References: <20190620060040.26945-1-mikey@neuling.org>
 <87tvcf8arn.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
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
Cc: linuxppc-dev@lists.ozlabs.org, sjitindarsingh@gmail.com,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-06-24 at 21:48 +1000, Michael Ellerman wrote:
> Michael Neuling <mikey@neuling.org> writes:
> > When emulating tsr, treclaim and trechkpt, we incorrectly set CR0. The
> > code currently sets:
> >     CR0 <- 00 || MSR[TS]
> > but according to the ISA it should be:
> >     CR0 <-  0 || MSR[TS] || 0
>=20
> Seems bad, what's the worst case impact?

It's a data integrity issue as CR0 is corrupted.

> Do we have a test case for this?

Suraj has a KVM unit test for it.

> > This fixes the bit shift to put the bits in the correct location.
>=20
> Fixes: ?

It's been around since we first wrote the code so:

Fixes: 4bb3c7a0208fc13c ("KVM: PPC: Book3S HV: Work around transactional me=
mory bugs in POWER9")

Mikey
