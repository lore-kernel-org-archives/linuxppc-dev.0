Return-Path: <segher@kernel.crashing.org>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D561967A77
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2005 04:07:45 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.12.10/8.12.10) with ESMTP id j5TI7dFu139822
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2005 18:07:39 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j5TI7dIk149502
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2005 20:07:39 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	j5TI7cCW021139
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2005 20:07:38 +0200
In-Reply-To: <20050629130113.GA30972@suse.de>
References: <20050629130113.GA30972@suse.de>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <20750c905c7c0f2eccc3eba6dc1421db@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Wed, 29 Jun 2005 20:08:13 +0200
To: Olaf Hering <olh@suse.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] use correct register names in
	arch/ppc/kernel/relocate_kernel.S
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> --- linux-2.6.13-rc1.orig/arch/ppc/kernel/relocate_kernel.S
> +++ linux-2.6.13-rc1/arch/ppc/kernel/relocate_kernel.S
> @@ -34,9 +34,9 @@ relocate_new_kernel:
>
>  	mr	r8, r0
>  	ori     r8, r8, MSR_RI|MSR_ME
> -	mtspr	SRR1, r8
> +	mtspr	SPRN_SRR1, r8
>  	addi	r8, r4, 1f - relocate_new_kernel
> -	mtspr	SRR0, r8
> +	mtspr	SPRN_SRR0, r8
>  	sync
>  	rfi

Or just mtsrr0 c.q. mtsrr1.


Segher
