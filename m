Return-Path: <linuxppc-dev+bounces-27723-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D4BC982D9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:27:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmTN51zdnz2yHD;
	Fri, 18 Sep 2026 20:27:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789727269;
	cv=none; b=e0QqmONSAXSxGEYtYKN3Dci0XyTyCoPezyqkH49226Qq0KP/2spBkNeK0m0vuldxYCiZ85AAoGB2kKuAEcu3MzvZeuBheu8RQAcnXFbWAdulqRNVKwFA0IkDy60trvyGlAms0SxA9zuJu0AzBojJ1XqVoTGV6Bo5zJBk1XgyQgRfRdFagiM1ZA3i1TW+SMQ4U10bJ14DkbgykNUJYHL6KAVgZatVHkd1tUwENBipk5O0SefjqD4JB+Q+OcbTWLscawDtedagLrvDcOU4AmP+gzsfd3yBT661HlqPV6r/jNCdpaJslwYaVVCX9SeL8AsapVcoeC6jQ7Hz8ZRjv8lFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789727269; c=relaxed/relaxed;
	bh=lkLUZeEnA99up/AmsUqwvacnHC/Y0Zt1xYo4A0fMueU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j1/R0Z2x4iwpsWGLy1x5Z1OXXUsHKEEbJz44i9rZAKxg8ZL5DPd+xfV5nWGu2T3RU9nHwlF8PXR+CIIQPTjxpAG/AR6fIRHvwXI7P12NJB3qclhc60ksYXqqVLmjAqtmr1/XUShlKcisnFqIpNdb4qCseo5SfzOImWVd1sKX6AX30B59GObXd69n+Pcja5GnHHoSHTX79+1Bcs7qJ/GRLp2sPMI/lrWfXaVblt41Kukv/htIAuek+58Akvxk5VlBmvQeHwUIUS4ym0RdXq//KCLYuLou73QHxSca0+gRMk6np1N77PgX6D0WbEqGuJ60YvkWSK5GFawon8eL98IKzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=fail (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItzDXld2 reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItzDXld2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmTN42cLkz2yr0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:27:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C7F5D60A5E;
	Fri, 18 Sep 2026 10:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414E21F000FF;
	Fri, 18 Sep 2026 10:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789727265;
	bh=lkLUZeEnA99up/AmsUqwvacnHC/Y0Zt1xYo4A0fMueU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ItzDXld2tby73VnalPfFMVQddC2s2ymzPgOS0ZChmR6dOPmegwuawzKjHFqmMDoF+
	 PoZnRzNeer2r2DmBsq/eYo8kJQkp1OBiPfBHHigVnCjlgxEslJ0v7OyJRVXzipoRBv
	 VZm1TT9Lc9oR99b5nG8pRlbO28sXT4TMcnVHOAs0mtzpIFRCVsuwztBBK5NyDHXE69
	 g15J3QHHDpWuZan+MCFxgFzN0l+Ef/JrBCLZq6PLqNVSm+GrT5waIr6oFwxfqDKTF7
	 ocTlp0emFiq+z7MtcqR5prTkmyE5VRJTzdZXh6UAWU9dGt07xnJ/Qg428kUKc3T4oP
	 n9iVhqtdLNzqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/17] crash: Normalize the kexec_load elfcorehdr at
 load time
Reply-To: sashiko-reviews@lists.linux.dev
To: baoquan.he@linux.dev, gregkh@linuxfoundation.org,
	ruirui.yang@linux.dev, npiggin@gmail.com, liukexin@kylinos.cn,
	dave.hansen@linux.intel.com, mclapinski@google.com,
	ritesh.list@gmail.com, takahiro.akashi@linaro.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, will@kernel.org, pratyush@kernel.org,
	coxu@redhat.com, mingo@redhat.com, zhangtianyang@loongson.cn,
	linux-fsdevel@vger.kernel.org, sourabhjain@linux.ibm.com,
	hpa@zytor.com, rafael@kernel.org, graf@amazon.com,
	ruanjinjie@huawei.com, jbouron@amazon.com, yeoreum.yun@arm.com,
	hbathini@linux.ibm.com, chenhuacai@kernel.org,
	akpm@linux-foundation.org, lizhengyu3@huawei.com, chleroy@kernel.org,
	adityag@linux.ibm.com, dakr@kernel.org, piliu@redhat.com,
	pasha.tatashin@soleen.com, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, ardb@kernel.org, leitao@debian.org,
	catalin.marinas@arm.com, kees@kernel.org, thuth@redhat.com,
	blum@kernel.org, kas@kernel.org, maddy@linux.ibm.com,
	james.morse@arm.com, tglx@kernel.org, bp@alien8.d,
	e@lists.ozlabs.org, mark.rutland@arm.com,
	driver-core@lists.linux.dev, kernel@xen0n.name, chao.gao@intel.com,
	eric.devolder@oracle.com, tangyouling@kylinos.cn,
	palmer@rivosinc.com, loongarch@lists.linux.dev, bgwin@google.com,
	guodongtai@kylinos.cn, rppt@kernel.org,
	linuxppc-dev@lists.ozlabs.org, maqianga@uniontech.com,
	seanjc@google.com, vishal.l.verma@intel.com, robh@kernel.org,
	gshan@redhat.com, "Jinjie  Ruan" <ruanjinjie@huawei.com>,
	me@linux.beauty, sshegde@linux.ibm.com, mpe@ellerman.id.au
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-12-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-12-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:27:41 +0000
Message-Id: <20260918102742.414E21F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kexec: elfcorehdr_updated in struct kimage is write-only and unused
--

commit 463b7b7692d8e96dc1be8ffaed1b6d0c8d298c9f
Author: Jinjie Ruan <ruanjinjie@huawei.com>

crash: Normalize the kexec_load elfcorehdr at load time

This commit changes kexec_load to normalize the elfcorehdr at load time
instead of waiting for the first crash hotplug event. By doing this while
the device_hotplug_lock can be safely taken, it allows hotplug paths to
skip CPU events safely and avoid racing with memory hotplug.

> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 3c9f4fbbe7ff0..f34fa8dba0288 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -457,9 +457,8 @@ void arch_crash_handle_hotplug_event(struct kimage *i=
mage, void *arg)
>  	 * possible CPUs, there is no need to update the elfcorehdr
>  	 * for additional CPU changes.
>  	 */
> -	if ((image->file_mode || image->elfcorehdr_updated) &&
> -		((image->hp_action =3D=3D KEXEC_CRASH_HP_ADD_CPU) ||
> -		(image->hp_action =3D=3D KEXEC_CRASH_HP_REMOVE_CPU)))
> +	if (image->hp_action =3D=3D KEXEC_CRASH_HP_ADD_CPU ||
> +	    image->hp_action =3D=3D KEXEC_CRASH_HP_REMOVE_CPU)
>  		return;

[Severity: Low]
Does this leave elfcorehdr_updated as a write-only and unused field?

Since this patch removes the last reader of image->elfcorehdr_updated,
the field is now only written to in crash_handle_hotplug_event() and
initialized in kernel/kexec_core.c:

kernel/crash_core.c:crash_handle_hotplug_event() {
    ...
    image->hp_action =3D KEXEC_CRASH_HP_NONE;
    image->elfcorehdr_updated =3D true;
    ...
}

Should the elfcorehdr_updated field be completely removed from struct kimage
in include/linux/kexec.h along with its assignments to avoid dead code and
structure overhead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D11

