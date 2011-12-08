Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 8ED381007D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2011 05:00:38 +1100 (EST)
Message-ID: <4EE0FB3C.6050608@freescale.com>
Date: Thu, 8 Dec 2011 12:00:28 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Liu Shengzhou-B36685 <B36685@freescale.com>
Subject: Re: [PATCH 1/2 v2] mtd/nand: fixup for fmr initialization of Freescale
 NAND controller
References: <1323161655-19050-1-git-send-email-Shengzhou.Liu@freescale.com>
 <4EDE4DEC.7010308@freescale.com>
 <3F453DDFF675A64A89321A1F352810216B0787@039-SN1MPN1-005.039d.mgd.msft.net>
 <4EDF9F9C.7050702@freescale.com>
 <3F453DDFF675A64A89321A1F352810216B089C@039-SN1MPN1-005.039d.mgd.msft.net>
In-Reply-To: <3F453DDFF675A64A89321A1F352810216B089C@039-SN1MPN1-005.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/07/2011 09:36 PM, Liu Shengzhou-B36685 wrote:
> 
> 
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Thursday, December 08, 2011 1:17 AM
>> To: Liu Shengzhou-B36685
>> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org; linux-
>> mtd@lists.infradead.org; dwmw2@infradead.org; Gala Kumar-B11780
>> Subject: Re: [PATCH 1/2 v2] mtd/nand: fixup for fmr initialization of
>> Freescale NAND controller
>>
>> On 12/07/2011 12:30 AM, Liu Shengzhou-B36685 wrote:
>>> [Shengzhou] This patch doesn't change the way ECCM is handled, it's
>> still same as before, just make sure CWTO timeout is set to maximum.
>>
>> It does change it.  It used to use the existing value in FMR, and now it
>> sets it based on ORn[PGS].
>>
>> -Scott
> 
> [Shengzhou]
>   In u-boot:
> 	#ifdef CONFIG_FSL_ELBC_FMR
>            priv->fmr = CONFIG_FSL_ELBC_FMR;
> 	#else
> 	     priv->fmr = (15 << FMR_CWTO_SHIFT) | (2 << FMR_AL_SHIFT);
> 	     or = in_be32(&elbc_ctrl->regs->bank[priv->bank].or);
> 	     if (or & OR_FCM_PGS)
>     		       priv->fmr |= FMR_ECCM;
> 	#endif
> 
> In kernel: It used to be " priv->fmr = in_be32(&lbc->fmr) & FMR_ECCM
> ", so fmr was always 0x100(or 0,depend on ORn[PGS]), CWTO was
> 0(timeout was minimum).   In this patch, for not relying on
> bootloader, fmr is initialized as what u-boot does, except
> FMR_AL_SHIFT is handled in fsl_elbc_chip_init_tail and without
> definition of CONFIG_FSL_ELBC_FMR.
> 
>   So, it doesn't change it.

You're assuming that the above U-Boot code is always run.  This depends
on whether the NAND driver is enabled in U-Boot.

In the future, though, it might also depend on whether a NAND command is
actually run in U-Boot -- this makes the setting of FMR
non-deterministic between boots, which is worse than a one-time breakage
of an unusual setup (driver not enabled in U-Boot at all).

So it is a change, but I now think it's a change we should make.  The
changelog should mention that this is happening, though.

> Do we still need CONFIG_FSL_ELBC_FMR in kernel? 

We do not want such a compile-time constant in the kernel.  Use ORn[PGS]
as the patch currently does.

-Scott
