Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 978BE2C013E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 10:38:45 +1000 (EST)
Message-ID: <1376959116.31636.392.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/2] powerpc/85xx: add hardware automatically enter
 altivec idle state
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Date: Mon, 19 Aug 2013 19:38:36 -0500
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F154392590101E5A5@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1376637789-27330-1-git-send-email-dongsheng.wang@freescale.com>
 <83499AB5-DCE7-407D-AEC1-B2493D1D38BE@kernel.crashing.org>
 <1376671853.31636.252.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F154392590101E5A5@039-SN2MPN1-021.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-08-18 at 21:53 -0500, Wang Dongsheng-B40534 wrote:
> Thanks for your feedback.
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Saturday, August 17, 2013 12:51 AM
> > To: Kumar Gala
> > Cc: Wang Dongsheng-B40534; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH 1/2] powerpc/85xx: add hardware automatically enter
> > altivec idle state
> > 
> > On Fri, 2013-08-16 at 06:02 -0500, Kumar Gala wrote:
> > > On Aug 16, 2013, at 2:23 AM, Dongsheng Wang wrote:
> > >
> > > > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > > >
> > > > Each core's AltiVec unit may be placed into a power savings mode
> > > > by turning off power to the unit. Core hardware will automatically
> > > > power down the AltiVec unit after no AltiVec instructions have
> > > > executed in N cycles. The AltiVec power-control is triggered by
> > hardware.
> > > >
> > > > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > >
> > > Why treat this as a idle HW governor vs just some one time setup at
> > boot of the time delay?
> > 
> > It is being done as one-time setup, despite the function name.
> > 
> > Maybe it should be moved into __setup/restore_cpu_e6500 (BTW, we really
> > should refactor those to reduce duplication) with the timebase bit
> > number hardcoded rather than a time in us.
> > 
> The frequency of the different platforms timebase is not the same.

It's close enough.  Remember, this number is a vague initial guess, not
something that's been carefully calibrated.  Though, it would make it
harder to substitute the number with one that's been more carefully
calibrated...  but wouldn't different chips possibly have different
optimal delays anyway?

> If we use it, we need to set different timebase bit on each platform.
> That is why I did not put the code in __setup/restore_cpu_e6500, I need
> use tb_ticks_per_usec to get timebase bit. So we only need to set a time
> for each platform, and not set different timebase bit.

It just seems wrong to have an ad-hoc mechanism for running
core-specific code when we have cputable...  If we really need this,
maybe we should add a "cpu_setup_late" function pointer.

With your patch, when does the power management register get set when
hot plugging a cpu?

> > As for the PVR check, the upstream kernel doesn't need to care about
> > rev1, so knowing it's an e6500 is good enough.
> > 
> But AltiVec idle & PW20 cannot work on rev1 platform.
> We didn't have to deal with it?

Upstream does not run on rev1.

-Scott
