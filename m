Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A759C4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Aug 2021 06:19:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18C160FC1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Aug 2021 06:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D18C160FC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GdSWw0xdLz30HM
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Aug 2021 16:19:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=d6/0ZIc+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=d6/0ZIc+; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GdSWT1L7fz2yyl
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Aug 2021 16:19:00 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GdSWQ5NdTz9sRK;
 Mon,  2 Aug 2021 16:18:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1627885139;
 bh=GUM6mY3meD2MOX2pln/9+oHlH+ZOZEFsM2wU6G9XIfE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=d6/0ZIc+o8RPgISrshbsEaAVakPmRXGIKfgR9vCS93Us/z3EDkQB/07Uys5Iq/0+I
 BxivD7NH9myvPJoca7+bDP7Y43fgnSZ7fBoH8j9vZBZrwAz7wNbBFjbFoT0DXwikDk
 xCOLW8GpL70VRwgH33AC8//4dfRtAmxtlSdACzZuFhV2/cxlpYJ9znIL9zeGkIlyZj
 BEzupSUXczkNQdZelS3WhT3toQflUHcnCcw5RYfU9DnQQnrb6nV/nYJqhMfpBGE3W+
 FZsevX7CODkyQakU8vaIUiTW7bbwXHlJ80K/11t68jvd0S3unsF+uciE9d+Xqlk8Ca
 3bGmDDcYJftfg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Murphy <murp@ibm.com>, pmenzel@molgen.mpg.de
Subject: RE: Possible regression by ab037dd87a2f (powerpc/vdso: Switch VDSO
 to generic C implementation.)
In-Reply-To: <OF44F7146F.67A4C1C2-ON00258720.004DBF64-00258720.004FCFCC@ibm.com>
References: <b5f948b4-759d-bb9f-06aa-6c15d37cd2bb@molgen.mpg.de>
 <a273c619-9258-e29a-24c3-ea47a13c4817@molgen.mpg.de>
 <3661999754da1a5e5c810fa669654cc7db95b059.camel@kernel.crashing.org>
 <4f037af0-5066-ebb9-53a6-733b3bd8eeac@molgen.mpg.de>
 <878s1q1udj.fsf@mpe.ellerman.id.au>
 <OF44F7146F.67A4C1C2-ON00258720.004DBF64-00258720.004FCFCC@ibm.com>
Date: Mon, 02 Aug 2021 16:18:58 +1000
Message-ID: <87czqwl67h.fsf@mpe.ellerman.id.au>
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
Cc: parkerderek86@gmail.com, laboger@linux.vnet.ibm.com, xaionaro@gmail.com,
 paulus@samba.org, murphyp@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Paul Murphy" <murp@ibm.com> writes:
>  
> (My apologies for however IBM's email client munges this)
>
>> I heard it is going to be in Go 1.16.7, but I do not know much about Go.
>> Maybe the folks in Cc can chime in.
>  
>  
> We have backports primed and ready for the next point release. They
> are waiting on the release manager to cherrypick them.

OK good, that is still the correct fix in the long run.

> I think we were aware that our VDSO usage may have exploited some
> peculiarities in how the ppc64 version was constructed (i.e hand
> written assembly which just didn't happen to clobber R30).

Yeah I was "somewhat surprised" that Go thought it could use r30 like
that across a VDSO call :D

But to be fair the ABI of the VDSO has always been a little fishy,
because the entry points pretend to be a transparent wrapper around
system calls, but then in a case like this are not.

> Go up to this point has only used the vdso function __kernel_clock_gettime; it
> is the only entry point which would need to explicitly avoid R30 for
> Go's sake.

I thought about limiting the workaround to just that code, but it seemed
silly and likely to come back to bite us. Once the compilers decides to
spill a non-volatile there are plenty of other ones to choose from.

cheers
