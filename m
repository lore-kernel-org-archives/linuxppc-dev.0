Return-Path: <SRS0=+nHh=CJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FD4C433E6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2020 10:53:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1262068F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2020 10:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Ozd2P0eG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1262068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bg6W33bXfzDqR7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2020 20:53:19 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bg6SP6jKrzDqCV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2020 20:51:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Ozd2P0eG; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Bg6SN2NyCz9sTC;
 Mon, 31 Aug 2020 20:51:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1598871061;
 bh=ZZAJQJvRryT1vCEbjlLVfVIOqOgB+RwGIpoUmmkEPGs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Ozd2P0eG55xiM2gAZJj1SUwOum5IzCsW1mdSUR4pr/I6de7ytVK1bnDsPFU3ouspw
 7GnyLYuiZfoIMRmJxzn4xyDwZuE6HQAXi2Z4kT8d7aRmbZw/fK+r5kZrUBAzRzrCUG
 1nszpvnU7jvGVY3oWYSkB3VsFmPyVqoZv80qoONQfqbSfoP4QYN4G9/d89Mq2hlQ6L
 g1cPf78IyHpRALwvJhH1cgqDO9BwCM8FDz+2/HDavfvkVtSNYuUBZQV5dLLkbG1p/u
 U/k4Q6F9C7platTKInc7bFdjtW9C8WLmZo/qyUHPHSVghS56tVM5mS/X9syCbFcUfW
 vrM5hmIoo9kwA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>, Nicholas Piggin
 <npiggin@gmail.com>
Subject: Re: KVM on POWER8 host lock up since 10d91611f426 ("powerpc/64s:
 Reimplement book3s idle code in C")
In-Reply-To: <20200831091523.GC29521@kitsune.suse.cz>
References: <20200830201145.GA29521@kitsune.suse.cz>
 <1598835313.5688ngko4f.astroid@bobo.none>
 <20200831091523.GC29521@kitsune.suse.cz>
Date: Mon, 31 Aug 2020 20:50:59 +1000
Message-ID: <87y2lv1430.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, ro@suse.de,
 Hari Bathini <hbathini@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> On Mon, Aug 31, 2020 at 11:14:18AM +1000, Nicholas Piggin wrote:
>> Excerpts from Michal Such=C3=A1nek's message of August 31, 2020 6:11 am:
>> > Hello,
>> >=20
>> > on POWER8 KVM hosts lock up since commit 10d91611f426 ("powerpc/64s:
>> > Reimplement book3s idle code in C").
>> >=20
>> > The symptom is host locking up completely after some hours of KVM
>> > workload with messages like
>> >=20
>> > 2020-08-30T10:51:31+00:00 obs-power8-01 kernel: KVM: couldn't grab cpu=
 47
>> > 2020-08-30T10:51:31+00:00 obs-power8-01 kernel: KVM: couldn't grab cpu=
 71
>> > 2020-08-30T10:51:31+00:00 obs-power8-01 kernel: KVM: couldn't grab cpu=
 47
>> > 2020-08-30T10:51:31+00:00 obs-power8-01 kernel: KVM: couldn't grab cpu=
 71
>> > 2020-08-30T10:51:31+00:00 obs-power8-01 kernel: KVM: couldn't grab cpu=
 47
>> >=20
>> > printed before the host locks up.
>> >=20
>> > The machines run sandboxed builds which is a mixed workload resulting =
in
>> > IO/single core/mutiple core load over time and there are periods of no
>> > activity and no VMS runnig as well. The VMs are shortlived so VM
>> > setup/terdown is somewhat excercised as well.
>> >=20
>> > POWER9 with the new guest entry fast path does not seem to be affected.
>> >=20
>> > Reverted the patch and the followup idle fixes on top of 5.2.14 and
>> > re-applied commit a3f3072db6ca ("powerpc/powernv/idle: Restore IAMR
>> > after idle") which gives same idle code as 5.1.16 and the kernel seems
>> > stable.
>> >=20
>> > Config is attached.
>> >=20
>> > I cannot easily revert this commit, especially if I want to use the sa=
me
>> > kernel on POWER8 and POWER9 - many of the POWER9 fixes are applicable
>> > only to the new idle code.
>> >=20
>> > Any idea what can be the problem?
>>=20
>> So hwthread_state is never getting back to to HWTHREAD_IN_IDLE on
>> those threads. I wonder what they are doing. POWER8 doesn't have a good
>> NMI IPI and I don't know if it supports pdbg dumping registers from the
>> BMC unfortunately.
>
> It may be possible to set up fadump with a later kernel version that
> supports it on powernv and dump the whole kernel.

Your firmware won't support it AFAIK.

You could try kdump, but if we have CPUs stuck in KVM then there's a
good chance it won't work :/

cheers
