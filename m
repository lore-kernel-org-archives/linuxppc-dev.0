Return-Path: <linuxppc-dev+bounces-28513-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08C4CA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 18:50:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvS0t3Qlcz30WJ;
	Wed, 30 Sep 2026 04:50:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790707822;
	cv=none; b=SkqSiDP+uNhQJKxd3iq5xjKvkoB4YkikzAqGxXBJkm2ia9LoG/aUn7SwAjQlqUiIRnRK5eVYlXA0NXrCZwq/KqDa+qEIZWB6szn9OwIql/g3+5NrYJVkbPlI6Q3dPi/pHKTLna92ebR59gbWPqXgyiHfI1dv/Xy1Ji6yKAdVtyAnONefqKMOVeFvJxo3thuMxyZAmkvo5gegbHnDKMTLL2LD3FDf9K/GG828gjL6gfW4rJVHRcJnUJByclazt3JxESgvs1Lvz3Dm8vmzFRptdrAtUEnwwztyZtbTgK/4+miUhRfx/7/nL45jWdBx64csewj9qIe1GvZle9FG5dPmSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790707822; c=relaxed/relaxed;
	bh=a0j9ZYPE0kpuxcGqfOeJqb1F8DjbAgg+aDr2TDXJr2k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZLZdb9M4Y9wtZUFdWJujxoKYS0tWzu9vizpaktAZR+4SNIE5a1tlwY/S2MuJm7KdvWLCXf+W2FfbX9UdAG/Cu4I/G19Dht15ch/hcOzNsBk/bUzagES1zCuvRbKw1kvrFg3q+IWFkGcy5Le1hPhsTLz5UBpWpQUk7UQCsZ3sPaqfNItT4QtsV8Vi6GvM36RIouF7jsjCmt6HUpHMltlQusCLMJq6W+Teh4pBKPlWiB7E0KL9HROwwu1p0NZrylCBhkiczgtX8tT+eQVRtBOEtjkWJ+fvoEGn9ltOUs4EMFTRouqdOeB+QScdhHaGQ/Hp+W98kod//5jvduWHraWhyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKL/NQJo; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKL/NQJo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvS0s2v2Qz30Vs
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 04:50:21 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DA7F040252;
	Tue, 29 Sep 2026 18:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C211F000FF;
	Tue, 29 Sep 2026 18:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707818;
	bh=a0j9ZYPE0kpuxcGqfOeJqb1F8DjbAgg+aDr2TDXJr2k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=AKL/NQJoQyB/VbLk21OaTs+Mad4FePYdN1yez5LipKrQ8ppXndkJ5NvSAie+kvhQ7
	 Yqyl0+b/kdqogNgUALIq95bXiZ9mFnXgC+4UviSh6lZef0lMj6jNLORKe9IN31zuNT
	 Vu8/t9RdpxSVVjF9Al3+GYkpLpqdUtRfCxKhcz0Wriu/JQRqpMn8u5EoboVp/bfF4C
	 cAB0XC1Pnny4KkDArsPRqCbt9dFO62WiZa9rNGDOdAyit5ChZkRHAy8b14ZbocdFUt
	 CA+EzLSqc4y19uaW8WZ9YTKy0iq3H/SVKVhdX4xUFyS1KmdYw5GkoFZzzmgjoSkYbO
	 7CDUOnBLTgKsA==
From: Thomas Gleixner <tglx@kernel.org>
To: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Yury Norov <ynorov@nvidia.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Waiman Long <longman@redhat.com>, Dennis Zhou
 <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter
 <cl@gentwo.org>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Onur =?utf-8?Q?=C3=96zkan?=
 <work@onurozkan.dev>, Kees Cook
 <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, Mike Rapoport <rppt@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil
 Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 rcu@vger.kernel.org, virtualization@lists.linux.dev,
 linux-rt-devel@lists.linux.dev, llvm@lists.linux.dev, Yury Norov
 <yury.norov@gmail.com>
Subject: Re: [PATCH 12/17] timers: assert static storage for DEFINE_TIMER()
In-Reply-To: <20260915031334.1194975-7-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915031334.1194975-7-ynorov@nvidia.com>
Date: Tue, 29 Sep 2026 20:50:15 +0200
Message-ID: <87o6dfj3iw.ffs@fw13>
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

On Mon, Sep 14 2026 at 23:13, Yury Norov wrote:
> DEFINE_TIMER() marks a timer as statically initialized for debugobjects.
> An automatic local timer instead needs timer_setup_on_stack() and the
> corresponding on-stack destruction before leaving scope.
>
> Add ASSERT_STATIC_STORAGE() to catch automatic declarations at compile
> time. The timer lockdep key is already static; this check enforces the
> debugobjects storage contract. Leave __TIMER_INITIALIZER() unchanged.
>
> Assisted-by: OpenAI Codex
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Reviewed-by: Thomas Gleixner <tglx@kernel.org>

