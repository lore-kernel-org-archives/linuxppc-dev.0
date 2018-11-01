Return-Path: <SRS0=OEx3=NM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76709C0044C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 11:24:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA208205F4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 11:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA208205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42m2sK4QlmzF3N8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 22:24:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=fweimer@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42m2nj1tj4zF3N7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 22:20:57 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 41772307EA8A;
 Thu,  1 Nov 2018 11:20:55 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C59C2600CC;
 Thu,  1 Nov 2018 11:20:53 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: PIE binaries are no longer mapped below 4 GiB on ppc64le
References: <87k1lyf2x3.fsf@oldenburg.str.redhat.com>
 <87lg6dfo3t.fsf@concordia.ellerman.id.au>
Date: Thu, 01 Nov 2018 12:20:50 +0100
In-Reply-To: <87lg6dfo3t.fsf@concordia.ellerman.id.au> (Michael Ellerman's
 message of "Thu, 01 Nov 2018 14:55:34 +1100")
Message-ID: <871s85kprh.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 01 Nov 2018 11:20:55 +0000 (UTC)
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, keescook@chromium.org,
 amodra@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Michael Ellerman:

> Hi Florian,
>
> Florian Weimer <fweimer@redhat.com> writes:
>> We tried to use Go to build PIE binaries, and while the Go toolchain is
>> definitely not ready (it produces text relocations and problematic
>> relocations in general), it exposed what could be an accidental
>> userspace ABI change.
>>
>> With our 4.10-derived kernel, PIE binaries are mapped below 4 GiB, so
>> relocations like R_PPC64_ADDR16_HA work:
>>
>> 21f00000-220d0000 r-xp 00000000 fd:00 36593493                          =
 /root/extld
>> 220d0000-220e0000 r--p 001c0000 fd:00 36593493                          =
 /root/extld
>> 220e0000-22100000 rw-p 001d0000 fd:00 36593493                          =
 /root/extld
> ...
>>
>> With a 4.18-derived kernel (with the hashed mm), we get this instead:
>>
>> 120e60000-121030000 rw-p 00000000 fd:00 102447141                       =
 /root/extld
>> 121030000-121060000 rw-p 001c0000 fd:00 102447141                       =
 /root/extld
>> 121060000-121080000 rw-p 00000000 00:00 0=20
>
> I assume that's caused by:
>
>   47ebb09d5485 ("powerpc: move ELF_ET_DYN_BASE to 4GB / 4MB")
>
> Which did roughly:
>
>   -#define ELF_ET_DYN_BASE	0x20000000
>   +#define ELF_ET_DYN_BASE		(is_32bit_task() ? 0x000400000UL : \
>   +					   0x100000000UL)
>
> And went into 4.13.
>
>> ...
>> I'm not entirely sure what to make of this, but I'm worried that this
>> could be a regression that matters to userspace.
>
> It was a deliberate change, and it seemed to not break anything so we
> merged it. But obviously we didn't test widely enough.

* Michael Ellerman:

>> I'm not entirely sure what to make of this, but I'm worried that this
>> could be a regression that matters to userspace.
>
> It was a deliberate change, and it seemed to not break anything so we
> merged it. But obviously we didn't test widely enough.

Thanks for moving back the discussion to kernel matters. 8-)

> So I guess it clearly can matter to userspace, and it used to work, so
> therefore it is a regression.

Is there a knob to get back the old base address?

> But at the same time we haven't had any other reports of breakage, so is
> this somehow specific to something Go is doing?

Go uses 32-bit run-time relocations which (I think) were primarily
designed as link-time relocations for programs mapped under 4 GiB.  It's
amazing that the binaries work at all under old kernels.  On other
targets, the link editor refuses to produce an executable, or may even
produce a binary which crashes at run time.

> Or did we just get lucky up until now? Or is no one actually testing
> on Power? ;)

I'm not too worried about it.  It looks like a well-understood change to
me.  The glibc dynamic linker prints a reasonably informative error
message (in the sense that it doesn't crash without printing anything).
I think we can wait and see if someone comes up with a more compelling
case for backwards compatibility than the broken Go binaries (which we
will rebuild anyway because we don't want text relocations).  I assume
that it will be possible to add a personality flag if it ever proves
necessary=E2=80=94or maybe map the executable below 4 GiB in case of ASLR is
disabled, so that people have at least a workaround to get old binaries
going again.

But right now, that doesn't seem necessary.

Thanks,
Florian
