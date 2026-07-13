Return-Path: <linuxppc-dev+bounces-24105-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637BEC44501
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 09:03:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzGgD0jWDz2yMm;
	Mon, 13 Jul 2026 19:03:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783933384;
	cv=none; b=T37z1IgsxcbgicoNQaqG7lrcXQlbHmRF/fOL1UlDeBX1MFpIOA4heGwFGbb0WhC21Vf45fFU0ab/Xe6NOHQk2QqGq/Co4J0eLUkjCp5dt+Ux0wNkh+ugYlmuFooph+7u5HiVnQXPCy0lM0L4cB5DmriUiY+79KDYTuAjCWvsZEkRK/1eIXKR3eNn1qZGmRLRrd1m4FxFHdP1w+Z7/quB8b2Jede9BrEtyo8SfhnAO7DsOeXM+peypeHwpgML+mmYr+rpL4MZsDsTMAV1msYzMONC6+gLx47vSoiZaibiFZ0HAmcu97K0zhUO6bAMjARMNWXJLw0dI3mVOscvi5e+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783933384; c=relaxed/relaxed;
	bh=uY1+6zKnm0ARhtZsH7l5IzaCBkmhtObZOzg1HXZhMHs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaRMZ2RIWFijJ6t4mLKHVC4hHLLp/kDqp8+VvL2tPgBB+LXGwxNFgpNfsJxwaUfxZk6XVpiEyCVVq9A0gh5Ao5rWy3oJslr0c0xkL9vfCnActsvhIcWwjD9FwdwONFGjN7S/V6A6tzds7Omwxu1Co5yzKztefj/gd4h23mN7X2D8pIJ4YHHA15buI/Gdf7cB8hdiZl0Tz1X5NVJWBNo1qoe9lwncJiI3uYVrcEKPYZRku1qMdyJ8NsKgywFuw8I70g0xAUuZwBe7WAzvMHE3doK7vn4DUz/6OFt4ln3iVGa5K3+ZeBNm9SIrBFdm03Wup7Q06T6t82jpw9K3EWccNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ElRy5naM; dkim-atps=neutral; spf=pass (client-ip=95.215.58.187; helo=out-187.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ElRy5naM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.187; helo=out-187.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzGg71s9lz2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 19:02:57 +1000 (AEST)
Date: Mon, 13 Jul 2026 11:02:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783933356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uY1+6zKnm0ARhtZsH7l5IzaCBkmhtObZOzg1HXZhMHs=;
	b=ElRy5naMRQNjss5+AFd8wI8IVcJUp7Cjm7HttQULJ3v5tiRz6jFJWtQJOtjfgRGaCGfpPK
	PcBGrjhsp1ajgiA64Vsw6f70/l3S5ehSppnMNJRmJlB2xap1mtPxoDANdagdvS3VrtJe3Z
	LTFRaAE8IwP8hiCtQsUQCbXrzUqDzCY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Remove unused struct table in setup_areas()
Message-ID: <alSppS3b9IzhlUIs@linux.dev>
References: <20260712151300.3664-3-thorsten.blum@linux.dev>
 <20260713134356.62f55781-f6-amachhiw@linux.ibm.com>
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
In-Reply-To: <20260713134356.62f55781-f6-amachhiw@linux.ibm.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 13, 2026 at 01:59:02PM +0530, Amit Machhiwal wrote:
> On 2026/07/12 05:13 PM, Thorsten Blum wrote:
> > The local table structure is not used - remove it.
> > 
> > Remove % in the comment while at it.
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  arch/powerpc/platforms/ps3/spu.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
> > index e817def7f424..c904f9fa1caa 100644
> > --- a/arch/powerpc/platforms/ps3/spu.c
> > +++ b/arch/powerpc/platforms/ps3/spu.c
> > @@ -185,13 +185,11 @@ static void spu_unmap(struct spu *spu)
> >   * The current HV requires the spu shadow regs to be mapped with the
> >   * PTE page protection bits set as read-only.
> >   *
> > - * Returns: %0 on success or -errno on error.
> > + * Returns: 0 on success or -errno on error.
> 
> The % prefix should actually be kept here I think. Per the kernel-doc
> documentation [1]:
> 
>   %CONST
>   Name of a constant. (No cross-referencing, just formatting.)
>   
>   Examples:
>   
>   %0    %NULL    %-1    %-EFAULT    %-EINVAL    %-ENOMEM
> 
> So %0 is valid and intentional kernel-doc markup that renders the
> constant 0 with proper formatting.

Interesting - not sure I have seen this style before and plain 0 seems
to be far more common. There has been some discussion around it here:
https://lore.kernel.org/all/87ilamz4j5.fsf@meer.lwn.net/

I guess I'll send a v2 without the %0 change.

Thanks,
Thorsten

