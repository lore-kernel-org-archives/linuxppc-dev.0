Return-Path: <linuxppc-dev+bounces-26536-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE751C624DE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 08:56:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbr135c8Sz2xZV;
	Fri, 04 Sep 2026 18:56:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.164 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788512183;
	cv=pass; b=Jj0vNgAHF1Q+p1CE+RNP8ThEnyWYmDk803mnysp0PnJ6kVhj37+onk7St7CIK/onko0fACR9ViORGTCo/T9i6IYa74l33PJmL2DuxSIiTZ+Be04ukKqCawEJ3W5GXWatxNmwB6+0ntbdCyccX2ixsO8skaxQzNB10lLsz7WnqdCXKeDIpVrFkqQS9Vk4s2zlY8HE+vSjURngvVTSK5tKvrw1SlsBgoc9c8rhcIbJVyWCUUsctVk+3KhuejKuPAkHgwcQ9HYLeM57dTdSRtkbIxkmEUx5zfkM7EAVIXn2cRz0P2LWVsp+jwjzJ2Onpmwwe9Tk/z4j18JAaj1YgvF6Iw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788512183; c=relaxed/relaxed;
	bh=t+wGxbsBC1yimzw8J+dVysxqes7YBa1gF3i3wHmcAsg=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=iOTYarVQXZt6NVwFvtBQp37yNRjlqaUlid244drzah0n20j+vlX2ebj3IxRknFU5BSN2WoD498dIAUGMUcW5TJ2zY1ouLZIkpXr/OHKePaJmWqcj4UI00FqR9+7gZz7QbJn5HsXasvC7JlRN8c6KZtxuTMG8TRO5JR3rMCOTurqXCVOHjmalbAKvHaxabgY0XYW/8EwV2J0wDONNmoVKmuxWQKKpK7frYCPWjBR3AuvaiW0G3ChH/Bb7OfKm98E6eFCATzpY7rNZHmSA1UjOP3oBmG8LB1hoGZXRfMUJhzORSaypBcQxZ7a/Thner1yVQueYLRohFYiGPxPSvnGjCg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=LwRRHNv9; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=V4q4vlG7; dkim-atps=neutral; spf=pass (client-ip=81.169.146.164; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=LwRRHNv9;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=V4q4vlG7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=81.169.146.164; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbr0x12mPz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 18:56:13 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1788512165; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kq19U3p9le89MF8k4ObDRNIoxoINOtJisx0q9jY6O1UrTD6u3ncwop6GXWjJlxdtHO
    WjnkqzdI82mnaqdh5jJXdVnrNnIxPxsSAb0TQUBeBJ1OG/bgcrOo3d723QRu/nlfa6YM
    R66XjBoUICSvLQQ7xfjK5MHIfeq7WommPkvBAcwBicYrkaoKf2PsCANWyBlj5H1wlETP
    ug5DpiYFj55WcDjjaLxcSo/9+OZ4dlW3oYxyUdI43kuEXdl40HPh5H4yb3B/3sjCBNjG
    IO+NdBIXK1bjrQ+M5XBilbwv6mHbYR0Ye8WPTI6MnXYPzUAGW9vhlHjQO80kyVTNYjip
    WNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1788512165;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=t+wGxbsBC1yimzw8J+dVysxqes7YBa1gF3i3wHmcAsg=;
    b=G6ve0vvN7YxkC26bvyElzCT0yISMry7/mJUCgsSTxIeIBjMwo0cMBkqF8r0I9XZ/cM
    mYJiX+jfm3O8yM2Ij9BNS+jQ2KmFc732oX9uWAfBaUR5m++vVWBZkfQfZZB/vX2lyh7m
    4RCpXGwRRwUbnW/BQlnK1bhfRsmVV2iM7s7H2EPimmchAKR/JS7AhFSItZbGLfJsTWV7
    Wl+5qSpP1NHGM6wZDxhHS+aqtpZ5cUjgSOGJbBEpC0Rd0pYSuB5DD6bO+V0bUgK8HKQT
    2y+780Hjgk+UMmevgzta4gWodBIsZkyD9j0g8i0CpzZTSdgLVHfY8NNw7S4KXBvmTzeI
    KU8g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1788512165;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=t+wGxbsBC1yimzw8J+dVysxqes7YBa1gF3i3wHmcAsg=;
    b=LwRRHNv9F3YUspJ0fxfaQPbJpW9l96ZaMqsIn1H0j4chLMDqkn0QfeL5ny2VOsw3Yt
    ZBuGvGWZ07AqmdUmcDzV96mUPwg3b5Jrdol7ZdjPrOouucnAsuD1fNpiIV+c/jmJwx9M
    r+mt1e6ZdJRP+GhmFrj6/xs288BsHGLPhfGP+QnvTd/1U1LyU+zx06vIA9IvE+j4fmSs
    HUqvWgFGbzrmC0/HKZm7MSIuB3CFXRBP/D8gj9ncd1BbWCSX4e1Dh6uMixIzufo0EN2K
    Vb0uEi1K6hbavCswZRv7qBNFOZ32shFpLDCsg4vY1gfYrOQfR0HKKzUyxA5mG29bVb58
    vvxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1788512165;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=t+wGxbsBC1yimzw8J+dVysxqes7YBa1gF3i3wHmcAsg=;
    b=V4q4vlG7+qraCJNUt0j+viOr0/kdqrm+eDUPNfkh7nWgt7QaPpzYClRVBFmcWi4cOP
    L8TydGds3PKOTaLJt/CA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7BZqwsy/CXnbxcSyMRGT1qrNiz7sLFQXRefpK"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id ee2bee2848u55Kz
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 4 Sep 2026 10:56:05 +0200 (CEST)
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
Date: Fri, 4 Sep 2026 10:55:54 +0200
Message-Id: <C78B55EA-2CA1-481F-9F85-597A88B80F94@xenosoft.de>
References: <5ed38c3e-4aaa-4a91-9eda-e31d09b44abc@linux.ibm.com>
Cc: =?utf-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 Christophe Leroy <chleroy@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 hypexed@yahoo.com.au, mad skateman <madskateman@gmail.com>,
 Christian Zigotzky <info@xenosoft.de>
In-Reply-To: <5ed38c3e-4aaa-4a91-9eda-e31d09b44abc@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
X-Mailer: iPhone Mail (23G83)

On 03 September 2026 at 07:23 Shrikanth Hegde <sshegde@linux.ibm.com> wrote:=


=EF=BB=BFFriendly LLM analysis says preemption is enabled too early and befo=
re
completing kvmppc_handle_exit_hv() / kvmppc_handle_nested_exit()

Below is ONLY a speculation and completely UNTESTED.
Maybe worth a try.

---
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 0409ac9e7b31..78d2b0618887 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -5049,8 +5049,6 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 t=
ime_limit,

       powerpc_local_irq_pmu_restore(flags);

-       preempt_enable();
-
       /*
        * cancel pending decrementer exception if DEC is now positive, or if=

        * entering a nested guest in which case the decrementer is now owned=

@@ -5072,6 +5070,8 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 t=
ime_limit,
       }
       vcpu->arch.ret =3D r;

+       preempt_enable();
+
       if (is_kvmppc_resume_guest(r) && !kvmppc_vcpu_check_block(vcpu)) {
               kvmppc_set_timer(vcpu);


Michal

- - -

Michal,

Is this patch also for the issues with KVM PR and KVM HV if PREEMPT is activ=
ated?

The entire FSL Cyrus+ board freezes when using KVM HV with PREEMPT.

The guest kernel doesn't boot if we use KVM PR with a PREEMPT kernel on
the PA Semi Nemo board.

Bug report: https://github.com/chzigotzky/kernels/issues/19

Thanks,
Christian=


