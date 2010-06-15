Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A1C50B7D66
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 15:05:04 +1000 (EST)
Subject: Re: [PATCH] powerpc: Fix mpic_resume on early G5 macs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alastair Bridgewater <alastair.bridgewater@gmail.com>
In-Reply-To: <AANLkTimrq40Pd-ulPkfb8T2LJ0NSybd5InviirU7fK5D@mail.gmail.com>
References: <AANLkTimrq40Pd-ulPkfb8T2LJ0NSybd5InviirU7fK5D@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 15 Jun 2010 15:04:55 +1000
Message-ID: <1276578295.2552.85.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-06-12 at 21:36 -0400, Alastair Bridgewater wrote:
> mpic_resume() on G5 macs blindly dereferences mpic->fixups, but
> it may legitimately be NULL (as on PowerMac7,2).  Add an explicit
> check.
> 
> This fixes susend-to-disk with one processor (maxcpus=1) for me.

Thanks. Patch is terribly mangled tho (word wrapped and tabs have been
replaced with spaces). I fixed it up manually but check your email setup
next time.

Cheers,
Ben.

> Signed-off-by: Alastair Bridgewater <alastair.bridgewater@gmail.com>
> ---
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 4fd57ab..28668ba 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1666,7 +1666,7 @@ static int mpic_resume(struct sys_device *dev)
>                                mpic->save_data[i].dest);
> 
>  #ifdef CONFIG_MPIC_U3_HT_IRQS
> -       {
> +       if (mpic->fixups) {
>                 struct mpic_irq_fixup *fixup = &mpic->fixups[i];
> 
>                 if (fixup->base) {
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
