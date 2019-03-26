Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB66C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 09:19:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1532084B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 09:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1532084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44T5Dk2KhrzDqFS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 20:19:34 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44T5C44FdrzDqFS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 20:18:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44T5C40S8mz9sSX; Tue, 26 Mar 2019 20:18:08 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44T5C35gT1z9sSS;
 Tue, 26 Mar 2019 20:18:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc/64: Fix memcmp reading past the end of src/dest
In-Reply-To: <20190325175431.GJ3969@gate.crashing.org>
References: <20190322123724.28435-1-mpe@ellerman.id.au>
 <20190322182943.GF3969@gate.crashing.org>
 <877ecnp1zf.fsf@concordia.ellerman.id.au>
 <20190325175431.GJ3969@gate.crashing.org>
Date: Tue, 26 Mar 2019 20:18:07 +1100
Message-ID: <87va06ngds.fsf@concordia.ellerman.id.au>
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
> On Mon, Mar 25, 2019 at 11:33:56PM +1100, Michael Ellerman wrote:
>> Segher Boessenkool <segher@kernel.crashing.org> writes:
>> > On Fri, Mar 22, 2019 at 11:37:24PM +1100, Michael Ellerman wrote:
>> >> +	clrldi	r6,r4,(64-12)	// r6 = r4 & 0xfff
>> >
>> > You can just write
>> >   rlwinm r6,r4,0,0x0fff
>> 
>> > if that is clearer?  Or do you still want a comment with that :-)
>> 
>> I don't think it's clearer doing a rotate of zero bits :)
>> 
>> And yeah I'd probably still leave the comment, so I'm inclined to stick
>> with the clrldi?
>
> I always have to think what the clrldi etc. do exactly, while with rlwinm
> it is obvious.  But yeah this may be different for other people who are
> used to different idiom.

Interesting, I'm the opposite. You know ppc assembler better than me so
I guess I just need to spend more time on it and embrace the zen of the
rotate instructions.

>> Would be nice if the assembler could support:
>> 
>> 	andi	r6, r4, 0x0fff
>> 
>> And turn it into the rlwinm, or rldicl :)
>
> The extended mnemonics are *simple*, *one-to-one* mappings.

It would still be simple and 1:1, but would only be valid for certain
constants :)

> Having "andi. 6,4,0x0f0f" a valid insn, but an extended mnemonic "andi 6,4,0x0f0f"
> that is not (and the other way around for say 0xff0000ff) would violate that.

I agree that's a bit of a foot gun.

I'm not sure it's vastly more hostile though than `andi. 6,4,0xffff`
being valid but `andi. 6,4,0x1ffff` being not valid.

The assembler could print a nice error saying you need to use a
contiguous mask. And I mean how often do you andi. with a mask that
isn't contiguous?

> You could do some assembler macro, that can also expand to multiple insns
> where that is useful.  Also one for loading constants, etc.  The downside
> to that is you often do care how many insns are generated.
>
> Instead you could do a macro for only those cases that can be done with *one*
> insn.  But that then is pretty restricted in use, and people have to learn
> what values are valid.
>
> I don't see a perfect solution.

Yeah, I guess a new `andi` instruction is the only real answer :)

cheers
