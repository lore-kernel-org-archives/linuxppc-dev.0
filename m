Return-Path: <SRS0=ON6F=CR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71F8C43461
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2020 07:23:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A9021D20
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2020 07:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="XYMUSZ1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A9021D20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BlxTY2XdhzDqRn
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2020 17:23:45 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BlxRw5wM0zDqPC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2020 17:22:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=XYMUSZ1H; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4BlxRw5PtDz9sTK; Tue,  8 Sep 2020 17:22:20 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BlxRw4M7Wz9sSP;
 Tue,  8 Sep 2020 17:22:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1599549740;
 bh=mg1TEyvxbEj8SNkIqfkM5ur3s8H5/mC4Xozw7sbRNC4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=XYMUSZ1HdpGRVA8LQnQJPGFN82ISfLaAwh2jG+KEWr2DoWl5AUpZKUqZjrELii39M
 TPa6IyKe5D0Vp5MX3obIAwCgRcOp96uVybIw1DGgDLTb9vYAhVxGxkcUlvVvlUBOEU
 mJ1Q3WpiI/SglxVnqmuOWTNnQL8vd0Uxw+0DmAkXkTscR9F5sfaUad9fsJdJP6qrgG
 z1BbnIGf2mL/65KT5LFgHEZo1pOFYQt7oxvbxul+qhNxWMujc/OLY4f9AKjBg1VV3i
 zSW1UzL20TXkJxwh4uk6xqoWqvNXj3z/HyYxZaU5SDUGzQT0mGwHJ7EeV865q0bqtq
 llBWnINtGmmhg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sachin Sant <sachinp@linux.vnet.ibm.com>
Subject: Re: [PATCH] selftests/powerpc: Skip PROT_SAO test in guests/LPARS
In-Reply-To: <5E12FA66-4147-46E6-9D8A-358FFAFDC3FB@linux.vnet.ibm.com>
References: <20200901124653.523182-1-mpe@ellerman.id.au>
 <5E12FA66-4147-46E6-9D8A-358FFAFDC3FB@linux.vnet.ibm.com>
Date: Tue, 08 Sep 2020 17:22:20 +1000
Message-ID: <87k0x4spg3.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Sachin Sant <sachinp@linux.vnet.ibm.com> writes:
>> On 01-Sep-2020, at 6:16 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>=20
>> In commit 9b725a90a8f1 ("powerpc/64s: Disallow PROT_SAO in LPARs by
>> default") PROT_SAO was disabled in guests/LPARs by default. So skip
>> the test if we are running in a guest to avoid a spurious failure.
>>=20
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> =E2=80=94
>
> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
>
> With the fix test is skipped while running in a guest
>
> # ./prot_sao=20
> test: prot-sao
> tags: git_version:unknown
> [SKIP] Test skipped on line 25
> skip: prot-sao
> #

Thanks. Sorry I missed adding your Tested-by tag.

cheers
