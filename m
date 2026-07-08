Return-Path: <linuxppc-dev+bounces-23814-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B63C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 10:52:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwFKt4mcVz308k;
	Wed, 08 Jul 2026 20:52:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783507954;
	cv=none; b=WnKhMtxGSjVspXjBrJNaX8WRqkm4Hdk7xncMXHAVWTv0Fs999SVYDCiZZPBr/Al3ReirLo/z0wFrrah1oMWSSdxB9N4IHFXO36IYis65qUIw9hGzAn5KvYGMztwikPxp59Ez+HAkYWeuTQQJpy6nQghFFIgR+Ne6r1iYgGohkxBsrClCiHHJ48P4uoD4uVIXL3n2i7IvihN64DehA38bMiQ6bodjOBit0ACzX3DTOiqXbmyg2OpDOS8xoL2WdYPrxk6peATuwBf+3432JH8EG6roW7IrpeVHZw20xVYITR/FVNBYefuDVy8i0WTyNGvVmvxf/ai54VDnvVQLJw3HgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783507954; c=relaxed/relaxed;
	bh=ojVZ4fwVtemMKlQ/Io+Qr09sI1H02IM4kIN49L9f5Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kb3yGOnL+cIarDrIZukYy1PW0+Ik8TCFDINgm98YOqGtzWjW7eA9k4vb/hQks3GSpCqadM4NP+IwS538vPNgaSqOA0qdrSnW8k63/aJp9fKYHGP/F5dPZDsc/eG3R6vdbnDOWKaRZ7p7gP91vM/0BHgqAX1JPG90cEwoa07poe5XQTw4F//uYgFekNg0PxXcJB5+Lg1che+u1S8bPBvXW031EOzEwn30c2JpqQhcZodK9Z/Sje5sI05mvWnLKm+bNl4qSSdyDrbbXXB2Llt7yMwRrS73sdZ5Yp7JtNCG4IclT2/o38QaEpRJLcVvQvS3L2lVWn+/pvd7TrrqoRkOdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SaNjhlur; dkim-atps=neutral; spf=pass (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SaNjhlur;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwFKq0pBlz308j
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 20:52:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783507952; x=1815043952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CyxJPLdFVSeuZ2RxzJTcc+hcmMlhX4OBVi0W+0ZwW10=;
  b=SaNjhlurp9rofcnqEXSUCqK/fN/XuMGU9WF1ujgQEMnndZvTeROAjgnX
   fAex2BaXozglXh43/+OhuS0kaJsTtENWqRKtBkjbxlGYeowAIvjDeZfbU
   KzuluPW5kFTaKVxsu1JBqVbunpx5UBqDrf05CaVSCNQo+b695DpAPqDEy
   553wwSb7bUKzsjlVsSaJ2WNEWg2GHcWd9MWxi2SZ62KS7nnxSkZRsg2cr
   6A3JhVoN9s+Wk8Lke7+rPe26Hi+rs+jCK9gSotB+tczLNRrq6WGTHCpt3
   aQMkqfXs0VvqreJkt5UtVToCR2XY2FRI0WYO2ewpZssJwiZeH++e7LPEp
   Q==;
X-CSE-ConnectionGUID: vWz+qmVcR5eXenxR13xgag==
X-CSE-MsgGUID: iaKkklpZQuyL5u8sWlvlFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84140617"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84140617"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 03:52:26 -0700
X-CSE-ConnectionGUID: g8YZV/AdS4WqXLiUz+5jSQ==
X-CSE-MsgGUID: Eie5xIutQQaxUySqp2ky5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="258561997"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 03:52:25 -0700
Date: Wed, 8 Jul 2026 13:52:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Erhard Furtner <erhard_f@mailbox.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel@vger.kernel.org
Subject: Re: test_bitmap fails on ppc/ppc64 on kernels v7.1.3, v7.2-rc2
Message-ID: <ak4r5uL8BX74H9ta@ashevche-desk.local>
References: <ca3547ae-8b79-43a2-a758-23ec980bfd9a@mailbox.org>
 <98d65de7-e5aa-4197-85bd-219eab01e572@kernel.org>
 <b9b762d0-cfe1-4fdb-b668-b6ef4afb0059@mailbox.org>
 <ak3_sGAnFxbmxfe8@ashevche-desk.local>
 <5430b52d-a072-41ea-ab56-9bb2f6f88849@kernel.org>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5430b52d-a072-41ea-ab56-9bb2f6f88849@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 08, 2026 at 09:51:34AM +0200, Christophe Leroy (CS GROUP) wrote:
> Le 08/07/2026 à 09:43, Andy Shevchenko a écrit :
> > On Wed, Jul 08, 2026 at 01:25:01AM +0200, Erhard Furtner wrote:

...

> > Oh, this is nice. So, there are two (more?) options I see to mitigate
> > the issue:
> > - carefully copy the garbage from the stack to the expected values
> >    (effectively merge the whatever is on stack with the expected value)
> > - allocate buffers on heap
> > 
> > The latter seems the easiest and right thing to do (since we can't really
> > predict if the stack pattern is the same or bitmap APIs scatters the bits
> > just on top of the respective set or clear ones over that pattern).
> > 
> > I will send a patch, thanks for the report and analysis!
> 
> The following change fixes the issue for me:

Indeed, I missed that and before seeing this message I also realised that this
is the probably best fix. Can you submit it as a formal patch, please?

> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 69813c10e6c0b..448c3eb48a4a8 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -392,6 +392,7 @@ static void __init test_bitmap_sg(void)
> 
>  	/* Scatter/gather relationship */
>  	bitmap_zero(bmap_tmp, 100);
> +	bitmap_zero(bmap_res, 100);
>  	bitmap_gather(bmap_tmp, bmap_scatter, sg_mask, nbits);
>  	bitmap_scatter(bmap_res, bmap_tmp, sg_mask, nbits);
>  	expect_eq_bitmap(bmap_scatter, bmap_res, 100);

-- 
With Best Regards,
Andy Shevchenko



