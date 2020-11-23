Return-Path: <SRS0=H+zi=E5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF8FC2D0E4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2020 11:23:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F68120706
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2020 11:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="R1K0WuGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F68120706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CflBr2r8QzDqQg
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2020 22:23:16 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cfl616mPSzDqMr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2020 22:19:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=R1K0WuGi; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Cfl604FFtz9sTc;
 Mon, 23 Nov 2020 22:19:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1606130344;
 bh=tJTGG2h6mgp16HvKmEMixgRvlSuhviv6rCu/mwCFS8Y=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=R1K0WuGiR9fY5YncKj5ZYDAfGqSnV53+RVMsAXRA63dFrjD/au1kxjuXKyN0NCMMu
 nAg5QzabjlEQ6/SXio5dTKXxNGTUH4O0qhbJTr3b1frVJIv/uaAeMZF3MvnlRn3BGM
 XYwver57kJVO6pe+cjngiAYVd3prXL/QjnVDnm7Gf8fk2grICOI7GaTbcpLCV0qybp
 +MWnpWsMIYFEuijuvfSmpFuH4do9uBoeR3ExS0UlCIWKyxDUQhh7cWZ+b4fMTOqunm
 k+lycVwAKrHkyX21ecemm6rm3YAYMJ5oX5/WvmK+CESBltG/uEf0zDuqUiprRMLdyk
 wJO+ejjdK11Bg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/perf: Fix crash with 'is_sier_available' when pmu
 is not set
In-Reply-To: <1606124997-3358-1-git-send-email-atrajeev@linux.vnet.ibm.com>
References: <1606124997-3358-1-git-send-email-atrajeev@linux.vnet.ibm.com>
Date: Mon, 23 Nov 2020 22:19:04 +1100
Message-ID: <877dqc1ftj.fsf@mpe.ellerman.id.au>
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
Cc: sachinp@linux.vnet.ibm.com, maddy@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Athira,

Athira Rajeev <atrajeev@linux.vnet.ibm.com> writes:
> On systems without any platform specific PMU driver support registered or
> Generic Compat PMU support registered,

The compat PMU is registered just like other PMUs, so I don't see how we
can crash like this if the compat PMU is active?

ie. if we're using the compat PMU then ppmu will be non-NULL and point
to generic_compat_pmu.

> running 'perf record' with
> =E2=80=94intr-regs  will crash ( perf record -I <workload> ).
>
> The relevant portion from crash logs and Call Trace:
>
> Unable to handle kernel paging request for data at address 0x00000068
> Faulting instruction address: 0xc00000000013eb18
> Oops: Kernel access of bad area, sig: 11 [#1]
> CPU: 2 PID: 13435 Comm: kill Kdump: loaded Not tainted 4.18.0-193.el8.ppc=
64le #1
> NIP:  c00000000013eb18 LR: c000000000139f2c CTR: c000000000393d80
> REGS: c0000004a07ab4f0 TRAP: 0300   Not tainted  (4.18.0-193.el8.ppc64le)
> NIP [c00000000013eb18] is_sier_available+0x18/0x30
> LR [c000000000139f2c] perf_reg_value+0x6c/0xb0
> Call Trace:
> [c0000004a07ab770] [c0000004a07ab7c8] 0xc0000004a07ab7c8 (unreliable)
> [c0000004a07ab7a0] [c0000000003aa77c] perf_output_sample+0x60c/0xac0
> [c0000004a07ab840] [c0000000003ab3f0] perf_event_output_forward+0x70/0xb0
> [c0000004a07ab8c0] [c00000000039e208] __perf_event_overflow+0x88/0x1a0
> [c0000004a07ab910] [c00000000039e42c] perf_swevent_hrtimer+0x10c/0x1d0
> [c0000004a07abc50] [c000000000228b9c] __hrtimer_run_queues+0x17c/0x480
> [c0000004a07abcf0] [c00000000022aaf4] hrtimer_interrupt+0x144/0x520
> [c0000004a07abdd0] [c00000000002a864] timer_interrupt+0x104/0x2f0
> [c0000004a07abe30] [c0000000000091c4] decrementer_common+0x114/0x120
>
> When perf record session started with "-I" option, capture registers
                          ^
                          is

> via intr-regs,

"intr-regs" is just the full name for the -I option, so that kind of
repeats itself.

> on each sample =E2=80=98is_sier_available()'i is called to check
                                      ^
                                      extra i

The single quotes around is_sier_available() aren't necessary IMO.

> for the SIER ( Sample Instruction Event Register) availability in the
                ^
                stray space
> platform. This function in core-book3s access 'ppmu->flags'. If platform
                                               ^                 ^
                                               es                a
> specific pmu driver is not registered, ppmu is set to null and accessing
           ^                                            ^
           PMU                                          NULL
> its members results in crash. Patch fixes this by returning false in
                        ^
                        a
> 'is_sier_available()' if 'ppmu' is not set.

Use the imperative mood for the last sentence which says what the patch
does:

  Fix the crash by returning false in is_sier_available() if ppmu is not se=
t.


> Fixes: 333804dc3b7a ("powerpc/perf: Update perf_regs structure to include=
 SIER")
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/core-book3s.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-boo=
k3s.c
> index 08643cb..1de4770 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -137,6 +137,9 @@ static void pmao_restore_workaround(bool ebb) { }
>=20=20
>  bool is_sier_available(void)
>  {
> +	if (!ppmu)
> +		return false;
> +
>  	if (ppmu->flags & PPMU_HAS_SIER)
>  		return true;
>=20=20
> --=20
> 1.8.3.1


cheers
