Return-Path: <linuxppc-dev+bounces-4110-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6A5E7717D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Dec 2024 11:15:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8mwP5BBjz3bTR;
	Fri, 13 Dec 2024 22:15:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734088533;
	cv=none; b=G9YTWSq/uhqxsWYvfJfdLZjCEFTs5kva3Ch7da/Dr2bUegIe93+LR2cb6+ujTUUxZqsbXCyn7BmV0JHqOBhS3J1H8SbcclqPy64jnp6NQR2pK8OqSrfYHaVtVxQO07T1+JKGY+Ygfvj4oh3Z/Wy0A+7ZcKS/hK8XqflkhhMp3RqaO9ZdONHJ2gtw1ziGo+XRERul9hkysbRyFOLx1Eu37VZEcO1rhB/K7IA+IACYAVL/U2NYV0ik2a4aKhCKqui5YlmzHoRR9Wl2WhXipuoUsHYyFiKci7bauh9rmv/Z9FargXUxj1HGkvRDuxL+x1Hq6BV/2S72rKCgW1d3UOLzJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734088533; c=relaxed/relaxed;
	bh=UBueY58dUV8FoxPqlPdOtRsE2X7QVvRdN4+n13zlSX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmNoCEFsOUCJRAh1fabAbRhYqHVdNsydnJV1K3u8O4YAbGkThVf4R4rU/A+bmb5ZekIor/Te8cmk8Ik0Pgw8+pYiWBChViBIAEs3PGjXqNWcoGpN+Sc5sTdGhBHWJpcaU2c9VEhaodzey2atAYLobUgp+XHl58yz+UGzM27hDwjFtl5dJmOsuAwlI8bnoOZ1RY/4LAS50HvKqhpdbSpfyiTWXJfQoDcvILoI++a9LRnXdXxJAh7DTSW4w3CnzwxzcWZBUTFBOnQ/loxj5pf2alxn1fKGI4UfoPlxrVcYj+HSPI+kUKp9MVTjnzZ/cdQeIP+mrlPRo4OgIV3fb5peTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MoFAcTxU; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MoFAcTxU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8mwN5yxCz3bTM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2024 22:15:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 481265C4675;
	Fri, 13 Dec 2024 11:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB90C4CED0;
	Fri, 13 Dec 2024 11:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734088530;
	bh=BTlSxEGtHZYuTq7GAzKkcSl04qcfdN+0PqhmkCjEG9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MoFAcTxUm3bJTSh4WmQp1AqUGanXxrkwEhu8I2hNKlWwymLHHcB4/1R12KuSRg5Wn
	 A2OTXSOSYWGUfPYGJbvF2CZgDLoqR57wP4R5PGqznRJimxPRFLEEyTlgcAmn9VAWc3
	 0LRVW5lT26J8+nrY4AX6n1CY7XeDnu5S5hVfjVao=
Date: Fri, 13 Dec 2024 12:15:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: haixiao.yan.cn@eng.windriver.com
Cc: nathanl@linux.ibm.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
	paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	haixiao.yan.cn@windriver.com
Subject: Re: [PATCH] powerpc/rtas: Prevent Spectre v1 gadget construction in
 sys_rtas()
Message-ID: <2024121322-epileptic-feeble-75e8@gregkh>
References: <20241213034422.2916981-1-haixiao.yan.cn@eng.windriver.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213034422.2916981-1-haixiao.yan.cn@eng.windriver.com>

On Fri, Dec 13, 2024 at 11:44:22AM +0800, haixiao.yan.cn@eng.windriver.com wrote:
> From: Nathan Lynch <nathanl@linux.ibm.com>
> 
> [ Upstream commit 0974d03eb479384466d828d65637814bee6b26d7 ]
> 


Now deleted, please see:
        https://lore.kernel.org/r/2024121322-conjuror-gap-b542@gregkh
for what you all need to do, TOGETHER, to get this fixed and so that I
can accept patches from your company in the future.

thanks,

greg k-h

