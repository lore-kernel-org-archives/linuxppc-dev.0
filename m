Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C64EC4332F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Dec 2023 07:13:50 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EbxYDLM9;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sq8wr5W91z3c3l
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Dec 2023 18:13:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EbxYDLM9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+6f90c2f2ff3264e7ff81+7415+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sq8vy027Lz2xQF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2023 18:13:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qKkN+WDYcrrRR7b+HudfeVg2AFuYxaP6rVgX+0kznJo=; b=EbxYDLM9Lk4pIpZkXV9nCK8z51
	YCd5d1LdC02cSV1apV+K2zcOxxSZoNtfVpcWrpVNadZvoJNtMWvB1ARWoJ23OJotx+tPrj4RkHzmn
	tkYNYTIMvFyRcSJ7devi5246/ihQjeDEwp2ITB/kIlrGVlEN6o22cPkUCV8tYFVUmmkxZfDpP1qhV
	lmyOiLcfhVkV5VA4bRSsj+O+kDvxpqINyzd1Au7UJ8aVNs689Uc3dO1CXYY855il7wvkUaihDjMJg
	ivEXtdTaBXv4VpnXTEumCHdc88MXEMloSq5yDkzkxaX/lbenUO1r/vREZNwzo6N9H2j0YGuK6YSpQ
	lyrO8Ajw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rCwwc-00AuQo-0N;
	Tue, 12 Dec 2023 07:12:42 +0000
Date: Mon, 11 Dec 2023 23:12:42 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH 3/3] drm/amd/display: Support DRM_AMD_DC_FP on RISC-V
Message-ID: <ZXgH6un2uLdjQ48X@infradead.org>
References: <20231122030621.3759313-1-samuel.holland@sifive.com>
 <20231122030621.3759313-4-samuel.holland@sifive.com>
 <ZV2+f/yu3C6xTVqn@infradead.org>
 <6d4cecd5-9083-4d68-a7e2-266dae9e3952@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d4cecd5-9083-4d68-a7e2-266dae9e3952@sifive.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, David Airlie <airlied@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Harry Wentland <harry.wentland@amd.com>, Nicolas Schier <nicolas@fjasle.eu>, Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org, Leo Li <sunpeng.li@amd.com>, Nathan Chancellor <nathan@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, linux-arm-kernel@lists.infradead.org, Pan Xinhui <Xinhui.Pan@amd.com>, Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, linuxppc-dev@lists.ozlabs.org, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 07, 2023 at 10:49:53PM -0600, Samuel Holland wrote:
> Actually tracking all possibly-FPU-tainted functions and their call sites is
> probably possible, but a much larger task.

I think objtool should be able to do that reasonably easily, it already
does it for checking section where userspace address access is enabled
or not, which is very similar.
