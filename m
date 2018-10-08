Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BC7C00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 08:24:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D1C2087D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 08:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D1C2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TD1h0v3czF3CC
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 19:24:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TCzW2tPrzF38t
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 19:23:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42TCzW2KLPz9sBh; Mon,  8 Oct 2018 19:23:03 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42TCzV74fjz9s9J;
 Mon,  8 Oct 2018 19:23:02 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jann Horn <jannh@google.com>
Subject: Re: [PATCH] powerpc: Don't print kernel instructions in
 show_user_instructions()
In-Reply-To: <CAG48ez3OZ5iquQeeqsy_SaLQF04hf6kphTSuP=OfsWC35G+TbA@mail.gmail.com>
References: <20181005132123.6038-1-mpe@ellerman.id.au>
 <CAG48ez3OZ5iquQeeqsy_SaLQF04hf6kphTSuP=OfsWC35G+TbA@mail.gmail.com>
Date: Mon, 08 Oct 2018 19:23:02 +1100
Message-ID: <87y3b826ft.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org, muriloo@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Jann Horn <jannh@google.com> writes:
> On Fri, Oct 5, 2018 at 3:21 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Recently we implemented show_user_instructions() which dumps the code
>> around the NIP when a user space process dies with an unhandled
>> signal. This was modelled on the x86 code, and we even went so far as
>> to implement the exact same bug, namely that if the user process
>> crashed with its NIP pointing into the kernel we will dump kernel text
>> to dmesg. eg:
>>
>>   bad-bctr[2996]: segfault (11) at c000000000010000 nip c000000000010000 lr 12d0b0894 code 1
>>   bad-bctr[2996]: code: fbe10068 7cbe2b78 7c7f1b78 fb610048 38a10028 38810020 fb810050 7f8802a6
>>   bad-bctr[2996]: code: 3860001c f8010080 48242371 60000000 <7c7b1b79> 4082002c e8010080 eb610048
>>
>> This was discovered on x86 by Jann Horn and fixed in commit
>> 342db04ae712 ("x86/dumpstack: Don't dump kernel memory based on usermode RIP").
>>
>> Fix it by checking the adjusted NIP value (pc) and number of
>> instructions against USER_DS, and bail if we fail the check, eg:
>
> This fix looks good to me.

Thanks.

> In the long term, I think it is somewhat awkward to use
> probe_kernel_address(), which uses set_fs(KERNEL_DS), when you
> actually just want to access userspace memory. It might make sense to
> provide a better helper for explicitly accessing memory with USER_DS.

Yes I agree, it's a bit messy. A probe_user_read() that sets USER_DS and
does the access_ok() check would be less error prone I think.

cheers
