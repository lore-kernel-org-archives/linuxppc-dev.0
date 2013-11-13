Return-Path: <scottwood@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9755C2C0096
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Nov 2013 05:19:24 +1100 (EST)
Received: from mail142-tx2 (localhost [127.0.0.1])	by
 mail142-tx2-R.bigfish.com (Postfix) with ESMTP id 7CB7C4203FF	for
 <linuxppc-dev@ozlabs.org>; Wed, 13 Nov 2013 18:19:21 +0000 (UTC)
Received: from TX2EHSMHS036.bigfish.com (unknown [10.9.14.227])	by
 mail142-tx2.bigfish.com (Postfix) with ESMTP id E021240283	for
 <linuxppc-dev@ozlabs.org>; Wed, 13 Nov 2013 18:19:13 +0000 (UTC)
Message-ID: <1384366750.1403.154.camel@snotra.buserror.net>
Subject: Re: [PATCH V2] powerpc/85xx: Merge 85xx/p1023_defconfig into
 mpc85xx_smp_defconfig and mpc85xx_defconfig
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@freescale.com>
Date: Wed, 13 Nov 2013 12:19:10 -0600
In-Reply-To: <5282E52B.2040306@Freescale.com>
References: <1383952632-5770-1-git-send-email-Lijun.Pan@freescale.com>
 <1384197913-24610-1-git-send-email-Lijun.Pan@freescale.com>
 <1384293891.1403.70.camel__45039.5534084693$1384293935$gmane$org@snotra.buserror.net>
 <5282B277.4090300@Freescale.com>
 <1384307175.1403.118.camel__32063.4016803981$1384307228$gmane$org@snotra.buserror.net>
 <5282E52B.2040306@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-11-12 at 20:34 -0600, Emil Medve wrote:
> Hello Scott,
> 
> 
> On 11/12/2013 07:46 PM, Scott Wood wrote:
> > On Tue, 2013-11-12 at 16:57 -0600, Emil Medve wrote:
> >> Hello Scott,
> >>
> >>
> >> On 11/12/2013 04:04 PM, Scott Wood wrote:
> >>> On Mon, 2013-11-11 at 13:25 -0600, Lijun Pan wrote:
> >>>> mpc85xx_smp_defconfig and mpc85xx_defconfig already have CONFIG_P1023RDS=y.
> >>>> Merge CONFIG_P1023RDB=y and other relevant configurations into mpc85xx_smp_defconfig and mpc85_defconfig.
> >>>>
> >>>> Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
> >>>> ---
> >>>>  arch/powerpc/configs/85xx/p1023_defconfig  |  188 ----------------------------
> >>>>  arch/powerpc/configs/mpc85xx_defconfig     |   18 +++
> >>>>  arch/powerpc/configs/mpc85xx_smp_defconfig |   17 +++
> >>>>  3 files changed, 35 insertions(+), 188 deletions(-)
> >>>>  delete mode 100644 arch/powerpc/configs/85xx/p1023_defconfig
> >>>
> >>> Are we still going to want to have one defconfig if and when we finally
> >>> get datapath support upstream?  That's a lot of code to add to the 85xx
> >>> config just for this one chip.
> >>
> >> Yes. But for mpc85xx_/smp_defconfig the datapath support shouldn't be
> >> enabled by default given that just one SoC in that family has the
> >> datapath (and we don't plan to put it in another e500v2 based SoC). For
> >> regression/automation purposes config fragments should be used
> > 
> > Is there any way to specify a meta-config for p1023 (or e500v2-dpaa or
> > whatever) that says to combine mpc85xx_smp_defconfig with a dpaa
> > fragment?
> 
> Not aware of it

Then it's not yet a substitute for having a defconfig.

> > Do we have any config fragments in the tree so far?
> 
> Nope. However, just to make sure, the fragment was my secondary point
> and not necessarily as a candidate for upstreaming. My main point was
> that the datapath support should simply not be enabled by default in the
> mpc85xx_[smp_]defconfig

I think we should get numbers on how big the datapath code is (in its
eventual upstream form) before deciding that, but if we do end up
deciding not to enable it in mpc85xx_smp_defconfig, then there should be
a separate defconfig for p1023 (possibly with a more generic name as
discussed earlier).  If and when there's support for defconfigs that
direct fragments to be included, then we can change the p1023 defconfig
to use that, but I don't want to just leave it up to the user to enable
manually.

If there's any way we can get the datapath code down to a reasonable
size for inclusion in mpc85xx_smp_defconfig, that would be ideal.

-Scott
