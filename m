Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFB5C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 10:15:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB4DD206B7
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 10:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4DD206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Yp743blPzDqQ4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 21:15:44 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Yp5H677jzDqPm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 21:14:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43Yp5D5H79z9sDr;
 Tue,  8 Jan 2019 21:14:08 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh+dt@kernel.org>, Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH] powerpc: build dtb even without COMPILE_TEST
In-Reply-To: <CAL_Jsq+Wo7kWTHg6f+HkTfq1=JN8r4iBrwSz9JRdJ0rhjyKSpg@mail.gmail.com>
References: <1546595897-33291-1-git-send-email-clabbe@baylibre.com>
 <CAL_Jsq+Wo7kWTHg6f+HkTfq1=JN8r4iBrwSz9JRdJ0rhjyKSpg@mail.gmail.com>
Date: Tue, 08 Jan 2019 21:14:07 +1100
Message-ID: <87bm4rtq1c.fsf@concordia.ellerman.id.au>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Rob Herring <robh+dt@kernel.org> writes:
> On Fri, Jan 4, 2019 at 3:58 AM Corentin Labbe <clabbe@baylibre.com> wrote:
>>
>> I wanted to test the virtex440-ml507 qemu machine and found that the dtb
>> for it was not builded.
>
> Just do:
>
> make virtex440-ml507.dtb

I actually thought you had to do that, so I've never done anything different.

>> All powerpc DTB are only built when CONFIG_OF_ALL_DTBS is set which depend on
>> COMPILE_TEST.
>> But building DTB is not related to a "compile build test".
>
> But it is. We normally only build the dtbs for enabled platforms just
> like we only build platform/driver code for enabled platforms. It's
> hidden behind COMPILE_TEST so it only gets enabled for
> allmodconfig/allyesconfig builds.
>
>> So this patch made building of DTB independent of COMPILE_TEST (by
>> depending only on the PPC arch)
>> A better selection of which DTB to build could be done in the future
>> like that do the ARM arch.
>
> No reason you can't start that now for the platform you care about.
> You don't have to convert everyone.

Yeah that seems like the best option. I'm happy to take a patch just for
that target.

cheers
