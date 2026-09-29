Return-Path: <linuxppc-dev+bounces-28501-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B13CA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:24:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvL6T486bz30Vv;
	Wed, 30 Sep 2026 00:24:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790691889;
	cv=none; b=awg8fzc98O79pm/6UqjFXPuUdYWwgJo7VAejwKSUv7apx8b8kKnCRIPbHxHKRLb5/A9UuMPAjOmXS+csZGZfFyXOpMxOifMSEQV0PA8WRzopSUwV5MIt4E8WaSZZrhbvivqus7W/ATRtlrZE1A3LkRWyieVILi5DVSBi7LjbhiJ3K8oYjnKn9cETeMYOzDZX+K55CFHiLpMgOAdsASmX0SvPGe/R3Rc0X8f/xrNsnn5tDrWYYdAUPi1CKTUxgSNdU0XDWJnCzfasW5W8Y1Fqkk6B2zuv6x4w0y3DiLPBDdi6gOzBtn+IZbpcCegXLipd8eQajgzL+TFoguqdbsowGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790691889; c=relaxed/relaxed;
	bh=S108zhyFgrWupBnxwjXeQHMSDadfxPXX2/f8wZjphW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzUgEQuoxgOJtGsER9pqH+sywe7eCcgJXwerD1bV+oqvhjFBzmgzLfubiK/faVrUuJ4piMm8rV5u4H6Cym9bfCoEPaZFprgDRD98kl034KMxdkGr8oDUPsgNG1gSficsYJ/LulkC0B2qq3cGV51XjcIJjTFnyT6QNhuW2140nRuCVIhJetKYGQHVtxPQUXi7I7p0osj9L1RqZlH1REJzNrPyOXk6AN67AChBiek2QpMVAjdkQOTimcrLKWejZdnWHQVZK+pdRbHBHpsjv+pRI3dpVtizIWssyyA2jLE5C1y2qF4c0+FbQB4Sbho3wQI44RS0ZqjyPaIsFZDivCVW4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=FpGia1pU; dkim-atps=neutral; spf=pass (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=FpGia1pU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvL6S5YY2z30Vs
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 00:24:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S108zhyFgrWupBnxwjXeQHMSDadfxPXX2/f8wZjphW0=; b=FpGia1pUEKUyyLiJ/s77zVQByE
	R2djtHe+L/OTqu+78ZMdMtGmyIsy+yF9m038TMkyVLXn3JdK6CNZGYTduvreLZfONkv0HVnaiXlYy
	zphDLBzKbnF5kMyDV+voJnOSa5e0jLcPS8060S+BETsPDBGnBZEUtvEfPyMpxxRVSvcZtwi7uQT41
	MeSeHUSurfKJHxl5ozVP+e/VKm5F1P05DsEHu3xDrklm7XlUxi9nQLYSIldqG8PbvnRsXoYFsi93f
	h5+uGYBakygOCU0VOTcvd61E+kAGkuPWpJqwDBLmjY8mR294N7SuUq6CnqcirZ+pVcRo5vK5BRrF/
	rP36JT0A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBYl4-0000000E75a-3YGc;
	Tue, 29 Sep 2026 14:24:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B830C3006DD; Tue, 29 Sep 2026 16:24:36 +0200 (CEST)
Date: Tue, 29 Sep 2026 16:24:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, sv@linux.ibm.com,
	alexandre.chartre@oracle.com, alexghiti@rivosinc.com,
	aliceryhl@google.com, ardb@kernel.org, bp@alien8.de,
	chleroy@kernel.org, elver@google.com, ihor.solodrai@linux.dev,
	jpoimboe@kernel.org, kees@kernel.org, legion@kernel.org,
	lossin@kernel.org, maddy@linux.ibm.com, masahiroy@kernel.org,
	mpe@ellerman.id.au, nathan@kernel.org, npiggin@gmail.com,
	nsc@kernel.org, ojeda@kernel.org, pmladek@suse.com,
	rostedt@goodmis.org, tamird@kernel.org,
	thomas.weissschuh@linutronix.de, thuth@redhat.com,
	yuxuan.zuo@outlook.com, sourabhjain@linux.ibm.com
Subject: Re: [PATCH v2 3/6] objtool: Fix "can't find starting instruction"
 warnings on vmlinux
Message-ID: <20260929142436.GB88198@noisy.programming.kicks-ass.net>
References: <20260929055138.43489-1-shivangu@linux.ibm.com>
 <20260929055138.43489-4-shivangu@linux.ibm.com>
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
In-Reply-To: <20260929055138.43489-4-shivangu@linux.ibm.com>

On Tue, Sep 29, 2026 at 11:21:34AM +0530, Shivang Upadhyay wrote:
> From: Sathvika Vasireddy <sv@linux.ibm.com>
> 
> Objtool throws a lot of can't find starting instruction warnings
> when run on vmlinux with --ftr-fixup option.
> 
> These warnings are seen because find_insn() function looks for
> instructions at offsets that are relative to the start of the section.
> In case of individual object files (.o), there are no can't find
> starting instruction warnings seen because the actual offset
> associated with an instruction is itself a relative offset since the
> sections start at offset 0x0.
> 
> However, in case of vmlinux, find_insn() function fails to find
> instructions at the actual offset associated with an instruction
> since the sections in vmlinux do not start at offset 0x0. Due to
> this, find_insn() will look for absolute offset and not the relative
> offset. This is resulting in a lot of can't find starting instruction
> warnings when objtool is run on vmlinux.

I'm confused; decode_instructions() iterates the section and inserts the
instructions at the exact offset it finds them at. Therefore it should
be able to find them again at that same offset, irrespective of the
actual start, no?

> +			if (func->len == 0 && is_notype_sym(func))
> +				continue;
> +
> +			func_off = opts.ftr_fixup ?
> +				func->offset - sec->sh.sh_addr : func->offset;

function offset really should not depend on opts. It should work
irrespective of any option, no?


