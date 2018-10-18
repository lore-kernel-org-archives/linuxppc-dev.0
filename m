Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA026C5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 11:16:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3906521473
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 11:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="gh8RX83T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3906521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bRLq02QgzF3Lp
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 22:16:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="gh8RX83T";
	dkim-atps=neutral
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bRH82MNHzF3Hh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 22:13:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="gh8RX83T"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42bRH81f9Zz8tR6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 22:13:08 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42bRH81PVHz9s9h; Thu, 18 Oct 2018 22:13:08 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=jannh@google.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="gh8RX83T"; 
 dkim-atps=neutral
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42bRH71Z4Mz9s4Z
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2018 22:13:06 +1100 (AEDT)
Received: by mail-ot1-x342.google.com with SMTP id l58so29350650otd.6
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2018 04:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=E/4oE9wezcDll+pcbipGTFGxbPff2EBdyMwoAVIclV0=;
 b=gh8RX83TYucN23PqNTOanbAp0KRBavoNu66IvZZaLK+wms4TW1mqEYHZz972I6am7b
 xn2O9B/hBzhXAveC4bmKjK2eHsd1D30b2TBU+wGCKTf+fyZ7OhzRec8sZh2J0CaRyP5o
 3SP6+2AnJ6KZqQkOCgXRLTM1UY27TEt6LFZQdIM7y0oNa6RM/Txu8mfQwNoTBRUSfG3e
 any3tglXeh05+wJn1UeZhtgxPw3JGH88oQDm4NcMUqXQzScPKx8KWUgWugItmTfHfbl3
 o/GDMCDDHb6ebXoAkokdZ483hiPYUhQUlIBlDtJSqq4wcq0wf4AecqM0Z3GgChdRjNwc
 rrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=E/4oE9wezcDll+pcbipGTFGxbPff2EBdyMwoAVIclV0=;
 b=Yg1Ry6XZ/Vpwpn32R5GQEGb5fTdJuszugXsQT8pbkHL6O2TMBuoRUDXrkgWK+U44Oz
 KjE4knu3BPWsFJdCJlN65c8NjgDzujLwTAjHirVVkyRewvv4xThKe7SS8NxkW4tRZ4VT
 p+LU1F5AFcLjNPUhC3cx+Fffu8rcUljMUWUz1JuGUfD5AvV814VEdadDojnhZ85Z8pWc
 LwjwgI5Fj/jcESpUXgFkOvPV3anXvHEogHGbrj6neh0+oCKnZQa+hWTZRcQM4WYlFdch
 3w07hsQmr5XF9oSrsk4KrRtx0nnVFAm3dMvjJzUZidauf8CxuYnUTixuG0qHiSgJ/WiD
 /4XA==
X-Gm-Message-State: ABuFfoiIeRAAuQU6LtXBB3w/7PpP51+IF3sgOOGXlxapo/O6NN7P5qqj
 5E9SGZra2eWot8PAkXlaDEZFb+RPgL/R6/dXxRgAbwd3
X-Google-Smtp-Source: ACcGV61s4dv/YHGMtDAmDVg4GhSo6D2uH2/x0NFl3a7RwwnYh4pg+M1kSyzplHepdrSvTDukQzr0u5je6FEoCzaYfDY=
X-Received: by 2002:a9d:5122:: with SMTP id c31mr9080705oth.255.1539861184777; 
 Thu, 18 Oct 2018 04:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181005132123.6038-1-mpe@ellerman.id.au>
 <6b3b54e5-cbe3-c693-23ea-26928e7597c8@c-s.fr>
In-Reply-To: <6b3b54e5-cbe3-c693-23ea-26928e7597c8@c-s.fr>
From: Jann Horn <jannh@google.com>
Date: Thu, 18 Oct 2018 13:12:38 +0200
Message-ID: <CAG48ez2C9M8zgmubC2DLwqWzS7WzUj=nKhUuT4KkfWwS4v1Dig@mail.gmail.com>
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
Cc: muriloo@linux.ibm.com, linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 18, 2018 at 11:28 AM Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
> Le 05/10/2018 =C3=A0 15:21, Michael Ellerman a =C3=A9crit :
> > Recently we implemented show_user_instructions() which dumps the code
> > around the NIP when a user space process dies with an unhandled
> > signal. This was modelled on the x86 code, and we even went so far as
> > to implement the exact same bug, namely that if the user process
> > crashed with its NIP pointing into the kernel we will dump kernel text
> > to dmesg. eg:
> >
> >    bad-bctr[2996]: segfault (11) at c000000000010000 nip c0000000000100=
00 lr 12d0b0894 code 1
> >    bad-bctr[2996]: code: fbe10068 7cbe2b78 7c7f1b78 fb610048 38a10028 3=
8810020 fb810050 7f8802a6
> >    bad-bctr[2996]: code: 3860001c f8010080 48242371 60000000 <7c7b1b79>=
 4082002c e8010080 eb610048
> >
> > This was discovered on x86 by Jann Horn and fixed in commit
> > 342db04ae712 ("x86/dumpstack: Don't dump kernel memory based on usermod=
e RIP").
> >
> > Fix it by checking the adjusted NIP value (pc) and number of
> > instructions against USER_DS, and bail if we fail the check, eg:
> >
> >    bad-bctr[2969]: segfault (11) at c000000000010000 nip c0000000000100=
00 lr 107930894 code 1
> >    bad-bctr[2969]: Bad NIP, not dumping instructions.
> >
> > Fixes: 88b0fe175735 ("powerpc: Add show_user_instructions()")
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > ---
> >   arch/powerpc/kernel/process.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/proces=
s.c
> > index 913c5725cdb2..bb6ac471a784 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -1306,6 +1306,16 @@ void show_user_instructions(struct pt_regs *regs=
)
> >
> >       pc =3D regs->nip - (instructions_to_print * 3 / 4 * sizeof(int));
> >
> > +     /*
> > +      * Make sure the NIP points at userspace, not kernel text/data or
> > +      * elsewhere.
> > +      */
> > +     if (!__access_ok(pc, instructions_to_print * sizeof(int), USER_DS=
)) {
> > +             pr_info("%s[%d]: Bad NIP, not dumping instructions.\n",
> > +                     current->comm, current->pid);
> > +             return;
> > +     }
> > +
>
> Is there any reason for not using access_ok() here ?

It's probably more robust this way, in case someone decides to call
into this from kernel exception context at some point, or something
like that?
