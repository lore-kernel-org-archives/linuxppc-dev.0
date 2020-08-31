Return-Path: <SRS0=+nHh=CJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CCDC433E6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2020 13:02:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60106206CD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2020 13:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Wh41E6xQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60106206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bg9Ml2xbBzDq9D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2020 23:02:11 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bg9JP6WXszDqQD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2020 22:59:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Wh41E6xQ; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Bg9JN5GDxz9sTR;
 Mon, 31 Aug 2020 22:59:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1598878756;
 bh=7PlyIY2IkMBgULpce0EFX69hEEL1xsd6L/k2Ni+fCtI=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=Wh41E6xQhuQkJhmB9i4UzxPfdlqREa3dmjmG+i85au9vRDAmmFvOl5SOknjcRVf0b
 Lszjpl47uy5p8aHfvLGRViRL+1KVw3Q3T4EDe+k5670D1NayhnfuOE43WbdlNJWTbe
 CGfJtC4egCo9yZod1+tnDlGQKCo/nqFUtyPxpUKMp22ud2kLKcR/XSwFoEMx4CrczB
 xopQQhTqArneQzRZ/i6/57Roj8nA1lsWzKZEY79+a1MQPVKL0SKKTZrKCzZHLeGMdM
 1YKL6Fn2WfeJ9EX0X022bu2w64OmbJsqLPQkAYnBzew3nZKK2qoxOQiLkeQ+heoq5z
 TVt0f2Micd0hw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ruediger Oertel <ro@suse.de>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>
Subject: Re: KVM on POWER8 host lock up since 10d91611f426 ("powerpc/64s:
 Reimplement book3s idle code in C")
In-Reply-To: <50693d7e-6c8b-4908-d003-25b99a867850@suse.de>
References: <20200830201145.GA29521@kitsune.suse.cz>
 <1598835313.5688ngko4f.astroid@bobo.none>
 <50693d7e-6c8b-4908-d003-25b99a867850@suse.de>
Date: Mon, 31 Aug 2020 22:58:49 +1000
Message-ID: <87v9gz0y5y.fsf@mpe.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Ruediger Oertel <ro@suse.de> writes:
> Am 31.08.20 um 03:14 schrieb Nicholas Piggin:
>> Excerpts from Michal Such=C3=A1nek's message of August 31, 2020 6:11 am:
>>> Hello,
>>>
>>> on POWER8 KVM hosts lock up since commit 10d91611f426 ("powerpc/64s:
>>> Reimplement book3s idle code in C").
>>>
>>> The symptom is host locking up completely after some hours of KVM
>>> workload with messages like
>>>
>>> 2020-08-30T10:51:31+00:00 obs-power8-01 kernel: KVM: couldn't grab cpu =
47
>>> 2020-08-30T10:51:31+00:00 obs-power8-01 kernel: KVM: couldn't grab cpu =
71
>>> 2020-08-30T10:51:31+00:00 obs-power8-01 kernel: KVM: couldn't grab cpu =
47
>>> 2020-08-30T10:51:31+00:00 obs-power8-01 kernel: KVM: couldn't grab cpu =
71
>>> 2020-08-30T10:51:31+00:00 obs-power8-01 kernel: KVM: couldn't grab cpu =
47
>>>
>>> printed before the host locks up.
>>>
>>> The machines run sandboxed builds which is a mixed workload resulting in
>>> IO/single core/mutiple core load over time and there are periods of no
>>> activity and no VMS runnig as well. The VMs are shortlived so VM
>>> setup/terdown is somewhat excercised as well.
>>>
>>> POWER9 with the new guest entry fast path does not seem to be affected.
>>>
>>> Reverted the patch and the followup idle fixes on top of 5.2.14 and
>>> re-applied commit a3f3072db6ca ("powerpc/powernv/idle: Restore IAMR
>>> after idle") which gives same idle code as 5.1.16 and the kernel seems
>>> stable.
>>>
>>> Config is attached.
>>>
>>> I cannot easily revert this commit, especially if I want to use the same
>>> kernel on POWER8 and POWER9 - many of the POWER9 fixes are applicable
>>> only to the new idle code.
>>>
>>> Any idea what can be the problem?
>>=20
>> So hwthread_state is never getting back to to HWTHREAD_IN_IDLE on
>> those threads. I wonder what they are doing. POWER8 doesn't have a good
>> NMI IPI and I don't know if it supports pdbg dumping registers from the
>> BMC unfortunately. Do the messages always come in pairs of CPUs?
>>=20
>> I'm not sure where to start with reproducing, I'll have to try. How many
>> vCPUs in the guests? Do you have several guests running at once?
>
> Hello all,
>
> some details on the setup...
> these machines are buildservice workers, (build.opensuse.org) and all they
> do is spawn new VMs, run a package building job inside (rpmbuild, debbuil=
d,...)
>
> The machines are running in OPAL/PowerNV mode, with "ppc64_cpu --smt=3Dof=
f".
> The number of VMs varies across the machines:
> obs-power8-01: 18 instances, "-smp 16,threads=3D8"
> obs-power8-02: 20 instances, "-smp 8,threads=3D8"
> obs-power8-03: 30 instances, "-smp 8,threads=3D8"
> obs-power8-04: 20 instances, "-smp 8,threads=3D8"

Can you send us the output of:

# grep . /sys/module/kvm_hv/parameters/*

cheers

