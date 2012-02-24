Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 68495B6FAB
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 14:04:41 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: allow CONFIG_PHYS_64BIT to be selectable
Date: Fri, 24 Feb 2012 03:04:36 +0000
Message-ID: <4F46FE3E.1050605@freescale.com>
References: <1329853995-7533-1-git-send-email-timur@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C02C5E8@039-SN1MPN1-002.039d.mgd.msft.net>
 <4F463006.7060507@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C02E4A8@039-SN1MPN1-002.039d.mgd.msft.net>
 <94F013E7935FF44C83EBE7784D62AD3F0578CD9A@039-SN2MPN1-023.039d.mgd.msft.net>
 <4F46F9CF.6040600@freescale.com>
 <94F013E7935FF44C83EBE7784D62AD3F0578CFD9@039-SN2MPN1-023.039d.mgd.msft.net>
In-Reply-To: <94F013E7935FF44C83EBE7784D62AD3F0578CFD9@039-SN2MPN1-023.039d.mgd.msft.net>
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

> Even though the user still need to know the addressing mode that u-boot
> is using.  It won't work if the addressing mode of u-boot and device
> tree are different.

U-Boot will tell the user if the DT does not match.  I added code to=20
U-Boot to do that.  So if you have a 36-bit U-Boot and a 32-bit DT, then=20
you will get a warning.  If you have a 36-bit U-boot and a 36-bit DT and a=
=20
32-bit kernel, you will get nothing.  But if you have a 32-bit U-boot and=20
a 32-bit DT and a 36-bit kernel, then that will work.  A 36-bit kernel=20
works with 32-bit *and* 36-bit DTs.  This is why a 36-bit kernel should be=
=20
the default.

--=20
Timur Tabi
Linux kernel developer at Freescale=
