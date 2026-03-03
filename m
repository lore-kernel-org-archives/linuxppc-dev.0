Return-Path: <linuxppc-dev+bounces-17639-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389C7EDEBFA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2026 21:53:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQV1M3Kbyz2xS3;
	Wed, 04 Mar 2026 08:53:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772574823;
	cv=none; b=kEQMP9M8jpsrr+/noqFn9rghudMstN0FEdhhYHFC+37ZtQ1mqp7stx43c22pqvGa2nBVjgt91eGY37eZSaOpvWvMEOq3bhKhxFCUwAAdGH+cjkzOmm5l0k9ti41Ba1Ml1pbPwANEZfZ6RsmRz1FSl9EYofzxtceZf0ROgZD228uByDPKiVz4jOAzm9pWf4/zQKIhAzU/Rg3ht4F2bdoSiKJ9KsGflAgKHdKFdbm+Ob64riLqJGLP8LV+sOsv7jNobOrpvqdNbu3gDiJxMxmtibmMoTCps2KNw2r1xyjaUO51hS4gmzWBqsqoQal3X394Qjr3uweSHaLmcPPd5LwHZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772574823; c=relaxed/relaxed;
	bh=D1r1C1nkJC8myDUqBbWlJuno+S+Hsv+z3MI/a3FcqHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBPHaMY7HMP+xx1eN9Avc7Z0dOzjvK6yS3c0Xg/w1gBf0cv8AWjKW/+LhmkTt7XY1WGMvxkFxpNZD/dkfh7sIDe9oXonnQTZtdo3gaDSsL7bM4noLOZKbLTM0EtLcwjtFlCkJF/VlgjmT63zak8otWa5c+h2JLGfDW8YyNG4HLso/gDmei/VgIaTb5ct0PC3+nPC8DC1EjvuEadAPIwQfmECEIoshKNMHu/6raDHuXFhdf3SSC7HHbQ1SWsG7MXnbdlDjz5JU7HdCG5qWaO66IExDutlxVq6/BBS2A2b+h0svD7gGjSvQ6sxEZp63t+SCukuMybhN9uiwGE9Hc3A6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com; dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026022301 header.b=RLwZ/rk8; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org) smtp.mailfrom=zytor.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026022301 header.b=RLwZ/rk8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zytor.com (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org)
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3::136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQV1L2r1Rz2xR4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 08:53:41 +1100 (AEDT)
Received: from [172.27.2.41] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 623LavOS3436858
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 3 Mar 2026 13:36:57 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 623LavOS3436858
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026022301; t=1772573825;
	bh=D1r1C1nkJC8myDUqBbWlJuno+S+Hsv+z3MI/a3FcqHc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RLwZ/rk8vaq6V4tFXUGKShs9EBYHpeXArYtAO8GRTPF0Qb9ckRJAy3tcD5EWeuBHX
	 vr0OB9eU7N3DVYjRVanoVDfqhq4F+AkTzExopgowDGEFypgJWOgNXBkU6FNdThL97f
	 Lw7JtD6O+ENFjRKkORJY5LGdYpcgeiUuBzkeJbD5nNV5qeKq9oq8xMw9GJMwXTJY58
	 GQjC3/XyTBNrpt/UhJOXTqWbTWEJKRY1JmqsyxsLflRD6J85F4d6toUWrWmiKQly38
	 ciLSIrOtlh968Kr67YxA/mjWIPI5I11u1R6hN8+kq3t5kAbHjJDAA+e6EhT7AmEGux
	 lOCVXVCJis+ZQ==
Message-ID: <0d2d834d-0f3c-43bb-9530-da6c2492763a@zytor.com>
Date: Tue, 3 Mar 2026 13:36:52 -0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] x86/vdso: Respect COMPAT_32BIT_TIME
To: Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org
References: <20260227-vdso-compat_32bit_time-v1-0-3f0286a7bac3@linutronix.de>
 <20260227-vdso-compat_32bit_time-v1-1-3f0286a7bac3@linutronix.de>
 <c29f5e70-bd17-4e1b-a005-5a3282e70075@app.fastmail.com>
 <03cd1e21-a2f2-46a1-a674-cbaef9712016@app.fastmail.com>
 <20260227103226-cc3bb32c-0107-4c09-b81a-ca33ea03ad5c@linutronix.de>
 <49b7c9f9-198a-49f7-880b-6ae74d7bd985@zytor.com>
 <2b1ac7b9-fcc8-4aa3-a0ad-eb37e4bce030@app.fastmail.com>
 <56591FD5-0DD0-4117-BC7B-4565E3F6512E@zytor.com>
 <d92f424c-9aee-417e-899e-3a0002a80f4a@app.fastmail.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <d92f424c-9aee-417e-899e-3a0002a80f4a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-03-03 13:27, Arnd Bergmann wrote:
> 
> I see. I would argue here that a link failure is actually the best
> case then: the entire point of CONFIG_COMPAT_32BIT_TIME=n is to
> enforce the fail-early case, as opposed to silent data corruption
> after (now) 12 years of operation.
> 
> I don't think there is an actual link failure here, as dl_vdso_vsym()
> resolves it at runtime by glibc (when using time32), while musl
> doesn't use __vdso_gettimeofday at all.
> 

Well, the former is a link failure -- just one handled reasonably gracefully.
A library that really wants a fallback can presumably also avoid the problem
by provide a weak reference for the fallback.

	-hpa


