Return-Path: <linuxppc-dev+bounces-17075-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396FCEC1128
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Feb 2026 19:54:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKWl84RXMz3bhq;
	Tue, 24 Feb 2026 06:54:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771876452;
	cv=none; b=LWyFaLzBnGWzTYrwUfvFNZSvxuc5xh0nRrBLqmktn3OD67UD1G83D4STIR93+PDhJV3FxCgf/1k69sfJ1bjZEOZs8hDIqGq6B71+qPmTSBAbOH3MpFUsnscTZt5sZkE7qTmVtQQqVdvikK8+kT5gCguBI0yguJ6KeclYHMVP3zHTBASS/UzGmLWCExPCrYZmqHkHAbxdTRS69VCELZrl/hXuoUKpL/3cnGGXysZGdcFQaLvvVlSkCDdQ08eJJYjdhGOYjXcK1X5z0u7Ku9VzUmmcTAxafNb5bWNXqnoNIddxqLCX/b4HLS2dtFl/T3M6SbC5kpje8iCtqiLnOyc70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771876452; c=relaxed/relaxed;
	bh=gikYi5WdMnS1kxzGiRr9SJf47bgLwIbpn3cHxQpbYhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCbruzKZzRmYM+U1cWDiVO6OZpSLOAvbOTaeP4nqBVWv9uZhcUHZWK+dc1xwfBhVZKxjLIt8DKvRyqY3EBXOnJom+SE7+NMsK9J1vISrD+zqCQAhAxO0qI4zPV30Sv8YvK3dc4t/dF+hyFrzwOF1tXSs7v7ZqoR0dahL2NOpImwIofE5fj6yCUa6KZUi0gnv3FUMyfw0CUN3lRVIDK9jndcRHCCkcX3Ga/nB+AA7KXBzKtkVX/iTtMP0Tl8ltcmKXNeG2ThTtAFzSFSghKuK7hsBzsl1ZKkKUCYbG2H4CQXTTUuMKb0TCk2JsZRFlBSlAb+Gl/myhsq8r1KvOdEXwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MmDP5cNh; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MmDP5cNh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKWl73hDlz3bfG
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2026 06:54:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5C34743F72;
	Mon, 23 Feb 2026 19:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E64C116C6;
	Mon, 23 Feb 2026 19:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771876449;
	bh=IYbIDZYsILBSeSQzfO40gPohBY+fqV/kQRQlYXa7IoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MmDP5cNhzbQtzpC+srXO430Dbat9Mm+n1IVynUOOwTNAN2EOu6rHF/ksoeUwGnzKq
	 4hYJfbbs1uIC+MyTym2aydZMKvG6Dc57S5u7xZT/YLijukZM1yltiiAPCi5mTLgdAj
	 zwrwtLjigi9QBJTy7sql9R5wLPJL/fmwGXiAaXmQHWB3BoccUmALsCkI8ZQgNWJg5J
	 C3PbUuTJmHOqXdEJfIRElOGaREATOBk0Q10CVVySmcheIBM1I+qoVivhFl0vBiu8U/
	 s2I8Wlb9ZmJ86lzGcX8w7hPcmrgLTcI2oQrhVXrUuKEDlYki0+xy7OBti7Ic8YxjCr
	 HdMNjpyNlqc0A==
Date: Mon, 23 Feb 2026 19:54:04 +0000
From: Simon Horman <horms@kernel.org>
To: Abhilekh Deka <abhindeka@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/ibmveth: fix typo in
 ibmveth_remove_buffer_from_pool()
Message-ID: <aZywXPt0X-gnNuRe@horms.kernel.org>
References: <20260222054117.14943-1-abhindeka@gmail.com>
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
In-Reply-To: <20260222054117.14943-1-abhindeka@gmail.com>

On Sun, Feb 22, 2026 at 11:11:17AM +0530, Abhilekh Deka wrote:
> Correct a typo in ibmveth_remove_buffer_from_pool()
> where gro_receive is misspelled in a comment.
> 
> Signed-off-by: Abhilekh Deka <abhindeka@gmail.com>

Hi,

Codespell notes that Partition is misspelt as Parttion in
the same file. Could you consider sending a v2 that fixes that too?

...

