Return-Path: <linuxppc-dev+bounces-17443-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFABFEE4C6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Feb 2026 06:58:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNGHX5tg1z30hg;
	Sat, 28 Feb 2026 17:58:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772261896;
	cv=none; b=HBUN+wOOvjdSL5CEYIGA+B/blP3460jFGEjv95iBIUg9kH0ZGBt7TYxtConsmasRCGPJFVGHy0hY/3/lZlHoYegwH0SiCAmb1MYTAPncEEgWm3iHz65I5M63ASPisC9AbyLAWcqw1l2njnsiGeSO3mSK1ZqpgP0zIFeBGuviqExtuAVmA7TI0XCchtMzWTOOXCVCnvCKDoUXMo1YkSArno4DrJTsYgyCgpEsNdPBLw6g2C8d+Z7A9rJPU14OaQnv8B6AgRQyMG86yjUwxEAxm9it6X/FRgDwZHb7JwCep/5bXyBRXpcxFtvGY2UWSkruSZNwVrreKu+6boAcxTG5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772261896; c=relaxed/relaxed;
	bh=NgDGtsqBhUQwL9XsdeBt/A2oCAsnHmbkb4D0bvRZojQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7hzEaIr7LT0SQaXRemfUP++YzjCGkDvT2LSR1YyYWVtRvQ1E78l/p4Hsh+vO2ySD4Gzkc1+GE4N2MCyQKFjDPGPs5OIEv3uxJO+ushfEuiq2e0sFSMCMtsBLwXLq0ceQzYQP3r93JxuCjCAS9RTN80RwENdVRaOnqlWQ31XYwY70qcoZndEaGS/UymOHeT25A78MQuLiPx+K8AOQ0a2qJNv5fhB1liD2t4wF8xVKEB10lWsIc7RXp9XHAflL/wdK2rsOmFOprz3c6CIiK/0/XfxxGQ3bCGAZYa0y3M8DxbvTfUKLDrPrnwB7105/Jh3sOclBFOtb/kP6P29XNbolw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WZJvSmvp; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WZJvSmvp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNGHX1WKMz30BR
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 17:58:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0EEED40229;
	Sat, 28 Feb 2026 06:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B51C116D0;
	Sat, 28 Feb 2026 06:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772261893;
	bh=OZ08akKAa75pF5HX8BdM2b9T1B4d2lEE9VTD0Yyikqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZJvSmvpEC6sHP/zivxpALj3tLGejpdvAPR0eMYRI+scB+s1IF4OeEtX5WKMQOtse
	 Y2O4u4bOc8GI/JkEy6r4u1efjOMWWhLBmlfPczD6cmniYI2bymYIkCjhEhIGubJ4gY
	 U9xKn5Z26jVbpiN+tbnYvysYm7bGRQ8U3XJJKW5Mpnhlp7/c6eic5HbKU4NYZzTh4Y
	 eWJy6kT6Z+zFjYDjttC40gAqyP1FxjjNb1CXpDAIZpiSYLp4Vl3s7MEe9JtyMARKCq
	 OsKaO4PPgfcbgTDw33LPxpOolodGKsdhIykRymhYri+JeNTEZUGQdgg0r4NRhV+/z9
	 uLwVU5xseRMgQ==
Date: Fri, 27 Feb 2026 22:58:10 -0800
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
Subject: Re: [PATCH 24/25] xor: pass the entire operation to the low-level ops
Message-ID: <20260228065810.GJ65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-25-hch@lst.de>
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
In-Reply-To: <20260226151106.144735-25-hch@lst.de>

On Thu, Feb 26, 2026 at 07:10:36AM -0800, Christoph Hellwig wrote:
> +#define __DO_XOR_BLOCKS(_name, _handle1, _handle2, _handle3, _handle4)	\
> +void								\
> +xor_gen_##_name(void *dest, void **srcs, unsigned int src_cnt,		\
> +		unsigned int bytes)					\
> +{									\
> +	unsigned int src_off = 0;					\
> +									\
> +	while (src_cnt > 0) {						\
> +		unsigned int this_cnt = min(src_cnt, 4);		\
> +		unsigned long *p1 = (unsigned long *)srcs[src_off];	\
> +		unsigned long *p2 = (unsigned long *)srcs[src_off + 1];	\
> +		unsigned long *p3 = (unsigned long *)srcs[src_off + 2];	\
> +		unsigned long *p4 = (unsigned long *)srcs[src_off + 3];	\

This reads out of bounds if src_cnt isn't a multiple of 4.

- Eric

