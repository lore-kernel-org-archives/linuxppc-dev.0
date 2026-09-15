Return-Path: <linuxppc-dev+bounces-27293-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB59EC88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 06:14:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkWv60LS5z2yFW;
	Tue, 15 Sep 2026 16:14:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789452865;
	cv=none; b=U/QdLYSQCr7fg+C09dkKmv5hNRV/w2D1udUgBirePRSxXUYnDF5asN1rftE8FL5SmDhvu6Phw6ZqqJ6nh00/WrKO1Ph/gBC7GYwDLSMNbgjK0Mq2we979eZW14AR9jnitH3Eic8afzlLUqLZY84rFvOrsEOGlRvtXnyyeDzt41FA0x+8KrH7PrdxI1EUoP900DfuQ29Gjzi69dFEZeZKWRbEThHMhSzIKvOOGFbrv7nighZo26L4nToWz0VDlUVfpj26Hu80RpqEJP0JmtTcqSSk2OWOO2D9kNcctJ50+XS7v12KTShL0oSbrMGA1VI3IAXPoqpHm8pjUYkxOQguUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789452865; c=relaxed/relaxed;
	bh=/xezU87Zq2Y1vT/o2bvpMtCWCufr1oupAxWYAhAbPVE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TewTfd1pfgyPtjCWFyHix+sHVJwLp4YvbGHp9FNXGMC2QOHM9NI4waCXCaDSpBQGaYfm2PQ5gEF25KB0o8RJah7nhh2zz4gmZUrQtlVA8mVx0jP8f7VHyaHYPdeJUQfxubP28AmIg7f6BVhQmfrVSAgp3Uc9wCL8Eu/IH913MiMon9vQfrHGH2s66IRKnd+JhRtSaLa6R6UNddPXPm3jXvV0y6o0NBtwXeISvhTG8pOj5Ey5wlZNtj16CBZ417hjeSDqk3A9Cxvvny6zJfdAfxlEpbwSVfAKZqIFFtmMA/0uFttRcDvQvW6Wvhgyda7XWcLyK+089OEdkIaKXfrUyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Cwwjt4nJ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Cwwjt4nJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkWv44cGxz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 16:14:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6A6A8600D1;
	Tue, 15 Sep 2026 06:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3910C1F000FF;
	Tue, 15 Sep 2026 06:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789452861;
	bh=/xezU87Zq2Y1vT/o2bvpMtCWCufr1oupAxWYAhAbPVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Cwwjt4nJYsaMpOAFBS96BKI8N+2+sK8qyZMEoJg8kDgjYtNT2BKKpZlwOV4sgpN7S
	 855KBpJ5y+VTkRCRPDpDh2agL14R3mMuAGVEDtM5DfVAxwgvZ+edoZhOW3rum1Pzlo
	 n7aEuG9bgOKttiqPyGo3uJh5NElBpjAtfEeOQXnI=
Date: Mon, 14 Sep 2026 23:14:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Matthew Wilcox <willy@infradead.org>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will
 Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long
 <longman@redhat.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo
 <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Uladzislau
 Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, Onur
 =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Kees Cook <kees@kernel.org>,
 Joel Granados <joel.granados@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Thomas Gleixner <tglx@kernel.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Mike
 Rapoport <rppt@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Lorenzo
 Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 virtualization@lists.linux.dev, linux-rt-devel@lists.linux.dev,
 llvm@lists.linux.dev, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 00/17] Treewide: enforce static storage for object
 initializers
Message-Id: <20260914231418.b15ec01f7225cf460f6e515a@linux-foundation.org>
In-Reply-To: <20260915030336.1192299-1-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 23:03:18 -0400 Yury Norov <ynorov@nvidia.com> wrote:

> Declaration macros that statically initialize embedded locks require static
> storage when lockdep is enabled. Automatic objects must use runtime
> initialization so lockdep receives a persistent class key.
> 
> For automatic local objects, lockdep cannot use the lock address as a persistent
> class key and reports "INFO: trying to register non-static key" before disabling
> itself.

So why haven't we been buried in reports about this warning coming out?

