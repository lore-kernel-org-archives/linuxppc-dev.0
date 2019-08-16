Return-Path: <SRS0=SmZj=WM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ADAC3A589
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Aug 2019 01:44:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24685206C1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Aug 2019 01:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24685206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 468mMM6mK8zDrHl
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Aug 2019 11:44:15 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 468mKJ0MDvzDqw6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2019 11:42:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 468mKG2TSzz9sN6;
 Fri, 16 Aug 2019 11:42:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alastair D'Silva <alastair@au1.ibm.com>
Subject: Re: [PATCH] powerpc: Allow flush_(inval_)dcache_range to work across
 ranges >4GB
In-Reply-To: <20190815071924.GA26670@kroah.com>
References: <20190815045543.16325-1-alastair@au1.ibm.com>
 <20190815071924.GA26670@kroah.com>
Date: Fri, 16 Aug 2019 11:42:22 +1000
Message-ID: <87mug97uo1.fsf@concordia.ellerman.id.au>
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, alastair@d-silva.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Allison Randal <allison@lohutok.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> On Thu, Aug 15, 2019 at 02:55:42PM +1000, Alastair D'Silva wrote:
>> From: Alastair D'Silva <alastair@d-silva.org>
>> 
>> Heads Up: This patch cannot be submitted to Linus's tree, as the affected
>> assembler functions have already been converted to C.

That was done in upstream commit:

22e9c88d486a ("powerpc/64: reuse PPC32 static inline flush_dcache_range()")

Which is a larger change that we don't want to backport. This patch is a
minimal fix for stable trees.


>> When calling flush_(inval_)dcache_range with a size >4GB, we were masking
>> off the upper 32 bits, so we would incorrectly flush a range smaller
>> than intended.
>> 
>> This patch replaces the 32 bit shifts with 64 bit ones, so that
>> the full size is accounted for.
>> 
>> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
>> ---
>>  arch/powerpc/kernel/misc_64.S | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> </formletter>

Hi Greg,

This is "option 3", submit the patch directly, and the patch "deviates
from the original upstream patch" because the upstream patch was a
wholesale conversion from asm to C.

This patch applies cleanly to v4.14 and v4.19.

The change log should have mentioned which upstream patch it is not a
backport of, is there anything else we should have done differently to
avoid the formletter bot :)

cheers
