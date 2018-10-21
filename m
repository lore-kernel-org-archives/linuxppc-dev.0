Return-Path: <SRS0=xfaR=NB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3A7ECDE43
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Oct 2018 12:52:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 217452083E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Oct 2018 12:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217452083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42dKLN6c7tzF0x7
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Oct 2018 23:52:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42dKJ24XD0zDsQ6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Oct 2018 23:50:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42dKJ23pwvz9sDb; Sun, 21 Oct 2018 23:50:26 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42dKHz4mCXz9sCw;
 Sun, 21 Oct 2018 23:50:23 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jann Horn <jannh@google.com>, christophe.leroy@c-s.fr
Subject: Re: [PATCH] powerpc: Don't print kernel instructions in
 show_user_instructions()
In-Reply-To: <CAG48ez0VmPknETV9waKhBLVbshfQ2+n9AYi-3Hes7y8pn9VsGw@mail.gmail.com>
References: <20181005132123.6038-1-mpe@ellerman.id.au>
 <6b3b54e5-cbe3-c693-23ea-26928e7597c8@c-s.fr>
 <CAG48ez2C9M8zgmubC2DLwqWzS7WzUj=nKhUuT4KkfWwS4v1Dig@mail.gmail.com>
 <73bd3821-2d5d-39f6-4d23-f8eae6d74cb3@c-s.fr>
 <CAG48ez0VmPknETV9waKhBLVbshfQ2+n9AYi-3Hes7y8pn9VsGw@mail.gmail.com>
Date: Sun, 21 Oct 2018 23:50:23 +1100
Message-ID: <87lg6rfoq8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 muriloo@linux.ibm.com, Thomas Gleixner <tglx@linutronix.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Jann Horn <jannh@google.com> writes:
> +cc x86 folks
>
> On Thu, Oct 18, 2018 at 1:18 PM Christophe LEROY
> <christophe.leroy@c-s.fr> wrote:
>> Le 18/10/2018 =C3=A0 13:12, Jann Horn a =C3=A9crit :
>> > On Thu, Oct 18, 2018 at 11:28 AM Christophe LEROY
>> > <christophe.leroy@c-s.fr> wrote:
>> >> Le 05/10/2018 =C3=A0 15:21, Michael Ellerman a =C3=A9crit :
>> >>> Recently we implemented show_user_instructions() which dumps the code
>> >>> around the NIP when a user space process dies with an unhandled
>> >>> signal. This was modelled on the x86 code, and we even went so far as
>> >>> to implement the exact same bug, namely that if the user process
>> >>> crashed with its NIP pointing into the kernel we will dump kernel te=
xt
>> >>> to dmesg. eg:
>> >>>
>> >>>     bad-bctr[2996]: segfault (11) at c000000000010000 nip c000000000=
010000 lr 12d0b0894 code 1
>> >>>     bad-bctr[2996]: code: fbe10068 7cbe2b78 7c7f1b78 fb610048 38a100=
28 38810020 fb810050 7f8802a6
>> >>>     bad-bctr[2996]: code: 3860001c f8010080 48242371 60000000 <7c7b1=
b79> 4082002c e8010080 eb610048
>> >>>
>> >>> This was discovered on x86 by Jann Horn and fixed in commit
>> >>> 342db04ae712 ("x86/dumpstack: Don't dump kernel memory based on user=
mode RIP").
>> >>>
>> >>> Fix it by checking the adjusted NIP value (pc) and number of
>> >>> instructions against USER_DS, and bail if we fail the check, eg:
>> >>>
>> >>>     bad-bctr[2969]: segfault (11) at c000000000010000 nip c000000000=
010000 lr 107930894 code 1
>> >>>     bad-bctr[2969]: Bad NIP, not dumping instructions.
>> >>>
>> >>> Fixes: 88b0fe175735 ("powerpc: Add show_user_instructions()")
>> >>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> >>> ---
>> >>>    arch/powerpc/kernel/process.c | 10 ++++++++++
>> >>>    1 file changed, 10 insertions(+)
>> >>>
>> >>> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/pro=
cess.c
>> >>> index 913c5725cdb2..bb6ac471a784 100644
>> >>> --- a/arch/powerpc/kernel/process.c
>> >>> +++ b/arch/powerpc/kernel/process.c
>> >>> @@ -1306,6 +1306,16 @@ void show_user_instructions(struct pt_regs *r=
egs)
>> >>>
>> >>>        pc =3D regs->nip - (instructions_to_print * 3 / 4 * sizeof(in=
t));
>> >>>
>> >>> +     /*
>> >>> +      * Make sure the NIP points at userspace, not kernel text/data=
 or
>> >>> +      * elsewhere.
>> >>> +      */
>> >>> +     if (!__access_ok(pc, instructions_to_print * sizeof(int), USER=
_DS)) {
>> >>> +             pr_info("%s[%d]: Bad NIP, not dumping instructions.\n",
>> >>> +                     current->comm, current->pid);
>> >>> +             return;
>> >>> +     }
>> >>> +
>> >>
>> >> Is there any reason for not using access_ok() here ?
>> >
>> > It's probably more robust this way, in case someone decides to call
>> > into this from kernel exception context at some point, or something
>> > like that?
>> >
>>
>> But access_ok() uses current->thread.addr_limit, while USER_DS may
>> provide a larger segment:
>>
>> #ifdef __powerpc64__
>> /* We use TASK_SIZE_USER64 as TASK_SIZE is not constant */
>> #define USER_DS         MAKE_MM_SEG(TASK_SIZE_USER64 - 1)
>> #else
>> #define USER_DS         MAKE_MM_SEG(TASK_SIZE - 1)
>> #endif
>
> Where do you write a smaller value than USER_DS into the addr_limit?

I don't think we do.

> The kernel is full of places that assume that any access up to USER_DS
> is safe; for example, perf_output_sample_ustack(),
> get_perf_callchain(), do_exit(), flush_old_exec(), vma_dump_size(),
> ... - and I also don't see anything in the powerpc code that would
> ever write a smaller value into the addr_limit.
>
> I don't know powerpc well, but AFAIK the rule on X86 is basically that
> even for compat tasks, attempting to access anything up to USER_DS is
> safe because the kernel doesn't put any kernel mappings there. Is that
> different on powerpc?

That's how it works on powerpc too.

A compat task will have a TASK_SIZE of 4GB - 1 page, but the kernel is
still at c000000000000000 and there aren't any kernel mappings below
that. So it's still safe to just check against the maximum possible user
address, which is 4PB.

cheers
