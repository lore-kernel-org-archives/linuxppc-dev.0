Return-Path: <linuxppc-dev+bounces-7967-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0A1C369AB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Apr 2025 18:24:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zk4Bm2Nfwz2yfx;
	Fri, 25 Apr 2025 04:24:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745519088;
	cv=none; b=QoZgPiMOH203UXdzN8OyBKWS0o9WXIg49bLY1qOYXq3u9950Ivzj1yOkYJUpmqvBRmNXK3LUf7kqe6/ipHm/13cVHzhET2O7L2rldkOeDZk9P2LFdBuVOOG4SXnLmfGOn4xw8B4XP1l5keZgR0Y7hhGOwQCRqv9d7ESCtgqBuTkudsCAq3zWm1RAS2h+k1KzckpfZehN5vPCq4e1LipmuAvk1otjUQj/7zc/mEYhuZx0BX/PCSxgyFErSub9ofly1WwGckkyZGPoNnWVNCeb8CGCNcp3Gt9xqkxF4zxioF9dvI3rSsXWMOr9YHqlRnwPhLnAnJOper0Wm4WkMQNJjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745519088; c=relaxed/relaxed;
	bh=p4U3uALqk5y71eHmVnVQKvx8S0c7/96/WIaObqvlG1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQTdteQDVXwtw0/OvsXUeeskELtoJtMdZgzwYi2nxU8++v9TcupmAuDlUnpoLH+tCwR/GDtNYJ65cCH8nFj3Bp9/DGPu/zFajshicltckI5sIrjZqeSwm45J7EM94J93WiNzwoifbJAgZVmdcJkwavT/BB2t6rpDOLxT0PD1D1HjhoQXkeDWjA8k8vm8zw8L/JipWaGwwKxeGgUrwFEhPsDU9zEg0DBPnFjzm4vnLvTxope1/fAPPLdjtkrl0k3v9ERb8E3b1k5fYNwHqDSYe262kL8K2lTj4Vc1AIZDg+wEwFaMWQAvTjkMGIkHh9W2g3oQZO4Jf3mLzgqwnFmdtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=O7+l4knV; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=acme@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=O7+l4knV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=acme@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zk4Bl5GPpz2yfv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Apr 2025 04:24:47 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AC731A4D09C;
	Thu, 24 Apr 2025 18:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A468C4CEE4;
	Thu, 24 Apr 2025 18:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745519085;
	bh=hyzkbqm4sOKiWO4qVvYP5wrpHM6flBsX96BDqcDu9ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7+l4knVZMuO5EKllmReVAf/jHDAe92qQlKUZj6hshrvM89nnakdcdprqxxxKoGhu
	 4nU7c46nLBxkPen96L6zsh0tYzm4EOc76pxDKZ6c62HbXzExa+Jauly2dn2hvjsvaq
	 Xt9vqqCR98yzX5qT5uyfOqIEs4DlDVHndlkHNoq6cUjUQkn8aIHbQ+4Uk6Bo7vfAe4
	 TP9DClPCOVthqnQq3wUnI/EIiyfgZbFqFqXQw8AzdtsNtRC4mZo6J/ZAi8syh4P1Ro
	 c60Vknckkyh7josYX/29ckOfvE/ClBtEGeMuMPpbskjsrnN+QVljsbDJtdFCs3NuDe
	 UBpTvfi0BDRsA==
Date: Thu, 24 Apr 2025 15:24:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, jolsa@kernel.org,
	adrian.hunter@intel.com, irogers@google.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com, disgoel@linux.vnet.ibm.com,
	hbathini@linux.vnet.ibm.com, Aditya.Bodkhe1@ibm.com,
	jiang.peng9@zte.com.cn, Tejas.Manhas1@ibm.com,
	sshegde@linux.ibm.com, sfr@canb.auug.org.au,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	ravi.bangoria@amd.com, bp@alien8.de
Subject: Re: [PATCH] perf build: Add tools/arch/x86/include/asm/amd/ibs.h to
 sync the headers
Message-ID: <aAqB6kI5mDp4bxY9@x1>
References: <20250424163033.6601-1-atrajeev@linux.ibm.com>
 <16bee348-2b41-4337-85c8-8a6d2719e99b@linux.ibm.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16bee348-2b41-4337-85c8-8a6d2719e99b@linux.ibm.com>

On Thu, Apr 24, 2025 at 10:39:56PM +0530, Venkat Rao Bagalkote wrote:
> On 24/04/25 10:00 pm, Athira Rajeev wrote:
> Tested this patch by applying on tip HEAD:
> 7ab869c799fc0fb22f9b4c2f36aaa603d9c7cc9d and it fixes the reported issue.

This is just a long list of characters, can you please next time provide
something like, humm, tip/head, not really:

⬢ [acme@toolbx perf-tools-next]$ git remote -v | grep tip
tip	https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git (fetch)
tip	https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git (push)
⬢ [acme@toolbx perf-tools-next]$ git remote update tip 
Fetching tip
⬢ [acme@toolbx perf-tools-next]$ git show 7ab869c799fc0fb22f9b4c2f36aaa603d9c7cc9d
fatal: bad object 7ab869c799fc0fb22f9b4c2f36aaa603d9c7cc9d
⬢ [acme@toolbx perf-tools-next]$

So please add the summary, that way we can try to figure out if this is
a rebase and they look for the description instead of this sha1 that I'm
not finding even after doing a 'git remore update tip'.
 
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Thanks,

- Arnaldo

