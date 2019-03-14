Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2AEC4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 13:03:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F522184C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 13:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F522184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KpmN3TDrzDqNT
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 00:03:16 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Kpjr4WgvzDqLk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 00:01:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44Kpjr3J5Pz9s5c; Fri, 15 Mar 2019 00:01:04 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44Kpjp5fV9z9s55;
 Fri, 15 Mar 2019 00:01:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies
 across Y2038
In-Reply-To: <CAK8P3a0A9dbneHo7_CrgiPS8ROaV1bWrYWJUh5Zo2FfEuABfhw@mail.gmail.com>
References: <20190313131438.8212-1-mpe@ellerman.id.au>
 <CAK8P3a0A9dbneHo7_CrgiPS8ROaV1bWrYWJUh5Zo2FfEuABfhw@mail.gmail.com>
Date: Fri, 15 Mar 2019 00:00:59 +1100
Message-ID: <871s398vas.fsf@concordia.ellerman.id.au>
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@ozlabs.org, John Stultz <john.stultz@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, jaydee@email.cz
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Arnd Bergmann <arnd@arndb.de> writes:
> On Wed, Mar 13, 2019 at 2:14 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> That causes CLOCK_MONOTONIC to jump ahead by ~4 billion seconds which
>> it is not meant to do. Worse, if the time is then set back before the
>> Y2038 boundary CLOCK_MONOTONIC will jump backward.
>>
>> We can fix it simply by storing the full 64-bit offset in the
>> vdso_data, and using that in the VDSO assembly code. We also shuffle
>> some of the fields in vdso_data to avoid creating a hole.
>
> I see nothing wrong with your patch,

Thanks.

> but I would point out that there is a patch series [1] from Vincenzo
> Frascino to unify the vdso implementation across architectures that I
> hope can make it into linux-5.2, and that will resolve this issue, as
> well as allow 32-bit architectures to provide a working interface with
> 64-bit time_t.

Yeah I did see that series. I will try and keep an eye on it, though I'm
not sure I'll have time to convert powerpc to use it for 5.2.

I'm also not sure how easy it's going to be to convert to the C
versions, because our syscall ABI is not a simple function call (result
code is returned in CR0.SO).

cheers
