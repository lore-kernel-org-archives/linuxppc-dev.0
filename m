Return-Path: <linuxppc-dev+bounces-22856-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2D3CD98F2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Jun 2026 12:55:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gjrsm2b0Yz2xQD;
	Sun, 21 Jun 2026 22:55:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782046540;
	cv=none; b=Mx4r+IGXv3aoHtTBT3kcTBegPrrRYLraA4fJbGSGfvCEbA++FofYxqR8onL8R1TP5vR+Y5ioMbpWEPpE9z8Nii1AnXpIjroptMp+Nm8mw+DUOtxRVb1muDLy2DlnHDlgte1kSYiFY+tNwNJSIK74bqqUKBuexvStBGb4l73r216yevs+FrStICcyxgqWgmx4h0EJk9SkqcS2rfJGF7ZkBp4bZ73wEGS2fLElNJ+pSFNunvkQiAhayHsUp/6GkePP/EvYqUePkIvlbuT06hhgvGt93K0vk+AfxUTmlEV+6WNACm6qNYzNRJ2QKV1CpqoORJjVh11CFC+v3txqpniThw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782046540; c=relaxed/relaxed;
	bh=WU+6TPSMrQeQnOmPDKoUDmLIYSzXbxEWNqGQFFhaaZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dYNB9RvlexUOEu0Mq/afJplQoEc7cZu0jk/PC9MB68/COL3u/vf9X/VyoQM4c9wwF2KQwKwB5z2VmQpOTjKm9EvCQuSbvdi1KUGYPKsiwbH6r4Z6oq1+3EIuaqRyZPDAPqO7eL7Mbk8C+3yM20j13Hnl0/+ybLG1tyhKak5GskHpUxdPWNlt+cfsgdiKNkaPPKjemfI465r8aS9peviU0byQHy5ZgOvAk2A3Jtg51Ix9TPeU8ny0mZzcBa9ctjs64Abao8QwKyIvX2aY2vVgmlm5xfmzw9a6paS+KJZ6nmpNALobgFIpP20kFgoCCU9PnWMj02h8628y0gzgDehzAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=icVKn3y7; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=icVKn3y7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gjrsk5TTWz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2026 22:55:37 +1000 (AEST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-46066e640easo2061349f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2026 05:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782046534; x=1782651334; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WU+6TPSMrQeQnOmPDKoUDmLIYSzXbxEWNqGQFFhaaZU=;
        b=icVKn3y7oXTr9RneVS5St/6d4tzcBNpEJqP0M+NxNyH9dG6QwEnqCvp0sEWQldOYQI
         v5yXCyyoef/jeXyKhuDe7kILmnQLgSZe7E3p1ZsJoagxR9rch6Ek+/RxsH1Z99vVO4PK
         0stRyjAB3PjCbta0jcqWS0kQzZnsoCGp63dOrHNiuduujfnJMGYDcKJhX8MSTSqG5fn+
         NCijMeKefWK0HoFEozR+xbdMnunR5CbqV05XJyYmslRyhPF2FVum8bxD3MjdwkWCNT1K
         inf1FuZbRoRsfyf6tY7ZvtR4FE7wBXUu3svWZmkP23Gnrv60fA2UpjtjE9yRj3KEAJIZ
         zIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782046534; x=1782651334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WU+6TPSMrQeQnOmPDKoUDmLIYSzXbxEWNqGQFFhaaZU=;
        b=Jn7q+xYeXZ5ZU9otStA+HXIZyOK9ieyb3UbbJSd1nIUqDxshjT2765Ikc1wp2gcV80
         KAXmjo4irENHvMPTqTE/lP3xy0dHitdF/nK+UWR+NWnVGwWnxdPhegJThYSvrSHoTfan
         BAvFbyEau0y7RRZo0A1MbeEfKjkxkdETjRgHA0uu9r8t68OALiLC9M4PgdThEOvWkpaq
         9T0xnKErOBBO55z2m2a1wz9Fy6mUSD3HXjs8HIdmAfuSgQrp0SigWKd/aQTV4GMLO4vT
         oh9YZ4UbMjzO9jYYqIhTcWQNpcSIww3Njcbc+7ewCU7+kN8HMk+S/hRIjyJs+KI2VD/W
         BM3g==
X-Forwarded-Encrypted: i=1; AFNElJ8EKea+ZsQzfXuymk+bDBOhV/qet7Ty5PjWDuoTQXwNnTu152uj/oNiqwuZTz2bE6DzUz2kGt+BYFnXkiI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzmmAoxnAoubtvg+Jw5nRvZH+GaTMEjfT29cvz51zAmQSWwbjij
	BkYROZa0zbsppgS7YISCuKJscLBbqCC3i36bKDSSO4sjOBZcrdYC/jjz
X-Gm-Gg: AfdE7clwfXnXNFpT9cdLZEb+w59Wg8D/Kc+trriqwB/bWI5s46Y6HRlzQgMvyRTndOZ
	E16KaZFF6JicQUgEc63nWbrJGkfRctECkbkwm3p91Q2UOzuo8W6bhouJPw3F8SK/PmYCOpmhSEv
	DGFSAsnKwYzg3pMHp1GPKOmr4K3nE2zrsB+9qOKD7w/c3pPgBd8X3GSMzA5cAyxT/ZgdomlEAXu
	2yodlBf3zTelWd90BZRhyJ9QWW9UeCn+9rl3NYgjP40vSMNFBsUV0PZ+k3MVWofEjYkn249EVf4
	CkdRLi4tMtXhxEkWTeEtQnudS4HxqD9jv4tPOWpuLclXCqWsxB8eZaBlaTJARd1t3fD+KamGTKV
	gOFfwo5iE5AtOUY3AcqoQtypHmbCsPFBXK4gD4hkESyvmzaz1gqUj7Z3lVtqhLpiNRW7ELwOlGH
	tlAwsDrLV8GJcSUSch6mzrVZCaSgu5UxM1ht17nBTJByRJGB2nIA==
X-Received: by 2002:a05:600c:e547:20b0:48f:d5b8:5b07 with SMTP id 5b1f17b1804b1-49240e81b22mr113459545e9.20.1782046534244;
        Sun, 21 Jun 2026 05:55:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249238900sm129230375e9.4.2026.06.21.05.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 05:55:33 -0700 (PDT)
Date: Sun, 21 Jun 2026 13:55:31 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Julia Lawall <julia.lawall@inria.fr>, Yury
 Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] tracing: Add CONFIG_TRACE_PRINTK_DEBUGGING to clean
 up kernel.h
Message-ID: <20260621135531.243375d9@pumpkin>
In-Reply-To: <87ik7cmcb7.ffs@fw13>
References: <20260621093430.264983361@kernel.org>
	<20260621093811.168514984@kernel.org>
	<87ik7cmcb7.ffs@fw13>
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

On Sun, 21 Jun 2026 12:13:00 +0200
Thomas Gleixner <tglx@kernel.org> wrote:

> On Sun, Jun 21 2026 at 05:34, Steven Rostedt wrote:
> > Instead of having trace_printk.h included in kernel.h, create a config
> > TRACE_PRINTK_DEBUGGING that when set will update the CFLAGS in the
> > Makefile to allow developers to add trace_printk() without the need to add
> > the include for it. Having it included in the Makefile keeps it from being
> > in the dependency chain and it will not waste extra CPU cycles for those
> > building the kernel without using trace_printk.  
> 
> IOW, you make it worse just because.
> 
> With the header being separate I add the three trace_printk()s and the
> include to the source file I'm investigating. The recompile will build
> exactly this source file.
> 
> Having to enable the config knob will result in a full kernel rebuild
> for no value.

Indeed...
Isn't trace_printk() just an extern?
Having it defined somewhere isn't going to make any difference to build times.

	David
 

> 
> Seriously?
> 
> Thanks,
> 
>         tglx
> 
> 
> 


