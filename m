Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E51C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 12:52:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A9D0223CB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 12:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9D0223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wh8b1gztzF3fQ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 23:52:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wh3Y4JdKzF3W7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 23:47:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42wh3Y1Lbjz9s3x;
 Thu, 15 Nov 2018 23:47:53 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alan Modra <amodra@gmail.com>, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] powerpc/32: Include .branch_lt in data section
In-Reply-To: <20181114040045.GX29784@bubble.grove.modra.org>
References: <20181114030218.25508-1-joel@jms.id.au>
 <20181114040045.GX29784@bubble.grove.modra.org>
Date: Thu, 15 Nov 2018 23:47:52 +1100
Message-ID: <87wopetslj.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Alan Modra <amodra@gmail.com> writes:

> On Wed, Nov 14, 2018 at 01:32:18PM +1030, Joel Stanley wrote:
>> When building a 32 bit powerpc kernel with Binutils 2.31.1 this warning
>> is emitted:
>> 
>>  powerpc-linux-gnu-ld: warning: orphan section `.branch_lt' from
>>  `arch/powerpc/kernel/head_44x.o' being placed in section `.branch_lt'
>> 
>> As of binutils commit 2d7ad24e8726 ("Support PLT16 relocs against local
>> symbols")[1], 32 bit targets can produce .branch_lt sections in their
>> output.
>> 
>> Include these symbols in the .data section as the ppc64 kernel does.
>> 
>> [1] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commitdiff;h=2d7ad24e8726ba4c45c9e67be08223a146a837ce
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Alan Modra <amodra@gmail.com>
>
> Looks fine to me.
>
>> ---
>> I wasn't sure where this should go or if the ordering matters.
>
> The usual answer is: "Look at where the section goes in the standard
> linker scripts."   But that doesn't apply here.  The section will be
> empty for a kernel build so it doesn't matter where it goes.

If it's empty why don't we just discard it?

cheers
