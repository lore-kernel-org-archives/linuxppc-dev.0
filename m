Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BE2832C0274
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Aug 2013 02:52:25 +1000 (EST)
Message-ID: <1376671853.31636.252.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/2] powerpc/85xx: add hardware automatically enter
 altivec idle state
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Fri, 16 Aug 2013 11:50:53 -0500
In-Reply-To: <83499AB5-DCE7-407D-AEC1-B2493D1D38BE@kernel.crashing.org>
References: <1376637789-27330-1-git-send-email-dongsheng.wang@freescale.com>
 <83499AB5-DCE7-407D-AEC1-B2493D1D38BE@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org,
 Dongsheng Wang <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-16 at 06:02 -0500, Kumar Gala wrote:
> On Aug 16, 2013, at 2:23 AM, Dongsheng Wang wrote:
> 
> > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > 
> > Each core's AltiVec unit may be placed into a power savings mode
> > by turning off power to the unit. Core hardware will automatically
> > power down the AltiVec unit after no AltiVec instructions have
> > executed in N cycles. The AltiVec power-control is triggered by hardware.
> > 
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Why treat this as a idle HW governor vs just some one time setup at boot of the time delay?

It is being done as one-time setup, despite the function name.

Maybe it should be moved into __setup/restore_cpu_e6500 (BTW, we really
should refactor those to reduce duplication) with the timebase bit
number hardcoded rather than a time in us.

As for the PVR check, the upstream kernel doesn't need to care about
rev1, so knowing it's an e6500 is good enough.

-Scott
