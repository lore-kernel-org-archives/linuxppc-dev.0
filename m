Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDADEC5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 11:34:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03DF22145D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 11:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PGzuze/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DF22145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bRmF3wp2zF379
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 22:34:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="PGzuze/6";
	dkim-atps=neutral
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bRj760dFzF3JT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 22:32:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="PGzuze/6"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42bRj759Tmz8tGF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 22:32:11 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42bRj74zxsz9s8T; Thu, 18 Oct 2018 22:32:11 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=jannh@google.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="PGzuze/6"; 
 dkim-atps=neutral
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42bRj63c2dz9s89
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2018 22:32:09 +1100 (AEDT)
Received: by mail-oi1-x244.google.com with SMTP id w81-v6so23701179oiw.9
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2018 04:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EOCRZrj4Iex/osjC6/NcfF6n+ccK7Xle0oJanuKn7D8=;
 b=PGzuze/6k66K3bcRkAsw7VeWgUSlyVtjCpjd+H38zzXxDXkdOvhHQpQDyxpiyRPhaQ
 c/j+G25mH+DiHQu9NNEuSEz51cNn9Gp2EprmXSEctekB4gP3xMkjB/N7ktPuE8WjbJvW
 biTz9EuLXeiRLE0auRvQc/oaw4lB+1798RmDDm1jZ3BHoxJrynJ3bYFm57lcG5O8d/uP
 W8JvT5P1coE8mEfvagqDdSY7nPyHpKY9pZL0j/UwewQN5pmkrdtqPwkTArcJyj7OqhmU
 9/LoMqk5AGFG/CeLh57sT/2HAXtqIbfuzqZ40mib1EP6pLCW1VtBZgp6RVvTkp0ZKZgG
 K1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EOCRZrj4Iex/osjC6/NcfF6n+ccK7Xle0oJanuKn7D8=;
 b=ifukoDInL4EruGVpw+vyHDS3sLYt+bZGi11KjB1P0YSTbcLxoPxw0PleQWvM2YcRlA
 ysbKWz/nV4Pn8thI/6rPcDKhSirihqBCis3xH4O7PUn1wtxSaNKO1AvYxrQ2RRRugBWs
 pK8j/S21APS2S8G689Y6nhTrXWCaLiibmBiK4whXVK9Vj1gb/1rI0YgbIryq+F7gD7E7
 ml9jvrBvQ/t0vWSQfSDQwwTWDnHq73QHx7cLjRAPyGi5NMij0xGpap3p12t8vqa64JyU
 vMxuTA+Q3uKIWVXmcX41zOeCvPl4UX8mt1GMdp4CRzSdKP3q8S2QFHtYbJLda0NTNoi0
 Bk2w==
X-Gm-Message-State: ABuFfoi1fBJxJrnCP0K0RhhF9MoYeaJDBisP43RQHyUsUwD8OmY1C+jb
 wy+w7K8VpKUwggdvIiKpPUMEoMlwRun7UZReTmm4Ig==
X-Google-Smtp-Source: ACcGV60mz1kVCP2jmqjWFSyMsnjQxJ63W8GTw+E2ntNPSthEGG7pJRGx+NYVKTF5KdzlKDts3/f8W+mzwKYNjKSKFag=
X-Received: by 2002:aca:c045:: with SMTP id
 q66-v6mr16549005oif.22.1539862328031; 
 Thu, 18 Oct 2018 04:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181005132123.6038-1-mpe@ellerman.id.au>
 <6b3b54e5-cbe3-c693-23ea-26928e7597c8@c-s.fr>
 <CAG48ez2C9M8zgmubC2DLwqWzS7WzUj=nKhUuT4KkfWwS4v1Dig@mail.gmail.com>
 <73bd3821-2d5d-39f6-4d23-f8eae6d74cb3@c-s.fr>
In-Reply-To: <73bd3821-2d5d-39f6-4d23-f8eae6d74cb3@c-s.fr>
From: Jann Horn <jannh@google.com>
Date: Thu, 18 Oct 2018 13:31:41 +0200
Message-ID: <CAG48ez0VmPknETV9waKhBLVbshfQ2+n9AYi-3Hes7y8pn9VsGw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Don't print kernel instructions in
 show_user_instructions()
To: christophe.leroy@c-s.fr
Content-Type: text/plain; charset="UTF-8"
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

+cc x86 folks

On Thu, Oct 18, 2018 at 1:18 PM Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
> Le 18/10/2018 =C3=A0 13:12, Jann Horn a =C3=A9crit :
> > On Thu, Oct 18, 2018 at 11:28 AM Christophe LEROY
> > <christophe.leroy@c-s.fr> wrote:
> >> Le 05/10/2018 =C3=A0 15:21, Michael Ellerman a =C3=A9crit :
> >>> Recently we implemented show_user_instructions() which dumps the code
> >>> around the NIP when a user space process dies with an unhandled
> >>> signal. This was modelled on the x86 code, and we even went so far as
> >>> to implement the exact same bug, namely that if the user process
> >>> crashed with its NIP pointing into the kernel we will dump kernel tex=
t
> >>> to dmesg. eg:
> >>>
> >>>     bad-bctr[2996]: segfault (11) at c000000000010000 nip c0000000000=
10000 lr 12d0b0894 code 1
> >>>     bad-bctr[2996]: code: fbe10068 7cbe2b78 7c7f1b78 fb610048 38a1002=
8 38810020 fb810050 7f8802a6
> >>>     bad-bctr[2996]: code: 3860001c f8010080 48242371 60000000 <7c7b1b=
79> 4082002c e8010080 eb610048
> >>>
> >>> This was discovered on x86 by Jann Horn and fixed in commit
> >>> 342db04ae712 ("x86/dumpstack: Don't dump kernel memory based on userm=
ode RIP").
> >>>
> >>> Fix it by checking the adjusted NIP value (pc) and number of
> >>> instructions against USER_DS, and bail if we fail the check, eg:
> >>>
> >>>     bad-bctr[2969]: segfault (11) at c000000000010000 nip c0000000000=
10000 lr 107930894 code 1
> >>>     bad-bctr[2969]: Bad NIP, not dumping instructions.
> >>>
> >>> Fixes: 88b0fe175735 ("powerpc: Add show_user_instructions()")
> >>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> >>> ---
> >>>    arch/powerpc/kernel/process.c | 10 ++++++++++
> >>>    1 file changed, 10 insertions(+)
> >>>
> >>> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/proc=
ess.c
> >>> index 913c5725cdb2..bb6ac471a784 100644
> >>> --- a/arch/powerpc/kernel/process.c
> >>> +++ b/arch/powerpc/kernel/process.c
> >>> @@ -1306,6 +1306,16 @@ void show_user_instructions(struct pt_regs *re=
gs)
> >>>
> >>>        pc =3D regs->nip - (instructions_to_print * 3 / 4 * sizeof(int=
));
> >>>
> >>> +     /*
> >>> +      * Make sure the NIP points at userspace, not kernel text/data =
or
> >>> +      * elsewhere.
> >>> +      */
> >>> +     if (!__access_ok(pc, instructions_to_print * sizeof(int), USER_=
DS)) {
> >>> +             pr_info("%s[%d]: Bad NIP, not dumping instructions.\n",
> >>> +                     current->comm, current->pid);
> >>> +             return;
> >>> +     }
> >>> +
> >>
> >> Is there any reason for not using access_ok() here ?
> >
> > It's probably more robust this way, in case someone decides to call
> > into this from kernel exception context at some point, or something
> > like that?
> >
>
> But access_ok() uses current->thread.addr_limit, while USER_DS may
> provide a larger segment:
>
> #ifdef __powerpc64__
> /* We use TASK_SIZE_USER64 as TASK_SIZE is not constant */
> #define USER_DS         MAKE_MM_SEG(TASK_SIZE_USER64 - 1)
> #else
> #define USER_DS         MAKE_MM_SEG(TASK_SIZE - 1)
> #endif

Where do you write a smaller value than USER_DS into the addr_limit?

The kernel is full of places that assume that any access up to USER_DS
is safe; for example, perf_output_sample_ustack(),
get_perf_callchain(), do_exit(), flush_old_exec(), vma_dump_size(),
... - and I also don't see anything in the powerpc code that would
ever write a smaller value into the addr_limit.

I don't know powerpc well, but AFAIK the rule on X86 is basically that
even for compat tasks, attempting to access anything up to USER_DS is
safe because the kernel doesn't put any kernel mappings there. Is that
different on powerpc?
