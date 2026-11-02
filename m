Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CD26072EFD
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Gz4AbbDz;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ZoskNSoX
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJHL63w7cz2xK7;
	Tue, 03 Nov 2026 03:32:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793637150;
	cv=none; b=K5/zQ67AdQ5P/aBo5VVEQ3H759ibU7MnzAS8Z4uVL6mxOMv4yP8MTS7ZhS+sid4VmkAcp8TBU068e0yCxoGqMzjVlP+lYkgSAuSTXVajiC4LjTKU2EJM8IWLl1lEmRcRdHkxqaEJfBz5Bp9Omr+Xwi75BNMIncH5FTqP+nNtLFbGUamCNVzEf29hUhmfDATIbnXKVVu0IVXLXsq84aieI6ab7+eO5Zs66upiuTD/EsWg30wTYA2c0x9RfAxXuKsUImAALtyWStOichSp8mN29wzL14f4LQH4zCNAtEmAwIpLaeOcaOWuGz84u6FgeLFeidsK83B7GZmygzxQb0F9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793637150; c=relaxed/relaxed;
	bh=nPU/b/fRrGFWjTF7wyffZ8NB+VPLw6oTBV3Tou13Kjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBmvU2CHb25r1aIdVR7IOiNOZCX3V9rm1X6mE0q0FtTvDQwBADwBY+5iORwg3FKbcm6TsC3Bjqa6lyZxEpilH3GAYQ9eHoxePEgJon+Hj1VoVDfGnhVzkZEN9UDHJ3ZcVmX5LRobEgUgwD8WG79J+Su3MmuMgvuceXt18s+shl7LHQ0D09LTFkD8Un7iln8LWBblBCB0Ld4GWeUGrgKUAlt2oZOZuUeZFv7H+UFEvSWUy+Ih8C+nBGbnM4e2qu8QQ4qwxP+Tz6+XYFqXzqopt63oPRsge28S7rLNz5bp5YrlnGPZeFE9Cu+HX6huky7fbJu+yvjYK00rlEHjuQHy2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Gz4AbbDz; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ZoskNSoX; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Gz4AbbDz;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ZoskNSoX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJHL546WQz2xJF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 03:32:29 +1100 (AEDT)
Date: Mon, 2 Nov 2026 17:32:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793637145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nPU/b/fRrGFWjTF7wyffZ8NB+VPLw6oTBV3Tou13Kjk=;
	b=Gz4AbbDzmFTUeKb+PI/scrv/zERqv9qLJs7cTD7S3OIgnXufwqmdnN3iKi4PcM4SBUgGX8
	UtoedaI7ms+aqqgeGgaOwkuaM9oZPK1lAyLZ6lQGZWiTwYQuUTyyoDbbxPWcdUvwlimDMM
	nKuLkgIQwbjOv/HntyT94oCvnYfjMGyG9hyAxFU3pvoE33erUhjWen46AI+gKZglTluvqH
	l07HR2MsG1L1qGp2HisKbq+oqi0sKfcBaQwe8Jxb4y4/WHCaY0Klpv1L8NEWSXNo9pIF6d
	xZfu3WkS+hZ1OGza0VfSell/3biHiXfUPyIrULIq7Zxfr0YpHfhlvCFO8bG3XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793637145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nPU/b/fRrGFWjTF7wyffZ8NB+VPLw6oTBV3Tou13Kjk=;
	b=ZoskNSoX7Zkzpqco8O3SZSFK670KaNvvzb/nguzZGQ/JTzhhn+43jzf2QQUP5q9Kddgtra
	/dFG6WtLnwEglODA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Palmer <daniel@0x0f.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/powermac: Always close the timebase-sync i2c bus
Message-ID: <20261102163223.qV85cD1R@linutronix.de>
References: <20261030232418.1145779-1-daniel@0x0f.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261030232418.1145779-1-daniel@0x0f.com>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-31 08:24:18 [+0900], Daniel Palmer wrote:
> smp_core99_cpu_prepare() opens an i2c bus for "tb sync" and that is
> closed again in smp_core99_cpu_online().
> 
> If a processor module is dysfunctional, not seated correctly or
> otherwise fails to come online smp_core99_cpu_online() is not called
> and the bus stays open.
> 
> On some G5s (tested PowerMac7,3) this i2c bus also has the CPU
> temperature sensor and fan controller connected to it so not closing
> the bus stops the kernel from making sure the working CPU doesn't
> roast itself to death.
> 
> Rename smp_core99_cpu_online() to smp_core99_cpu_online_prepare_down()
> and wire it up to get called when onlining fails as well so the
> bus is closed and the working CPU stays working.

"and the I2C bus remains accessible by the i2c-driver."

The `smp_core99_host_open' makes sure it does not get closed twice so
that works.

> Fixes: 68e694dcef24 ("powerpc/powermac: Convert to hotplug state machine")

So the old CPU_UP_CANCELED case would have close it and I forgot to copy
that part.

> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  arch/powerpc/platforms/powermac/smp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
> index 88e92af8acf9..e310b6fbbede 100644
> --- a/arch/powerpc/platforms/powermac/smp.c
> +++ b/arch/powerpc/platforms/powermac/smp.c
> @@ -865,7 +865,7 @@ static int smp_core99_cpu_prepare(unsigned int cpu)
>  	return 0;
>  }
>  
> -static int smp_core99_cpu_online(unsigned int cpu)
> +static int smp_core99_cpu_online_prepare_down(unsigned int cpu)
>  {
>  	/* Close i2c bus if it was used for tb sync */
>  	if (pmac_tb_clock_chip_host && smp_core99_host_open) {
> @@ -893,9 +893,9 @@ static void __init smp_core99_bringup_done(void)
>  #ifdef CONFIG_HOTPLUG_CPU
>  	cpuhp_setup_state_nocalls(CPUHP_POWERPC_PMAC_PREPARE,
>  				  "powerpc/pmac:prepare", smp_core99_cpu_prepare,
> -				  NULL);
> +				  smp_core99_cpu_online_prepare_down);
>  	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "powerpc/pmac:online",
> -				  smp_core99_cpu_online, NULL);
> +				  smp_core99_cpu_online_prepare_down, NULL);

I don't think it is needed to rename the function as such.  OpenBUS/
CloseBUS would be more matching than to the sate it runs in me think.
But it is not my call. For the "adding the function to the prepare
notifier" part:

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

>  #endif
>  
>  	if (ppc_md.progress)

Sebastian

