Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC229C4332F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Dec 2023 09:03:04 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WvhpFINa;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ss3CW2Ng9z3dRc
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Dec 2023 20:03:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WvhpFINa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ss3Bb1zb0z3bx0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2023 20:02:15 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 4E897B82541;
	Fri, 15 Dec 2023 09:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B06C433C8;
	Fri, 15 Dec 2023 09:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702630929;
	bh=GxjorUvjVfFdNsGcr47vxy9wVmeBkGFklppC39F4NSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WvhpFINabgM+XrOxUOlTLD7JyTXZTYt5+i6n4Cj4VpJYYN1VMPzELtKouqYtG7ZNh
	 +Cj+Jem2vI8v7Iaiz5xwtT3mAjL1oEg2fpbF41FukjzyKR5p6x77tVYShNS7LMFXMH
	 kxKAuf5YQPcpHKjYstLIfOhe7pGH3EjUxS24/u7wLDwDJxuskG12ugHgYqw1sge2qE
	 LySRkfD51BOthJ5zdAgjLdKEM01qVO/1JMSJuzTM1IJBCgmfZrvUg1Jl949eSTGag+
	 XLV6e88ig6U6QMzDuBEptw2qGt/JQBu4RylOHM7/GCw4oR+zznkmfbTD/L5liaHXNA
	 e7JVS+Bijp1uQ==
X-Mailer: emacs 29.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Nicholas Miehlbradt <nicholas@linux.ibm.com>, glider@google.com,
	elver@google.com, dvyukov@google.com, akpm@linux-foundation.org,
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Subject: Re: [PATCH 09/13] powerpc: Disable KMSAN checks on functions which
 walk the stack
In-Reply-To: <20231214055539.9420-10-nicholas@linux.ibm.com>
References: <20231214055539.9420-1-nicholas@linux.ibm.com>
 <20231214055539.9420-10-nicholas@linux.ibm.com>
Date: Fri, 15 Dec 2023 14:32:02 +0530
Message-ID: <87wmtfu9dh.fsf@kernel.org>
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
Cc: iii@linux.ibm.com, linux-kernel@vger.kernel.org, Nicholas Miehlbradt <nicholas@linux.ibm.com>, linux-mm@kvack.org, kasan-dev@googlegroups.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Miehlbradt <nicholas@linux.ibm.com> writes:

> Functions which walk the stack read parts of the stack which cannot be
> instrumented by KMSAN e.g. the backchain. Disable KMSAN sanitization of
> these functions to prevent false positives.
>

Is the annotation needed to avoid uninitialized access check when
reading parts of the stack? Can you provide a false positive example for
the commit message?

-aneesh
