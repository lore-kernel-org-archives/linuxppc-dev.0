Return-Path: <linuxppc-dev+bounces-18473-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E14D1093170
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 03:18:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcST509TWz2xm5;
	Fri, 20 Mar 2026 14:18:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773976728;
	cv=none; b=ZJrhQ87bNrzE9JRR6Q7K4DClIZ2k8hKqTtOfW0oiKbgHrLhBdCb8xcfscKNDGxKbvF/ys2hysC8CuEksdBhDn6uZkg9wJvDYptk1x5BKSYNf/kyDEiPVH024Ud7dJ75zfG4gsqknX5PmbG+aG/tkvrsTJcBnWGfOdEZ/Vm9DQaHXqRK9NvsdKtOu+FwCPPC+2/GxDbdkQOTxvwU1x6G4G9xD12El7GEYkjeWy6TxYtRiiFhcpLkgx3KDcAaj3f3L/N++PRDFyi20dsfEfv8Uvr4od1PcuiDHArDejlfsT+oQtLyjdLE6kW0HGRsYxG8XgXEUQgHZDpzOs7RCXZtuxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773976728; c=relaxed/relaxed;
	bh=/HzAyuv1cR2aPHHtMvh1o2+bWKgmUnvOcDh+3uBWmXE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nnrpv4BjYvtex7Yn0bmfeOEGJeYltu2gt4KTLzkPEEeGaw9fDQvXJ8QXI3Vhxz5DpKQDX/YV3wcy+Qlz0EoJRgqNz8t2e3oQTUyS8X3caU2oOXFPfszy4pSkm0AoYajd2mPZT5uiySdlXFj68WXwWEoDxsyK/x6bEH6Zag7iV0C7QSFc98/FrW/Id24+7rbDtA/9Nl6BsUrlj9E8kiXZcAEkML0QJcelC6SqZYMVUYAcvWkiAYh3J7nLJYo3lqG9kgx0FuBwZk9yycLz1Raky4Q8hhFLA4KWqZXzjPS73DMnbrkllYd4oG3GPt3Xj4hiEb8mXSEwjjQgR7U3W5l4Fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=XCGRZxSu; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=XCGRZxSu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcST018Dpz2xN2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 14:18:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EB74B4358E;
	Fri, 20 Mar 2026 03:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A21BC19424;
	Fri, 20 Mar 2026 03:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773976720;
	bh=RnWaFWKleytYk2xnMbn6rVyzIPDB56jqJgJOybkNp58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XCGRZxSuX7NB0ciVsWAd9qvBv9OyQ8YLbS1a+8P3iOs92SF02WGeSPOmDhHZYN8k3
	 2ERRZEycezU/gQTEFoNqad93hDeICz1JmYWv2WgOP9VeqK4G40VWziMGpyao6ozqpE
	 +lt/ohK+PFKlyJD2wClCMFCru8H2uNJzFHowMP6w=
Date: Thu, 19 Mar 2026 20:18:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: david@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org (open),
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] change young flag check functions to return bool
Message-Id: <20260319201839.2dfa704041b8f13d8dbbfd3b@linux-foundation.org>
In-Reply-To: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Mar 2026 11:23:59 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> This is a cleanup patchset to change all young flag check functions to
> return bool, as discussed with David in the previous thread[1]. Since
> callers only care about whether the young flag was set, returning bool
> makes the intention clearer. No functional changes intended.

One observation from Sashiko.  Minorish, worth addressing:
	https://sashiko.dev/#/patchset/cover.1773890510.git.baolin.wang%40linux.alibaba.com

