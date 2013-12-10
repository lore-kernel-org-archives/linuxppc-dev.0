Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 72FF42C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 21:05:08 +1100 (EST)
Date: Tue, 10 Dec 2013 11:05:01 +0100
From: Gerhard Sittig <gsi@denx.de>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v1 1/1] powerpc/512x: dts: remove misplaced IRQ spec from
 'soc' node
Message-ID: <20131210100501.GO2982@book.gsilab.sittig.org>
References: <1386068212-11484-1-git-send-email-gsi@denx.de>
 <20131203150432.2c326004@crub>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131203150432.2c326004@crub>
Cc: devicetree@vger.kernel.org, matteo.facchinetti@sirius-es.it,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ Cc: to Matteo as well ]

On Tue, Dec 03, 2013 at 15:04 +0100, Anatolij Gustschin wrote:
> 
> On Tue,  3 Dec 2013 11:56:52 +0100
> Gerhard Sittig <gsi@denx.de> wrote:
> 
> > the 'soc' node in the common .dtsi for MPC5121 has an '#interrupt-cells'
> > property although this node is not an interrupt controller
> > 
> > remove this erroneously placed property because starting with v3.13-rc1
> > lookup and resolution of 'interrupts' specs for peripherals gets misled,
> > emits 'no irq domain found' WARN() messages and breaks the boot process
> > 
> >   irq: no irq domain found for /soc@80000000 !
> >   ------------[ cut here ]------------
> >   WARNING: at /home/gsi/SRC/linux-torvalds/drivers/of/platform.c:171
> > [ ... ]
> > 
> >   ...
> >   irq: no irq domain found for /soc@80000000 !
> >   fsl-diu-fb 80002100.display: could not get DIU IRQ
> >   fsl-diu-fb: probe of 80002100.display failed with error -22
> >   irq: no irq domain found for /soc@80000000 !
> >   mpc512x_dma 80014000.dma: Error mapping IRQ!
> >   mpc512x_dma: probe of 80014000.dma failed with error -22
> >   ...
> >   irq: no irq domain found for /soc@80000000 !
> >   fs_enet: probe of 80002800.ethernet failed with error -22
> >   ...
> >   irq: no irq domain found for /soc@80000000 !
> >   mpc5121-rtc 80000a00.rtc: mpc5121_rtc_probe: could not request irq: 0
> >   mpc5121-rtc: probe of 80000a00.rtc failed with error -22
> >   ...
> > 
> > [ best viewed with 'git diff -U5' to have DT node names in the context ]
> > 
> > Cc: Anatolij Gustschin <agust@denx.de>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Gerhard Sittig <gsi@denx.de>
> > ---
> >  arch/powerpc/boot/dts/mpc5121.dtsi |    1 -
> >  1 file changed, 1 deletion(-)
> 
> applied, thanks!

FYI: I only noticed yesterday that MPC5125 suffers from the same
issue, have sent <1386669068-2477-1-git-send-email-gsi@denx.de>
to fix that as well.  Both patches may get squashed when going
upstream.  Don't have a dump at hand for MPC5125 as I don't have
access to hardware.

Matteo, can you verify that an unpatched v3.13-rc1 (up to and
including -rc3) won't boot, and that the patch fixes the issue
for you?  Forgot to Cc: you on the MPC5125 patch, will bounce it
to you.  Thanks!


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
