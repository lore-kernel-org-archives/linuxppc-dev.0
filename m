Return-Path: <SRS0=tOPa=TO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645BEC04AB4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 May 2019 07:17:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF22E208C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 May 2019 07:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF22E208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4538C22dvdzDqJc
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 May 2019 17:17:18 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45388P4Y9pzDq6N
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2019 17:15:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45388P0nqRz9sCJ;
 Tue, 14 May 2019 17:15:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Build failure in v4.4.y.queue (ppc:allmodconfig)
In-Reply-To: <20190509162340.GB24493@roeck-us.net>
References: <20190508202642.GA28212@roeck-us.net>
 <20190509065324.GA3864@kroah.com> <87zhnvvgwm.fsf@concordia.ellerman.id.au>
 <20190509162340.GB24493@roeck-us.net>
Date: Tue, 14 May 2019 17:15:00 +1000
Message-ID: <871s11tsln.fsf@concordia.ellerman.id.au>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Guenter Roeck <linux@roeck-us.net> writes:
> On Fri, May 10, 2019 at 12:31:05AM +1000, Michael Ellerman wrote:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> > On Wed, May 08, 2019 at 01:26:42PM -0700, Guenter Roeck wrote:
>> >> I see multiple instances of:
>> >> 
>> >> arch/powerpc/kernel/exceptions-64s.S:839: Error:
>> >> 	attempt to move .org backwards
>> >> 
>> >> in v4.4.y.queue (v4.4.179-143-gc4db218e9451).
>> >> 
>> >> This is due to commit 9b2d4e06d7f1 ("powerpc/64s: Add support for a store
>> >> forwarding barrier at kernel entry/exit"), which is part of a large patch
>> >> series and can not easily be reverted.
>> >> 
>> >> Guess I'll stop doing ppc:allmodconfig builds in v4.4.y ?
>> >
>> > Michael, I thought this patch series was supposed to fix ppc issues, not
>> > add to them :)
>> 
>> Well it fixes some, but creates others :}
>> 
>> > Any ideas on what to do here?
>> 
>> Turning off CONFIG_CBE_RAS (obscure IBM Cell Blade RAS features) is
>> sufficient to get it building. Is that an option for your build tests
>> Guenter?
>> 
> I could turn it off unconditionally, meaning it would affect all other
> branches. I would rather stop building ppc:allmodconfig for v4.4.y.

Yeah fine by me. No one actually runs allmodconfig anyway.

cheers
