Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620EFC46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 23:03:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5ED207DD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 23:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="iXJQ6uI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5ED207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42h2j03yB2zF3Dg
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 10:03:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="iXJQ6uI5";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=amacapital.net
 (client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com;
 envelope-from=luto@amacapital.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=amacapital.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=amacapital-net.20150623.gappssmtp.com
 header.i=@amacapital-net.20150623.gappssmtp.com header.b="iXJQ6uI5"; 
 dkim-atps=neutral
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42h2f13W1mzF3CJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 10:00:24 +1100 (AEDT)
Received: by mail-wm1-x342.google.com with SMTP id s10-v6so3069382wmc.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 16:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amacapital-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4xrjEd/VNJfR9BdiFe8658fSdCbGCDz2jw/S2VGKuSY=;
 b=iXJQ6uI5YYUwj8kSyhngpiQx2fDFmnA1pFCFI6aUuMzbKAfO+XyqSVWl3omRFrtl8k
 nYN8Hn9cu2KHsiTjEVqq0BW9+8EryAWI5ZEY0v9S4wYt4ons+nMwbixASITrGYekxOj6
 SvbYl/C32/Wpn2CLNdea4SqrhmO5CtsmMh5wIxBtnzupWCksEl34gXTLF9ZxsaEFoD8o
 mLNbrhJ3ojpDHt0pHOJHc2rdpe19aP/7eEfSPHSUJKb+1buau7LvD9Adano2fCyAC+t3
 ZfSGoBCuIeduAoseUqB1t8mjpPlDY08zAaqBJKB0N/K+Zk9HZbHCTsLcc2Il+xUbPLdd
 j6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4xrjEd/VNJfR9BdiFe8658fSdCbGCDz2jw/S2VGKuSY=;
 b=blVYzcwrzPmResN/3FtbCvl/8hg+YPkiYqzviTIKBgxXEE2DTrqlYCdMOB/Dqz5s7K
 oYOKjlu84iRMs8+t4O4VFJL1ihpb0bUbniLgcoqnw8rspRnMAfkdd3TiP1KI+O7/sunk
 uiy25pAeTdX+FRWvrcvlywdVU/uJC+W4zkDFLN083PIa9G1JXpea+uJQldCR3aBAYaeE
 HfkiKRqWSYaEl6ZiH6//KaPKEJtGB8Zef7U1rz9t2qaJ4QztXcEP+6DDy+2gmish589k
 GRnC8ivMwO/faR2cMolr/zm6H0trTW50wiaeUOFQC5jKBAWjy8O5HNwnuCK2H9j+5/xx
 e7sg==
X-Gm-Message-State: AGRZ1gLcRYbsHxRWlwy0vHpkGyKXqO3AIJqpwxlP+w6BMF79Sm89fWTe
 RLa3agiBPZlpWdtyosCp30yx4TJqpkU7YwmZQX/uNg==
X-Google-Smtp-Source: AJdET5cdk4mZhf9Fuzh7mMahzpNF7130eiFh886+8oC9e2QvPgBBXBTyHtMUKQI9lLTZWc/NsyLuhtRWXuZXHG225o4=
X-Received: by 2002:a1c:f312:: with SMTP id
 q18-v6mr3452213wmq.14.1540508421781; 
 Thu, 25 Oct 2018 16:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181024153523.10974-1-msammler@mpi-sws.org>
 <87zhv3nrr0.fsf@oldenburg.str.redhat.com>
 <11a706bd-060f-41de-118b-bababfd83b3d@mpi-sws.org>
 <875zxqo0ee.fsf@oldenburg.str.redhat.com>
 <c4d3f5c1-a2dc-5b44-4d12-1fae829a372c@mpi-sws.org>
In-Reply-To: <c4d3f5c1-a2dc-5b44-4d12-1fae829a372c@mpi-sws.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 25 Oct 2018 16:00:10 -0700
Message-ID: <CALCETrX_E5_p1-MjCcdtRQbziCCzXcOCfxRBckZx_zbO1QX=Dw@mail.gmail.com>
Subject: Re: [PATCH] seccomp: Add pkru into seccomp_data
To: Michael Sammler <msammler@mpi-sws.org>
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
Cc: Florian Weimer <fweimer@redhat.com>, Will Drewry <wad@chromium.org>,
 Kees Cook <keescook@chromium.org>, Linux API <linux-api@vger.kernel.org>,
 linuxram@us.ibm.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 25, 2018 at 9:42 AM Michael Sammler <msammler@mpi-sws.org> wrote:
>
> On 10/25/2018 11:12 AM, Florian Weimer wrote:
> >> I understand your concern about exposing the number of protection keys
> >> in the ABI. One idea would be to state, that the pkru field (which
> >> should probably be renamed) contains an architecture specific value,
> >> which could then be the PKRU on x86 and AMR (or another register) on
> >> POWER. This new field should probably be extended to __u64 and the
> >> reserved field removed.
> > POWER also has proper read/write bit separation, not PKEY_DISABLE_ACCESS
> > (disable read and write) and PKEY_DISABLE_WRITE like Intel.  It's
> > currently translated by the kernel, but I really need a
> > PKEY_DISABLE_READ bit in glibc to implement pkey_get in case the memory
> > is write-only.
> The idea here would be to simply provide the raw value of the register
> (PKRU on x86, AMR on POWER) to the BPF program and let the BPF program
> (or maybe a higher level library like libseccomp) deal with the
> complications of interpreting this architecture specific value (similar
> how the BPF program currently already has to deal with architecture
> specific system call numbers). If an architecture were to support more
> protection keys than fit into the field, the architecture specific value
> stored in the field might simply be the first protection keys. If there
> was interest, it would be possible to add more architecture specific
> fields to seccomp_data.
> >> Another idea would be to not add a field in the seccomp_data
> >> structure, but instead provide a new BPF instruction, which reads the
> >> value of a specified protection key.
> > I would prefer that if it's possible.  We should make sure that the bits
> > are the same as those returned from pkey_get.  I have an implementation
> > on POWER, but have yet to figure out the implications for 32-bit because
> > I do not know the AMR register size there.
> >
> > Thanks,
> > Florian
> I have had a look at how BPF is implemented and it does not seem to be
> easy to just add an BPF instruction for seccomp since (as far as I
> understand) the code of the classical BPF (as used by seccomp) is shared
> with the code of eBPF, which is used in many parts of the kernel and
> there is at least one interpreter and one JIT compiler for BPF. But
> maybe someone with more experience than me can comment on how hard it
> would be to add an instruction to BPF.
>

You could bite the bullet and add seccomp eBPF support :)
