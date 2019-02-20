Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9A7C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 11:21:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F02E7206B7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 11:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02E7206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444FYB5wSVzDqGB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 22:21:34 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444FTw2v3rzDqFY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 22:18:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 444FTv5hVdz9s5c; Wed, 20 Feb 2019 22:18:43 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 444FTs4sxKz9s71;
 Wed, 20 Feb 2019 22:18:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64s: Fix possible corruption on big endian due to
 pgd/pud_present()
In-Reply-To: <20190219201539.GT14180@gate.crashing.org>
References: <20190214062339.7139-1-mpe@ellerman.id.au>
 <20190216105511.GA31125@350D> <20190216142206.GE14180@gate.crashing.org>
 <20190217062333.GC31125@350D> <87ef86dd9v.fsf@concordia.ellerman.id.au>
 <20190217215556.GH31125@350D> <87imxhrkdt.fsf@concordia.ellerman.id.au>
 <20190219201539.GT14180@gate.crashing.org>
Date: Wed, 20 Feb 2019 22:18:38 +1100
Message-ID: <87sgwi7lo1.fsf@concordia.ellerman.id.au>
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
Cc: erhard_f@mailbox.org, jack@suse.cz, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 aneesh.kumar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Mon, Feb 18, 2019 at 11:49:18AM +1100, Michael Ellerman wrote:
>> Balbir Singh <bsingharora@gmail.com> writes:
>> > Fair enough, my point was that the compiler can help out. I'll see what
>> > -Wconversion finds on my local build :)
>> 
>> I get about 43MB of warnings here :)
>
> Yes, -Wconversion complains about a lot of things that are idiomatic C.
> There is a reason -Wconversion is not in -Wall or -Wextra.

Actually a lot of those go away when I add -Wno-sign-conversion.

And what's left seems mostly reasonable, they all indicate the
possibility of a bug I think.

In fact this works and would have caught the bug:

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index d8c8d7c9df15..3114e3f368e2 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -904,7 +904,12 @@ static inline int pud_none(pud_t pud)
 
 static inline int pud_present(pud_t pud)
 {
+	__diag_push();
+	__diag_warn(GCC, 8, "-Wconversion", "ulong -> int");
+
 	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PRESENT));
+
+	__diag_pop();
 }
 
 extern struct page *pud_page(pud_t pud);



Obviously we're not going to instrument every function like that. But we
could start instrumenting particular files.

cheers
