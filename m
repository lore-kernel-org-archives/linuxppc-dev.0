Return-Path: <linuxppc-dev+bounces-17435-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB4AFEE4C5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Feb 2026 04:41:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNCG8683Yz30BR;
	Sat, 28 Feb 2026 15:41:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772253712;
	cv=none; b=cl3qSX6rKC0O2oy9krnSdYFq0ApZiRQjKaHICZ/YK9vayNjTNRzT96ny2Ec3oKY7W8wYQwLmUQg8qFOWOXDzxkf/SK273OqpCAxNbUgprIPBU6Bvk2xTeEshMb08086QJsyYiuA9sNYrrFf34j07Aq5n6vIUBGjRBDvO784m2JPbKX6R9Mn8SKX2YejZHUNPkDRNHxO8tn5V9uSjQOd5nZaKAfiiYhCtzAboIqj81mDDZYWbS7UIjaI9/MmvnVyix3BgyMIetZgbG+gpzojLWYUDF+FeS5YeDNWh5vEY2Ea+SpeJAsV/l9t8obcnnhb0uMOv5zTdUZYFnYbJP1apgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772253712; c=relaxed/relaxed;
	bh=Y3L+qGVzTsCJQnoG5TCi8Lc0DlEfyMFXUAiYCFvEtfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JF7AcOthDYWguoCYUCHnR8ed9aOT+dt9pWvAMtMK2TWHf2nH0NqqDZbDIZTJbKom9FTrYqTzOuT5Fe9mZlnTImCLX3e1ONhwsY+7zWyV/umXo7uXJqsx5n/DC1LoRcw0PnuKcfcaqyLEeecv8hJtoPRYGmc5HXyvS7yfS0QGITEZjeQI5jdMGQ8NfeVD0gECxAWCoSSDxaBMF7cZfoLtuL/xk1aV7NUH+RpQEAJtPEiZRpek9Cyd6hLQAM3NWggHrwoun4d1/DUhozNqgqVYkXDj37leYpBS3xvQOQS/wFKFAosbZ0ezaMNXwLP8WbwpCkpKmH4A3q2pFhEXBPcwFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rOKkIgOd; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rOKkIgOd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNCG80slsz2xlj
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 15:41:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F247640067;
	Sat, 28 Feb 2026 04:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A79C116D0;
	Sat, 28 Feb 2026 04:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772253708;
	bh=GTl5b4pj52hP0KVBkFlgMlumLNdyDtznBRe/1mAWWQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rOKkIgOdBSzVWSzHxw5DOhxNn03a0Ygaw1woVlTjin4KLowyLELOm+OVhIowZs3Mi
	 dqJMT1De+b8BARm6gDQusg4IahSRzGUQaRpIL79MWyistCvbIiMZ6GQa64miu3ZcRZ
	 cmMCGr06kdASJAnWQFN5T5HEhrn2CSG3d0wt7lfBrAFCfHwD8AHIT6zDjcjgyWpudZ
	 1T16tuC8Ef/5l0VtYfOtBa3/4cAwxmH1U8wP9gZSK6LcugatbAZqq7cuamim+FKLGl
	 QGX36uRgBg/t7BIN5Yg+65x2RyzeJ36b/t9uuoaV9NMPtIM82r7BkkP953pZJg4x7P
	 1Tdp6OJiWNiZw==
Date: Fri, 27 Feb 2026 20:41:43 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 06/25] xor: cleanup registration and probing
Message-ID: <20260228044143.GC65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-7-hch@lst.de>
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
In-Reply-To: <20260226151106.144735-7-hch@lst.de>

On Thu, Feb 26, 2026 at 07:10:18AM -0800, Christoph Hellwig wrote:
>  /* Set of all registered templates.  */
>  static struct xor_block_template *__initdata template_list;
> +static int __initdata xor_forced = false;

bool instead of int

>  	b1 = (void *) __get_free_pages(GFP_KERNEL, 2);
>  	if (!b1) {
> -		printk(KERN_WARNING "xor: Yikes!  No memory available.\n");
> +		pr_info("xor: Yikes!  No memory available.\n");

pr_warn() instead of pr_info()

- Eric

