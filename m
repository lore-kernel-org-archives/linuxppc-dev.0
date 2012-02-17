Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe005.messaging.microsoft.com
 [65.55.88.15]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D5C34B6F13
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Feb 2012 03:22:31 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc/85xx: fix problem that prevents PHYS_64BIT
 from configurable
Date: Fri, 17 Feb 2012 16:22:21 +0000
Message-ID: <CAOZdJXWQzxWXhU_4WmeKXx1mfTxGQx=-JZx0AkZcF7CmRrp1gQ@mail.gmail.com>
References: <1329394210-1014-1-git-send-email-leoli@freescale.com>
 <EDB74FED-002D-4F94-B134-995BFB4C0A6B@kernel.crashing.org>
In-Reply-To: <EDB74FED-002D-4F94-B134-995BFB4C0A6B@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 16, 2012 at 7:27 PM, Kumar Gala <galak@kernel.crashing.org> wro=
te:

> For some of these platforms like P2041RDB, P3041DS, P3060QDS, P4080DS, & =
P5020DS only a 36-bit physical address map is supported by u-boot and the d=
evice tree. =A0This was a decision that was made to NOT support 32-bit addr=
ess map for these boards and accept the performance implication of it to re=
duce the # of builds, etc.

Was this a Freescale internal decision, or is this a generic 85xx decision?

For the record, I'm in favor in leaving out support for 32-bit address
map in the upstream kernel, and having it be an option on the SDK
only.  However, in order to do that, we cannot have "select
PHYS_64BIT" in the Kconfigs.  It needs to be in the defconfigs
instead.  Putting it in the defconfig will eliminate the need to have
it in every Kconfig block, so I think that's an improvement.

Then the SDK can include a defconfig that does not have PHYS_64BIT
defined.  And the SDK can include 32-bit U-Boots and 32-bit device
trees for any board where Freescale determines there is a need.

I think Leo's patch simplifies things for everyone.

--=20
Timur Tabi
Linux kernel developer at Freescale=
