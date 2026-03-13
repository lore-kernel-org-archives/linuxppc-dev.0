Return-Path: <linuxppc-dev+bounces-18161-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19983106FD7D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 05:49:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXD7r3fkkz3cJk;
	Fri, 13 Mar 2026 16:49:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773380952;
	cv=none; b=LHnNjuLiKQliFM/pycXyuqqSQMbHc8mb3k0fdsI7m8CGCpqi5plemaUSOec7TPxULl3AWmaz5B9aG2klYCsDWo7cumdFbCt/kWRJlWK/Q0GXmHgozK6CK844jVe2uSInRhj2Pf/C1Pn1sXZ4xOnx/pJp//cSkEoUGjGodSoaUlJZ9bWfPwZxsm2IAt8UmjpMXa1dqjVLMuL6/54As1PHkN85aA6IGAZ8aZDw2m+Trc+GGassr+lN7a39H4dDZR5iRBHf4tPA7a/p3Vu+9paRNh+wdjk2NF2BfCNzcVMBwLQcs1JRuC9tH84viraIDmTv2eR1nUsAcwLxAKbZxE/8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773380952; c=relaxed/relaxed;
	bh=MhADgZLiFPiSNlAWct/eoeXww34LQnX5uPNWa/ki4hs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xl91dmgre9L+RuABF7nWvZdEv2qTeLMQny0m/jTtR3VqMsk5zcKY9c3YxUGAskzURdf7EakH4l96n0AHCJ1GXAbz3ggDDIT0UP5PpvzGoP7UmpyV5Fi4sML2jRwjYpI85KTa+LdwxB5JViUwnOl2W75SbX1U+BIEc+58YR1PKfkaUfomA6ZADx19Cb6TZzVaFe1w+wlNQ7WipnHA11I5TeSJbtRh0k2rKD4sTO8rbioYkFFMv8i7udJb4c7k5COzqfbazLi9FlzMEQzfbDloUsikllPwZt+6rQ3X1wDdriK0uW9pfyt+YNs+Q1I9Ow1h5Ucw6XGbAaarbcW3XbgKOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=B5c2KTMQ; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=iUk0Xhww; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=namcao@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=B5c2KTMQ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=iUk0Xhww;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=namcao@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXD7p6QMDz3cGM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 16:49:10 +1100 (AEDT)
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773380938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MhADgZLiFPiSNlAWct/eoeXww34LQnX5uPNWa/ki4hs=;
	b=B5c2KTMQB6Oh5UTVuF4FNUL4+PXfRxy2fnfIlueuR9Yjq6CZr5qWUbokZ1XCZ/mbORF6cT
	ZJbr4dJpiDB2kqkSVRqiHHrELpX2w9H7SXcHElczNd+JDMxCJG/9dVzI5NQVeGRlLYlufC
	TnfMdP7i8i+9+SJfzHT0DINm+OtaP7ys2YrfeuLtqxerQzTLLAOxIQyDX/gsg59gduXdDQ
	2bYev8+0W3u3ivEaMZ1RVovhQHT2zGMW36gcCVg9PRYxFby8xYpJzaWz7IT57nuCqCq8tN
	YWrMn4Fca8iM6E8Hhn1qQ67D0A9Sl7yOG9kaiDwvas85y2YCg62g5c7kNwLw1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773380938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MhADgZLiFPiSNlAWct/eoeXww34LQnX5uPNWa/ki4hs=;
	b=iUk0Xhww78MdUFXG3+93pLIFfV8DCGb/3KL/x1YFT3dQ6QYu811xnA2ff7ziqkoOELiRw+
	BAlBN05TjGjqGmDA==
To: Nilay Shroff <nilay@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, tglx@linutronix.de, maz@kernel.org,
 ritesh.list@gmail.com, gautam@linux.ibm.com, Nilay Shroff
 <nilay@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/xive: fix kmemleak caused by incorrect
 chip_data lookup
In-Reply-To: <20260311134336.326996-1-nilay@linux.ibm.com>
References: <20260311134336.326996-1-nilay@linux.ibm.com>
Date: Fri, 13 Mar 2026 06:48:56 +0100
Message-ID: <878qbw5lfb.fsf@yellow.woof>
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
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Nilay Shroff <nilay@linux.ibm.com> writes:
> The kmemleak reports the following memory leak:
...
> Fix this by retrieving the irq_data from the correct domain using
> irq_domain_get_irq_data() and then accessing the chip_data via
> irq_data_get_irq_chip_data().
>
> Cc: stable@vger.kernel.org
> Fixes: cc0cc23babc9 ("powerpc/xive: Untangle xive from child interrupt controller drivers")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>

