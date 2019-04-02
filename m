Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37CFC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:21:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B2820840
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B2820840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YJy70GfQzDqLF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 17:21:35 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YJwF6FpSzDqJs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 17:19:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44YJwF4k0Zz9sTQ; Tue,  2 Apr 2019 17:19:57 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44YJwF0hTGz9sTK;
 Tue,  2 Apr 2019 17:19:57 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "stable\@vger.kernel.org" <stable@vger.kernel.org>,
 "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH stable v4.14 13/32] powerpc/fsl: Add barrier_nospec
 implementation for NXP PowerPC Book3E
In-Reply-To: <763028d666042f5642104b42aaa416c2867baa31.camel@infinera.com>
References: <20190329112620.14489-1-mpe@ellerman.id.au>
 <20190329112620.14489-14-mpe@ellerman.id.au>
 <763028d666042f5642104b42aaa416c2867baa31.camel@infinera.com>
Date: Tue, 02 Apr 2019 17:19:56 +1100
Message-ID: <87imvxorn7.fsf@concordia.ellerman.id.au>
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
Cc: "diana.craciun@nxp.com" <diana.craciun@nxp.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "msuchanek@suse.de" <msuchanek@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Joakim Tjernlund <Joakim.Tjernlund@infinera.com> writes:
> On Fri, 2019-03-29 at 22:26 +1100, Michael Ellerman wrote:
>> From: Diana Craciun <diana.craciun@nxp.com>
>> 
>> commit ebcd1bfc33c7a90df941df68a6e5d4018c022fba upstream.
>> 
>> Implement the barrier_nospec as a isync;sync instruction sequence.
>> The implementation uses the infrastructure built for BOOK3S 64.
>> 
>> Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
>> [mpe: Split out of larger patch]
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> What is the performanc impact of these spectre fixes?

I've not seen any numbers from anyone.

It will depend on the workload, it's copy to/from user that is most
likely to show an impact.

We have a context switch benchmark in
tools/testing/selftests/powerpc/benchmarks/context_switch.c.

Running that with "--no-vector --no-altivec --no-fp --test=pipe" shows
about a 2.3% slow down vs booting with "nospectre_v1".

> Can I compile it away?

You can't actually, but you can disable it at runtime with
"nospectre_v1" on the kernel command line.

We could make it a user selectable compile time option if you really
want it to be.

cheers
