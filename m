Return-Path: <SRS0=qrpl=7M=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70D9C433DF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 May 2020 22:19:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9002220715
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 May 2020 22:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="l7D4/QNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9002220715
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49ZG7l3TvCzDqjh
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2020 08:19:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=protonmail.com (client-ip=185.70.40.22; helo=mail2.protonmail.ch;
 envelope-from=skirmisher@protonmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail header.b=l7D4/QNF; 
 dkim-atps=neutral
Received: from mail2.protonmail.ch (mail2.protonmail.ch [185.70.40.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49ZG5c04Q0zDqjN
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2020 08:17:36 +1000 (AEST)
Date: Sat, 30 May 2020 22:17:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail; t=1590877051;
 bh=n2lEdXv9y/1gpVOk7Rui9/NzlBGOUtxCL7CBQp19mYI=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=l7D4/QNF1f6desP4Z4PhMnV2LncVHZLgzYmPRQT3T0sD8JXa1eOuvecox1z3us8cd
 Eu7ulp5MvKIIX3TJ18D9vNE9iJBf3qBfSWw7oYX52wvzNMSYfqm4+U03KxuFuAoCK3
 b8ka7OJUTq8+Zp1KcQ1W2odQOCb6SXLvvXReSROQ=
To: linuxppc-dev@lists.ozlabs.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>
From: Will Springer <skirmisher@protonmail.com>
Subject: Re: ppc64le and 32-bit LE userland compatibility
Message-ID: <2498690.q0ZmV6gNhb@sheen>
In-Reply-To: <8be94d2e-8e20-52b6-22e6-152b79a94139@csgroup.eu>
References: <2047231.C4sosBPzcN@sheen>
 <8be94d2e-8e20-52b6-22e6-152b79a94139@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reply-To: Will Springer <skirmisher@protonmail.com>
Cc: libc-alpha@sourceware.org, eery@paperfox.es, daniel@octaforge.org,
 musl@lists.openwall.com, binutils@sourceware.org, libc-dev@lists.llvm.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Saturday, May 30, 2020 8:37:43 AM PDT Christophe Leroy wrote:
> There is a series at
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3D173231 t=
o
> switch powerpc to the Generic C VDSO.
>=20
> Can you try and see whether it fixes your issue ?
>=20
> Christophe

Sure thing, I spotted that after making the initial post. Will report back=
=20
with results.

Will [she/her]




