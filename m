Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DF7C76196
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Apr 2023 00:58:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Px48m3L1hz3bqW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Apr 2023 10:58:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=eYEu8wri;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Px47r1bn0z3bfk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2023 10:58:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=eYEu8wri;
	dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Px47q5lNPz4xDh;
	Wed, 12 Apr 2023 10:57:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1681261079;
	bh=QqX5Ao3FPny7Iq5rbfMRQ2bwDHdhfwos6Coj7AKoQAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eYEu8wri6hZzCvgoglCi5hvM6j8dX2WtA76M6FK38X7ByJkzLsgb/aGOEiRgRoh6N
	 nqX66j+mQq0h8AfmOjuZOqRISnI7VOCYGolVEmLY+ITlwdeqrOIpL5YK3aaSLfrKy5
	 LPKxLvvuwgtp4nFu2GYT8u8rTTthT58odkSlPR/GvGS14bus4Un4u4ku2k6CK1ff5O
	 3jISriGdhEzgUIoXfZvXQik9GpPMedU8ttL1XHs5uiK+q8x6svOQg4WvE1ijYQD0fU
	 UcADM4TqnRyhMAfmsWec6dogt6qJzVWTrK7WVNMW7k8vWWAM3l77LEouU9lkaww0ZB
	 3Gbw898+FnCxg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/boot: Fix crt0.S current address branch form
In-Reply-To: <875ya7javn.fsf@mpe.ellerman.id.au>
References: <20230407040924.231023-1-npiggin@gmail.com>
 <875ya7javn.fsf@mpe.ellerman.id.au>
Date: Wed, 12 Apr 2023 10:57:58 +1000
Message-ID: <87zg7dj4rt.fsf@mpe.ellerman.id.au>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:
> Nicholas Piggin <npiggin@gmail.com> writes:
>> Use the preferred form of branch-and-link for finding the current
>> address so objtool doesn't think it is an unannotated intra-function
>> call.
>
> We don't run objtool on this code in mainline AFAIK. Because BOOTAS
> doesn't call it.

But as Nick pointed out, if you run:

 $ make arch/powerpc/boot/crt0.o

It does run objtool, because it uses the generic cmd_as_o_S rule instead
of the BOOTAS rule.

cheers
