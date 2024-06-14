Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6274BC27C6E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Jun 2024 08:46:40 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FjKRjeO/;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W0tDZ1P83z3cYM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Jun 2024 18:46:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FjKRjeO/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W0tCn3Hx7z30VM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2024 18:45:56 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 44880CE2995;
	Fri, 14 Jun 2024 08:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D355C2BD10;
	Fri, 14 Jun 2024 08:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718354750;
	bh=GKdxUhUXcDfYN3jYPCUX/pOROt6SaxRLTeslIUh2VrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FjKRjeO/WPyO7cpdvMcjMHK8Ko20hHPMj03iXXYsncckVkJjXyEinIoNaXPVHN1yU
	 /LRAqeGJFOErqLHh7tU/0hnVMS/qqaoL+oAn8f44q3nliKrXr0Tc0EkRcvqFpUwbny
	 LtunLNuq/5Mq9/GxQyIkp5GnpdSdrwCI/brDszXQ=
Date: Fri, 14 Jun 2024 10:45:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Please backport 2d43cc701b96 to v6.9 and v6.6
Message-ID: <2024061411-hypertext-saline-afb4@gregkh>
References: <87wmmsnelx.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmmsnelx.fsf@mail.lhotse>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jun 14, 2024 at 05:54:50PM +1000, Michael Ellerman wrote:
> Hi stable team,
> 
> Can you please backport:
>   2d43cc701b96 ("powerpc/uaccess: Fix build errors seen with GCC 13/14")
> 
> To v6.9 and v6.6.
> 
> It was marked for backporting, but hasn't been picked up AFAICS. I'm not
> sure if it clashed with the asm_goto_output changes or something. But it
> backports cleanly to the current stable branches.

It's still in my "to get to queue" along with about 150+ other patches
that were tagged for stable inclusion.  It's in good company, I'll get
to it after this current round of -rc releases is out.

thanks,

greg k-h
