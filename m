Return-Path: <SRS0=37tr=TD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A727BC43219
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 13:36:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC1932075E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 13:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1932075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44wY863q1WzDqcK
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 23:36:54 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44wY2d74MNzDqkd
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2019 23:32:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44wY2Z5SZTz9sDn;
 Fri,  3 May 2019 23:32:06 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg KH <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 5.1-rc5
In-Reply-To: <20190502122128.GA2670@kroah.com>
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190502122128.GA2670@kroah.com>
Date: Fri, 03 May 2019 23:31:48 +1000
Message-ID: <87ef5fy88r.fsf@concordia.ellerman.id.au>
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
Cc: Christoph Hellwig <hch@infradead.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Greg KH <gregkh@linuxfoundation.org> writes:
> On Mon, Apr 15, 2019 at 09:17:10AM -0700, Linus Torvalds wrote:
>> On Sun, Apr 14, 2019 at 10:19 PM Christoph Hellwig <hch@infradead.org> wrote:
>> >
>> > Can we please have the page refcount overflow fixes out on the list
>> > for review, even if it is after the fact?
>> 
>> They were actually on a list for review long before the fact, but it
>> was the security mailing list. The issue actually got discussed back
>> in January along with early versions of the patches, but then we
>> dropped the ball because it just wasn't on anybody's radar and it got
>> resurrected late March. Willy wrote a rather bigger patch-series, and
>> review of that is what then resulted in those commits. So they may
>> look recent, but that's just because the original patches got
>> seriously edited down and rewritten.
>> 
>> That said, powerpc and s390 should at least look at maybe adding a
>> check for the page ref in their gup paths too. Powerpc has the special
>> gup_hugepte() case, and s390 has its own version of gup entirely. I
>> was actually hoping the s390 guys would look at using the generic gup
>> code.
>> 
>> I ruthlessly also entirely ignored MIPS, SH and sparc, since they seem
>> largely irrelevant, partly since even theoretically this whole issue
>> needs a _lot_ of memory.
>> 
>> Michael, Martin, see commit 6b3a70773630 ("Merge branch 'page-refs'
>> (page ref overflow)"). You may or may not really care.
>
> I've now queued these patches up for the next round of stable releases,
> as some people seem to care about these.
>
> I didn't see any follow-on patches for s390 or ppc64 hit the tree for
> these changes, am I just missing them and should also queue up a few
> more to handle this issue on those platforms?

No you haven't missed them for powerpc. It's on my list.

cheers
