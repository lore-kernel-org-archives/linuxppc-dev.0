Return-Path: <linuxppc-dev+bounces-21818-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEDBCD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 15:29:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTdDl5n7Vz2xqn;
	Tue, 02 Jun 2026 01:29:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780327783;
	cv=none; b=WRzrKqFlS0d4Zph0diiCH2gO181LaxvdqqhJ+JSpUh3+XhsXpIY5ef9RwibC3j9b8zMSnYWfK/wcqnLhRS3J0en3zWvhi926ZVS+ov01MvtTBsIbG8FOkPTfYP3SoJ6qLnwcP6Wr6tlir/g59PTnututnANN8ovKU5w9q/BKrQfv7rIQSrcl1mOi5fBBV0MZrLiej/hnjd7zqqpQ9IWUfuvW5JeyQt0FZXdg05CZztzg6MVjcuj8WAqEVJVRIJmb0M7uYeeFvAvvV/IrIQFs/w495Osa4r5zJWnq47b3Zpw1O6UUd8D4ZcKmQXGwutWt0WwDsykfpy+JB7evQY/oOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780327783; c=relaxed/relaxed;
	bh=tWtcDYW8t9tbo1A0H7nK13BcgPLS6WqiwxOLb05uxLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZC43REroRMwrSdoGPjAOWmvsRWvtKZ0xFwLN8D0AWMQfLfeEln5smiFxM7jSWWePYrCzbF3PHI/JgSEN3wchtH44g0EHE/S/XVm7cW0iKU4tUmxbvcK0ZmhA0nKDohAbUxU8da/Le38t70pqtuRk8t832dx/4XpBDc5euIDS4XxJrimnffPI78w4VzVRxbcsqcgbgzufc0QzWdXH/vPAoufdRQfueqcJAWaN4i21lRdIGSrgV+YAEnkrgubW/8AJYzypSZDeR1oFst0OtdAiwUQyRTeRhdTEktQwXmCppDG79KqbkXKN9UPoGprTacLskJ9QDomqzD8uMREGyZ9fQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTdDj4TyGz2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 01:29:40 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id C677A68BFE; Mon,  1 Jun 2026 17:29:33 +0200 (CEST)
Date: Mon, 1 Jun 2026 17:29:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: kernel test robot <lkp@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, oe-kbuild-all@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [axboe:for-7.0/block 19/138]
 block/blk-crypto-fallback.c:154:17: sparse: sparse: cast from
 restricted blk_status_t
Message-ID: <20260601152933.GA6444@lst.de>
References: <202606012339.rZAl6Xq8-lkp@intel.com>
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
In-Reply-To: <202606012339.rZAl6Xq8-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

I think powerpc really need to pick the tricks from other architectures
to make cmpxchg work on __bitwise fields.

On Mon, Jun 01, 2026 at 11:26:16PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-7.0/block
> head:   72f4d6fca699a1e35b39c5e5dacac2926d254135
> commit: b37fbce460ad60b0c4449c1c7566cf24f3016713 [19/138] blk-crypto: optimize bio splitting in blk_crypto_fallback_encrypt_bio
> config: powerpc64-randconfig-r111-20260601 (https://download.01.org/0day-ci/archive/20260601/202606012339.rZAl6Xq8-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 8.5.0
> sparse: v0.6.5-rc1
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260601/202606012339.rZAl6Xq8-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202606012339.rZAl6Xq8-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> block/blk-crypto-fallback.c:154:17: sparse: sparse: cast from restricted blk_status_t
> >> block/blk-crypto-fallback.c:154:17: sparse: sparse: cast from restricted blk_status_t
>    block/blk-crypto-fallback.c:154:17: sparse: sparse: cast to restricted blk_status_t
> 
> vim +154 block/blk-crypto-fallback.c
> 
>    143	
>    144	static void blk_crypto_fallback_encrypt_endio(struct bio *enc_bio)
>    145	{
>    146		struct bio *src_bio = enc_bio->bi_private;
>    147		int i;
>    148	
>    149		for (i = 0; i < enc_bio->bi_vcnt; i++)
>    150			mempool_free(enc_bio->bi_io_vec[i].bv_page,
>    151				     blk_crypto_bounce_page_pool);
>    152	
>    153		if (enc_bio->bi_status)
>  > 154			cmpxchg(&src_bio->bi_status, 0, enc_bio->bi_status);
>    155	
>    156		bio_put(enc_bio);
>    157		bio_endio(src_bio);
>    158	}
>    159	
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
---end quoted text---

