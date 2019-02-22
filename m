Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D7FC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 03:48:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC4B2086A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 03:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC4B2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445HP15jrZzDqSl
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 14:48:05 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445HM52GmFzDqQj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 14:46:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 445HM50xGYz9s9L;
 Fri, 22 Feb 2019 14:46:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>, Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH 0/7] Kernel Userspace Protection for radix
In-Reply-To: <CAGXu5jL0ZOzTo2sXiWkgemcwHusX4YuM9b_9y-MZ2THuDoRC+g@mail.gmail.com>
References: <20190221093601.27920-1-ruscur@russell.cc>
 <CAGXu5j+P1wh0uf1kfMywSTo4NYtwFPSnKXg6wbfyBRqwVRZVYA@mail.gmail.com>
 <8ef1669cdfbcc6114eebc30c610c91c191c7cc7a.camel@russell.cc>
 <CAGXu5jL0ZOzTo2sXiWkgemcwHusX4YuM9b_9y-MZ2THuDoRC+g@mail.gmail.com>
Date: Fri, 22 Feb 2019 14:46:24 +1100
Message-ID: <87bm34pjsf.fsf@concordia.ellerman.id.au>
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
Cc: PowerPC <linuxppc-dev@lists.ozlabs.org>, Nick Piggin <npiggin@gmail.com>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Kees Cook <keescook@chromium.org> writes:
> On Thu, Feb 21, 2019 at 4:09 PM Russell Currey <ruscur@russell.cc> wrote:
>> On Thu, 2019-02-21 at 08:07 -0800, Kees Cook wrote:
>> > On Thu, Feb 21, 2019 at 1:36 AM Russell Currey <ruscur@russell.cc>
>> > wrote:
>> > > The first three patches of these series are from Christophe's work
>> > > and are
>> > > the bare minimum framework needed to implement the support for
>> > > radix.
>> > >
>> > > In patch 3, I have removed from Christophe's patch my
>> > > implementation of
>> > > the 64-bit exception handling code, since we don't have an answer
>> > > for
>> > > making nested exceptions work yet.  This is mentioned in the final
>> > > KUAP
>> > > patch.  Regardless, this is still a significant security
>> > > improvement
>> > > and greatly narrows the attack surface.
>> >
>> > Nice! Am I understanding correctly that with this series powerpc9 and
>> > later, using radix, will pass the lkdtm tests for KUAP and KUEP (i.e.
>> > EXEC_USERSPACE and ACCESS_USERSPACE)?
>>
>> Yes!  We've had execution prevention for a while on radix (which is
>> default on POWER9) since 3b10d0095a1e, the only functional thing this
>> series does is allow disabling it with nosmep.  This series adds access
>> prevention.
>
> Ah-ha; excellent. And CONFIG_PPC_RADIX_MMU is "default y" already. :)

Though on real hardware it doesn't really work yet, at least if there
are any idle states enabled.

Patch under discussion to fix it:

  https://patchwork.ozlabs.org/patch/1038568/


cheers
