Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0205.outbound.protection.outlook.com [207.46.163.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A91A12C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2014 07:45:13 +1100 (EST)
Message-ID: <1389127500.11795.184.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/2] powerpc/85xx: handle the eLBC error interrupt if it
 exist in dts
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <Dongsheng.Wang@freescale.com>
Date: Tue, 7 Jan 2014 14:45:00 -0600
In-Reply-To: <1acd410af7444ba89e81dc004f2d6e89@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389076061-20159-1-git-send-email-dongsheng.wang@freescale.com>
 <1389077881.11795.137.camel@snotra.buserror.net>
 <1acd410af7444ba89e81dc004f2d6e89@BN1PR03MB188.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Xie
 Shaohui-B21989 <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-01-07 at 04:01 -0600, Wang Dongsheng-B40534 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, January 07, 2014 2:58 PM
> > To: Wang Dongsheng-B40534
> > Cc: linuxppc-dev@lists.ozlabs.org; Xie Shaohui-B21989; Kumar Gala
> > Subject: Re: [PATCH 2/2] powerpc/85xx: handle the eLBC error interrupt if it
> > exist in dts
> > 
> > On Tue, 2014-01-07 at 14:27 +0800, Dongsheng Wang wrote:
> > > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > 
> > AFAICT this patch was originally written by Shaohui Xie.
> > 
> > > On P3041, P1020, P1021, P1022, P1023 eLBC event interrupts are routed
> > > to Int9(P3041) & Int3(P102x) while ELBC error interrupts are routed to
> > > Int0, we need to call request_irq for each.
> > 
> > For p3041 I thought that was only on early silicon revs that we don't
> > support anymore.
> > 
> > As for p102x, have you tested that this is actually what happens?  How
> > would we distinguish eLBC errors from other error sources, given that
> > there's no EISR0?  Do we just hope that no other error interrupts
> > happen?
> Yes, I tested. The interrupt is shard eLBC interrupt handler could check the error.
> This patch is fix "nobody cared" the error interrupt. After sleep resume the lbc
> will get a chip select error.

s/no other error interrupts happen/no other error interrupts for which
we don't have a handler registered or which don't even have an
associated status register happen/

-Scott
