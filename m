Return-Path: <linuxppc-dev+bounces-26539-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF2AC624DE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 09:20:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbrXt3KsZz2xlY;
	Fri, 04 Sep 2026 19:20:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.166 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788513630;
	cv=pass; b=M5GK25NETLRe/JRHtKxM/T2VbIsh0l5DqM4FaZ6o9KA+/tQPBZ4LhvjRs9fl+QrklTJ3z8H3QIzJz4oOr87RlC66hDWWU43ReTj17hRQsOW5pFRbWPYSiO7eQe2DpPz80V0yVfCsYc9qUhHcGRIVymnTyI7RFuUDItkAKYxojOoUcW+3Zszpq7rXULXvp2F2YDNmwMQcLyBCV/1AXAgvjsMIQas4mMj5e6InrIBmUlFFt3r4bygtALTa7nFp/fdFA6pnUSr6x22vBCop8JrVYsPouyFMTg8PLgRhJB3FmKw3y34qPWoqvsVD5Ix6GoVr2J4C/VbODROvwniJ8kAZmg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788513630; c=relaxed/relaxed;
	bh=9OTAve5MS8vp4GXY6N47wdS4l18+pPjiXvB8NhZWEqg=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=M/W+7+tJReQl/Og3IItQiyVxS5AlMN8dbSOuMvfEx7N9/7C0rHi09uaRflEpeZ5sa3nyKpP96bG3Qt1/TwmCCqNYmHoeMK5u/qL0AyUDtDiSZGypKfLDJdcMXRGlPSclP+cQsqJN095NjyixMV8TdEfr35Ziu9FBU0JLzQPiNGikb24/QgtvMdzSYp+KkdRSMl0wi1x9ZI1ydp6UhewmmWJvlFpUck7o+ysHHSWt9NTkCmLYdyfgOsvjDCe4VMO22lDT7HOZ1nfOzOwcFijKC1c1zrEZEChJLoCGRRC1qtKjG8Wjal/rBbdiEwRV17bwP5++XUQUnO+k4z0sieqeNw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=jm7WFc1U; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Y9XY8Ed5; dkim-atps=neutral; spf=pass (client-ip=81.169.146.166; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=jm7WFc1U;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Y9XY8Ed5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=81.169.146.166; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbrXn5K0pz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 19:20:24 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1788513619; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RngXiASqWzN8KXaxBWfiVG+QnJmV1XkB2eS+xAmVErw5bu5KCOU1oEBi8SXO8PoWt7
    iLzSsinOe4wDP60gUsnf/Q2GTTLLpucq+Ldr8A3S8+yui1aRy2vNGz26wnOVcKaQK/Ir
    DApL/Qyd1ovzBDKsF38v/UxT7tu8ExBPb7k4R2MCoWHpz4XJ/5/tmSfGy1n54XkTdOau
    aJ5m0+e9gE2WGlRvgGTnHZzK2PsDLzhrpazTe6350IS0ya2STLm96z+nSvsxI4xhXO59
    s9qJsU4GaDehDCx4V5EWzNNWSGX0w1Trc5FmQPEcw0T3D5ZYToP5s/zk0jUZaXMUouPf
    DBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1788513619;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=9OTAve5MS8vp4GXY6N47wdS4l18+pPjiXvB8NhZWEqg=;
    b=dSPp1lC7HP4c44ZQfWAVIgim9a6yHIH0J1s09OqfZLVN5NKSXfZmnsCHdLBTCsYvBE
    Sfg+mE3Y1jmGQy5z8v2dlEVkePm0uAGAbYnH0TmVfW2JcQuRGkM00cjaem7aOiDaj/m6
    D9jp1LLF3+51Jyy9IYXlsSXWSe35vm1gO3qW5sg4cbLe3CYKKYmn6S0PRTd1Nr/jW5as
    ghnevE5FXCK8IjLSFrV77c05MxNuUtprzZGh3QGfYIu6WZtcsOVZqaYwpKhAyTasiT6n
    +Dm955xTmL9Ksr0rBCm1EewbFfgzTOApl5D6i+7WZM4IzY1aBu2u3zFFpGrI4zMZoMfR
    wI/w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1788513619;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=9OTAve5MS8vp4GXY6N47wdS4l18+pPjiXvB8NhZWEqg=;
    b=jm7WFc1UXEw+axwQlwSMJio5rl5VrszAnTEUIbATpowhL4tMshAKqxx3BMHdzBTshf
    oyLteywSAraaIaoJatO6PTy5h+00HMmt74/kkRI22YDx+9LgwtC8sF4qCeRMYo3MNv/m
    X8cdmJF/6KuL0uT33QftJ8ddAoWEdb4ZdRpaRrbmo8Fxg7qZ/JFW9Wc0I+DJoaNloyUH
    wnQHnp5vxUbYOaG7ujC3NA1OLTM5fQG/qLRHyjdhM+qr6k0S6aokentWWn1cqXTkoWFL
    aNAd30Z0mLRHM+pxBcctOSEcVOojroFc/owdRPcduEzvPOUVmD13mhx9U29FlJqo6sdQ
    0mQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1788513619;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=9OTAve5MS8vp4GXY6N47wdS4l18+pPjiXvB8NhZWEqg=;
    b=Y9XY8Ed5gmBu1gi8Sh2P5zRm9C4ZSnvz3xZC7nPe2pdUxXGOb2d5Ag2bw9k6XJ/lmZ
    mkyEk8rxnr9m10TS38CA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7BZqwsy/CXnbxcSyMRGT1qrNiz7sLFQXRefpK"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id ee2bee2849KI5cT
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 4 Sep 2026 11:20:18 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [Linux PPC] Disable PREEMPT
Date: Fri, 4 Sep 2026 11:20:08 +0200
Message-Id: <2F1C6E83-7A50-491C-B4F8-32885EED9D41@xenosoft.de>
References: <C78B55EA-2CA1-481F-9F85-597A88B80F94@xenosoft.de>
Cc: =?utf-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 Christophe Leroy <chleroy@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 hypexed@yahoo.com.au, mad skateman <madskateman@gmail.com>,
 Christian Zigotzky <info@xenosoft.de>
In-Reply-To: <C78B55EA-2CA1-481F-9F85-597A88B80F94@xenosoft.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
X-Mailer: iPhone Mail (23G83)


> On 04 September 2026 at 10:56 Christian Zigotzky <chzigotzky@xenosoft.de> w=
rote:
>=20
> =EF=BB=BFOn 03 September 2026 at 07:23 Shrikanth Hegde <sshegde@linux.ibm.=
com> wrote:
>=20
> =EF=BB=BFFriendly LLM analysis says preemption is enabled too early and be=
fore
> completing kvmppc_handle_exit_hv() / kvmppc_handle_nested_exit()
>=20
> Below is ONLY a speculation and completely UNTESTED.
> Maybe worth a try.
>=20
> ---
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 0409ac9e7b31..78d2b0618887 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -5049,8 +5049,6 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64=
 time_limit,
>=20
>       powerpc_local_irq_pmu_restore(flags);
>=20
> -       preempt_enable();
> -
>       /*
>        * cancel pending decrementer exception if DEC is now positive, or i=
f
>        * entering a nested guest in which case the decrementer is now owne=
d
> @@ -5072,6 +5070,8 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64=
 time_limit,
>       }
>       vcpu->arch.ret =3D r;
>=20
> +       preempt_enable();
> +
>       if (is_kvmppc_resume_guest(r) && !kvmppc_vcpu_check_block(vcpu)) {
>               kvmppc_set_timer(vcpu);
>=20
>=20
> Michal
>=20
> - - -
>=20
> Michal,

Sorry, I meant Shrikanth.

>=20
> Is this patch also for the issues with KVM PR and KVM HV if PREEMPT is act=
ivated?
>=20
> The entire FSL Cyrus+ board freezes when using KVM HV with PREEMPT.
>=20
> The guest kernel doesn't boot if we use KVM PR with a PREEMPT kernel on
> the PA Semi Nemo board.
>=20
> Bug report: https://github.com/chzigotzky/kernels/issues/19
>=20
> Thanks,
> Christian


