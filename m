Return-Path: <SRS0=VpCV=5J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF7AC43331
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 02:56:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E07C20409
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 02:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKTO6TqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E07C20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48mbVd3Wj9zDr08
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 13:56:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::341;
 helo=mail-ot1-x341.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=WKTO6TqW; dkim-atps=neutral
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48mbSh0437zDqSP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2020 13:54:41 +1100 (AEDT)
Received: by mail-ot1-x341.google.com with SMTP id a49so15680675otc.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2020 19:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/bu3Qy6roHJnjU6fPV0Tm4m7rvRoThB4EXQuI3xrPlI=;
 b=WKTO6TqWisKLWubGDk9HoFWfBt8l/9JJFR87YDvS+b6sEpsPKVpqqItOIqNUc6OFRU
 ou/6RqCN9/tiDa/4Ue5bBLIWSSUW5yKT6qAWq5NS9KXjWNCplo6rSanNwF2ECopg3Z/a
 UaIOT5H3P5ATN10HTCcSoAzXUWWCnOVEkgXAtgR09oNYinh7yxoJss4pJOiUNM++rcQG
 qzWCgLtYnr9o+F7HCp9XphcnfYOgSZEM+TRX0NdsD/IyQJiTUzz2pr69xPVgyIKYJeUa
 Zm0TWjqMFGQg86v/BmrdDr9raqt6CC/6UR8LhU8CH/AqNpflEC3cvqeNVCZYwHNc8Kla
 aspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/bu3Qy6roHJnjU6fPV0Tm4m7rvRoThB4EXQuI3xrPlI=;
 b=fkr7CwUHZXA+C2UO3QKoxyTxNmoNU/Em9qMdL6aI6ymfBSXjRSP6mL6n+PMHXEhqtG
 bmPXratz9oSIAfMIig7DdEwLyofeAZRSQaLLL0YHMtfo0ME88Wm45TZAsG1LW2ims/0i
 03fo5wiMe8cCpUV2I9+ARdWQ2KUe3845/wsB4Ez/yw/3qTVCMKQisYITohxNM+/5Eu5+
 yKuFuJQHpOB17+3lwOnti+mqUQiB6YRgbzT/U2y3OyynzAahCodNQmYmZLyzXAW2iMUP
 mNfsqba45SzC/MvtYBK0n6kxTI97ef/XmzjKEE+s4fVIW+jowexIdlawKffSqAS86i9p
 8ceA==
X-Gm-Message-State: ANhLgQ3eUiGSRunK7f6KyzaokFWXToMEsrKq+HhBKvnPtRgrRnkWWs4R
 NEC0Uf4ExyV+rqE9Fk3GIoYANV6MLcXCid3Rcr8=
X-Google-Smtp-Source: ADFU+vu1huIWOHsmklnoAIaXNQiri16smakceQeftT/BMETqVeouSNe9BJPoJlGzVPsKIX8A7wdE/6TsrwdGDTCfYIk=
X-Received: by 2002:a05:6830:1683:: with SMTP id
 k3mr10357439otr.28.1585018478387; 
 Mon, 23 Mar 2020 19:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200320051809.24332-1-jniethe5@gmail.com>
 <1584944279.gvl0lg5dde.astroid@bobo.none>
 <CACzsE9r5uvL-zp34VrCqO_RTEsXPbLrt2iu+MHL-apapydOugA@mail.gmail.com>
 <1584957138.lj5a68bk6x.astroid@bobo.none>
In-Reply-To: <1584957138.lj5a68bk6x.astroid@bobo.none>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Tue, 24 Mar 2020 13:54:27 +1100
Message-ID: <CACzsE9qrNpfvoLKfdeXths4rKJ8jQcUic3=dFZ57ntogdeaMug@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] Initial Prefixed Instruction support
To: Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alistair Popple <alistair@popple.id.au>,
 Balamuruhan S <bala24@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 23, 2020 at 9:21 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Jordan Niethe's on March 23, 2020 7:25 pm:
> > On Mon, Mar 23, 2020 at 5:22 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >>
> >> Jordan Niethe's on March 20, 2020 3:17 pm:
> >> > A future revision of the ISA will introduce prefixed instructions. A
> >> > prefixed instruction is composed of a 4-byte prefix followed by a
> >> > 4-byte suffix.
> >> >
> >> > All prefixes have the major opcode 1. A prefix will never be a valid
> >> > word instruction. A suffix may be an existing word instruction or a
> >> > new instruction.
> >> >
> >> > This series enables prefixed instructions and extends the instruction
> >> > emulation to support them. Then the places where prefixed instructions
> >> > might need to be emulated are updated.
> >> >
> >> > The series is based on top of:
> >> > https://patchwork.ozlabs.org/patch/1232619/ as this will effect
> >> > kprobes.
> >> >
> >> > v4 is based on feedback from Nick Piggins, Christophe Leroy and Daniel Axtens.
> >> > The major changes:
> >> >     - Move xmon breakpoints from data section to text section
> >> >     - Introduce a data type for instructions on powerpc
> >>
> >> Thanks for doing this, looks like a lot of work, I hope it works out :)
> >>
> > Yes it did end up touching a lot of places. I started thinking that
> > that maybe it would be simpler to just use a u64 instead of the struct
> > for  instructions.
> > If we always keep the word instruction / prefix in the lower bytes,
> > all of the current masking should still work and we can use operators
> > again instead of ppc_inst_equal(), etc.
>
> Yeah.. I think now that you've done it, I prefer it this way.
Sorry, just to be clear which way do you mean?
>
> > It also makes printing easier. We could just #define INST_FMT %llx or
> > #define INST_FMT %x on powerpc32 and use that for printing out
> > instructions.
>
> Well, not sure about that. Would it make endian concerns more
> complicated? Print format for prefix might be '%016llx', but we
> don't want that for all instructions only prefixed ones, and I
> don't know if that is the way to go either.
Hm yeah that is true.
>
> We'll want to adopt some convention for displaying prefixed
> instruction bytes, but I don't know what what works best. I wonder
> if binutils or any userspace tools have a convention.
binutils-gdb upstream has supports disassembling prefixed instructions.
Here is what objdump looks like:
  44:    00 00 00 60     nop
  48:    00 00 00 07     pnop
  4c:    00 00 00 00
  50:    01 00 20 39     li      r9,1
  54:    00 00 00 06     paddi   r4,r9,3
  58:    03 00 89 38
  5c:    00 00 62 3c     addis   r3,r2,0
>
> Which reminds me, you might have missed show_instructions()?
> Although maybe you don't need that until we start using them in
> the kernel.
You are right I missed that here.
>
> Thanks,
> Nick
