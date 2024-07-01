Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CDBC2BD09
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jul 2024 14:54:21 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=areSKkIe;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WCTb035lCz3cF1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jul 2024 00:54:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=areSKkIe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WCTZC28Pgz3bhD
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2024 00:53:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C616061425;
	Mon,  1 Jul 2024 14:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2165FC116B1;
	Mon,  1 Jul 2024 14:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719845616;
	bh=yuEuUrvrf9RYFQWRBvVIUN1PGXOh9kgr1e+Z1d9sF4Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=areSKkIeeJUY2Ap59EJGGWO+Nswre0vJmX0ojetisDqWQpzobNc/fFIFj5z2FrQ5h
	 7/RSW9BGJabnqVwtcBlK3QJuampZRIR9VSRpsydVWBaNXO43FhX4vbJTMd1jb2PB82
	 Se+BofJlvcR6G+TV4XqpVIUpAoBf5v0UXLDcp3zX8FtF3tZnZI6lj3K3PD/9ESHLQq
	 x4h4uFs0LSN2e9iEeAWOcV+ivhxelocq90JitRe7h9+1PqgH7+aXVXybbb7NfiVgYj
	 i9xASRFIaq6tx0odc2AexF6IXiJBS2jpe7FtxuZgueMsCvmiyoZAQj09nMSWqRUnW6
	 H92KIcGTTiMzQ==
Message-ID: <3642f5dc17bcb52aab7f0570637e922b08758d08.camel@kernel.org>
Subject: Re: [PATCH] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize
 session support
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Date: Mon, 01 Jul 2024 14:53:33 +0000
In-Reply-To: <9e167f3e-cd81-45ab-bd34-939f516b05a4@linux.ibm.com>
References: <20240617193408.1234365-1-stefanb@linux.ibm.com>
	 <9e167f3e-cd81-45ab-bd34-939f516b05a4@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
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
Cc: naveen.n.rao@linux.ibm.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2024-06-19 at 18:34 -0400, Stefan Berger wrote:
> Jarkko,
> =C2=A0=C2=A0 are you ok with this patch?

Nope :-) It masks a bug, does not fix it.

BR, Jarkko
