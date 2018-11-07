Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97933C32789
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 00:42:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C5120844
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 00:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="MDbxarrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C5120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qSKs6lmGzF3Dy
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 11:42:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=neuling.org header.i=@neuling.org header.b="MDbxarrY";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qSHF1BCSzF2HT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 11:39:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.b="MDbxarrY"; 
 dkim-atps=neutral
Received: from spoke.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 42qSHD66cTz9s9h;
 Wed,  7 Nov 2018 11:39:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1541551192;
 bh=pwyLkkHj/1fUWy+i8L1hm5RBkSUhANttxlw0QGeRkoU=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=MDbxarrY369Pnsl+ksJGr5L6gQcoHSo8ACDeqHGpqML/D+XR4bRfxVH38yp7742dJ
 VzLV+5kVYwylY5DWntwCTpHGM9B22MUnqJf+VyJo6mKH7qiM5dflKg+xzeiyu6cNVG
 6CJ1D6RPTt/SAyrnCsaBGOGvw001oo0Rl3tC0SlZYe0N28sZEBoB9ruWcfJbHErC1Q
 2hGayX6OFCJ1f4/QnhhuObLp2gEvneI/3RzjYJ6y71HJg4hcO5bGOTt8gNdADkHNmK
 TxBVMG+tZ8W2F3duza8d1hUDS9kqfqFtc9zgq4g4c+P3LUOeqyw274a6IrbvA2/6lC
 UqJ7TpQfhAs4g==
Received: by spoke.localdomain (Postfix, from userid 1000)
 id CAA8C2A3CE9; Wed,  7 Nov 2018 11:39:52 +1100 (AEDT)
Message-ID: <6aeda97a057b73ea8620bf59006508bb6d5553e7.camel@neuling.org>
Subject: Re: [RFC PATCH v2 00/14] New TM Model
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, Florian Weimer <fweimer@redhat.com>
Date: Wed, 07 Nov 2018 11:39:52 +1100
In-Reply-To: <12883814-0100-91dc-3aac-84b689f82273@debian.org>
References: <1541508028-31865-1-git-send-email-leitao@debian.org>
 <87zhumkqfa.fsf@oldenburg.str.redhat.com>
 <12883814-0100-91dc-3aac-84b689f82273@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
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
Cc: ldufour@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 cyrilbur@gmail.com, Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


> In fact, I was the one that identified this performance degradation issue=
,
> and reported to Adhemerval who kindly fixed it with
> f0458cf4f9ff3d870c43b624e6dccaaf657d5e83.
>=20
> Anyway, I think we are safe here.

FWIW Agreed. PPC_FEATURE2_HTM_NOSC should be persevered by this series.

Mikey
