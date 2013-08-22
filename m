Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 479C42C009F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 01:19:34 +1000 (EST)
Message-ID: <1377184761.5029.96.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/2] powerpc/85xx: add hardware automatically enter
 altivec idle state
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Date: Thu, 22 Aug 2013 10:19:21 -0500
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F1543925901027BD3@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1376637789-27330-1-git-send-email-dongsheng.wang@freescale.com>
 <83499AB5-DCE7-407D-AEC1-B2493D1D38BE@kernel.crashing.org>
 <1376671853.31636.252.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F154392590101E5A5@039-SN2MPN1-021.039d.mgd.msft.net>
 <1376959116.31636.392.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F1543925901027BD3@039-SN2MPN1-021.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-08-21 at 22:13 -0500, Wang Dongsheng-B40534 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, August 20, 2013 8:39 AM
> > To: Wang Dongsheng-B40534
> > Cc: Wood Scott-B07421; Kumar Gala; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH 1/2] powerpc/85xx: add hardware automatically enter
> > altivec idle state
> > 
> > It just seems wrong to have an ad-hoc mechanism for running
> > core-specific code when we have cputable...  If we really need this,
> > maybe we should add a "cpu_setup_late" function pointer.
> > 
> > With your patch, when does the power management register get set when
> > hot plugging a cpu?
> > 
> Um.. I don't deal with this situation. I will fix it.
> __setup/restore_cpu_e6500 looks good. But only bootcpu call __setup_cpu_e6500, not on each cpu.
> I think this is a bug.

Other CPUs call __restore_cpu_e6500.

> > > > As for the PVR check, the upstream kernel doesn't need to care about
> > > > rev1, so knowing it's an e6500 is good enough.
> > > >
> > > But AltiVec idle & PW20 cannot work on rev1 platform.
> > > We didn't have to deal with it?
> > 
> > Upstream does not run on rev1.
> > 
> :), But already have customers in the use of rev1.
> Why we don't need to care about that?

rev1 is not production-qualified.  Those customers are supposed to only
be using rev1 for evaluation and early development.  It's not that we
don't care about rev1 now (we have the SDK for that) but that we won't
care about it long-term and don't want to have to carry around a bunch
of baggage for it.  Some of the workarounds are pretty nasty (especially
A-006198).

-Scott
