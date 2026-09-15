Return-Path: <linuxppc-dev+bounces-27305-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94563C88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 09:24:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkc630jgCz2yFW;
	Tue, 15 Sep 2026 19:24:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789464251;
	cv=none; b=RLz5nkt3ohaaY5JGWdcdBeWiykMvMtWl0AVu6soUKz/953KZ8Nc0DPp9Y2aoaCL8D4fVPvt6hdwLqhZcZOulhrlwR42QDNE7qcbK5wSaEP1EJDrHcPAwzaBIE/NFt1fh7TVKB0jARjbEGJkImyVQ3nIMh8zGy1Db9fwSiq1DxhjTa8k8axCPkstZLssXkQfOwsunzRD9gYGGTSVnETBBaHbcWWacB8D3NVucnxzD94yEy7WVxDEtTdFgEtJdxvqgUzZOSBGE3LfXVMh6L72V4AXdXIYWtsRWGHdTZ1I+zxQjA/DOFUnLU7guFjWyhwZPG6DOQZXVvTAYSrCfd27ziw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789464251; c=relaxed/relaxed;
	bh=aLdhT2Q1x0+krLh05Drnda1oX9PUv34jY/LmETe5rwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIBhx54IVQguYn1fUmwRdoj85Q17FNRZnG1/fFW0sT1Gq9xuwyMIMqB0D/Ubl16K7jKFte4azKcDXZuzrcAL80xT79LyR0X4Jg5ax878q0Ch/wzs7eyc/uU4esUddCogO7HrI6gy8p2VCrLooMzSJjJGO9xngCWyAO+Yl3apxvuxzgf/qhVYZHSmQRA2FyjkAUYh0BOs+0YnuyXKb+lfO5RJzhfy+/P8bAfmXZVOaFDAuVklAdy3X6HH5B8JGo0puIzsMghaBxG/BV7iol0aWPHYaPjZFPVHFrg4jVhR3JSPDciYFTJ+TIifmKKtms+toFDDMkHe2yoQZlJz4nKG3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j97FvAKP; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j97FvAKP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com [IPv6:2a00:1450:4864:31::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkc6151Nxz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 19:24:08 +1000 (AEST)
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-49cc9f581c4so10211855e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 02:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789464244; x=1790069044; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aLdhT2Q1x0+krLh05Drnda1oX9PUv34jY/LmETe5rwQ=;
        b=j97FvAKPf/EY03Y2JCTKEvBYeVz9317O7BaEixXo/yERoeB4bFW7onUUwkRE7eCkvi
         AzP898xotSJ1gfzFvu2jZGdv5HziZDK6ss/Zg0t4cJ1XuDmPKpVxKTTqjR+U1LKgUh+U
         4t9YM2e/S4mi1DErFLUPrebThyCXm2um7QAU3aS1okf9xbbO955dkZTcKfqdUSuUZPNZ
         4Unef8CBprrvFBy+/EdgzDy95jO4R5UQn/N25dHuO6mx3aad0lFdqsyPFXaLyt5+OoDc
         7edZRnqPX+fnaiVrkYczwxwSPZusnRg+Y+w8iuhaQZ//J6iNgwvgn0mfN7Xm1wFaKS9S
         J58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789464244; x=1790069044;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aLdhT2Q1x0+krLh05Drnda1oX9PUv34jY/LmETe5rwQ=;
        b=JEzS9MNknMK6qPmmDcm/qos4yBRpGtcDNK4w6+5gSLCX/CBOSq+el5GcRfO70mRjXO
         59tB0iLfXuFzAZ+5l/dI8r65W28w2EYV5BYYvshFlJjGb/YPjIhxCX2GcEf26LxgxY+Y
         BdmjII1cbRTSyYFo8j4I40HL74+iXPH+3qgqDD+vwt6ukePtXz7UDDqRHaYaFgUOWWns
         UT/9PvZa7O6FFCu4HuiykkAWLa870AElJjrxym6ypT40wTXvuWBSelHgiu90QCDUVeNi
         4hxqI7cyeuieA4RN11hMHcmmsgC5HEl1Rg1Nq6ig6gM0XwjZ/cq1glUn/AxekbulTOWE
         cBYQ==
X-Forwarded-Encrypted: i=1; AKwUvBwsBqy3L9xFhab+UVTH94GnU0VB8YX8TXl04e1pF73B39SUtYGYqk/Dv7Qt/IWB11XDPNLZZ97CE3bv1M4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mFzTgr5Hm0KdhWN//ARNCeYPs8FTh4DByktRXk3VJIXsXqWgL1
	2zMKftWQZDcpi3OTfTv0WxeMVx72TlBFmx3gwIJc+5H3Vukdamcmw1Uw
X-Gm-Gg: AYBFou1fZRZgGawJoZxkEYPmOLx/fuw4/9438L4hgVQ5qGWYLoWIHEtUG28nJYQaYdB
	zgceHn/2Vhqdct9wapCsOQ4Bbv2/WAkkLkipEoiOvKFP/KBoBCZJ0u1tUapk2tbDS/FiEJvIqXe
	fAIKjGkNzXPwCz8W8BrHjxxNzSAwK1cMM1y8NRFNTYG0kSkg6NNo+JAfG6LvqyJs/WJWDv5oZTw
	n8VCF7h05FSLc2Mh+RWoe9AR9iq5ygynYFEANMn9V0NC5ApokVeKpvj8cADkdAAhdtwejk3/ryG
	FSsNZl92y2HZDfWfdz5Ooz6iCDXBhEXJ4A34BpQ18Ms6HAnft/bg9X81sANiXivSFMT8UDzzLZ4
	lzlgtgsaMVBb4/4Uru5FtmpHLVGaPZ6PYMfAcEL2Iqh2/62vnyAdwWMjeh0CQeI8w8LvUOcjEoT
	lJF9jOxrats01M6PAmD1uME0AACPTey7yWvYkn9RU8aNMLZ13hjThd45/NrlOQTdc/bD8w9y7Uj
	Y7/O+oOU0zmFz+Fc1GQw6t/j9GuGZpVk2Lw
X-Received: by 2002:a05:600c:c162:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-49e7d72b000mr36925425e9.5.1789464243970;
        Tue, 15 Sep 2026 02:24:03 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7ef9228fsm49333445e9.15.2026.09.15.02.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:24:03 -0700 (PDT)
Date: Tue, 15 Sep 2026 10:24:01 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
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
 Zqiang <qiang.zhang@linux.dev>, Onur =?UTF-8?B?w5Z6a2Fu?=
 <work@onurozkan.dev>, Kees Cook <kees@kernel.org>, Joel Granados
 <joel.granados@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, Mike Rapoport <rppt@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil
 Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 virtualization@lists.linux.dev, linux-rt-devel@lists.linux.dev,
 llvm@lists.linux.dev, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 00/17] Treewide: enforce static storage for object
 initializers
Message-ID: <20260915102401.3c56aa95@pumpkin>
In-Reply-To: <20260914231418.b15ec01f7225cf460f6e515a@linux-foundation.org>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
	<20260914231418.b15ec01f7225cf460f6e515a@linux-foundation.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 23:14:18 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 14 Sep 2026 23:03:18 -0400 Yury Norov <ynorov@nvidia.com> wrote:
> 
> > Declaration macros that statically initialize embedded locks require static
> > storage when lockdep is enabled. Automatic objects must use runtime
> > initialization so lockdep receives a persistent class key.
> > 
> > For automatic local objects, lockdep cannot use the lock address as a persistent
> > class key and reports "INFO: trying to register non-static key" before disabling
> > itself.  
> 
> So why haven't we been buried in reports about this warning coming out?
> 

Are there any code changes outside of testing?

David

