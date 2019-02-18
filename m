Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0CAC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 00:51:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B4C2184E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 00:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B4C2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 442lfq3B1zzDqKZ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 11:51:15 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 442lcg5HzWzDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 11:49:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 442lcg3G1Nz9sD4; Mon, 18 Feb 2019 11:49:23 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 442lcd2whwz9s7h;
 Mon, 18 Feb 2019 11:49:21 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH] powerpc/64s: Fix possible corruption on big endian due to
 pgd/pud_present()
In-Reply-To: <20190217215556.GH31125@350D>
References: <20190214062339.7139-1-mpe@ellerman.id.au>
 <20190216105511.GA31125@350D> <20190216142206.GE14180@gate.crashing.org>
 <20190217062333.GC31125@350D> <87ef86dd9v.fsf@concordia.ellerman.id.au>
 <20190217215556.GH31125@350D>
Date: Mon, 18 Feb 2019 11:49:18 +1100
Message-ID: <87imxhrkdt.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:
> On Sun, Feb 17, 2019 at 07:34:20PM +1100, Michael Ellerman wrote:
>> Balbir Singh <bsingharora@gmail.com> writes:
>> > On Sat, Feb 16, 2019 at 08:22:12AM -0600, Segher Boessenkool wrote:
>> >> On Sat, Feb 16, 2019 at 09:55:11PM +1100, Balbir Singh wrote:
>> >> > On Thu, Feb 14, 2019 at 05:23:39PM +1100, Michael Ellerman wrote:
>> >> > > In v4.20 we changed our pgd/pud_present() to check for _PAGE_PRESENT
>> >> > > rather than just checking that the value is non-zero, e.g.:
>> >> > > 
>> >> > >   static inline int pgd_present(pgd_t pgd)
>> >> > >   {
>> >> > >  -       return !pgd_none(pgd);
>> >> > >  +       return (pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
>> >> > >   }
>> >> > > 
>> >> > > Unfortunately this is broken on big endian, as the result of the
>> >> > > bitwise && is truncated to int, which is always zero because
>> >> 
>> >> (Bitwise "&" of course).
>> >> 
>> >> > Not sure why that should happen, why is the result an int? What
>> >> > causes the casting of pgd_t & be64 to be truncated to an int.
>> >> 
>> >> Yes, it's not obvious as written...  It's simply that the return type of
>> >> pgd_present is int.  So it is truncated _after_ the bitwise and.
>> >>
>> >
>> > Thanks, I am surprised the compiler does not complain about the truncation
>> > of bits. I wonder if we are missing -Wconversion
>> 
>> Good luck with that :)
>> 
>> What I should start doing is building with it enabled and then comparing
>> the output before and after commits to make sure we're not introducing
>> new cases.
>
> Fair enough, my point was that the compiler can help out. I'll see what
> -Wconversion finds on my local build :)

I get about 43MB of warnings here :)

cheers
