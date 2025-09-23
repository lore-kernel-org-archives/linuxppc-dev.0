Return-Path: <linuxppc-dev+bounces-12533-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EDDCAC5A5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Sep 2025 08:10:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cWCN90FbHz2xck;
	Tue, 23 Sep 2025 18:10:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758615048;
	cv=none; b=SLEBXqN1BjQHa32PnU0hPJ7sblAo43EX9zVy1aGX2MGI1gBp4UHkSVP39yIY6ekJXj6K4hPT2Lj36WiqLDIIxOU2cPbOxnhYmDd963XXlzButpJuT19qXUJhADaeutXBWBVR8+dhmEp3TDi08/HbNKzB1vL6frAzJMdAQTrJkB42kSoWPwKOx4LHoDurKvnqSCZCoIrZXosWPkz6mzGaND7bma5FemOMT3B1UZUXm569KPp+4PDRYRrOTsza4T9P5vcmYE6XB2L0NIITLflDPcbEKH+X9yekegT2Z2U02SQDkXHImSymSjRnMaXgqwmrXV2GvSlHuL4Lt8JTBEOHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758615048; c=relaxed/relaxed;
	bh=ZwGSVkJMg/pC0iQ+cr7Qd3UuY5+roZiwC+AuRSFpduI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxl942zZGH4SD25htc98SDj+FW2MDRdWmI4sxFgE9X3NRg20CVsntzyN2yCmqxeBumtEa/5QyVmezOvaaediIpHK0SXJXKaR5TBQt4nj9k0HX0VHOzgExDDUFEg18JKulXgQuTcvxJDeaoQxFJWOCPAX0qbi4NKvM0G02s46ykDplDLWF4/Vm/zY904bTisPOzy95hHlbtLgsjiWgWX0mDCP/C3Z70HKW/h4UztgSIh25JxJpBObAIB2AY7PUzbxITMba+5L9j+zLOS2chKiO+hvTTH8EerCNwGDfT9P66oeYpj+baooBV4ynv1Rx44oHmXnJRULTRz9Nx+PRXw9bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CUu1lvbZ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CUu1lvbZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cWCN76l6wz2xQ5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2025 18:10:47 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3FE0A6027C;
	Tue, 23 Sep 2025 08:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF88C4CEF5;
	Tue, 23 Sep 2025 08:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758615044;
	bh=iW3WPoagLwoxw6Vm11W1B8DLUUbl+cSm5INVhgNbxS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CUu1lvbZ9Vi1eiQbP9TyKCBWnxSO+wgYt1w5dZjQNLBYdyQNp1x8oj13nSFHO0dgh
	 sjOnfLjfTdgRefJ7Ti7MyNKmVPU7anyFQuO3d/EvN39oDlbBs+7nY2MgKdB0As76IL
	 NzTQk5WZKpQpx4s86jlO4XYnqAhAVOnyTfn93l2U=
Date: Tue, 23 Sep 2025 10:10:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	brauner@kernel.org, jack@suse.cz, raven@themaw.net,
	miklos@szeredi.hu, a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, borntraeger@linux.ibm.com
Subject: Re: [PATCH 19/39] debugfs: remove duplicate checks in callers of
 start_creating()
Message-ID: <2025092331-magnolia-educated-cd0f@gregkh>
References: <20250920074156.GK39973@ZenIV>
 <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
 <20250920074759.3564072-19-viro@zeniv.linux.org.uk>
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
In-Reply-To: <20250920074759.3564072-19-viro@zeniv.linux.org.uk>

On Sat, Sep 20, 2025 at 08:47:38AM +0100, Al Viro wrote:
> we'd already verified that DEBUGFS_ALLOW_API was there in
> start_creating() - it would've failed otherwise
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/debugfs/inode.c | 15 ---------------
>  1 file changed, 15 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

