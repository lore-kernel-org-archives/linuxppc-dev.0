Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B05C61D97
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Nov 2023 10:50:37 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ukaXY67t;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ScBbH658jz3dLq
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Nov 2023 21:50:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ukaXY67t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=naveen@kernel.org; receiver=lists.ozlabs.org)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ScBZM4w0Rz3cF1
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2023 21:49:47 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id B06E8B82E2D;
	Fri, 24 Nov 2023 10:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B61CC433C8;
	Fri, 24 Nov 2023 10:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700822980;
	bh=Mc9l/5qZx3bV28JGcUnLYVVjoTZuZuF9T+H/zZcHzMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ukaXY67tGkx/8zHjU4DC+fhiFlh+ET7h7GK0Gk0fzsmcvmM5zryBddrBk6Vv4eeEE
	 mUraTzWt5RFWyOzgrMoIQhI8EIdpArbwYOIBqtyXbPlqeumF58p9sAI4IgluV20Kvs
	 mAPyavsCQbBPsRFxsY2/cet7/CG4CZi5ErInRBV4jcstYhe94Df4xtu+2m3IPPlOs9
	 CdfavfQphaqVAvCFc1a9uzmKZ1jv0WAe/Jx7fbGJq8sLMiFvzsWre5h+j50+VOLhcG
	 nonxU8JcGNdkQq2cghzYNLMqjPIu5u7MvAd31+848dKrXH9SB39LMYOSaRLBrLW56g
	 D6ih4cLWVCi6w==
Date: Fri, 24 Nov 2023 16:12:37 +0530
From: Naveen N Rao <naveen@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] powerpc/lib: Avoid array bounds warnings in vec ops
Message-ID: <x6av7lho6n7hnmspc7e4o2pacd64jru2kfb3wqmet3jug4x4v6@7hjo7eu2pfsr>
References: <20231120235436.1569255-1-mpe@ellerman.id.au>
 <i4zq3tg6gwaptnuoq2ainowffvkols2k5x7rads473zn55r27y@cvdy5yvkmj2p>
 <87pm02jt2g.fsf@mail.lhotse>
 <ab6uj2olygi3edqkjn73kfxvx6igtxotkp3m35j4ikn3ztm2eg@ixkpj2f47ri2>
 <c7fb16c0-ce17-465e-8624-2ee39b545a11@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7fb16c0-ce17-465e-8624-2ee39b545a11@embeddedor.com>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 23, 2023 at 09:17:54AM -0600, Gustavo A. R. Silva wrote:
> 
> > > To be honest I don't know how paranoid we want to get, we could end up
> > > putting WARN's all over the kernel :)
> > > 
> > > In this case I guess if the size is too large we overflow the buffer on
> > > the kernel stack, so we should at least check the size.
> > > 
> > > But does it need a WARN? I'm not sure. If we had a case that was passing
> > > a out-of-bound size hopefully we would notice in testing? :)
> > 
> > You're right, a simpler check should suffice. I will send an updated
> > patch.
> 
> This[1] patch indeed also makes those -Wstringop-overflow warnings go away. :)
> 
> I'm not subscribed to the list but here are my
> 
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Build-tested-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks for testing. I intended my patch to go atop Michael's patch since 
do_fp_load()/do_fp_store() also clamp down the size passed to 
do_byte_reverse(). While the use of min() isn't strictly necessary with 
the added check for 'size' at the beginning of the function, it doesn't 
hurt to have it and Michael's patch does have a better description for 
the change :)


- Naveen

