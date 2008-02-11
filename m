Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A46EBDDE18
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 02:01:15 +1100 (EST)
Message-Id: <AF675730-BD71-4494-B1CF-18FC77133028@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martin Langer <martin-langer@gmx.de>
In-Reply-To: <20080209174748.GA3245@tuba>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] Fix for Freescale ppc cores: major revision detection
Date: Mon, 11 Feb 2008 09:01:03 -0600
References: <20080209174748.GA3245@tuba>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 9, 2008, at 11:47 AM, Martin Langer wrote:

> Ppc cores by Freescale are using the configuration field instead of  
> the
> major revision field for their major revision number. Those field
> definitions come from include/asm-powerpc/reg.h.
>
> Look at the pdf below and you will see that PVR_MAJ() does a wrong  
> shift
> for ppc cores by Freescale. This patch fixes it.
>
> http://www.freescale.com/files/archives/doc/support_info/PPCPVR.pdf

This doc doesn't encompass the e500/book-e cores that don't follow the  
same pattern.

The code should probably be something like:

#ifdef CONFIG_FSL_BOOKE
maj = PVR_MAJ(pvr);
#else
maj = (pvr >> 8) & 0xff;
#endif

>
>
>
> Signed-Off-By: Martin Langer <martin-langer@gmx.de>
>
>
> --- arch/powerpc/kernel/setup-common.c.ORIGINAL	2008-02-08  
> 22:22:56.000000000 +0100
> +++ arch/powerpc/kernel/setup-common.c	2008-02-09 18:18:36.000000000  
> +0100
> @@ -241,7 +241,7 @@
> 	/* If we are a Freescale core do a simple check so
> 	 * we dont have to keep adding cases in the future */
> 	if (PVR_VER(pvr) & 0x8000) {
> -		maj = PVR_MAJ(pvr);
> +		maj = (pvr >> 8) & 0xF;
> 		min = PVR_MIN(pvr);
> 	} else {
> 		switch (PVR_VER(pvr)) {
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
