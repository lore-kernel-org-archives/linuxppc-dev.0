Return-Path: <linuxppc-dev+bounces-19021-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0333210D14A2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 11:44:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkqD04kKjz2xpt;
	Mon, 30 Mar 2026 22:44:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774871072;
	cv=none; b=jsSosEFJDuFqpbb2GUlnz1yHJ4hEt/1q8jZPz45Xy6k3wgeM2zuWPSZv45XEc9kewxO79dQac0dPDa8Jg8yVNb8GGz68Ioj/5bZ/6/RMxhaQVymykC9vEmfabUHdS0EnLTD2uYOcg2ANzH2uDa9eIuEleiLg064r5IDfplJLFANTXQ+1aTOWU9VdreZmAqFg8BFa9DugRsQs/6LaQHNi5M9JD8aVxmRP/rbSZzw/GFAhTd371oI7gcXgTnH6/WEjQxHnd5U2YfkxxlOdVWSTL/XFqv0LQuTbqvKnWdGtJeolW1iiVzsiF8wH6bJWppCT3kwH/vr/jipmrgtTMAlqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774871072; c=relaxed/relaxed;
	bh=gvAh52M6pis730l5q8D5EHWXWp5qXG4bsCWjlx9wIeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpiHcADPQH9wZ0CkrbXNbwXiwgcb7I/gMJabgz2nRbGGitcLwhxX2i7JfZkNOc3iMa4j2VHOUBAfcrkYvp310VSMHOqAvKFhWy76Elhp9CfjyY/GEC8XYkHRATsAyW/qsznUvAGhWpLRIb4VYJALd39F95CAMEn6f2VoYUh8lvp7B6vY/g01GV/JLFycs2zN1kdurIcCRq0C5O7mmH9CWg+4vC1pl5dLVwZecq8Z8EX/dCI4R+LBVaw7eiEv3CuicEPrZzzIq56DrMPfS1FE7v9swsPTphTQT00ECXgCgL4FcwDp5GBQNePf8onSrQvTaio/e+qcRGRh8F1192x0PQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uRgEIC0O; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uRgEIC0O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkqCz4n0Hz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 22:44:31 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 46791443BC
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 11:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6E6C2BCB9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 11:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774871069;
	bh=f4YOF8vt92eNl1mKdqZyMCWyNb3+OoCLLo4tIp4YmMQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uRgEIC0OHFTjGnjqpcUzudj5PK0ySwoo0ihbOdzRQr39HpLRTD/b2F2IvmnAy0QMB
	 rMpU3c4qVSq+9B8Y3duAzRNQuULKIQZbB39tqIkx8h89z4P2sZ9eMWiMJ30V3z502w
	 NIF2J7pbUI3fUK3BirFOwUYBzMAggmASC/7WvxLSBKqvpOvo7SunL3gq+bnDoEJUBY
	 /UdVOODG1a06dfavlzYSUXk3tAmWgl7T6tulCQxgzbVEbmMNzTjDANd7cfZfR1sR8j
	 74NgXYv75Qk/gs3G1Y+cluMsPz+Bgmuy8fyQZZ4dv58tGBG5rim27ZzZxmmF48FCKY
	 N6cZh6RtZJ6jQ==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-66c1d3fecb2so140054a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 04:44:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSBnh1OHF/Sn2dvr2YWm4RKrxgrT7xLfmhSmJmlsssdVUFATw/j3n6QFcr3PKmrR6YB89mTP6oHZMSi04=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxxaxjNEj38Z4MZ7/ZT4xqmHeGMPyjq8qeNBxgQhyfg6CcUH/by
	equZvqe0Q42vRlNwmouSfKCZOzHOnAyg4pzq1UdUkn8mo3Hj3aT7EtIwQK2PAvIotuY/MEQ6bab
	Imis+AraTpXiTPjFCOvRZHeoHt7hpJA==
X-Received: by 2002:a05:6402:448d:b0:66b:82e6:5355 with SMTP id
 4fb4d7f45d1cf-66b82e65456mr3962353a12.19.1774871067648; Mon, 30 Mar 2026
 04:44:27 -0700 (PDT)
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
MIME-Version: 1.0
References: <20260225060347.718905-1-coxu@redhat.com> <20260225060347.718905-4-coxu@redhat.com>
In-Reply-To: <20260225060347.718905-4-coxu@redhat.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 30 Mar 2026 06:44:15 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+0w2hGN=Loy=ucHbZcdnn+ty3x9qS4WVX0Vj+g19tfpg@mail.gmail.com>
X-Gm-Features: AQROBzBPVOVlPWkIprh4svfiWPChabJG3_HPxZ8omC63yiiiHstiwFYKcyHWrdY
Message-ID: <CAL_Jsq+0w2hGN=Loy=ucHbZcdnn+ty3x9qS4WVX0Vj+g19tfpg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] arm64,ppc64le/kdump: pass dm-crypt keys to kdump kernel
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, 
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, Baoquan he <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Thomas Staudt <tstaudt@de.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, 
	Will Deacon <will@kernel.org>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Saravana Kannan <saravanak@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 12:04=E2=80=AFAM Coiby Xu <coxu@redhat.com> wrote:
>
> CONFIG_CRASH_DM_CRYPT has been introduced to support LUKS-encrypted
> device dump target by addressing two challenges [1],
>  - Kdump kernel may not be able to decrypt the LUKS partition. For some
>    machines, a system administrator may not have a chance to enter the
>    password to decrypt the device in kdump initramfs after the 1st kernel
>    crashes
>
>  - LUKS2 by default use the memory-hard Argon2 key derivation function
>    which is quite memory-consuming compared to the limited memory reserve=
d
>    for kdump.
>
> To also enable this feature for ARM64 and PowerPC, the missing piece is
> to let the kdump kernel know where to find the dm-crypt keys which are
> randomly stored in memory reserved for kdump. Introduce a new device
> tree property dmcryptkeys [2] as similar to elfcorehdr to pass the
> memory address of the stored info of dm-crypt keys to the kdump kernel.
> Since this property is only needed by the kdump kernel, it won't be
> exposed to user space.
>
> [1] https://lore.kernel.org/all/20250502011246.99238-1-coxu@redhat.com/
> [2] https://github.com/devicetree-org/dt-schema/pull/181
>
> Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Kairui Song <ryncsn@gmail.com>
> Cc: Pingfan Liu <kernelfans@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Thomas Staudt <tstaudt@de.ibm.com>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c |  4 ++++
>  arch/powerpc/kexec/elf_64.c            |  4 ++++
>  drivers/of/fdt.c                       | 21 +++++++++++++++++++++
>  drivers/of/kexec.c                     | 19 +++++++++++++++++++
>  4 files changed, 48 insertions(+)

Acked-by: Rob Herring (Arm) <robh@kernel.org>

