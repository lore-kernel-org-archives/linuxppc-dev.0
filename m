Return-Path: <SRS0=OkvJ=76=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB264C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2020 10:58:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3004C208B3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2020 10:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HB7HHd1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3004C208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49n2B02Hd8zDqC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2020 20:58:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=will@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=HB7HHd1u; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49n28D04JYzDqpM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2020 20:57:15 +1000 (AEST)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0AC77208B3;
 Wed, 17 Jun 2020 10:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592391433;
 bh=oVYweIR6zLMediXDsU1jDQ9pyvK//XIYoenxlo7SOcE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HB7HHd1u1+1jDZ68+nOq2V/Yg9kDRfF1mmDDPGQSytreC543TQYscnE8rTyG7ryWc
 EJ497VjPlRBG1okeyG9fRVW0vkxlOE6AxZX+c7XaDhFmhezLeATXXnIZkYJs/f+/+9
 zWW/n+CA4dyENNhzkB6Q499C43G10YVNCGjGKsEM=
Date: Wed, 17 Jun 2020 11:57:08 +0100
From: Will Deacon <will@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 0/3] Fix build failure with v5.8-rc1
Message-ID: <20200617105708.GA3503@willie-the-truck>
References: <cover.1592225557.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1592225557.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: arnd@arndb.de, "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

[+Arnd in case he's interested in this series]

On Mon, Jun 15, 2020 at 12:57:55PM +0000, Christophe Leroy wrote:
> Commit 2ab3a0a02905 ("READ_ONCE: Enforce atomicity for
> {READ,WRITE}_ONCE() memory accesses") leads to following build
> failure on powerpc 8xx.
> 
> To fix it, this small series introduces a new helper named ptep_get()
> to replace the direct access with READ_ONCE(). This new helper
> can be overriden by architectures.

Thanks for doing this, and sorry for the breakage. For the series:

Acked-by: Will Deacon <will@kernel.org>

Hopefully we can introduce accessors for the other page-table levels too,
but that can obviously happen incrementally.

Will

> Christophe Leroy (3):
>   mm/gup: Use huge_ptep_get() in gup_hugepte()
>   mm: Allow arches to provide ptep_get()
>   powerpc/8xx: Provide ptep_get() with 16k pages
> 
>  arch/powerpc/include/asm/nohash/32/pgtable.h | 10 ++++++++++
>  include/asm-generic/hugetlb.h                |  2 +-
>  include/linux/pgtable.h                      |  7 +++++++
>  mm/gup.c                                     |  4 ++--
>  4 files changed, 20 insertions(+), 3 deletions(-)
> 
> -- 
> 2.25.0
> 
