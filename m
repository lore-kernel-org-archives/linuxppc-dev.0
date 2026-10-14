Return-Path: <linuxppc-dev+bounces-29499-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02364CC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 17:45:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4drZ0nHKz2y8p;
	Thu, 15 Oct 2026 04:45:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791999902;
	cv=none; b=mdfsCVIKI0TeYVKr+p3nduv4z/dGpbCgex29y03DDyx7ZcQ5rdlwZcnwEoaqcU6+kOXR6KYLLHsQKVyqEhfhvVs7YxycNAkHFQHjQw/lC0NVdU/KJLaj8xPQHw2rCCBwBb1Zh5FguLqmhsfGMM+tcD11wAaeHACN8gbL6mA1VM8bDDvZwlx4y8PpGOfvMUJFRtBNp4tYg+GoF4M1KUgjo36bvsROjpbcuRe1mb4KLAiroOGgcptpVdovlk4dojU//BcyPl2SiwmDMbmzE70v+1T8655ULLnPjHCnKCY0rmq5fOrAdwG+XVhxALX9PgUk0oxWfY3IVg9R+V0bS1Szzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791999902; c=relaxed/relaxed;
	bh=sTxxFIiD6mgFs2UdEY1I8MyQnekZZiyPvhQw7RuhHrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEGV+D+u6twquTSKOtESdI0gJfnnlDAF9poin/3KSZyAgVjlneXDM8GiEZ9y74mRsydy3lGwAEshEMKjIsWUH9Ffz5A8Lni5DQYoJbHPd9Vpr165UF/gWIn2zLb9oWrCLdbyoyujvFhL8g9pUZ++3AbmvZtMl5S9vLjN4e/imMZ3L/8nuxr+7QXAbxG3U9n/iwyrK+E/7ZHZnyxGoGqbtxNqec5F0LiA7cck06nd/l+V0SlbtilOhtAhqMed9I/JzGlmkmNnpjfV4zHcJiSSNa7BxqJYAki7mjWKVXXNx+6VLT1sLPjBZC7CwveWPddB4r62FWZ6yaFKZegQ7aHkZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Y/JbqQJU; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Y/JbqQJU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4drX5W6Dz2xnv
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 04:44:59 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7156940856;
	Wed, 14 Oct 2026 17:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330F01F000C4;
	Wed, 14 Oct 2026 17:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791999896;
	bh=sTxxFIiD6mgFs2UdEY1I8MyQnekZZiyPvhQw7RuhHrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y/JbqQJUIEWFLFscjenxW9GCe5wNUa4lKG/qtufKEMdVe8I7JjwbgDqX5hbrhnbnk
	 g11pdaabApMfzBMkfpM3w5n1u6n4ty6P15W2DYuVy6e5rpnrYB4vdZc0i3KcsTyQQY
	 TKLv1ClTGNe42312p3oiyQs34X3dYVxDiKaB2oxQ=
Date: Wed, 14 Oct 2026 19:45:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Ian Rogers <irogers@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Nayna Jain <nayna@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	David Teigland <teigland@redhat.com>,
	Alexander Aring <aahringo@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	driver-core@lists.linux.dev, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	gfs2@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] kobject: Require explicit initialization of struct
 kobj_type::release
Message-ID: <2026101434-scam-padding-87a5@gregkh>
References: <20261013223946.1836757-1-irogers@google.com>
 <2026101425-why-boring-4f2d@gregkh>
 <202610140932.5F9CFCE5@keescook>
 <CANiq72=4WQ1B1oCSW=69u_Z=FFLE56hYCqDwWr+poQdzSTS31A@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=4WQ1B1oCSW=69u_Z=FFLE56hYCqDwWr+poQdzSTS31A@mail.gmail.com>

On Wed, Oct 14, 2026 at 06:44:18PM +0200, Miguel Ojeda wrote:
> On Wed, Oct 14, 2026 at 6:37 PM Kees Cook <kees@kernel.org> wrote:
> >
> > I'd really like to have the attribute available, and I've got at least
> > one user I can apply today that don't require fix-ups (seq_file), so
> > if Miguel is okay with it, I'd like to snag patch 1 and send it with
> > my seq_file "first user" for this coming merge window so it's available
> > starting with v7.4-rc1, and we don't end up needing to wait 10 weeks for
> > other subsystems to be able to use it. And the kobj fixups can continue
> > in parallel. Does that sounds okay?
> 
> Of course, please feel free to pick it up (with the small tweak I
> requested) if you have a user.
> 
> And if you don't pick the user, I could still pick the first patch up
> through the compiler attributes tree if you and other folks want to
> use it after -rc1.
> 
> Greg: adding the attribute itself should be safe and would unblock
> others that may want to "protect" themselves, without having to wait
> for every potential user to get fixed (but of course I agree they
> should get fixed -- we should not forget about them, if that is your
> concern).

I agree, not a problem to add the attribute now as long as it doesn't
break the build.

thanks,

greg k-h

