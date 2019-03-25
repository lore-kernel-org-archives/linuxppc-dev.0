Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DAAC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 12:36:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A3A2085A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 12:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A3A2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SYdv08Q9zDqKJ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 23:36:03 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SYbV1y4BzDqGT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 23:33:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44SYbT5s7hz9sSN; Mon, 25 Mar 2019 23:33:57 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44SYbT41Wmz9sRt;
 Mon, 25 Mar 2019 23:33:57 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc/64: Fix memcmp reading past the end of src/dest
In-Reply-To: <20190322182943.GF3969@gate.crashing.org>
References: <20190322123724.28435-1-mpe@ellerman.id.au>
 <20190322182943.GF3969@gate.crashing.org>
Date: Mon, 25 Mar 2019 23:33:56 +1100
Message-ID: <877ecnp1zf.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org, chandan@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Fri, Mar 22, 2019 at 11:37:24PM +1100, Michael Ellerman wrote:
>>  .Lcmp_rest_lt8bytes:
>> -	/* Here we have only less than 8 bytes to compare with. at least s1
>> -	 * Address is aligned with 8 bytes.
>> -	 * The next double words are load and shift right with appropriate
>> -	 * bits.
>> +	/*
>> +	 * Here we have less than 8 bytes to compare. At least s1 is aligned to
>> +	 * 8 bytes, but s2 may not be. We must make sure s2 + 8 doesn't cross a
>
> "s2 + 7"?  The code is fine though (bgt, not bge).

Duh, thanks for catching it.

>> +	 * page boundary, otherwise we might read past the end of the buffer and
>> +	 * trigger a page fault. We use 4K as the conservative minimum page
>> +	 * size. If we detect that case we go to the byte-by-byte loop.
>> +	 *
>> +	 * Otherwise the next double word is loaded from s1 and s2, and shifted
>> +	 * right to compare the appropriate bits.
>>  	 */
>> +	clrldi	r6,r4,(64-12)	// r6 = r4 & 0xfff
>
> You can just write
>   rlwinm r6,r4,0,0x0fff

> if that is clearer?  Or do you still want a comment with that :-)

I don't think it's clearer doing a rotate of zero bits :)

And yeah I'd probably still leave the comment, so I'm inclined to stick
with the clrldi?

Would be nice if the assembler could support:

	andi	r6, r4, 0x0fff

And turn it into the rlwinm, or rldicl :)

>> +	cmpdi	r6,0xff8
>> +	bgt	.Lshort
>
> Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

I'll fixup the comment. Thanks.

cheers
