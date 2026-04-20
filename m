Return-Path: <linuxppc-dev+bounces-19847-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFA0F557F8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2026 09:44:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzgYq2vCtz2yqT;
	Mon, 20 Apr 2026 19:44:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776678271;
	cv=none; b=OnKCwPdhK4udmgjX/i+SrTUfJUHab8NEtyRyYs5soM9ASEzSa7aqPcQ8btIWt+H47FszYPTOmOeK4JGbBQ1o7CjyY3IXJHZ2ip+huivvwr1qyHDzF9Axms0iMALXc3AjhmDWNS1btq16A3KPwxQbDPPzVF4kwfqTLTaDnJB7rcqLk4c5SEYL5dBNiXe7E+Mis0sjnO67uiPSVIQ2U4YGDN4NKfo+R2J4roj2wc5h3TfevP7xvCVa7iSIArgyrnd8bz9ciIG6W7Ny7r8KqDhL8D55DBEiXHfsqURFO/HJDsleh8ELQB/I6iLhuINTB33v63B9hm+LgEA90HDmMV16ig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776678271; c=relaxed/relaxed;
	bh=hd7TGTt0cqbghqHMxHsJzLIh7KbXXHCIVomHjKuP7KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/CCEbhmLPwPSHXvgC8p7M+Pgyv1Q+t5fBd/2QmVT/1OXMPUxUROnHmrx4RvmyhZHTkgh9yYaPmurnXbucyQYQghnBVos7thJAX9+g4TWiqDrHgkfDwGeScljiyji0mJdJ6WiLlJQrvtAtRcKIUOsjGfb3+VziqgX58HkhXsLNZL8CqVoumkGa68LjnY4Ba6VzfYeha2fbf4J/QV0Z7M5e4YJ9XQeCouJjlnXJLdV3791Kibybs3P0PBGr16LgtzLQagTmUFnYnamoDclB0AEMyJaEgBcbXNfCKvXEB+1jQWK9OAdEhh2sL7JSiQBgj8Y3IfmAz4b1Qc0z0ZogwyiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=On12/JsX; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=On12/JsX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fzgYp1VnGz2ynn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2026 19:44:29 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 58CDA440EF;
	Mon, 20 Apr 2026 09:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F6FC19425;
	Mon, 20 Apr 2026 09:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776678267;
	bh=orVQQAkokr/ZgckLno97Wt1TCs0NqYT9zlpZ/LTDeX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=On12/JsX+i3fpguYVx+6aKWBA0+2Scgbv6LSEOxAV+u2KOK1nNpbXBsMoySfGYkvj
	 CPuuFEe3gLujpHyyHjFkL5v+2gImBBbvR5ri2bfaogKzIIM/zaH+Z/Fa4hX3OtM0Yj
	 LXhC4vzROD0sD1jJuTMJB1fp64nZV7y3YkOI/bGk=
Date: Mon, 20 Apr 2026 11:44:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries/papr-hvpipe: fix NULL dereference in
 handle creation
Message-ID: <2026042009-lesser-refrain-c154@gregkh>
References: <20260420093856.123681-1-lgs201920130244@gmail.com>
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
In-Reply-To: <20260420093856.123681-1-lgs201920130244@gmail.com>

On Mon, Apr 20, 2026 at 05:38:56PM +0800, Guangshuo Li wrote:
> papr_hvpipe_dev_create_handle() transfers ownership of src_info with
> retain_and_null_ptr(src_info) after anon_inode_getfile() succeeds.
> However, retain_and_null_ptr() clears src_info immediately, and the
> function then still dereferences src_info in the subsequent list_add().
> 
> Store the transferred pointer in a separate variable and use that for
> the list insertion.
> 
> Manually identified during code review.
> 
> Fixes: 6d3789d347a7af5c4b0b2da3af47b8d9da607ab2 ("papr-hvpipe: convert papr_hvpipe_dev_create_handle() to FD_PREPARE()")

Please use the proper notation here, as the documentation asks you to.

thanks,

greg k-h

