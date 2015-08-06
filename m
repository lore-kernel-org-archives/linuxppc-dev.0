Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0123.outbound.protection.outlook.com [207.46.100.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418F01A1DF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 15:46:41 +1000 (AEST)
Message-ID: <1438839985.2097.151.camel@freescale.com>
Subject: Re: [PATCH 1/3] Powerpc: mpc85xx: refactor the PM operations
From: Scott Wood <scottwood@freescale.com>
To: Chenhui Zhao <chenhui.zhao@freescale.com>
CC: <b29983@freescale.com>, <b07421@freescale.com>,
 <linux-kernel@vger.kernel.org>, Tang Yuantian <Yuantian.Tang@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 6 Aug 2015 00:46:25 -0500
In-Reply-To: <1438834837.23384.0@remotesmtp.freescale.net>
References: <1438334444-31919-1-git-send-email-b29983@freescale.com>
 <1438387178.19345.77.camel@freescale.com>
 <1438601578.7515.2@remotesmtp.freescale.net>
 <1438633568.2097.35.camel@freescale.com>
 <1438769477.21522.0@remotesmtp.freescale.net>
 <1438829848.2097.129.camel@freescale.com>
 <1438834837.23384.0@remotesmtp.freescale.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-08-06 at 12:20 +0800, Chenhui Zhao wrote:
> On Thu, Aug 6, 2015 at 10:57 AM, Scott Wood <scottwood@freescale.com> 
> wrote:
> > On Wed, 2015-08-05 at 18:11 +0800, Chenhui Zhao wrote:
> > >  On Tue, Aug 4, 2015 at 4:26 AM, Scott Wood <scottwood@freescale.com>
> > >  wrote:
> > >  > On Mon, 2015-08-03 at 19:32 +0800, Chenhui Zhao wrote:
> > >  > >  >
> > >  >
> > >  > >  On Sat, Aug 1, 2015 at 7:59 AM, Scott Wood 
> > > <scottwood@freescale.com>
> > >  > >  wrote:
> > >  >
> > >  > >  >
> > >  > >  > Could you explain irq_mask()?  Why would there still be IRQs
> > >  > > destined
> > >  > >  > for
> > >  > >  > this CPU at this point?
> > >  > >
> > >  > >  This function just masks irq by setting the registers in RCPM 
> > > (for
> > >  > >  example, RCPM_CPMIMR, RCPM_CPMCIMR). Actually, all irqs to 
> > > this CPU
> > >  > >  have been migrated to other CPUs.
> > >  >
> > >  > So why do we need to set those bits in RCPM?  Is it just caution?
> > > 
> > >  Setting these bits can mask interrupts signalled to RCPM from MPIC 
> > > as a
> > >  means of
> > >  waking up from a lower power state. So, cores will not be waked up
> > >  unexpectedly.
> > 
> > Why would the MPIC be signalling those interrupts if they've been 
> > masked at
> > the MPIC?
> > 
> > -Scott
> > 
> 
> The interrupts to RCPM from MPIC are IRQ, Machine Check, NMI and 
> Critical interrupts. Some of them didn't be masked in MPIC.

What interrupt could actually happen to a sleeping cpu that this protects 
against?

-Scott
