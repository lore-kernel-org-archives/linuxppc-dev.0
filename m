Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3421DC25B75
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 May 2024 06:10:04 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Wh4HNVq/;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VrCQL3FB0z30Vf
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 May 2024 16:10:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Wh4HNVq/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VrCPR2mCjz3bsR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2024 16:09:15 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A71E4CE1BE2;
	Fri, 31 May 2024 06:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9F0C116B1;
	Fri, 31 May 2024 06:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717135747;
	bh=FOgJ1nWsKY1HqqT5AsZjlUD928VwEjzdZ/ngER5Sxw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wh4HNVq/hiDTRYMJ7bdDbK4wcdDKh5OdWZzZKmevW5FqZHmWt+UmItoGmFWdGou18
	 bB4W9jm5tlsSkdLcpiBaZaV6HjMjtZ53NJz0uy23NZ4diJELXYAOK4qG2s9SLWKdAv
	 iUjeNCwevnjTI/8qrjAspMgMC1zhF+nCoiOZPqHc=
Date: Fri, 31 May 2024 08:09:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH] arch/powerpc/kvm: Fix doorbell emulation by adding DPDES
 support
Message-ID: <2024053143-wanted-legible-ca3f@gregkh>
References: <20240522082838.121769-1-gautam@linux.ibm.com>
 <rrsuqfqugrdowhws2f7ug7pzvimzkepx3g2cp36ijx2zhzokee@eitrr6vxp75w>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rrsuqfqugrdowhws2f7ug7pzvimzkepx3g2cp36ijx2zhzokee@eitrr6vxp75w>
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
Cc: kvm@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, naveen.n.rao@linux.ibm.com, stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, May 31, 2024 at 10:54:58AM +0530, Gautam Menghani wrote:
> Hello,
> 
> Please review this patch and let me know if any changes are needed.

There already was review comments on it, why ignore them?
