Return-Path: <linuxppc-dev+bounces-22872-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3616CDB46F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2026 14:41:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkW9x1jnBz2yVZ;
	Tue, 23 Jun 2026 00:41:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782133719;
	cv=none; b=nd/m6dga6YBWFfhrWjiI6u+6mjXG4OlByZJm3O/GGLTv+1ZXwQ/MvALesP5aAQRa06Eu7/3rV5yWYfboISwlOUXEy2fUstYhI4m3JFKu9pkCX41aY715hMJ5NX4VqMgbeXYF3ffP5jqV3woAr84xmlyYyjYrebyemsa5ZHve7fV+wInGmV3b7knmw7O6KiHOCPisBc7go+JpTz72b2ruBkBC1tCNrMfjbVoWTRnC99fxDGDu3XzL4s+B1OAT2neV/e+vV2MdOuC0d/6LBDXXU/Pl0Pepr5Zdp49ASpkfmnZyv/DutBFi0kx29o0KZVJ5eilj2x1pwElKQOmogroTAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782133719; c=relaxed/relaxed;
	bh=Wl8mD9+xZA8nx14eIBmWbrmAKkBoa2SL0k1i5niNjQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gI5/zTQMMw4n7X8L8GH4oAtj6A1DWmYTtY1Je51li6QXm3pAnbhjZxDJLrUrwbSfyk4jCG1AXr8+67BxMquUtOluEFdgiYr0aAvvMwEjonoTGW0HfGwnddEv8bS7f1HXgGLGQM8hDoA1wNBBm644/Oqs/oXdJskGLsQtpRCx83pTXmBkWSA5yajG9UO4r78SJDV3hjCz58xbddIfTZyDWAyB4jQ2LeIA5vM3LY9dilUjrta9c7L5yqdNU5wHCvFDrDmF1Cavl928KjmEFs+pff5FkXdNGkvV1TFBowGlD33TIN4CoCHk63sTC3UdgdCCUaGJKG4W/S1ltyKS12NmLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a20FWXNV; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rostedt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a20FWXNV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rostedt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkT6G5g6wz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2026 23:08:38 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4C8B5601F0;
	Mon, 22 Jun 2026 13:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB651F000E9;
	Mon, 22 Jun 2026 13:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782133715;
	bh=Wl8mD9+xZA8nx14eIBmWbrmAKkBoa2SL0k1i5niNjQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a20FWXNV5UIOVvZQK3oYlnmbhvnGanajAqGfPBzgq1mtLmcUE0p/4+x6YU7Shadgl
	 mqi/3qM8CCBEc0VEfdgQBopeHXXuKfZG+uiDCEbuCYUpTv0SvsiCbiGCb/9bB4KhEW
	 DRUlVIjPKW+wSj99mCg6leZnz6Tlv8BmEwq+uZD69jaXsaAzuDy40c4nJO/LtwTgIV
	 HkMCM8iVWaXizhCkYCbfvhIXZ4Fc2dHPUyzviYNP1yPfWv5E/7zB3cUSfjt3Sls1ya
	 Bk1Z9eNqEc0O10dh8knMYEWL3e8V2fAD+NW45w3IWR+66cvzU66jHpfTiQOKBsif7e
	 TuRZv2ou5tdjQ==
Date: Mon, 22 Jun 2026 09:08:26 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Thomas
 Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Julia
 Lawall <julia.lawall@inria.fr>, Yury Norov <yury.norov@gmail.com>,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 0/2] tracing: Move trace_printk.h out of kernel.h
Message-ID: <20260622090826.20efadb3@fedora>
In-Reply-To: <dbb5915e-6587-4de9-87f3-76bea5024da8@kernel.org>
References: <20260621093430.264983361@kernel.org>
	<dbb5915e-6587-4de9-87f3-76bea5024da8@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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

On Mon, 22 Jun 2026 10:05:13 +0200
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> > There's been complaints about trace_printk() being defined in kernel.h as it
> > can increase the compilation time. As it is only used by some developers for
> > debugging purposes, it should not be in kernel.h causing lots of wasted CPU
> > cycles for those that do not ever care about it.  
> 
> Do we have a measurement of the increased compilation time ?

I believe Yury does.

-- Steve

