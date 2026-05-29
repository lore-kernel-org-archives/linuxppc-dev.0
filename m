Return-Path: <linuxppc-dev+bounces-21704-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C2CCD5BD2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 09:46:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRdlh5dLKz2yQH;
	Fri, 29 May 2026 19:46:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.171
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780047968;
	cv=none; b=gr63wRDsYuzbQmqE5ee4I1MY8oEYw1K0mOe46lMSd+ovaA1fIms86OdHOPd+1nqt3xMaiagatZ7agL0vuqZ1WV12b77zH8tloJ5DBLrLqt9T0e4wrGD6w+4rV4DKLTc6qCY3BdplSSftrvsHGH0RAc8Sb/Ca+a/DvdeJBx5i34WB/XWG86fFWbRGInTIEjHrj600pDn4Y6kt8uQHLoMVuhBC2DJ53exa0LkRZL7lEWIeUU/6SWEgbvcorSutwdjnt+lyqDxouOeS91Ie9hsJ8Lb4lsmJ7wvL6MRtLFvTjs7GvlM/HzZX+CDRSblZuzxCOk1wf2N/noulHcQSAE6g6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780047968; c=relaxed/relaxed;
	bh=KqewLC0ystRGSosSaah/vqaj9n4xXharr8XhrhW8ihA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhNEZzNpgf+2zqmkX88NoFevkdToeMR29zVkX4XE0pu/5ylfNkiwzmZ8+YTGnGa0JLyMgjhjqNgHN1fEM90hrXVyjMa6+KDo+jh0flj+HZg9ZerdIOendvdCFZ3+wJI/4x6V//xt0YKgfPpEsy1lTvwZkDxRCITiHFVS0ub2UeubJcAmkp3PLYjy/qhHHpp0/qkrkxatzjEVkroUL9TKQzXoIH/cLxftp6qtGbTsgfznQ//Z3AaA8NeXLmf7EO0oGU4ofoaKCjlSnMiy0ocwSKKvA6YOjee8nTw2+nXSOBfWv562B8//GbAN++M0UhiqOd+6shAebjZS2kU+0KYnQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=j7XkHKkX; dkim-atps=neutral; spf=pass (client-ip=95.215.58.171; helo=out-171.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=j7XkHKkX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.171; helo=out-171.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRdld0pvBz2xnZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 19:46:03 +1000 (AEST)
Date: Fri, 29 May 2026 11:45:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780047943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KqewLC0ystRGSosSaah/vqaj9n4xXharr8XhrhW8ihA=;
	b=j7XkHKkXDqP3CyTMA1KZEDRpB7pBfunZHt6k9/L7sTlm69r22PfVriJ2KulnEFmkO4c9RG
	w0E0XTpjREJx26RjzvvamglfkFX76kznc7szCyIKAE7vFk7GGatyNFHKM8l24CrvAOyEjM
	Afppq2eEp4ZzFAPHYhoUt2dSwQ1K/lE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/boot: remove unused min_t/max_t macros
Message-ID: <ahlgQZW7z7Ht4qpS@linux.dev>
References: <20260525091839.817778-3-thorsten.blum@linux.dev>
 <7c1a04f3-caa8-4200-a4ee-55cd2cc28461@kernel.org>
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
In-Reply-To: <7c1a04f3-caa8-4200-a4ee-55cd2cc28461@kernel.org>
X-Migadu-Flow: FLOW_OUT

Hi Christophe,

On Fri, May 29, 2026 at 11:10:20AM +0200, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 25/05/2026 à 11:18, Thorsten Blum a écrit :
> > The min_t() and max_t() macros are no longer used by the boot wrapper,
> > remove them.
> 
> Did you test your change ?

Yes, but with Gzip and not with XZ, and by grepping for min_t/max_t in
arch/powerpc/boot/. I (wrongly) assumed that arch/powerpc/boot/ is
self-contained.

Thanks for catching this, and please drop this patch for now as I wasn't
aware of the dependency to lib/xz/.

Thorsten

