Return-Path: <SRS0=PW3U=LW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15665C48BC2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jun 2021 01:13:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6096B61469
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jun 2021 01:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6096B61469
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GCqNT4vTMz308V
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jun 2021 11:12:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=aus9ryL+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux-foundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.a=rsa-sha256 header.s=korg header.b=aus9ryL+; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GCqMz6kpvz2ydK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jun 2021 11:12:30 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DC08619C5;
 Mon, 28 Jun 2021 01:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1624842747;
 bh=jHVvl6fcFfg+IVQ3lBpd7cBJiC21/SiQ2M2n/J/aDeQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=aus9ryL+DgdKH4ZNAJ5wqeFEe6w9+xkQn3TmuhatvYPqjRvTfTCqQsNQm3nJrmYD/
 X3DX2v1FqasZlVOaBS1sW/lXxvheF8cEwJVuOjRQZm7cTjQNhBT3i/tCFbtBeIq3yj
 bupVyrvJDARUQXHC8Ly6sHJgcxIsv6qUTNCdNM7w=
Date: Sun, 27 Jun 2021 18:12:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3] mm: pagewalk: Fix walk for hugepage tables
Message-Id: <20210627181226.983d899cc30c02420e1a6af5@linux-foundation.org>
In-Reply-To: <38d04410700c8d02f28ba37e020b62c55d6f3d2c.1624597695.git.christophe.leroy@csgroup.eu>
References: <38d04410700c8d02f28ba37e020b62c55d6f3d2c.1624597695.git.christophe.leroy@csgroup.eu>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steven Price <steven.price@arm.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Oliver O'Halloran <oohall@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 25 Jun 2021 05:10:12 +0000 (UTC) Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Pagewalk ignores hugepd entries and walk down the tables
> as if it was traditionnal entries, leading to crazy result.
> 
> Add walk_hugepd_range() and use it to walk hugepage tables.

More details, please?  I assume "crazy result" is userspace visible? 
For how long has this bug existed?  Is a -stable backport needed?  Has
a Fixes: commit been identified?  etcetera!
