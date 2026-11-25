Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13961606A321
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=lweNZejM;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=QAIDFWPg
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZJFH52Xdz2xjN;
	Wed, 25 Nov 2026 23:01:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795608115;
	cv=none; b=KAMxBdXD3Qj2j8eCFSmrksQG5g8fu2SLXSvOq813m/wPMqScxv6kNbBhgz96R4hr1B+DQG4/dlZAcM1jwHeZRxitLqmQTL1wUCoJrgF8JtKWq3LgCdA1TXD1wHq1wrbLi385pFHUfPm+rov+SdcafytjL3J4+dbpSNbSUeDBSA9c43PeVt4nqK51MiKZHScoZjhvl/9/JHmRnhAkYyMp6UomrkGbcOh2VnqefCk/8Xi6GYjQaxxb8tQW0VPgOcTqH39n6wNrIxdzF3TJGQOPV5II0zM8MceW8FC38O/QgoYMIvXovWaFmTXbiqTMOtX+noOVUpGv1ErDvngm9ot5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795608115; c=relaxed/relaxed;
	bh=g85ZtScV2I4XNTHq3zpYSJXggv8P2pnkPwzz2Ze7ydw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hi6IWm7oS7DHHdXMhQymH1hNyltsVhVzBJgRLWzte9CH/XkOsAat72RQT8acuGZ4Qbz0bA7ld0hA2F0iuc98kd8e/yb+//VK+GMpZXiRGHKYDkV3kYDOCeCM2x2tTSNFlIu0Cs0EBzo3pnSBRWo/Rk+X2hYk642XgtKHZ9Ts1osBb5gYYQJgn8n5g99od7YyRHvy9i6Pl6Lu7GB/9DtqNiMWmUGuiF+mKDIj4nIyrReY2UmO0k3v3DrEbm/qzMnjmLw3sJF9JY0g5QIX7rpc/7giBFZkEDRNVqVI9tQ3gp2XeIhhJ/Av//dXcLxsLLHCWa6BBrQ1sG9QMzGXPHfHuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=lweNZejM; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=QAIDFWPg; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=lweNZejM;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=QAIDFWPg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZJFG3Qb2z2xKQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 23:01:54 +1100 (AEDT)
Date: Wed, 25 Nov 2026 13:01:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795608104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g85ZtScV2I4XNTHq3zpYSJXggv8P2pnkPwzz2Ze7ydw=;
	b=lweNZejMWRcfnmeBRHYPK8ptOMUZoF9wWQiFgD1Un0ZNl4/S71bUpfAEPgqec9Dr92aGmr
	ywFMraGx9AgmcJDuhVn3gamewb08i7O1pRCT3F7SVSMNc2rZPkdd+XoY5aHBMllZpwWsfT
	PQd8b7NCG3qBqPAQjercIHjry4vyjfALBoIsSC/1WFy5VgxttymDX9vDPQ1vPa6mFA3Zjc
	QgUp790p24qvkDhwNsTYGbAITxVTPIvPwciqtPmN6iRYfSa+GQeiXyCtnzyznUTuerqQZP
	dlrQJcbrQiLP6EYUCfJtaU2vlw9eyNzVZNccQQzvAl+BJNwMWDTzwclBkTHkCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795608104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g85ZtScV2I4XNTHq3zpYSJXggv8P2pnkPwzz2Ze7ydw=;
	b=QAIDFWPgqhD/EhRvXQzB1vdIdnif7+H/wL6YaSrkwwD5a3cFTTiYPO7NnanqHJq6NQnURE
	lz9q6UxfNDuvqoAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org, chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCHv4 1/4] powerpc/64: Leave lockdep hardirq context around
 replayed interrupts
Message-ID: <20261125120142.Uw7Srj9z@linutronix.de>
References: <cover.1795603946.git.ritesh.list@gmail.com>
 <6a02babe73f316616cf829af3ddbbfc61fb4066a.1795603946.git.ritesh.list@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6a02babe73f316616cf829af3ddbbfc61fb4066a.1795603946.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-25 16:56:03 [+0530], Ritesh Harjani (IBM) wrote:
> With PROVE_LOCKING, boot warns once and lockdep turns itself off:
>   DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
>   WARNING: kernel/locking/lockdep.c:4448 at lockdep_hardirqs_on_prepare+0=
x22c/0x2d4, CPU#0: swapper/0/0
=E2=80=A6
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Cc: stable@vger.kernel.org
> Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Closes: https://lore.kernel.org/linuxppc-dev/b44aefc5-e066-478b-8d34-50d2=
d0deab6b@linux.ibm.com/
> Closes: https://lore.kernel.org/linuxppc-dev/20260922150619.lwWqj1AO@linu=
tronix.de/
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

