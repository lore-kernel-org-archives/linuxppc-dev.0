Return-Path: <linuxppc-dev+bounces-17600-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B720EDA693
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2026 16:05:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQLHz69ysz30Lw;
	Wed, 04 Mar 2026 03:05:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772553951;
	cv=none; b=aRv86w9xthiGqh5dvbUq4ebE3Q6V0qC8PoDEfleO1P+WU4ThmcpHL8gp+Pj9QfJ0wIiNLw2FY7av+m/aoih7bu/3TCkfIwXVaEWXH9K72gvkKZoikaMK7I8CJRRvMwmHRFp7nCoD4pAGpoTxuPzRxNhjchVx0zWolXX1R7nyPxZncKlEeCIi6aWFYAQ6mppG0zNWkhUe9mGT9EnZQgL+1a3crPQXqKv8/oowEibVJ0cD919hjYvL85R0UEnMQf21f/aaAu8wqXyFm4FgQMX7/oNBDKfaXP6rVIJa3e2ZBnKeVmaVOwlTPCrV7LlOWXEAUEcyFq6AkvY9MeEFYsoBQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772553951; c=relaxed/relaxed;
	bh=8ZtP2eiqo9Oq7WEnEjSsfSf6tBntt8UGm+9MQ8eyCOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXUCF3oJf2H9UhDZuKvjLVw5XFezeYaTgqjXHZ1ZdvCJbFgBcUDzup1Z2oyQ/ZrubwQiCPeXWlK6oxJ/qofWGyKEhGMmwQzrIAw11jKKex9Lr/TO11Nrr3i2INIqMTB4eMh4mB7Um2Gkvp5ULxzaAhqNyinc4a+FEs1EsyjU9dMj2mHGf9TMA7bxVXzgtC/pyxGL2YDFYkaD2wigML3jC/SGUiPYdxnXtgFOhEuuaLzUnSE1jVWq7NUxAdK58oOqADZhUpDsDJ1uwgrJD2B1qkSmM71dnlGspIW7lJxUkIFSBlFME7QA9HUbCSql+piv/drYfvcLC6jw3o5nZ6bL3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQLHz1PG7z2xP9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 03:05:51 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id BF4F068BEB; Tue,  3 Mar 2026 17:05:46 +0100 (CET)
Date: Tue, 3 Mar 2026 17:05:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 18/25] x86: move the XOR code to lib/raid/
Message-ID: <20260303160546.GF7021@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260226151106.144735-19-hch@lst.de> <20260227143016.GH1282955@noisy.programming.kicks-ass.net> <20260227235529.GA31321@quark> <20260228103117.GK1282955@noisy.programming.kicks-ass.net>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228103117.GK1282955@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Feb 28, 2026 at 11:31:17AM +0100, Peter Zijlstra wrote:
> Hmm, I suppose. Its just weird that we now have to look in both
> arch/$foo and lib/*/$foo/ to find all arch code.

We've had instance of that for a long time, e.g. lib/raid6/

> And I don't suppose symlinks would make it better?

Ugg, just purely from the organizaton perspective it would make
things a lot worse.  I'm also not sure how well git copes with
symlinks.

