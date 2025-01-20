Return-Path: <linuxppc-dev+bounces-5428-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518BCC02181
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jan 2025 21:56:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YcPKq5CVLz2yjJ;
	Tue, 21 Jan 2025 08:55:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737410159;
	cv=none; b=MmHpZKJxwePKUqDwrHXodxYc18buIkH1MOviRE0ErxOTmwKmIsw138ZlmktkEnVpYP+Jah0nNjLCAnb+ZBE3hTpfaO5BeX4bKVD+PrfwfVn6lzPFkCgWSKibO1A6nqKvP57cC5MeqEIak0ZjpbjldfOcGKRKL+4rLKHOmQas9sFLE22U/4nDbxSfXnPb1cD1/kuWrFIQMrP+actsiNcFckO/DCQ+3yPiMFB+vSCvdHsdh1EheHYb15mVRfWYw7Fzr2OCA8PSOu/+6d/1bGeg0hDjU0n2jOnkBtJ4mBYcudyssYlkH4m9llr2fTugqupN1JanNvaJdY2CiBupHJ9dBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737410159; c=relaxed/relaxed;
	bh=S+Mhu4iqf5I4iV5evTlX9ekr4cvVJCX164d/EMWwfsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQ4r9ijrYlOw8OWmPoVc+ZoAH/gfyPdG0X+WmOcSzIhPNAYtcYTX9FYhwED5kruJ6UElRKbHSU5n+mUtnx1kGvt5gbsDenbo4W+Z+frYPUJCTBOCUlMmfqmsEhTJRxQITsxWSVKPOssLKkNY6aZjdivOdYF+ynyOf536tq240zH1XKkaPDWhcJ6WMLs7b60kx4axL/QsI/5YZKpYOmrnPop2qmhD6AHM4cXsUiy+2gMQZc5yWIZiatouefuw9w+NQRxj2HQ+7NA8M9uxxkBaAONoMm934Zu2i7V/IxhavE76Ph+UEjClq0SjyEXSJxaKh4jsYxaM+1/IEYxcgDwTQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EsUaMf97; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EsUaMf97;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YcPKq08Pqz2yhG
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2025 08:55:59 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4DA3F5C5E78;
	Mon, 20 Jan 2025 21:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82914C4CEDD;
	Mon, 20 Jan 2025 21:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737410156;
	bh=69VVu6VzykbfRha47TkcjIWnRLGOSO3UtXRheEUR2PQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EsUaMf97jAFv1nRL3KNRyS5BjcZUNm9G/sGdGn0zulnz/myvBUb6ieRKsKb10DkzB
	 QpqZbH6ZBxIq+6USgPxaLCfYmqcT+Dqhf61MP6nbJ7dXyTR3T1e3gPbeyh2tHUsrjT
	 JiRRde6SDBMnqVtN/4UZxX5Bn/896X+XhKSdOpsVHiBkZ/rVvohEUNAII2763t28qb
	 fK2Nd2qxlmSI8qwRCM2lagdEt5uIYVVt8om4fm+LqD2VliQ1oG20xJg9cWghWs2E1p
	 nK7GYwh4rN3yS3oa9RcYPntPQ4F/kAE9q1sHDE+pqS+xcV5D7rsyVA6NdKV+MD/zkS
	 78dGZi85tfhUQ==
Date: Mon, 20 Jan 2025 13:55:54 -0800
From: Kees Cook <kees@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/4] seccomp: remove the 'sd' argument from
 __secure_computing()
Message-ID: <202501201355.DDA4B6A24@keescook>
References: <20250120134409.GA21241@redhat.com>
 <20250120134459.GA21284@redhat.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120134459.GA21284@redhat.com>

On Mon, Jan 20, 2025 at 02:44:59PM +0100, Oleg Nesterov wrote:
> After the previous changes 'sd' is always NULL.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

