Return-Path: <linuxppc-dev+bounces-13411-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A535BCCF9E5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Oct 2025 00:59:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwX8c1nGMz3fnn;
	Tue, 28 Oct 2025 11:59:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:a000:7:0:5054:ff:fe1c:15ff"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761613184;
	cv=none; b=J6UwMfGW06Fo9nTs+KcYD1JU9hbgIgC62f7HfXPEZZOFpA1k11naGTEPsyY5GpFLDAoFmilwbw2n3xhrMylEFOewuqBmiQX+dGK+SIU0V6WV8lExC6fap81VOPJw/1FJ03gf4tLIkrHZ/K/pPhxrIDUu1dQhqJ0XAsA/l7VY3rP/YxOFeh0k4gaPdP5Nq6pwXu/0w39AhuxE3J3c353uoNa0r7USG/Z+33uAZLvCduEhS0uV7d4DIzmmhcVRxFi0sMuUh93vvNkkRjGQQJEpPgcK5dgwCXz7BFMddGy+BS54e3FRiOS5SvpwxHAUZvuehk62TFnoPiSc9+WVxVjjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761613184; c=relaxed/relaxed;
	bh=9wyoIZYTrVDDO7g+99sSfbwUrHDKLElCNrsKfYNRevE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LthndCtqDgzxVGrDONs6j8c/kJs3PNrrf9dCHKmzxlSyQjSy2Le2lmPs3HAcwAcfAQIRXR6Vd1Swvngd81fbMCdvFTpfqWmExZ2Wkf47r7ZR27Ztdz1ZfRDbrXl5cbXWHbDdO0w22OkF9PZsGa83nrHomGPJURFIeE7t6V4XvjYNSAWiUT0XmklMo+bi4qnlEFFoAL+04tmnywIHstyUhu+GvJbb5bkx5iotC58/ouRpN4E09D74zPaPd2AByrOvmqo1Ksw8MaCuHdzy12BJLMRksJCewU3OfiZL76vlsxU18OV7ml6+JtbECJYCToM+G/+O+nLiL7W67b99K57h1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=bYrDOiVt; dkim-atps=neutral; spf=none (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=bYrDOiVt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwX8b3lWvz3fnl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2025 11:59:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9wyoIZYTrVDDO7g+99sSfbwUrHDKLElCNrsKfYNRevE=; b=bYrDOiVtr9EnBCfWeyaRKsN0Rf
	zO8thzgRBHKXhYx/oORvEyK4vY6Lh/KF4IU6ZB+15g7s1PWyfACnJ8ZUB6uKhzi/ywkiIYACjMEUA
	fOg/T6QctXpDZBgXPrUjGIXpN74nbg7sXP6WMlKmHnvhs7IHmvDQ4fSsxsB2yNVu5WDBqRWQs/4mu
	VqLVY7LfZpSLOBTqqDWt3Dj48aR9TI4boH4iE7d+iH4XNY+K7frisMFDEpM2MGAIVw+TcCyv2B6mW
	kN/vCpaOPX8rpp+QhOzxzUmHJjhY2L3aZJAJ7ZO/UnNOyL+2oM21W4iRjm1spaIvxuG664KGPM+x2
	2gK54TvA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDY3h-00000001wen-1zTr;
	Tue, 28 Oct 2025 00:59:33 +0000
Date: Tue, 28 Oct 2025 00:59:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name,
	a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, paul@paul-moore.com,
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org,
	john.johansen@canonical.com, selinux@vger.kernel.org,
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Subject: Re: [PATCH v2 00/50] tree-in-dcache stuff
Message-ID: <20251028005933.GK2441659@ZenIV>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
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
In-Reply-To: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 28, 2025 at 12:45:19AM +0000, Al Viro wrote:

> Compared to v[1/50] 

*blink*

That should've been "Compared to v1:"...

