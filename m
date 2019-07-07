Return-Path: <SRS0=WV6v=VE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55008C48BDB
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Jul 2019 13:18:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD71B20828
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Jul 2019 13:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD71B20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45hTfM4xTTzDqQY
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Jul 2019 23:18:03 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45hTbW74dtzDqQY
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Jul 2019 23:15:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45hTbV4SGMz9s4Y;
 Sun,  7 Jul 2019 23:15:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH] Replaces long number representation by BIT() macro
In-Reply-To: <20190702164850.GP18316@gate.crashing.org>
References: <20190613180227.29558-1-leonardo@linux.ibm.com>
 <87imskihvd.fsf@concordia.ellerman.id.au>
 <20190702161635.GO18316@gate.crashing.org>
 <20190702164850.GP18316@gate.crashing.org>
Date: Sun, 07 Jul 2019 23:15:34 +1000
Message-ID: <87d0imhtop.fsf@concordia.ellerman.id.au>
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
Cc: Leonardo Bras <leonardo@linux.ibm.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Tue, Jul 02, 2019 at 11:16:35AM -0500, Segher Boessenkool wrote:
>> On Wed, Jul 03, 2019 at 01:19:34AM +1000, Michael Ellerman wrote:
>> > What we could do is switch to the `UL` macro from include/linux/const.h,
>> > rather than using our own ASM_CONST.
>> 
>> You need gas 2.28 or later for that though.
>
> Oh, but apparently I cannot read.  That macro should work fine.

:)

Yeah one day we'll be able to drop them entirely, but not yet.

The official minimum is 2.20:
  https://www.kernel.org/doc/html/latest/process/changes.html


But my "old" toolchain is binutils 2.22, so that's effectively the
minimum for anything I test. I'm not sure many people are actually
testing with 2.20.

cheers
