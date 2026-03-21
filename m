Return-Path: <linuxppc-dev+bounces-18528-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9138B1099B5C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2026 02:22:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd3950qgHz2yVt;
	Sat, 21 Mar 2026 13:22:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774059721;
	cv=none; b=XmnPiC+IeOCLgsHvEDAeQ1UATSTlqhXsHdmqj6FMuGQjDrvWgmcZEWSrU+xk8x7jFIxl9/Ie7zefDbkWUk8ABXJSXC9zHuKULkfrR5CtSEgyVh4nYNhs4HaAMkThWM9Q2s6kSsSngSfoP3HGYf1emDucagpXtgzwiK9ct8QqqBxarsDO2z3bSiQN319XsRYQKK5S//1AVwv9AWLeCTQH1j7ewP3i/i33SmWIA3mhH6S6/kou7Dexv+wpm5fmWZr66eao12nioabmRj6wJcYiDlK2Pf9g6ubjQUPHtO0f608x1duTkkhDd5Bl1sVoiEaO6pKF9vth5B7mMnGQg3kkMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774059721; c=relaxed/relaxed;
	bh=Ws242O5xah0xoOzUmyRDbXa/fc9T7bUDmUjzPUeaeDo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=L+Hfn2/EkOl0lllcX59CVTwuW/oGo//IQwn0U3ow5YJncUUNg/8SVt9HxBEznd4GQx4vgwPpMaO2RcwF5NlRjEbBGAy5S/aZ6orBFEuTRQ1Xk8/GImzk14McAaNKdtIHO2LCQASfkhJLzFqRclXgZPTG+IUlsGTVGTjhV9KA6iUY1ovQG+T77kJmcwqXLGJK+gx5jcxY7nK2/C4Uzfkv3+4AM7hslbhfO2SGDjt9lHHtGgZ+uXF+WFQ0bXzabgcdyljeLB3+r+FIfEC78hLQGIURNeaS3MzEHzEctFildrLktvTDw59L+ZMg0Le1lVTc9E/ez7hNCxdw//Cx0e0GnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=ck2Vz6iE; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=ck2Vz6iE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd3935GpBz2yVP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 13:21:58 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 30B7F437AF;
	Sat, 21 Mar 2026 02:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2B1C4CEF7;
	Sat, 21 Mar 2026 02:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774059715;
	bh=Ws242O5xah0xoOzUmyRDbXa/fc9T7bUDmUjzPUeaeDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ck2Vz6iEhaK6Q5BPLU95zOlkUyMZHVsCVcsQ/QCu3AgfEoL+k8ri/Lqo5NHpjLuFx
	 eiahSHamyqEBzIQLdplojEK/CjwMzfB6Eq6QPo/DeCkWyrIiZS0gD7OYIvgh6onRCp
	 0pHXWrgLNc6JIWfLF6+sUUlD0PfUaX7zV4qq8viI=
Date: Fri, 20 Mar 2026 19:21:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Harry Yoo (Oracle)"
 <harry@kernel.org>, linuxppc-dev@lists.ozlabs.org, Harry Yoo
 <harry.yoo@oracle.com>, Nathan Chancellor <nathan@kernel.org>, Thomas
 =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, Michal
 Clapinski <mclapinski@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Srikar
 Dronamraju <srikar@linux.ibm.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>
Subject: Re: NULL pointer dereference when booting ppc64_guest_defconfig in
 QEMU on -next
Message-Id: <20260320192153.759d6fec57f04fb653a0dac7@linux-foundation.org>
In-Reply-To: <h5qax9x2.ritesh.list@gmail.com>
References: <20260319233745.GA769346@ax162>
	<abzKcGiRSR_E8lLN@hyeyoo>
	<7780a471-9d99-40a7-ade7-0c4594ac36c7@efficios.com>
	<ab1J9ODkX5iChu-C@hyeyoo>
	<7458d8fd-5922-4e0b-9cd5-91880282aaa3@efficios.com>
	<7a8faee8-0eb5-4e58-a6d5-ef711791e3f4@efficios.com>
	<h5qax9x2.ritesh.list@gmail.com>
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

On Sat, 21 Mar 2026 06:42:41 +0530 Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:

> Looks like this is causing regressions in linux-next with warnings
> similar to what Harry also pointed out. Do we have any solution for
> this, or are we planning to hold on to this patch[1] and maybe even
> remove it temporarily from linux-next, until this is fixed?

Yes, I'll disable this patchset.

