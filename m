Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DC48BDDFF4
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 07:55:27 +1000 (EST)
Subject: Re: [PATCH] [PowerPC] Support For Initrd Loaded Into Highmem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Konstantin Baydarov <kbaidarov@ru.mvista.com>
In-Reply-To: <4A103EDF.7050108@ru.mvista.com>
References: <4A103EDF.7050108@ru.mvista.com>
Content-Type: text/plain
Date: Mon, 18 May 2009 07:55:03 +1000
Message-Id: <1242597303.18075.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Also if initrd is in the highmem, uBoot adds initrd highmem region into the
> initial_boot_params->off_mem_rsvmap. This leads to kernel crash, because kernel
> assumes that regions from the initial_boot_params->off_mem_rsvmap are in the
> lowmem. So patch skips initrd highmem region when kernel reserves lowmem regions
> in early_reserve_mem().
> 
>   This patch is for linux-2.6.30-rc6.

Fixing the reserve map isn't the right approach.

We should be able to have anything in there. It's the kernel that should
be more careful at coping if it contains things that aren't in lowmem.

Cheers,
Ben.
