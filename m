Return-Path: <SRS0=BgZL=ZL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304FAC432C0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 01:21:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A6F206CC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 01:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="QDGQW6bh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A6F206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47H7MQ6f3qzDqZT
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 12:21:38 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47H7KB52DQzDqT5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2019 12:19:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="QDGQW6bh"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 47H7K82zfhz9sPL;
 Tue, 19 Nov 2019 12:19:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1574126382;
 bh=maX43JYoFqxngt1nHc0oT20YehFVIccTW2ma2xMGkGM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=QDGQW6bhsISaWKFrbk1hKjd7p5pQ0kdKTiSRd2sA8AYFk1XRjRuVmwYCkTZtHYwBK
 7wRb2CrSoWyOz2jXyZLwfQ/jjPrGCggeitnii7FWhlJCN5XRcOf2lxjzhH8XIw7P6j
 Y9+qkRRzgHkGhLKh59mHWsIcv8jWnzd7qS5JwpeS7ZuRiLBU4N2u5BCFN5FOmTkG33
 ruAWLHjJGjA/LwQ0sYNH5TL0vNFpOfWygeJjZleYhvCHJANuJFgSxJ/I1VsjlGDZxG
 NdDmPAc4YFtwVL6OE7jh8n/LlqNGBWTnD/CD6F/QOaq8v3YEf8jVwuorkhG7Rs4LdO
 68ZJBJtybCrgA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Qais Yousef <qais.yousef@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 03/12] powerpc: Replace cpu_up/down with
 device_online/offline
In-Reply-To: <20191030153837.18107-4-qais.yousef@arm.com>
References: <20191030153837.18107-1-qais.yousef@arm.com>
 <20191030153837.18107-4-qais.yousef@arm.com>
Date: Tue, 19 Nov 2019 12:19:39 +1100
Message-ID: <87h830d5n8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Enrico Weigelt <info@metux.net>,
 Qais Yousef <qais.yousef@arm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Qais Yousef <qais.yousef@arm.com> writes:
> The core device API performs extra housekeeping bits that are missing
> from directly calling cpu_up/down.
>
> See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
> serialization during LPM") for an example description of what might go
> wrong.
>
> This also prepares to make cpu_up/down a private interface for anything
> but the cpu subsystem.
>
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> CC: Michael Ellerman <mpe@ellerman.id.au>
> CC: Enrico Weigelt <info@metux.net>
> CC: Ram Pai <linuxram@us.ibm.com>
> CC: Nicholas Piggin <npiggin@gmail.com>
> CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> CC: Christophe Leroy <christophe.leroy@c-s.fr>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: linuxppc-dev@lists.ozlabs.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/powerpc/kernel/machine_kexec_64.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

My initial though is "what about kdump", but that function is not called
during kdump, so there should be no issue with the extra locking leading
to deadlocks in a crash.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

I assume you haven't actually tested it?

cheers

> diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
> index 04a7cba58eff..ebf8cc7acc4d 100644
> --- a/arch/powerpc/kernel/machine_kexec_64.c
> +++ b/arch/powerpc/kernel/machine_kexec_64.c
> @@ -208,13 +208,15 @@ static void wake_offline_cpus(void)
>  {
>  	int cpu = 0;
>  
> +	lock_device_hotplug();
>  	for_each_present_cpu(cpu) {
>  		if (!cpu_online(cpu)) {
>  			printk(KERN_INFO "kexec: Waking offline cpu %d.\n",
>  			       cpu);
> -			WARN_ON(cpu_up(cpu));
> +			WARN_ON(device_online(get_cpu_device(cpu)));
>  		}
>  	}
> +	unlock_device_hotplug();
>  }
>  
>  static void kexec_prepare_cpus(void)
> -- 
> 2.17.1
