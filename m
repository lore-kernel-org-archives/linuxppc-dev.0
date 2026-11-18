Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A292606A33B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=i6T5OkA6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVB4p64PDz2xdX;
	Thu, 19 Nov 2026 06:10:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795029018;
	cv=none; b=Bml3CEvaCVAhQ/E4FeCbkHa3EHO/1jJgYL71ofXosDx51wkkIF6twfCIPQaNCP3f39oUYpH47QV3X1MAHMzGjELJlZzWkVfH23De2qO8Ms2Ef35L4yamvAKPQEkaCJ9UOD0AqX5+Ulk4FSR3zc29KxkTUTZkje79+MXmhrUmc2BUDeedRimP4Ce4czeheEdlged/Z+bvy097vGXFyuiAzYMcFq1gej2b8ibtaTJYNOYnx/YSvDoe9br6XBZvPLrwVTo5XuxAnWSqIJLXU9lbpUF3vLYqMuJ3F4R63YKHOTdfXi7aG9a6N2GEfwa4Y02SfinG9331L4U/5Pia9yB0Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795029018; c=relaxed/relaxed;
	bh=YxWsOpaN6CU+fFgVMclUNy68ZrjNu1idGsKCVJ6O9Z4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=PkZgbS7wjO4Q3A3L7ugT0b96im0F/u9yzmQErdl50E/0Lo6D89lf3BTkQTNMHSpCpP826wuAqpB1wSaq8ZAXgLVy3idWiyQdmdPFCg3ut0yj+I6I40fbZ5+hVXmxaTuWS0q4unx8TjGjBBAdEGEWLs9HJ5+Y1qslKfnmyBPmVRQRukOwdFxha4FzWH8zgksX7ITMx6zqzYMf1VNzWZCHGJaMXJErYyjFSQFNvA63vppJrZYDMOc4h5/bT3E0NH6n8CjwbnH/WlL1vbQkLJ+cg07gmhApVq3boREeE9+XvGZAPFFA4T8IgA2iFA+sKmR0c351wdYG6SnrQBFqL2wgKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=i6T5OkA6; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+7073d70c6fbcdd9aef0b+8487+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=i6T5OkA6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=desiato.srs.infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+7073d70c6fbcdd9aef0b+8487+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVB4j4xl2z2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 06:10:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=YxWsOpaN6CU+fFgVMclUNy68ZrjNu1idGsKCVJ6O9Z4=; b=i6T5OkA6HB7NG25CMcQ8Te4Ltr
	KxIOzXx/mNFMONQ4ViCWFPNmIrUOuZVTIe8TZnkkJlz9SvrT7bF+8x41WWOLI8qO2kRjpz3bGORzX
	iZXB3H/1+181sDQQBjKkDX3Ecxc0BS+EsdKOocrWt+stbQmWHtKIf0QpLepBumkQf/831tPfnEejg
	Mn0K+Y6S4HnvTOy97cfE4cJl/H97wFiYDnoEOJ+PmptkQJL2VFtvIU9o0jXrb7h8DKMAaRLOBo6Ic
	75Zv3gjRNJV25Ap9P2B/c6B1/SSOXgveIKaxkIQi9zRBBjJ2Hb8o/hzhGZMKQfHMsaX3VVDtMH58Q
	ZlneSFqw==;
Received: from [2a00:23ee:2910:16f:a90:4999:d4c:f045] (helo=ehlo.thunderbird.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTl2l-0000000GRW5-1yMX;
	Wed, 18 Nov 2026 19:10:07 +0000
Date: Wed, 18 Nov 2026 19:10:01 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
CC: Sean Christopherson <seanjc@google.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, ashish.kalra@amd.com,
 michael.roth@amd.com, nsaenz@amazon.com, anelkz@amazon.de,
 James.Bottomley@HansenPartnership.com, Melody Wang <huibo.wang@amd.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, x86@kernel.org,
 coconut-svsm@lists.linux.dev, joerg.roedel@amd.com,
 Mushahid Hussain <hmushi@amazon.co.uk>,
 Sriram Nambakam <snambakam@linux.microsoft.com>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH 06/16] KVM: x86: Widen the plane vCPU fd ioctl allowlist
User-Agent: K-9 Mail for Android
In-Reply-To: <4e4fb011-9171-42c1-b499-27b0333a2fd6@redhat.com>
References: <20260608144252.351443-1-joro@8bytes.org> <20261111222911.477-1-dwmw2@infradead.org> <20261111222911.477-7-dwmw2@infradead.org> <4e4fb011-9171-42c1-b499-27b0333a2fd6@redhat.com>
Message-ID: <D0EE54A9-3FF3-4005-875B-A9AF04EB1341@infradead.org>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 18 November 2026 17:58:33 GMT, Paolo Bonzini <pbonzini@redhat=2Ecom> wro=
te:
>On 11/11/26 23:29, David Woodhouse wrote:
>> From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>>=20
>> A VMM that puts an initial VTL context on a higher plane cannot finish
>> the job through the plane vCPU's fd=2E kvm_arch_is_vcpu_plane_ioctl()
>> refuses the ioctls it needs, while the one capability ioctl it does
>> admit, KVM_ENABLE_CAP, reaches *every* vCPU capability handler=2E
>>=20
>>   - KVM_GET/SET_MP_STATE: a plane vCPU for an AP starts in
>>     wait-for-INIT like any non-boot x86 vCPU, and nothing ever sends
>>     INIT/SIPI to the higher plane of an AP=2E The VMM has to mark it
>>     runnable itself=2E
>>   - KVM_SET_GUEST_DEBUG: single-step and breakpoints on a non-zero
>>     plane=2E The debug exits surface through the plane-0 KVM_RUN loop
>>     like any other plane exit=2E
>>   - KVM_X86_SETUP_MCE: mcg_cap is per vCPU and every twin starts with
>>     the KVM_MAX_MCE_BANKS default, so programming plane 0 alone leaves
>>     the planes disagreeing=2E Hyper-V shares MCG state across VTLs=2E
>>   - KVM_ENABLE_CAP: accept only the audited capabilities on a plane fd,
>>     the SynIC pair and the two CPUID-enforcement toggles, which change
>>     state that each twin keeps separately=2E Anything else gets -EINVAL=
, as
>>     non-allowlisted ioctls already do=2E The nested paths behind
>>     enlightened VMCS and direct TLB flush have never been audited for
>>     plane_level > 0, and without the filter any future vCPU cap would
>>     work on planes without anyone having decided that it should=2E
>
>Not sure about KVM_ENABLE_CAP, the other seem sane=2E
>
>BTW at some point I'll rewrite these commit messages, they're infuriating=
=2E=2E=2E

Yeah=2E I've grown kind of immune to them now=2E Even found myself typing =
"load-bearing" with my actual meat fingers the other day=2E

I've also been looking harder at the completion thing=2E We *can't* (well,=
 I don't want to) enter another plane while there's still a completion wait=
ing on the first plane=2E

Which means any control register or MSR interception which needs to be han=
ded to another plane has to completed first=2E

I think we need to be able to complete them with the RIP unchanged (not ad=
vanced over the instruction)=2E Then for VSM, it's VTL1 which will handle t=
hem and then advance RIP for its VTL0=2E VTL1 wants to be told the instruct=
ion length too; I could make QEMU find it but since KVM tends to have it an=
yway, I'm looking at how I can export that=2E


