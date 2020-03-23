Return-Path: <SRS0=3fZu=5I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D64C4332B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2020 11:34:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F474206F9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2020 11:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="aTcjVDSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F474206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48mC3C382kzDqwF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2020 22:34:46 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48mBzz4R5mzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2020 22:31:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=aTcjVDSk; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48mBzy1vyGz9sNg;
 Mon, 23 Mar 2020 22:31:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1584963118;
 bh=E8qzQqSnckPlaK6x1m+N0pBLmfMANwHYQ3F7yFr6SOA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=aTcjVDSkPYSmeazwV0zJAQ9BTywpIKpXUDUmVwPX3RY6smvITQazeWgaQuH+U5Eah
 h/tua4v9v3wEL9TuA9BbUZMFM8002tNlxDKxCbuWyMTO7Hu2LxofHxVyfnJ6dQIiVt
 f90KVcqVqj+nyB0az0gqNLHlUm5N1ObNGS1VPyJ6C0kdTgJ2q99f3zgxmvl5KHTASs
 8/qkc5iCRVWkSZciHXljoZTRRoLmfFo8bJ08GteWXygUP2DQ0AkRR61yCq+1Eh8WLE
 jJeEAon6vvVEzpVAV7PsWe7OQ5rCHk08RyODWIUgXA6DyWkIBKmP4wnEgh4r9Xd6CR
 Sp+nDUHpM7DTQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Haren Myneni <haren@linux.ibm.com>
Subject: Re: [PATCH v8 03/14] powerpc/vas: Define nx_fault_stamp in
 coprocessor_request_block
In-Reply-To: <1584923120.arc9bj6gmg.astroid@bobo.none>
References: <1584598120.9256.15237.camel@hbabu-laptop>
 <1584598437.9256.15247.camel@hbabu-laptop>
 <1584923120.arc9bj6gmg.astroid@bobo.none>
Date: Mon, 23 Mar 2020 22:32:02 +1100
Message-ID: <87bloncnnx.fsf@mpe.ellerman.id.au>
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
Cc: mikey@neuling.org, ajd@linux.ibm.com, hch@infradead.org, oohall@gmail.com,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 herbert@gondor.apana.org.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> Haren Myneni's on March 19, 2020 4:13 pm:
>> 
>> Kernel sets fault address and status in CRB for NX page fault on user
>> space address after processing page fault. User space gets the signal
>> and handles the fault mentioned in CRB by bringing the page in to
>> memory and send NX request again.
>> 
>> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>> Signed-off-by: Haren Myneni <haren@linux.ibm.com>
>> ---
>>  arch/powerpc/include/asm/icswx.h | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/include/asm/icswx.h b/arch/powerpc/include/asm/icswx.h
>> index 9872f85..b233d1e 100644
>> --- a/arch/powerpc/include/asm/icswx.h
>> +++ b/arch/powerpc/include/asm/icswx.h
>
> "icswx" is not a thing anymore, after 6ff4d3e96652 ("powerpc: Remove old 
> unused icswx based coprocessor support").

Yeah that commit ripped out some parts of the previous attempt at a user
visible API for this sort of "coprocessor" stuff. VAS is yet another
attempt to do something useful with most of the same pieces but some
slightly different details.

> I guess NX is reusing some 
> things from it, but it would be good to get rid of the cruft and re-name
> this file and and relevant names.

> NX already uses this file, so I guesss that can happen after this series.

A lot of the CRB/CSB stuff is still the same, and P8 still uses icswx.
But I'd be happy if the header was renamed eventually, as icswx is now a
legacy name.

cheers
