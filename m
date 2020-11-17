Return-Path: <SRS0=3gej=EX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C00CC2D0E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2020 10:28:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF13720E65
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2020 10:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkcUKO1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF13720E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cb2Gp3DGCzDqV8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2020 21:28:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=EkcUKO1b; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cb2Dz6fLjzDqQV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2020 21:27:13 +1100 (AEDT)
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 63E6E22202;
 Tue, 17 Nov 2020 10:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605608830;
 bh=suTWvoLJ55Ut1FqBR7Xy/ItUlnZJmBkmEfCbJxX1yR4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EkcUKO1bbVjQJmBvMV2pyTcBInGMm4m9iRqXrWXX5MRwMzD4VKEJWrR5yl0v5j9Sy
 Qa1rzwANDRKu7H4ErZmJG58j71EYDkX2HDFXurin6kop5cauF87/7wX2YozUgklB0a
 z2dJKsQwsSvH2ihf5/fVQEJrhFt13eByVTt2qwUU=
Date: Tue, 17 Nov 2020 11:27:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH for 5.4] powerpc/603: Always fault when _PAGE_ACCESSED is
 not set
Message-ID: <X7OlrpFkRKBQMNQ8@kroah.com>
References: <9351d8a775f749d7c881c909388e69af944087b9.1604943353.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9351d8a775f749d7c881c909388e69af944087b9.1604943353.git.christophe.leroy@csgroup.eu>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 09, 2020 at 05:40:52PM +0000, Christophe Leroy wrote:
> [That is backport of 11522448e641e8f1690c9db06e01985e8e19b401 to linux 5.4]
> 
> The kernel expects pte_young() to work regardless of CONFIG_SWAP.
> 
> Make sure a minor fault is taken to set _PAGE_ACCESSED when it
> is not already set, regardless of the selection of CONFIG_SWAP.
> 
> Fixes: 84de6ab0e904 ("powerpc/603: don't handle PAGE_ACCESSED in TLB miss handlers.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Link: https://lore.kernel.org/r/a44367744de54e2315b2f1a8cbbd7f88488072e0.1602342806.git.christophe.leroy@csgroup.eu
> ---
>  arch/powerpc/kernel/head_32.S | 12 ------------
>  1 file changed, 12 deletions(-)

Both backports now queued up, thanks.

greg k-h
