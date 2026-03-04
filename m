Return-Path: <linuxppc-dev+bounces-17682-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794E7EB7EA0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 08:10:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQljJ6SK4z30hq;
	Wed, 04 Mar 2026 19:10:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772611844;
	cv=none; b=RYrWbNSvpKm+MFb0GsInhPUEkEVbQw1Jv8cZqDU4tz4Yr0WXuA6J+4L3X9gY9bNd2abbvMGX5C6uJ0S/ckza+p47neuv5My/Zr3gO2KGi+IwBWI5piK11ZkbhX8HLdzkyTc3y/dUq21fTp4T2SZuyNEXmgSTLeX1PK6AoZQE7HbVPvytpE0wXHEiej9NxBdU1W6/5YMKbuKlZpA6DjwRmA39wPypFke8XwG57HFJHaq+VBMflKszAEgfyPGpHLBlXgDs4XjWILPv3av2X0NGtscfLGwUzfLn7A9TAXpLKBQETQQ21TcLVmHHfhifKQsZmOnwFqxfoMcoDCUm7xYI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772611844; c=relaxed/relaxed;
	bh=FG26zjgDK5eBMn4s4euS52tQRFYHZ3KePwJU6F0o7Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2HvvDhPZLdhCqm2nExt1h3Qf6vGm/O/Feqow9CMuHrqAllOoijC3c7lwI7ny9sSUnobeiQStUImVJvRzUz9egOsrQ5PBRfCRShhcRXPyn8NHgHiGoJgw4oH4zISQYQJlRIkeTNRJe3R5c0bpqjSK8HkTay1LRFnG7yI8S8fGbGh98ICFE+u5x3cMGxEyVo/NVvRkONUslEzyTCsmMe85LnLyubvfU16ejZQNnztUipIwr3xvF3B8bbAhGn6HYppeI7qlBUabH3gEYmOgtXLmDI+yKqNsy8mD4kPE75cai8GcvswJ07IdlDs8k7HODOiHMqWaT6n3vNuuDajutS9vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZvsY4JxF; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZvsY4JxF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQljH4R5bz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 19:10:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AD0EB40999;
	Wed,  4 Mar 2026 08:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53E8C19423;
	Wed,  4 Mar 2026 08:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772611840;
	bh=x/cjkUsrdE57qY9IYoGwEYkkvopBW35thxqhqdiJIAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZvsY4JxFcYf52LCAM8zNIoCTUr/ugS8UrXI8DpnABve0PkoahFeUDVQyAZ2T7w5tc
	 qvDxXw377nK660zLOZq0b1o4TMaqwXcThhKOlEpjZFL0bkvwxztXrr9ZfUwyJTBKr8
	 cQxEFx0psqwMRwqmtOZEExTbQ7fXQvjYQp1XY9q5+MJUrg2BO+qa42sUoMUFw/UKDM
	 FTPPks6SNAe+9AFIQxr/FV9a/NoFSZsQPHrTqKnPcpAk+LPhi9vX+9vtaSsBZMqckd
	 jCBvfJZ1aYZ2JCuOJ5wjnShT63I1i+NIZT0LHit09LZaUnxSAYz27d1DHaKybPv+SF
	 oKjTezLFpLZ+A==
Message-ID: <21ee2f0b-ae8e-40b6-ab13-e46f55c34254@kernel.org>
Date: Wed, 4 Mar 2026 09:10:31 +0100
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
Subject: Re: [PATCH v6 01/14] vdso/datastore: Reduce scope of some variables
 in vvar_fault()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andy Lutomirski <luto@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Nick Alcock <nick.alcock@oracle.com>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Shuah Khan <shuah@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Russell King
 <linux@armlinux.org.uk>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Shannon Nelson <sln@onemain.com>,
 Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260304-vdso-sparc64-generic-2-v6-0-d8eb3b0e1410@linutronix.de>
 <20260304-vdso-sparc64-generic-2-v6-1-d8eb3b0e1410@linutronix.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260304-vdso-sparc64-generic-2-v6-1-d8eb3b0e1410@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/03/2026 à 08:48, Thomas Weißschuh a écrit :
> These variables are only used inside a single branch.
> 
> Move their declarations there.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Tested-by: Andreas Larsson <andreas@gaisler.com>
> Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   lib/vdso/datastore.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
> index a565c30c71a0..2cca4e84e5b5 100644
> --- a/lib/vdso/datastore.c
> +++ b/lib/vdso/datastore.c
> @@ -41,8 +41,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
>   			     struct vm_area_struct *vma, struct vm_fault *vmf)
>   {
>   	struct page *timens_page = find_timens_vvar_page(vma);
> -	unsigned long addr, pfn;
> -	vm_fault_t err;
> +	unsigned long pfn;
>   
>   	switch (vmf->pgoff) {
>   	case VDSO_TIME_PAGE_OFFSET:
> @@ -54,6 +53,9 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
>   			 * Fault in VVAR page too, since it will be accessed
>   			 * to get clock data anyway.
>   			 */
> +			unsigned long addr;
> +			vm_fault_t err;
> +
>   			addr = vmf->address + VDSO_TIMENS_PAGE_OFFSET * PAGE_SIZE;
>   			err = vmf_insert_pfn(vma, addr, pfn);
>   			if (unlikely(err & VM_FAULT_ERROR))
> 


