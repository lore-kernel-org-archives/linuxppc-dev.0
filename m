Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C16C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 22:46:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AB62075B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 22:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="nb8YCr2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AB62075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430d3C4W4hzF3H8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 09:46:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=neuling.org header.i=@neuling.org header.b="nb8YCr2Z";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430czQ0ynRzF3Rf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 09:42:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.b="nb8YCr2Z"; 
 dkim-atps=neutral
Received: from spoke.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 430czP5HMJz9s3C;
 Thu, 22 Nov 2018 09:42:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1542840177;
 bh=H2ga5LxpwSX6nioeABfIQZlMugcQK3pVGX89DlDyrLU=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=nb8YCr2ZYu1nLvS23YiJ1iUyf+G38iz4os7fSPG5tcULberJpif/pm9MJRdiSVW3/
 SZVcD61K3AoqNaIzz/P8SCv2v1xl6GaAMwS+jOb1eCrThZxQU67T/An5wQVn7CUl1o
 h4ZGkw0z4QDPd+oS78XWHEad457Rtf1OiaUaWJPTGO6+e6Icgrk2Nei9qtNJ3GrwGz
 LaYgyPK9T7OMClUZQbIp2UmC7Dy5pjGBivXQlW6g6M4pijd9PEjBrrIStsiA9NrCce
 FM8lT5JmTGcr3h097CXAQheR1pUHd33pD7Y4WhEZGT5+uDMdmwPEDleBcP4AdgW8P+
 6kVkJiCegrPoQ==
Received: by spoke.localdomain (Postfix, from userid 1000)
 id 78FD52A0C19; Thu, 22 Nov 2018 09:42:57 +1100 (AEDT)
Message-ID: <c4edf2ad99edb1c932f7367819e11d19e3a3bb75.camel@neuling.org>
Subject: Re: [PATCH] powerpc/tm: Set MSR[TS] just prior to recheckpoint
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 22 Nov 2018 09:42:57 +1100
In-Reply-To: <5ead16d3-2ada-d5b2-5481-0326a3c920af@debian.org>
References: <1542631494-10344-1-git-send-email-leitao@debian.org>
 <9cdf12d1eaa5350e130d3cfb15ecb060323b6788.camel@neuling.org>
 <5ead16d3-2ada-d5b2-5481-0326a3c920af@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
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
Cc: Gustavo Romero <gromero@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> Do you mean in this part of code?
>=20
>   SYSCALL_DEFINE0(rt_sigreturn)
>   {
> 	....
>         if (__copy_from_user(&set, &uc->uc_sigmask, sizeof(set)))
>                 goto badframe;
>=20
> 	...
>         if (MSR_TM_SUSPENDED(mfmsr()))
>                 tm_reclaim_current(0);

I'm actually thinking after the reclaim, not before.

If I follow your original email properly, you have a problem because you en=
d up
in this senario:
1) Current MSR is not TM suspended
2) regs->msr[TS] set
3) get_user() (which may fault)

After the tm_reclaim there are cases in restore_tm_sigcontexts() where the =
above
is also the case. Hence why I think we have a problem there too.

Mikey
