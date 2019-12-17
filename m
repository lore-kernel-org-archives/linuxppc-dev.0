Return-Path: <SRS0=7pZz=2H=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE48C43603
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Dec 2019 10:12:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01ABA2072D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Dec 2019 10:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01ABA2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47cYqD0QjRzDq7F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Dec 2019 21:12:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gondor.apana.org.au (client-ip=216.24.177.18;
 helo=deadmen.hmeau.com; envelope-from=herbert@gondor.apana.org.au;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gondor.apana.org.au
Received: from deadmen.hmeau.com (helcar.hmeau.com [216.24.177.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47cYn11d6JzDqSJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Dec 2019 21:10:45 +1100 (AEDT)
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
 id 1ih9EX-0005Te-TL; Tue, 17 Dec 2019 17:33:37 +0800
Received: from herbert by gondobar with local (Exim 4.89)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1ih9EU-0007G3-H7; Tue, 17 Dec 2019 17:33:34 +0800
Date: Tue, 17 Dec 2019 17:33:34 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Haren Myneni <haren@linux.ibm.com>
Subject: Re: [PATCH 08/10] crypto/NX: Add NX GZIP user space API
Message-ID: <20191217093334.ihvz3fzzfgjwse32@gondor.apana.org.au>
References: <1576414240.16318.4066.camel@hbabu-laptop>
 <1576415119.16318.4094.camel@hbabu-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576415119.16318.4094.camel@hbabu-laptop>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Cc: mikey@neuling.org, npiggin@gmail.com, hch@infradead.org,
 linux-crypto@vger.kernel.org, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Dec 15, 2019 at 05:05:19AM -0800, Haren Myneni wrote:
> 
> On power9, userspace can send GZIP compression requests directly to NX
> once kernel establishes NX channel / window. This patch provides GZIP
> engine access to user space via /dev/crypto/nx-gzip device node with
> open, VAS_TX_WIN_OPEN ioctl, mmap and close operations.
> 
> Each window corresponds to file descriptor and application can open
> multiple windows. After the window is opened, mmap() system call to map
> the hardware address of engine's request queue into the application's
> virtual address space.
> 
> Then the application can then submit one or more requests to the the
> engine by using the copy/paste instructions and pasting the CRBs to
> the virtual address (aka paste_address) returned by mmap().
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Signed-off-by: Haren Myneni <haren@us.ibm.com>
> ---
>  drivers/crypto/nx/Makefile            |   2 +-
>  drivers/crypto/nx/nx-842-powernv.h    |   2 +
>  drivers/crypto/nx/nx-commom-powernv.c |  21 ++-
>  drivers/crypto/nx/nx-gzip-powernv.c   | 282 ++++++++++++++++++++++++++++++++++
>  4 files changed, 304 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/crypto/nx/nx-gzip-powernv.c

We already have a kernel compress API which could be exposed
to user-space through af_alg.  If every driver created their
own user-space API it would be unmanageable.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
