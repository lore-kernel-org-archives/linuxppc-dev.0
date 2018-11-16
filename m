Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C02C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 12:50:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FAC92087C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 12:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FAC92087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xJ4b6zPKzF3nd
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 23:50:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xJ013XKjzF3nC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 23:46:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42xHzz4Bftz9sBn;
 Fri, 16 Nov 2018 23:46:55 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sandipan Das <sandipan@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64: Fix kernel stack 16-byte alignment
In-Reply-To: <6627fcee-17c9-4e04-35c8-898663aac85c@linux.ibm.com>
References: <20181115023427.31033-1-npiggin@gmail.com>
 <6627fcee-17c9-4e04-35c8-898663aac85c@linux.ibm.com>
Date: Fri, 16 Nov 2018 23:46:55 +1100
Message-ID: <87a7m92nr4.fsf@concordia.ellerman.id.au>
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
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Sandipan Das <sandipan@linux.ibm.com> writes:

> On 15/11/18 8:04 AM, Nicholas Piggin wrote:
>> Commit 4c2de74cc869 ("powerpc/64: Interrupts save PPR on stack rather
>> than thread_struct") changed sizeof(struct pt_regs) % 16 from 0 to 8,
>> which causes the interrupt frame allocation on kernel entry to put the
>> kernel stack out of alignment.
>> 
>> Add a pad field to fix alignment, and add a BUILD_BUG_ON to catch this
>> in future.
>> 
>> Fixes: 4c2de74cc869 ("powerpc/64: Interrupts save PPR on stack rather
>> than thread_struct")
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> [...]
>
> Thanks for fixing this. Commit 4c2de74cc869 ("powerpc/64: Interrupts save
> PPR on stack rather than thread_struct") was also leading to incorrect
> kernel stack traces.

OK thanks.

In future if you see something weird like that please report it to the
list.

cheers

> E.g.
> If you are using `perf record -g` and expect to see a stack trace like this:
>
>         c0000000002b19a0 bpf_check+0x1910 (/usr/lib/debug/lib/modules/4.18.17-200.fc28.ppc64le/vmlinux)
>         c0000000002a5554 bpf_prog_load+0x684 (/usr/lib/debug/lib/modules/4.18.17-200.fc28.ppc64le/vmlinux)
>         c0000000002a6938 sys_bpf+0xaf8 (/usr/lib/debug/lib/modules/4.18.17-200.fc28.ppc64le/vmlinux)
>         c00000000000b9e4 system_call+0x5c (/usr/lib/debug/lib/modules/4.18.17-200.fc28.ppc64le/vmlinux)
>             7fff815bca90 syscall+0x50 (/usr/lib64/libc-2.27.so)
>             7fff7d96ee0c bpf_prog_load+0x16c (/usr/lib64/libbcc.so.0.7.0)
> [...]
>
> you would instead see something like this:
>
>         c0000000002bdb88 bpf_check+0xb88 (/lib/modules/4.20.0-rc1+/build/vmlinux)
>         c0000000002bdb60 bpf_check+0xb60 (/lib/modules/4.20.0-rc1+/build/vmlinux)
>             3fff8f350a90 syscall+0x50 (/usr/lib64/libc-2.27.so)
>             3fff8b788e0c bpf_prog_load+0x16c (/usr/lib64/libbcc.so.0.7.0)
> [...]
>
> --
> With Regards,
> Sandipan
