Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3C8C67863
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 03:22:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B952145D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 03:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B952145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42brn95cqyzF3TP
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 14:22:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42br5s0W5mzF3Rt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 13:51:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42br5r4gvTzB4NJ; Fri, 19 Oct 2018 13:51:28 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: bde1a1335c5031758d3917d83dd5b85b761bbebd
In-Reply-To: <19885260cc71182f8c03840204e2553ef42acb67.1539781367.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/book3e: redefine pte_mkprivileged() and pte_mkuser()
Message-Id: <42br5r4gvTzB4NJ@ozlabs.org>
Date: Fri, 19 Oct 2018 13:51:28 +1100 (AEDT)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-10-17 at 13:03:22 UTC, Christophe Leroy wrote:
> Book3e defines both _PAGE_USER and _PAGE_PRIVILEGED, so the nohash
> default pte_mkprivileged() and pte_mkuser() are not usable.
> 
> This patch redefines them for book3e.
> 
> In theorie, only pte_mkprivileged() needs to be redefined because
> _PAGE_USER includes _PAGE_PRIVILEGED, but it is less confusing
> to redefine both.
> 
> Fixes: a0da4bc166f2 ("powerpc/mm: Allow platforms to redefine some helpers")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bde1a1335c5031758d3917d83dd5b8

cheers
