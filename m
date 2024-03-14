Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC64C5475B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2024 10:41:56 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=d5NqvJSi;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TwP830bNsz3vYn
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2024 21:41:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=d5NqvJSi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=kabel@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TwP7F4fjtz3cPR
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2024 21:41:13 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2CC4BCE1D80;
	Thu, 14 Mar 2024 10:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63136C433F1;
	Thu, 14 Mar 2024 10:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710412870;
	bh=NKeKefPF6egagCg3IVA3tpwNCyhF4yfvOCdSY7XKMV0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d5NqvJSiJLIuJ8UfZzIlO+3hWCpzNH+tKOmCRquj6mVZpDuZpZPfJJqRpiTe1Ufj+
	 4CDxEWnc+DhHW6ZcQVNa0FJm8l5qm51+tnWI5h5X30tDvkkmcbymgTgjPhmVu+skC+
	 fhKJyOoLRmBbkxKV5O5F7UCo7jjHlmQ4kp6QMh3tIcZtZetbwPw8vsjZKyvMt5lhOj
	 ELghCvaa4Bip6VGbyvfldZNrilS4haYwvzT8JHXtvH1jG6+sMBV9f26/qUy7ajiMfM
	 pvIThJ8v0fM4ud0wySZ1/ygDtkyG2wb8njNYj/jQ/p/QMHHarXbr9fLq/P0ASW4pa5
	 cTFtcNALYcL7Q==
Date: Thu, 14 Mar 2024 11:40:25 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: George Stark <gnstark@salutedevices.com>
Subject: Re: [PATCH v6 1/9] locking/mutex: introduce devm_mutex_init
Message-ID: <20240314114025.1e27399e@thinkpad>
In-Reply-To: <20240314084531.1935545-2-gnstark@salutedevices.com>
References: <20240314084531.1935545-1-gnstark@salutedevices.com>
	<20240314084531.1935545-2-gnstark@salutedevices.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kabel@kernel.org, linuxppc-dev@lists.ozlabs.org, vadimp@nvidia.com, mazziesaccount@gmail.com, peterz@infradead.org, boqun.feng@gmail.com, lee@kernel.org, kernel@salutedevices.com, linux-kernel@vger.kernel.org, npiggin@gmail.com, hdegoede@redhat.com, andy.shevchenko@gmail.com, mingo@redhat.com, pavel@ucw.cz, longman@redhat.com, nikitos.tr@gmail.com, will@kernel.org, linux-leds@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 14 Mar 2024 11:45:23 +0300
George Stark <gnstark@salutedevices.com> wrote:

> Using of devm API leads to a certain order of releasing resources.
> So all dependent resources which are not devm-wrapped should be deleted
> with respect to devm-release order. Mutex is one of such objects that
> often is bound to other resources and has no own devm wrapping.
> Since mutex_destroy() actually does nothing in non-debug builds
> frequently calling mutex_destroy() is just ignored which is safe for now
> but wrong formally and can lead to a problem if mutex_destroy() will be
> extended so introduce devm_mutex_init()
>=20
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Suggested by-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
