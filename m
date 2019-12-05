Return-Path: <SRS0=1hKA=Z3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C5FC43603
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Dec 2019 03:02:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1EBF206DB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Dec 2019 03:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="fr7eUK9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1EBF206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47T0r52FRJzDqY7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Dec 2019 14:02:13 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47T0nM5tknzDqCV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2019 13:59:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="fr7eUK9Z"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 47T0nK6BZ1z9sNx;
 Thu,  5 Dec 2019 13:59:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1575514791;
 bh=RhwaeUVtdgvUjr2JVRfHFkjO1wjCt04eFE+iY69n+iE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=fr7eUK9Z+zL6LRB5A77Gky2KVZfX4gfedoY+B5Amafeac65cxStIkN2mfaWUPM//A
 5FwzcBHqe+kxxJIGpuGbGYuzPXsP9mTmFNgSKxjrhfLtCDpABObb9XGx028mkNtOHT
 O8KGO9SvEydlFUPXwe2v23jjS4lchVmwDPyMvprobOvWZlHGSe+d6gp1YjJnwjqQWv
 yWGQIuzOoPZZcO80jh2OgbFnovcVbzBvOYmCNIcG9QpJkda5ES0zEl/vKZHOPDEgYH
 nltcb2DIhaxx34to55oa18r3Jho6wVGcNIBFvc+tE4Is4GXrcVHWZi6UL5AsMwPUfV
 8u708CkeqAXWw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries/cmm: fix wrong managed page count when
 migrating between zones
In-Reply-To: <7edce293-0ee2-3c2a-8cd9-a3db85465ba7@redhat.com>
References: <20191204205309.8319-1-david@redhat.com>
 <7edce293-0ee2-3c2a-8cd9-a3db85465ba7@redhat.com>
Date: Thu, 05 Dec 2019 13:59:49 +1100
Message-ID: <87h82feau2.fsf@mpe.ellerman.id.au>
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
Cc: linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Richard Fontana <rfontana@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Arun KS <arunks@codeaurora.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

David Hildenbrand <david@redhat.com> writes:
> Forgot to rename the subject to
>
> "powerpc/pseries/cmm: fix managed page counts when migrating pages
> between zones"
>
> If I don't have to resend, would be great if that could be adjusted when
> applying.

I can do that.

I'm inclined to wait until the virtio_balloon.c change is committed, in
case there's any changes to it during review, and so we can refer to
it's SHA in the change log of this commit.

Do you want to ping me when that happens?

cheers
