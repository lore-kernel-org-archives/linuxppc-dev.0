Return-Path: <SRS0=EQUS=5X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFE7C2BA1A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2020 00:07:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4BB2082D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2020 00:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="hP2f9sWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4BB2082D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48x75m1XL9zDqgF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2020 10:07:56 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48x6y84LXjzDqkg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2020 10:01:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=hP2f9sWp; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48x6y60yQbz9sSb;
 Tue,  7 Apr 2020 10:01:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1586217679; bh=A/84cobeo/UVyjykfoa1X4y58WV7ot7+3H5XSPUqBL8=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=hP2f9sWpVYrH9K7zG38YwbnoPZPBD11DUfLrMOQBUUBpOyCozOs1zvMSYAEQMzxCo
 qyUV01N/ioM0FJwECYpouUVXS3yeORxApJoAxgMyqnh09BNnRNbgQfkfUZgZ3RumH/
 D5amVJn6VYoNQYgMiGyUN9pPcULmr3cLyJ6z1Ae4XhR78H2Xqk+ci8TM37rZQv+ucN
 V/+lUlbLcfx91j8w5ncFyN32TfokXuLiyjmLxIH4hWKrt6xJR+lBxmts0fO5cM4qkl
 leB5gj68Qtmmwu1cOb9h3AH0rbpyJfYk01fMTcs9Pj3VbVjMKTb7aNqgyCLSY6GWng
 0Z1zL2glv/Avw==
Message-ID: <06400bab5a734666bc5b9565e151eb477f9831b7.camel@ozlabs.org>
Subject: Re: [PATCH 1/6] powerpc/spufs: simplify spufs core dumping
From: Jeremy Kerr <jk@ozlabs.org>
To: Christoph Hellwig <hch@lst.de>, Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 07 Apr 2020 08:01:16 +0800
In-Reply-To: <20200406120312.1150405-2-hch@lst.de>
References: <20200406120312.1150405-1-hch@lst.de>
 <20200406120312.1150405-2-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
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
Cc: linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christoph,

> Replace the coredump ->read method with a ->dump method that must call
> dump_emit itself.  That way we avoid a buffer allocation an messing with
> set_fs() to call into code that is intended to deal with user buffers.
> For the ->get case we can now use a small on-stack buffer and avoid
> memory allocations as well.

That looks much better, thanks!

Reviewed-by: Jeremy Kerr <jk@ozlabs.org>

However, I no longer have access to hardware to test this on. Michael,
are the coredump tests in spufs-testsuite still alive?

Cheers,


Jeremy

