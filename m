Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1D3C04EBF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 08:25:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E152082B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 08:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E152082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438sH96Db8zDqmh
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 19:25:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: lists.ozlabs.org;
 spf=neutral (mailfrom) smtp.mailfrom=lip6.fr
 (client-ip=192.134.164.83; helo=mail2-relais-roc.national.inria.fr;
 envelope-from=julia.lawall@lip6.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lip6.fr
X-Greylist: delayed 658 seconds by postgrey-1.36 at bilbo;
 Wed, 05 Dec 2018 19:23:02 AEDT
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438sDk1W1jzDqjH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 19:23:01 +1100 (AEDT)
X-IronPort-AV: E=Sophos;i="5.56,317,1539640800"; d="scan'208";a="358847000"
Received: from abo-91-111-68.mrs.modulonet.fr (HELO hadrien) ([85.68.111.91])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 09:11:56 +0100
Date: Wed, 5 Dec 2018 09:11:56 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/ipic: Fix a bounds check in
 ipic_set_priority()
In-Reply-To: <87sgzchcw8.fsf@concordia.ellerman.id.au>
Message-ID: <alpine.DEB.2.21.1812050910030.2670@hadrien>
References: <20181203144834.ocxntjflfz2idxrb@kili.mountain>
 <87sgzchcw8.fsf@concordia.ellerman.id.au>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kim Phillips <kim.phillips@freescale.com>, kernel-janitors@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Dan Carpenter <dan.carpenter@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On Wed, 5 Dec 2018, Michael Ellerman wrote:

> Hi Dan,
>
> Thanks for the patch.
>
> Dan Carpenter <dan.carpenter@oracle.com> writes:
> > The ipic_info[] array only has 95 elements so I have made the bounds
> > check smaller to prevent a read overflow.  It was Smatch that found
> > this issue:
> >
> >     arch/powerpc/sysdev/ipic.c:784 ipic_set_priority()
> >     error: buffer overflow 'ipic_info' 95 <= 127
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > I wasn't able to find any callers of this code.  Maybe we removed the
> > last one in commit b9f0f1bb2bca ("[POWERPC] Adapt ipic driver to new
> > host_ops interface, add set_irq_type to set IRQ sense").  So perhaps we
> > should just remove it.  I'm not really comfortable doing that myself,
> > because I don't know the code well enough and can't build test
> > it properly.
>
> Hah wow, last usage removed in 2006!
>
> I don't see any mention of it since then, so I'll remove it. If it
> breaks something we can put it back.
>
> Can smatch help us find things like this that are defined non-static but
> never used?

I wrote a Coccinelle script for this, that just uses grep.  Of course the
results need checking because uses can be constructed within macros using
#.

Are things that are defined static but are never used useful to keep
around?

julia
