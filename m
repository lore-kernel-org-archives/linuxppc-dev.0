Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EF3292C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 06:19:08 +1000 (EST)
Date: Mon, 29 Apr 2013 15:18:56 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 12/15] powerpc/85xx: add time base sync support for
 e6500
To: Zhao Chenhui <chenhui.zhao@freescale.com>
In-Reply-To: <20130428095634.GA27100@localhost.localdomain> (from
 chenhui.zhao@freescale.com on Sun Apr 28 04:56:34 2013)
Message-ID: <1367266736.32182.11@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 r58472@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/28/2013 04:56:34 AM, Zhao Chenhui wrote:
> On Thu, Apr 25, 2013 at 07:07:24PM -0500, Scott Wood wrote:
> > On 04/24/2013 07:28:18 PM, Zhao Chenhui wrote:
> > >On Wed, Apr 24, 2013 at 05:38:16PM -0500, Scott Wood wrote:
> > >> We shouldn't base it on CPU_FTR_SMT.  For example, e6500 doesn't
> > >> claim that feature yet, except in our SDK kernel.  That doesn't
> > >> change the topology of CPU numbering.
> > >>
> > >
> > >Then, where can I get the thread information? dts?
> > >Or, wait for upstream of the thread suppport of e6500.
> >
> > It's an inherent property of e6500 (outside of some virtualization
> > scenarios, but you wouldn't run this code under a hypervisor) that
> > you have two threads per core (whether Linux uses them or not).  Or
> > you could read TMCFG0[NTHRD] if you know you're on a chip that has
> > TMRs but aren't positive it's an e6500, but I wouldn't bother.  If
> > we do ever have such a chip, there are probably other things that
> > will need updating.
> >
>=20
> But how to know that there are TMRs on a chip except by CPU_FTR_SMT.

I don't know.  I said I wouldn't bother. :-)

Just assume there are 2 threads per core on e6500.  Then you won't have =20
a dependency on the threading patches, and you won't break if =20
CPU_FTR_SMT gets disabled for some other reason, or if the threads are =20
missing from the device tree for some reason (I've seen some people =20
remove them manually in an attempt to disable threading -- I tell them =20
not to when I see it, but eventually others will do it again).

-Scott=
