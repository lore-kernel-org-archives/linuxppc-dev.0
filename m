Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5SsB4zq3zDqR8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 03:53:02 +1100 (AEDT)
Message-ID: <1506963157.25065.48.camel@kernel.crashing.org>
Subject: Re: [PATCH 0/2] powerpc/xive: fix CPU hot unplug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, David Gibson
 <david@gibson.dropbear.id.au>
Date: Mon, 02 Oct 2017 18:52:37 +0200
In-Reply-To: <378a1945-6263-dca7-3912-b4a2c61794b8@kaod.org>
References: <20170923082656.27219-1-clg@kaod.org>
 <378a1945-6263-dca7-3912-b4a2c61794b8@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-10-02 at 18:27 +0200, Cédric Le Goater wrote:
> On 09/23/2017 10:26 AM, Cédric Le Goater wrote:
> > Hi,
> > 
> > Here are a couple of small fixes to support CPU hot unplug. There are
> > still some issues to be investigated as, in some occasions, after a
> > couple of plug and unplug, the cpu which was removed receives a 'lost'
> > interrupt. This showed to be the decrementer under QEMU.
> 
> So this seems to be a QEMU issue only which can be solved by 
> removing the DEE bit from the LPCR on P9 processor when the CPU 
> is stopped in rtas. PECE3 bit on P8 processors. 

It should be the same bit no ?

> I think these patches are valuable fixes for 4.14. The first 
> is trivial and the second touches the common xive part but it
> is only called on the pseries platform.  
> 
> Could you please take a look ? 
> 
> Thanks,
> 
> C. 
> 
> > Nevertheless, these patches are required and provide a significant
> > improvement to support CPU removal.
> > 
> > Tested under a phyp and a XIVE QEMU model for pseries.
> > 
> > Thanks,
> > 
> > C.
> > 
> > Cédric Le Goater (2):
> >   powerpc/xive: fix IPI reset
> >   powerpc/xive: fix cpu removal
> > 
> >  arch/powerpc/sysdev/xive/common.c | 8 ++++++++
> >  arch/powerpc/sysdev/xive/spapr.c  | 4 ++++
> >  2 files changed, 12 insertions(+)
> > 
