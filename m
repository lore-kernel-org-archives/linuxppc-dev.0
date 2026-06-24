Return-Path: <linuxppc-dev+bounces-22966-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB03ECDB479
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2026 20:34:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gltvk5KLKz2xl6;
	Thu, 25 Jun 2026 06:34:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782333266;
	cv=none; b=VIecroz0jsSpELNu15oEILrVLYiN6X3bU9aVYTCH/oBeIbaqw1GTl9Ixwxs8W52GtT5LpD8fmWDXZAtNaN6wA2Udgm5IZyKIT+TJw2BHLQpwkQIOeJ9uQr59N1l44OTh0VSJJLVUhLUq3W8g5TC7HXKV50xoQZEe8Krw1+JZNG1UFWeqskKfXgwt6E3lR33rIHpCwW2ILPPFkohtLSp6P1l2F9EYe/PXmm7Hi07xzPNgG59uWhYx5NYwfRdki8ep3JcXgxjtxKkAHJeqezqoz75W548i8w/3BM+gdJnfQTDvKK8XCrJGoRu8LLR0JFdxmL7uCep+8vixWLx0yaalGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782333266; c=relaxed/relaxed;
	bh=v50C9rmilrJSPUZRmZFJHXf8XpnOvwu3LDKb8v0nT/U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=A8vuhC9xwg2TUKFTEj97bGmKS349pwmDO1S/QkOeZe2pewzePLadOucOWrYMM9QglMtnd+ACMDFyEKiWCGiqSck1iUgvIxjKXFRf+/9sgtMSa3MG4RBuw3qoa8xHedAonNrQphN5DdeU84Rj+jgn5GEBgWbjHEk6r6uWwo6EXH75Pq3eET8Ty248Skre06Bc9Di6lYcsW09wW6KAKRaD+XYZbo1dPDrjBNstrPZEPwu3vYZJlmKeHj81tBnjprgjo60oDlzezOrdmLHP9rBr3PR/DNqxLpPbVdzb3q9EUbkNdmcuBgCp5g+xlAwMukIsI2FZ+H7ED1mG/VbHqELb9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=jNERU6yA; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=jNERU6yA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gltvj19f2z2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2026 06:34:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D283E42A85;
	Wed, 24 Jun 2026 20:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FE21F000E9;
	Wed, 24 Jun 2026 20:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782333260;
	bh=v50C9rmilrJSPUZRmZFJHXf8XpnOvwu3LDKb8v0nT/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jNERU6yA88PY6pt5GF3po/0MPuC5DfMcfLoCMASqAnAKjDV0fJbnH2eGL9mNBy0kS
	 zrVdwq8MXqwVqF3dYQuKSECoE6G7vDT5Qe+0wTRCcMXZEOCJpAHlFnpf/iFMw8Da4a
	 9e5tCqhsVDsJnCKoeO7J1EeLnnuqVFdxUPnGRf6c=
Date: Wed, 24 Jun 2026 13:34:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Bradley Morgan <include@grrlz.net>
Cc: Petr Mladek <pmladek@suse.com>, Feng Tang <feng.tang@linux.alibaba.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <chleroy@kernel.org>, Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jinchao Wang
 <wangjinchao600@gmail.com>, Kees Cook <kees@kernel.org>, Rio
 <rioo.tsukatsukii@gmail.com>, Joel Granados <joel.granados@kernel.org>,
 Pnina Feder <pnina.feder@mobileye.com>, Petr Pavlu <petr.pavlu@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Douglas Anderson
 <dianders@chromium.org>, Mayank Rungta <mrungta@google.com>, Tejun Heo
 <tj@kernel.org>, Zhenguo Yao <yaozhenguo1@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] sys_info: add helper for callers that handle
 all_bt
Message-Id: <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org>
In-Reply-To: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
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

On Tue, 23 Jun 2026 15:34:58 +0000 Bradley Morgan <include@grrlz.net> wrote:

> Some callers handle SYS_INFO_ALL_BT themselves before calling sys_info().
> Add a helper that strips that bit without turning an all_bt only mask into
> a kernel_sys_info fallback.

I assume this patch wants a Fixes: and a cc:stable also.

It would be nice to have the conventional [0/N] cover letter to tell
readers what this is all about.

The patches all have different Fixes: targets.  This risks inviting the
-stable maintainers to merge only some of the patches into some
kernels, resulting in an untested combination and which might break
things.

It would be cleaner to make all patches have the same Fixes: target if
possible.

