Return-Path: <SRS0=YyhJ=3M=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE83AC2D0DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jan 2020 11:01:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F2A2253D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jan 2020 11:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="HSStN14F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F2A2253D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 483K8G6tPDzDqW1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jan 2020 22:01:18 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 483K5t1Y9DzDqV3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jan 2020 21:59:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=HSStN14F; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 483K5r5snRz9sSQ;
 Thu, 23 Jan 2020 21:59:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1579777154;
 bh=HLfndF9RAt4g+AGkbC5qXfhi2W5ru43lrY+OrFwE77c=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=HSStN14FpEBPLwZGlx8oA+ZZNFfWdzHQErga4zK0XJhZfzP21D9wVvy2nuua2Mcro
 coc6kYH0eO3TodIQoXW3uHMTv0a3Qpku4sXMmh6C1rqkRglSS/MAUic6YqP0/byH0G
 ZJ7pawYuL1pjqPlF2vm4ykwCpFBmFOSc0iYPFqJZo0mEpsJQ76+wJbrBrKrEo9nmNs
 ZgSBsLMbn5gSujjwiM9+A2Ut5yJUmDY0rLKA8hcDKkIQJCPsjUpvQ3nRRKQRMY/OPV
 I80FJuKhnIDrVr9c3L0OKrBKo50KaQQi2hgOJyv7mbq1cJ3kvDlZyYKoDIRW7yeq51
 dxF8E/uUq8TlQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 5/6] powerpc/32s: prepare prevent_user_access() for
 user_access_end()
In-Reply-To: <824b69f5452d1d41d12c4dbd306d4b8f32d493fc.1579715466.git.christophe.leroy@c-s.fr>
References: <12a4be679e43de1eca6e5e2173163f27e2f25236.1579715466.git.christophe.leroy@c-s.fr>
 <824b69f5452d1d41d12c4dbd306d4b8f32d493fc.1579715466.git.christophe.leroy@c-s.fr>
Date: Thu, 23 Jan 2020 21:59:07 +1100
Message-ID: <87pnfaiglg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> In preparation of implementing user_access_begin and friends
> on powerpc, the book3s/32 version of prevent_user_access() need
> to be prepared for user_access_end().
>
> user_access_end() doesn't provide the address and size which
> were passed to user_access_begin(), required by prevent_user_access()
> to know which segment to modify.
>
> The list of segments which where unprotected by allow_user_access()
> are available in current->kuap. But we don't want prevent_user_access()
> to read this all the time, especially everytime it is 0 (for instance
> because the access was not a write access).
>
> Implement a special direction case named KUAP_SELF. In this case only,
> the addr and end are retrieved from current->kuap.

Can we call it KUAP_CURRENT?

ie. "use the KUAP state in current"

cheers
