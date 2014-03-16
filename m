Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0241.outbound.protection.outlook.com [207.46.163.241])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 044CA2C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Mar 2014 19:07:37 +1100 (EST)
Message-ID: <1394957243.12479.155.camel@snotra.buserror.net>
Subject: Re: [PATCH 10/10] Revert "powerpc/watchdog: Don't enable interrupt
 on PPC64 BookE"
From: Scott Wood <scottwood@freescale.com>
To: Wim Van Sebroeck <wim@iguana.be>
Date: Sun, 16 Mar 2014 03:07:23 -0500
In-Reply-To: <20140315195137.GA14681@spo001.leaseweb.com>
References: <1394755249-8856-1-git-send-email-scottwood@freescale.com>
 <1394755249-8856-11-git-send-email-scottwood@freescale.com>
 <20140315195137.GA14681@spo001.leaseweb.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Tiejun Chen <tiejun.chen@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2014-03-15 at 20:51 +0100, Wim Van Sebroeck wrote:
> Hi Scott,
> 
> > This reverts commit 3978bdb4ed653342b0be66c031bf61b72cc55d60, now that
> > critical interrupts are properly supported on ppc64 booke.
> > 
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > Cc: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
> > Cc: Wim Van Sebroeck <wim@iguana.be>
> > ---
> >  drivers/watchdog/booke_wdt.c | 8 --------
> >  1 file changed, 8 deletions(-)
> > 
> > diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
> > index f1b8d55..a8dbceb3 100644
> > --- a/drivers/watchdog/booke_wdt.c
> > +++ b/drivers/watchdog/booke_wdt.c
> > @@ -138,14 +138,6 @@ static void __booke_wdt_enable(void *data)
> >  	val &= ~WDTP_MASK;
> >  	val |= (TCR_WIE|TCR_WRC(WRC_CHIP)|WDTP(booke_wdt_period));
> >  
> > -#ifdef CONFIG_PPC_BOOK3E_64
> > -	/*
> > -	 * Crit ints are currently broken on PPC64 Book-E, so
> > -	 * just disable them for now.
> > -	 */
> > -	val &= ~TCR_WIE;
> > -#endif
> > -
> >  	mtspr(SPRN_TCR, val);
> >  }
> >  
> 
> Patch has been added to linux-watchdog-next.

Please unapply it.  It is patch 10/10 and depends on the previous parts
of the patchset to make critical interrupts work properly.

-Scott
