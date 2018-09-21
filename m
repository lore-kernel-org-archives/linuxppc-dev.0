Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42H1MM70PSzF3QZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2018 03:49:51 +1000 (AEST)
Message-ID: <666d304e5aeae639dbae2f5e9f62d7234041d6d2.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: York Sun <york.sun@nxp.com>, Scott Wood <swood@redhat.com>, David
 Lamparter <equinox@diac24.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 21 Sep 2018 12:47:34 -0500
In-Reply-To: <DB7PR04MB4298A6AD0F866804A3F4FB6F9A120@DB7PR04MB4298.eurprd04.prod.outlook.com>
References: <20180920224856.GJ487685@eidolon.nox.tf>
 <1537489893.7689.38.camel@redhat.com>
 <DB7PR04MB4298A6AD0F866804A3F4FB6F9A120@DB7PR04MB4298.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH ppc-next] powerpc/fsl-booke: don't load early TLB at once
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-09-21 at 17:40 +0000, York Sun wrote:
> On 09/20/2018 05:31 PM, Scott Wood wrote:
> > On Fri, 2018-09-21 at 00:48 +0200, David Lamparter wrote:
> > > This is a *partial* revert of "powerpc/85xx: Load all early TLB entries
> > > at once" (d9e1831a420267a7ced708bb259d65b0a3c0344d.)
> > > 
> > > My dusty old P4080DS just completely fails to boot (no output at all)
> > > without this revert.  I have no clue what's going on here, I just
> > > bisected it down and since it looks like an optimization to me I just
> > > reverted it - and voilá, the P4080 boots again.
> > 
> > It's not an optimization; it was required to get kdump working, at least
> > for certain choices of crash kernel location.  I just tried booting a 32-
> > bit kernel and did not see this problem -- but I don't have access to a
> > p4080ds anymore.  I tried with qemu e500mc, and also running a 32-bit
> > kernel on e6500 (needs a tiny change to get past SMP init, since 32-bit
> > isn't really supported on e6500, but you do get output even without that).
> > 
> > Do you have a JTAG that can be used to find out where it's hanging?  If
> > not, I can try to get early debug working (needs an early IOMMU mapping).
> > 
> > York, can you try booting the latest kernel on p4080ds?
> > 
> 
> Scott,
> 
> I haven't tried P4080DS for a long time. What defconfig do you use for
> this board? I tried latest master branch (commit a27fb6d983c7b5) with
> corenet_basic_defconfig, it didn't boot up. Kernel has an exception very
> early (pc ffffae80).
> 
> However, before I claimed the board, someone booted Linux 4.14.71 on
> this board. I need to track down where the image came from.

Use corenet32_smp_defconfig

corenet_basic_defconfig is just a fragment used by the makefiles in assembling
the final config.

-Scott
