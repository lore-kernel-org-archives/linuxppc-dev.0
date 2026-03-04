Return-Path: <linuxppc-dev+bounces-17727-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A2DEF8FF4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 15:16:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQx8k5zC6z3bp0;
	Thu, 05 Mar 2026 02:16:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772637398;
	cv=none; b=EGJIf7+92MgY9AmYaOAkz+gWHUifRL6x/GN5pDcjEX4nYDcZ6WmHUwfNxrm0tF7GsmW8v36yjwiZd6vrxuVT1NGGGp2S99UIk9HdNPH5Ho+gR+njSc4ndOjy1LjHVTA/E+I3a2fVG+ZRVDKrYQZqAPX2NGJT35mHrH/zYoa509yfGv+XN2ysrGJHV8/oPQGFVmbDw4MqKY/ctceh8MaaambTvbccRsp/A5nFz4dLVKs1IExu5S+k9Vq4C8jhmWH9fs5w7N2MfTv2bz2GrHNpzBEa3hWd90PY2jxmdHb6U5GKGmPJGgThfEPQj6ddzBEShlfhVw/mDRcB2BjWgBpv1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772637398; c=relaxed/relaxed;
	bh=6YOM2WbXA6Qkgtapqxkvfve9MfkbbU3JEb7qOmomVt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYF+OqqF9Wj/AFRVHwWcYySQAlFpifQ9E59nLJYTt7uoWKmew+PGp2DsvvgCaoxxSvGBEC1LToNmYPZ2N/7VGqMNWWz4gDC+QRg1zlERgJUYiVKIA6tm73RdI1XBAEXbkJn9bkuRjIWQ6sAbjVwdqOeTCgUowq/BaJ3yDczQ72Yq4BwU/wyM8lsHVow1aVnUbYnouDnHxLNlsSJ0Qb4wytllwKsvwsPVn2LYsFOEoTuUAx+LajTeTPDBRbdLbFtIg6nKSYP5Q8S7mZdbSVtVK8nHsKnWlW8Q0PfCgXY7djtt9w8Q9DZkdMyxaYTLjOVe9Kg0Cr/cOcQOkw1iyzxLEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=q1J4oN1p; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=q1J4oN1p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQx8h5Rhnz2yY0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 02:16:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6YOM2WbXA6Qkgtapqxkvfve9MfkbbU3JEb7qOmomVt8=; b=q1J4oN1pPBSexJBFfjtr2VdcfT
	cPjNy395v4gDWuxsi/ha9yDNRWUDE6LFqfzn4Yd1LrI2S8TpWPL9z3MhAmoIER+ZDJyxwPon5M1aZ
	AskUH2Doi34eCDyGezZO7dFjB0MasMnhHu+waAlY2mSgI1X8HVcdj0ldXYJVqOQJGTHaRlrHebAgJ
	7wxEvMsC0Uv8vstvbUoelynHMruTuwwfR7BfY5x5rRwbRWYnr5u0aOyOekToDV4C2BditkWs1U/DG
	GZMgOgAqSwHzeMa0C5li6urfh2f+Xx0KFGH88a+OERM2YwXtwihCtup0aktg8uAV14j68e34o5DP6
	1F2fSdZQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxnwz-0000000DTMB-31pq;
	Wed, 04 Mar 2026 15:15:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 20C7A300FB6; Wed, 04 Mar 2026 16:15:48 +0100 (CET)
Date: Wed, 4 Mar 2026 16:15:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>,
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
Subject: Re: [PATCH 01/25] xor: assert that xor_blocks is not called from
 interrupt context
Message-ID: <20260304151548.GN1395266@noisy.programming.kicks-ass.net>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-2-hch@lst.de>
 <20260227142455.GG1282955@noisy.programming.kicks-ass.net>
 <20260303160050.GB7021@lst.de>
 <20260303195517.GC2846@sol>
 <20260304145134.GA21983@lst.de>
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
In-Reply-To: <20260304145134.GA21983@lst.de>

On Wed, Mar 04, 2026 at 03:51:34PM +0100, Christoph Hellwig wrote:

> > How about "WARN_ON_ONCE(!preemptible())"?  I think that covers the union
> > of the context restrictions correctly.  (Compared to in_task(), it
> > handles the cases where hardirqs or softirqs are disabled.)
> 
> Good enough I guess.  Peter?

Sure. The only caveat with that is that for PREEMPT_COUNT=n this might
not work, it unconditionally returns 0.

