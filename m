Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C07C433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Nov 2021 18:33:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6698E61BD3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Nov 2021 18:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6698E61BD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HvWlN0Btpz3bmr
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Nov 2021 05:33:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=qlkcK6Ei;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=desiato.srs.infradead.org
 (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org;
 envelope-from=batv+060ef2ffc16683cdd84b+6660+infradead.org+dwmw2@desiato.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=desiato.20200630 header.b=qlkcK6Ei; 
 dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HvWkf06fzz2xCt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Nov 2021 05:32:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=UrCfwAAERGpFkpH84kgGsztDfzBHzApXpFPk7Q4aM3Q=; b=qlkcK6EiUDCYNFmrW2y88AiZNE
 cmQvmZ/hQeDmBuBaxBlEz8/9xSDGrc79+e+G9Ohrg5SCBR9+U6oMY2TCcJXuU2nNiBFuD3+kWs5eT
 IBPH2OgqzqIIS3CImevIylsIHPwL04bJaRDQbp5TgrjKZuuQ7/IGm6pG4x0HQWq0ZUJe2eHLXzCPj
 f6Yvwy6gqczKGGJV9qWHf3sPhxK2DC4ivkTSa4HaWFyKoFujkMpT8PDC2tAVJRnfRaU58s8vA1x38
 8L1RywfOIo3IjwOk1sM0OUF4A2t8iZC5ZKCHOLMVvHUQ609zEC4WkGW9X1KUl7pVE6G8B/0JOjLPo
 DBQsXa2g==;
Received: from [2001:8b0:10b:1:d129:67c1:5868:c3aa] (helo=[IPv6:::1])
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnPiu-00GXzz-IG; Wed, 17 Nov 2021 18:31:56 +0000
Date: Wed, 17 Nov 2021 18:31:55 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Marc Zyngier <maz@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_08/12=5D_KVM=3A_Propagate_vcpu?=
 =?US-ASCII?Q?_explicitly_to_mark=5Fpage=5Fdirty=5Fin=5Fslot=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <87pmqy7ir2.wl-maz@kernel.org>
References: <20211117174003.297096-1-dwmw2@infradead.org>
 <20211117174003.297096-9-dwmw2@infradead.org> <87pmqy7ir2.wl-maz@kernel.org>
Message-ID: <63CDC53D-D05A-499B-8694-14E5DA3855FB@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Anup Patel <anup.patel@wdc.com>,
 "wanpengli @ tencent . com" <wanpengli@tencent.com>, kvm <kvm@vger.kernel.org>,
 Joao Martins <joao.m.martins@oracle.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-s390@vger.kernel.org,
 "joro @ 8bytes . org" <joro@8bytes.org>, Huacai Chen <chenhuacai@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, karahmed@amazon.com,
 Catalin Marinas <catalin.marinas@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "jmattson @ google . com" <jmattson@google.com>,
 "seanjc @ google . com" <seanjc@google.com>,
 "mtosatti @ redhat . com" <mtosatti@redhat.com>, linux-mips@vger.kernel.org,
 James Morse <james.morse@arm.com>, kvm-riscv@lists.infradead.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "vkuznets @ redhat . com" <vkuznets@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 17 November 2021 18:13:37 GMT, Marc Zyngier <maz@kernel=2Eorg> wrote:
>On Wed, 17 Nov 2021 17:39:59 +0000,
>David Woodhouse <dwmw2@infradead=2Eorg> wrote:
>>=20
>> From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>>=20
>> The kvm_dirty_ring_get() function uses kvm_get_running_vcpu() to work o=
ut
>> which dirty ring to use, but there are some use cases where that doesn'=
t
>> work=2E
>>=20
>> There's one in setting the Xen shared info page, introduced in commit
>> 629b5348841a ("KVM: x86/xen: update wallclock region") and reported by
>> "butt3rflyh4ck" <butterflyhuangxx@gmail=2Ecom> in
>> https://lore=2Ekernel=2Eorg/kvm/CAFcO6XOmoS7EacN_n6v4Txk7xL7iqRa2gABg3F=
7E3Naf5uG94g@mail=2Egmail=2Ecom/
>>=20
>> There's also about to be another one when the newly-reintroduced
>> gfn_to_pfn_cache needs to mark a page as dirty from the MMU notifier
>> which invalidates the mapping=2E In that case, we will *know* the vcpu
>> that can be 'blamed' for dirtying the page, and we just need to be
>> able to pass it in as an explicit argument when doing so=2E
>>=20
>> This patch preemptively resolves the second issue, and paves the way
>> for resolving the first=2E A complete fix for the first issue will need
>> us to switch the Xen shinfo to be owned by a particular vCPU, which
>> will happen in a separate patch=2E
>>=20
>> Signed-off-by: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>> ---
>>  arch/arm64/kvm/mmu=2Ec           |  2 +-
>>  arch/x86/kvm/mmu/mmu=2Ec         |  2 +-
>>  arch/x86/kvm/mmu/spte=2Ec        |  2 +-
>>  arch/x86/kvm/mmu/tdp_mmu=2Ec     |  2 +-
>>  arch/x86/kvm/x86=2Ec             |  4 ++--
>>  include/linux/kvm_dirty_ring=2Eh |  6 ++++--
>>  include/linux/kvm_host=2Eh       |  3 ++-
>>  virt/kvm/dirty_ring=2Ec          |  8 ++++++--
>>  virt/kvm/kvm_main=2Ec            | 18 +++++++++---------
>>  9 files changed, 27 insertions(+), 20 deletions(-)
>
>What's the base for this series? This patch fails to compile for me
>(at least on arm64), and the following patch doesn't apply on -rc1=2E

kvm/master

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
