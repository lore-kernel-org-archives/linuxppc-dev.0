Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E06C4338F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Aug 2021 16:55:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3998260F57
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Aug 2021 16:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3998260F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GmV6F3WBvz3cWV
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Aug 2021 02:55:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=dkim header.b=nnPxnFFL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=alien8.de (client-ip=5.9.137.197; helo=mail.skyhub.de;
 envelope-from=bp@alien8.de; receiver=<UNKNOWN>)
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GmV5N1Rzxz30L2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Aug 2021 02:54:09 +1000 (AEST)
Received: from zn.tnic (p200300ec2f0a0d00fd43514a4e38f781.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0a:d00:fd43:514a:4e38:f781])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 804C41EC0411;
 Fri, 13 Aug 2021 18:53:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1628873636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=/84z6Jt71TwxTIyDYITeuLKD4Ta4roESLEjk8oftwvw=;
 b=nnPxnFFLQXpCfOvbEt0Av0rUZgOj1mCuG52fzxh3GPPNWTGmksMlvf0COZbS6GeG7w/U4X
 7mZL51Ynycu3lBpXmVHvv8/wQCm+WKZrzwUcxFqB4d6xvMbh86UVysShSR99PoH2kwcun4
 oA4KUqxbZo0t2RUufvPoKKaeCKXRSRk=
Date: Fri, 13 Aug 2021 18:54:34 +0200
From: Borislav Petkov <bp@alien8.de>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] powerpc/svm: Don't issue ultracalls if
 !mem_encrypt_active()
Message-ID: <YRajyuHdlJuO0shK@zn.tnic>
References: <20210730114231.23445-1-will@kernel.org>
 <871r7cks8x.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871r7cks8x.fsf@mpe.ellerman.id.au>
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
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>, iommu@lists.linux-foundation.org,
 Claire Chang <tientzu@chromium.org>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 02, 2021 at 09:20:30PM +1000, Michael Ellerman wrote:
> Will Deacon <will@kernel.org> writes:
> > Commit ad6c00283163 ("swiotlb: Free tbl memory in swiotlb_exit()")
> > introduced a set_memory_encrypted() call to swiotlb_exit() so that the
> > buffer pages are returned to an encrypted state prior to being freed.
> >
> > Sachin reports that this leads to the following crash on a Power server:
> >
> > [    0.010799] software IO TLB: tearing down default memory pool
> > [    0.010805] ------------[ cut here ]------------
> > [    0.010808] kernel BUG at arch/powerpc/kernel/interrupt.c:98!
> >
> > Nick spotted that this is because set_memory_encrypted() is issuing an
> > ultracall which doesn't exist for the processor, and should therefore
> > be gated by mem_encrypt_active() to mirror the x86 implementation.
> >
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Cc: Claire Chang <tientzu@chromium.org>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Fixes: ad6c00283163 ("swiotlb: Free tbl memory in swiotlb_exit()")
> > Suggested-by: Nicholas Piggin <npiggin@gmail.com>
> > Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> > Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> > Link: https://lore.kernel.org/r/1905CD70-7656-42AE-99E2-A31FC3812EAC@linux.vnet.ibm.com/
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  arch/powerpc/platforms/pseries/svm.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> Thanks.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> 
> I assume Konrad will take this via the swiotlb tree?

Btw, we're currently reworking that whole "am I running as a
confidential guest" querying, see:

https://lkml.kernel.org/r/029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com

for example.

I see Konrad has queued this for 5.15 in his devel/for-linus-5.15 branch
so if he sends it to Linus in the upcoming merge window (right Konrad?)
then I can base the rework ontop, once 5.15-rc1 releases, so that there
are no build breakages...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
