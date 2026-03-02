Return-Path: <linuxppc-dev+bounces-17550-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E1AEB362E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2026 18:55:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPp620l0Vz3bn7;
	Tue, 03 Mar 2026 05:55:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772477722;
	cv=none; b=Vl4aewvRdtyw7SFrUvEmMUTofdjLHpDQjTAYkWZBaosWCMIDXTepLevg4tJb07ZkgA9cazznz0RcdMrkeAa1L6WHdQIWTLOIwmmZKcAlM7vPzHA90a8M8bt1DTCfT7tsbypMFcXbF/ZlbMb4KaMqdPDeA9ZHfvdOTKI83IulF69TzpnJ3H9VwzpzkQvkFASvATApXPsqzmUx4AYPV8NGz+Bu5XlUIquG02FAtUdKAuJhgrl/H4R+b/Gmjlcdn4zP7HYOYhtm2mVGHtynKlV5qiqDu9yhRAGnPQeu9RldDzCUY4nuivNt/AfaSCBykzjjPM3O+6vbga2R7fZJCnIDMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772477722; c=relaxed/relaxed;
	bh=hRlJolTcfRvzUSQHPs3dCXFlQx1DAFYYMFjz2DuLSf4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqpnmsB2Xgx+HO9qrLCvwL48XRtZ3b1CtwpCq2u8VwJc8Hu6QvCy5lqy31ctKzBvSwPiE6bwArSl6e3tI8fDgKQsxnterVaUCEa/qP18SiyW3HrZGNOhTM2kSwxIDyCwMHx+QWTGZ8pO/0hj4cUCdSUVzWunJypJHZzbPfmbNNgJk4fdOGFANLIsqYJ+zM7Un+UjEu9sweVgvXpEkIflhfPKIEzpnY7yvADtHVcxv0kMl6GotombtIsf9GMn93UUN02ZT1QgvjRN4BzNp7NI2qXupi/NNC4uScPuiyuz+ydFD2FS+x284lRtHzbdIRM/fEhirqKOlovzmwjrkjqZSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gunrv5Cw; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gunrv5Cw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPp601lVBz3bn4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Mar 2026 05:55:19 +1100 (AEDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-483a233819aso46542575e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Mar 2026 10:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772477714; x=1773082514; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRlJolTcfRvzUSQHPs3dCXFlQx1DAFYYMFjz2DuLSf4=;
        b=gunrv5Cw/nNuwFofY6ymH0IqWuW34CSct1NzwV8GXEhC51wc7FMBB7gZFb+G5rQWB1
         108yuCQdC8Ux3Gdux6AtA0wtB21AD+RM3vmVPvH1e5ddTIelEOQH1928Tpc50ZpxgqEe
         FxVR5RM69Xf6bNBgMOHItohfovfQMAWl9qfucWM9PEgsv/WYwl9nl6xmqK8AYHSqvulC
         Qh3Pjj5vIlB6rsR6WDelmom0I0w4SfP9ooe2kvk5U4KnvL+7wl0UiJQYECj53vfc4KzR
         euO9hjHubYvkbew/0t2bFoMtp9SCiIfJwRPvr4PW4AULhrZ5zp3aQEu1ZzaB5Bcx60GN
         kZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772477714; x=1773082514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hRlJolTcfRvzUSQHPs3dCXFlQx1DAFYYMFjz2DuLSf4=;
        b=XyVGwtPxUaer6iLA82lGbdWv+xpMFCim9scJkmI0lpZ9tzr7dRH6xT6wNax1iCm53c
         ENYxNanqbGafzvdLALVAkMGHf/RxvnQTSAn3SyFpv2cpzp03eFVWy40e6bcXVJkyHvGh
         wt0LTEogSN517A5KtNV1DlmBsNmCHvDBjiNNa0BERzhHGqn+Xg0phS6I7kcJywYW1PG1
         bQNUTnnH64D+4zX0JTN9x95QH8m/DnRvE0rcvNN8acAvVw2FpSbdISQmzQyq7olNfTNl
         Btu0O8F1DgLurlH37j6mMXKn6BCdmAYny3DWrnjr0druF+Ymm9GCGbUd92yc0KFHuDqH
         QvgA==
X-Forwarded-Encrypted: i=1; AJvYcCXLqEsqJHV8HT0lZnVy7zjHGBy3BPdsaCG4/vZMc4Rq83ebCWeFcS6dNlN5ZvDWoKokczLm1rUWgMUjjH8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxj/atE0poZIudN5QAeFhGI/JaDTf9GoEX2KBkPp3UVjG9ICFgP
	YTxoHz80Gjt/JVwJiMleQxcNSTXfYV1q/6RgjDToOq4wA/5BlfLqRjUa
X-Gm-Gg: ATEYQzxQglieSNpLwpQ5OHnyhbr/j2VOufxSmJgrK8DXR7J5UYVhcSnpCfsNr2DwwmK
	P2o2z3V4b7bx3oDqTo4+ojhFY/W59zkM0DlEWoWkHblSOCROi4J00b7/m2kTuBI0fib/XppqvyG
	pucVHlhaf3sIC0I4g9nLDYX5oLwZ+xoG+g4rdcGY0Y6wysSlYsu1KPrBD98rsdhi9IDaA7xjjyR
	ZBOQZLZSDRjNDLfiksi1JvzTT1tCONZqlIEvf3Xq9Sq3ha3dBO4q8eilnb8mXK80cYmdwXxOHud
	Np9tpw6MXCP3BgvD3ohdqDGGq4gFu2FWWD5n1XAJId6cu7NncRrLSPvhvfEQvqnisYmOkyNZI4P
	0kFsR0FVBTzW0D90W8yijlyGtfS+jlkvcsf072emWcBAuJbcb8dYQvzf9zsoGYhU5qy7cKfts5W
	t+9kYBlNEWDkBHu+IT6A==
X-Received: by 2002:a05:600c:350d:b0:483:a8e9:201b with SMTP id 5b1f17b1804b1-483c9b81265mr267465545e9.0.1772477712531;
        Mon, 02 Mar 2026 10:55:12 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b89c99sm299471225e9.15.2026.03.02.10.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 10:55:12 -0800 (PST)
Date: Mon, 2 Mar 2026 18:55:10 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Andre Almeida <andrealmeid@igalia.com>, Andrew
 Cooper <andrew.cooper3@citrix.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Christian Brauner <brauner@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Heiko Carstens
 <hca@linux.ibm.com>, Jan Kara <jack@suse.cz>, Julia Lawall
 <Julia.Lawall@inria.fr>, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Nicolas Palix
 <nicolas.palix@imag.fr>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Russell King
 <linux@armlinux.org.uk>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, x86@kernel.org, Kees Cook <kees@kernel.org>,
 akpm@linux-foundation.org
Subject: Re: [PATCH v2 1/5] uaccess: Fix scoped_user_read_access() for
 'pointer to const'
Message-ID: <20260302185510.6b49a025@pumpkin>
In-Reply-To: <CAHk-=wjKWi=j_xcMBAi2Hkuut6aNeqXTwOFoMGkHfDA+3WXsgg@mail.gmail.com>
References: <20260302132755.1475451-1-david.laight.linux@gmail.com>
	<20260302132755.1475451-2-david.laight.linux@gmail.com>
	<e8a688b3-97e1-4523-9a82-8d9dd16e3d90@kernel.org>
	<CAHk-=wjKWi=j_xcMBAi2Hkuut6aNeqXTwOFoMGkHfDA+3WXsgg@mail.gmail.com>
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

On Mon, 2 Mar 2026 09:26:31 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 2 Mar 2026 at 06:59, Christophe Leroy (CS GROUP)
> <chleroy@kernel.org> wrote:
> >
> > Can we get this fix merged in 7.0-rc3 so that we can start building 7.1
> > on top of it ?  
> 
> Applied this first patch. I'm not so convinced about the others in the
> series, although people can always try to argue for them..

Patches 2 and 3 seemed a reasonable idea to me.
Removes a lot of code that is only there to make the whole thing work.
The 'with' is a bit of a take on Pascal - but without the 'making the
code completely unreadable' side effect.

I don't do WARN=1 builds, never mind WARN=2 :-)
Although -Wshadow can find real bugs - so I would turn it on and
suffer the annoyances. 

Patch 5 was just what I was experimenting with.
Doing the equivalent change to the non-compat version (IIRC it
uses the (likely) much slower copy_to/from_user() because the
structures match) might even be more sensible.

	David


> 
>               Linus


