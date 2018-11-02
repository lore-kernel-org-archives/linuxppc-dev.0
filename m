Return-Path: <SRS0=pcIm=NN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0837BC32789
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 09:43:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5519A20657
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 09:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5519A20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42mcZz4dhwzF36s
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 20:43:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42mcXz3KJ6zF36d
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Nov 2018 20:41:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42mcXz0DlkzB4V8;
 Fri,  2 Nov 2018 20:41:55 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alan Modra <amodra@gmail.com>
Subject: Re: PIE binaries are no longer mapped below 4 GiB on ppc64le
In-Reply-To: <20181101064911.GB29482@bubble.grove.modra.org>
References: <87k1lyf2x3.fsf@oldenburg.str.redhat.com>
 <87lg6dfo3t.fsf@concordia.ellerman.id.au>
 <20181101064911.GB29482@bubble.grove.modra.org>
Date: Fri, 02 Nov 2018 20:41:54 +1100
Message-ID: <87d0rnerz1.fsf@concordia.ellerman.id.au>
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
Cc: Florian Weimer <fweimer@redhat.com>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, keescook@chromium.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Alan Modra <amodra@gmail.com> writes:
> On Thu, Nov 01, 2018 at 02:55:34PM +1100, Michael Ellerman wrote:
>> Hi Florian,
>> 
>> Florian Weimer <fweimer@redhat.com> writes:
>> > We tried to use Go to build PIE binaries, and while the Go toolchain is
>> > definitely not ready (it produces text relocations and problematic
>> > relocations in general), it exposed what could be an accidental
>> > userspace ABI change.
>> >
>> > With our 4.10-derived kernel, PIE binaries are mapped below 4 GiB, so
>> > relocations like R_PPC64_ADDR16_HA work:
>> >
>> > 21f00000-220d0000 r-xp 00000000 fd:00 36593493                           /root/extld
>> > 220d0000-220e0000 r--p 001c0000 fd:00 36593493                           /root/extld
>> > 220e0000-22100000 rw-p 001d0000 fd:00 36593493                           /root/extld
>> ...
>> >
>> > With a 4.18-derived kernel (with the hashed mm), we get this instead:
>> >
>> > 120e60000-121030000 rw-p 00000000 fd:00 102447141                        /root/extld
>> > 121030000-121060000 rw-p 001c0000 fd:00 102447141                        /root/extld
>> > 121060000-121080000 rw-p 00000000 00:00 0 
>> 
>> I assume that's caused by:
>> 
>>   47ebb09d5485 ("powerpc: move ELF_ET_DYN_BASE to 4GB / 4MB")
>> 
>> Which did roughly:
>> 
>>   -#define ELF_ET_DYN_BASE	0x20000000
>>   +#define ELF_ET_DYN_BASE		(is_32bit_task() ? 0x000400000UL : \
>>   +					   0x100000000UL)
>> 
>> And went into 4.13.
>> 
>> > ...
>> > I'm not entirely sure what to make of this, but I'm worried that this
>> > could be a regression that matters to userspace.
>> 
>> It was a deliberate change, and it seemed to not break anything so we
>> merged it. But obviously we didn't test widely enough.
>> 
>> So I guess it clearly can matter to userspace, and it used to work, so
>> therefore it is a regression.
>> 
>> But at the same time we haven't had any other reports of breakage, so is
>> this somehow specific to something Go is doing? Or did we just get lucky
>> up until now? Or is no one actually testing on Power? ;)
>
> Mapping PIEs above 4G should be fine.  It works for gcc C and C++
> after all.  The problem is that ppc64le Go is generating code not
> suitable for a PIE.  Dynamic text relocations are evidence of non-PIC
> object files.
>
> Quoting Lynn Boger <boger@us.ibm.com>:
> "When building a pie binary with golang, they should be using
> -buildmode=pie and not just pass -pie to the linker".

Thanks Alan.

So this isn't a kernel bug per se, but the the old behaviour falls in
the category of "shouldn't have worked but did by accident", and so the
question is just how wide spread is the userspace breakage.

At least so far it seems not very wide spread, so we'll leave things as
they are for now. As Florian said we can always add a personality flag
in future if we need to.

cheers
