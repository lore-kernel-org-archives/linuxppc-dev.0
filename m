Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C787DB6F62
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 15:11:36 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: allow CONFIG_PHYS_64BIT to be selectable
Date: Fri, 24 Feb 2012 04:11:13 +0000
Message-ID: <4F470DDD.2060803@freescale.com>
References: <1329853995-7533-1-git-send-email-timur@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C02C5E8@039-SN1MPN1-002.039d.mgd.msft.net>
 <4F463006.7060507@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C02E4A8@039-SN1MPN1-002.039d.mgd.msft.net>
 <94F013E7935FF44C83EBE7784D62AD3F0578CD9A@039-SN2MPN1-023.039d.mgd.msft.net>
 <4F46F9CF.6040600@freescale.com>
 <94F013E7935FF44C83EBE7784D62AD3F0578CFD9@039-SN2MPN1-023.039d.mgd.msft.net>
 <4F46FE3E.1050605@freescale.com>
 <94F013E7935FF44C83EBE7784D62AD3F0578D305@039-SN2MPN1-023.039d.mgd.msft.net>
 <4F470910.9080008@freescale.com>
 <94F013E7935FF44C83EBE7784D62AD3F0578D5BD@039-SN2MPN1-023.039d.mgd.msft.net>
In-Reply-To: <94F013E7935FF44C83EBE7784D62AD3F0578D5BD@039-SN2MPN1-023.039d.mgd.msft.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Huang Changming-R66093 <r66093@freescale.com>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Li Yang-R58472 wrote:

> It's a good point.  Why can't we decide to use 32-bit/36-bit TLB at runti=
me even for e500v2?

That's not what PHYS_64BIT does.  PHYS_64BIT determines whether=20
phys_addr_t is a u64 or a u32.  This is something that must be determined=20
at compilation time.

>> Please remember that the Kconfig for the P1022DS already forced
>> PHYS_64BIT for all mpc85xx platforms.  All we're doing is making it
>> possible to deselect PHYS_64BIT.
>
> I think it's a side-effect introduced by P1022DS support and need to be f=
ixed.

Exactly.  That's what these patches do.  And these patches have been=20
applied to the SDK.  I'm just waiting for Kumar to apply them to his=20
repository.

> There was no mentioning of enforcing 36-bit for all mpc85xx platforms.

It's not enforcing, it's just the default.  If you build with=20
mpc85xx_smp_defconfig, then you'll get a 36-bit kernel.  But now you can=20
also use menuconfig to turn off PHYS_64BIT.  Before these fixes, that was=20
not possible.

--=20
Timur Tabi
Linux kernel developer at Freescale=
