Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A2AC282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 23:11:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CCED21019
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 23:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCED21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43lLdd4lJ2zDqKw
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 10:11:49 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43lLZ110nxzDqJh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2019 10:08:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43lLYy4klJz9s7h;
 Thu, 24 Jan 2019 10:08:38 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel] vfio-pci/nvlink2: Fix ancient gcc warnings
In-Reply-To: <CAMuHMdUuTPpYsLcJ2fnZpYQu36_uOELPBLaOQpmRqLaiHLLXEQ@mail.gmail.com>
References: <20190123040711.21759-1-aik@ozlabs.ru>
 <20190122213043.051d7739@x1.home>
 <CAMuHMdUuTPpYsLcJ2fnZpYQu36_uOELPBLaOQpmRqLaiHLLXEQ@mail.gmail.com>
Date: Thu, 24 Jan 2019 10:08:37 +1100
Message-ID: <878szbx98q.fsf@concordia.ellerman.id.au>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 KVM list <kvm@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> Hi Alex,
>
> On Wed, Jan 23, 2019 at 5:30 AM Alex Williamson
> <alex.williamson@redhat.com> wrote:
>> The below patch comes about from the build regressions and improvements
>> list you've sent out, but something doesn't add up that we'd be testing
>> with an old compiler where initialization with { 0 } generates a
>> "missing braces around initialization" warning.  Is this really the
>> case or are we missing something here?  There's no harm that I can see
>> with Alexey's fix, but are these really just false positives from a
>> compiler bug that we should selectively ignore if the "fix" is less
>> clean?  Thanks,
>
> Yes, they are false positives, AFAIK.
>
>> On Wed, 23 Jan 2019 15:07:11 +1100
>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>
>> > Using the {0} construct as a generic initializer is perfectly fine in C,
>> > however due to a bug in old gcc there is a warning:
>> >
>> >   + /kisskb/src/drivers/vfio/pci/vfio_pci_nvlink2.c: warning: (near
>> > initialization for 'cap.header') [-Wmissing-braces]:  => 181:9
>
> These all seem to come from an old gcc 4.6, which is the oldest still
> supported version for compiling Linux
> http://kisskb.ellerman.id.au/kisskb/buildresult/13663641/
>
> Note that kisskb is also using gcc 4.6.3 for s390x and mips, which are the only
> other builds showing missing braces warnings.

As documented here:

  https://www.kernel.org/doc/html/latest/process/changes.html#current-minimal-requirements

x86 has effectively dropped support for 4.6 because it doesn't support
retpoline and CONFIG_RETPOLINE is default y.

So it might be time to stop supporting 4.6, but I'd rather that happened
by someone sending a patch to change the requirements doc above, and
then kisskb can stop doing the builds with 4.6.

cheers
