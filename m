Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 033481A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 18:01:17 +1000 (AEST)
Date: Wed, 23 Sep 2015 10:00:24 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Wang Dongsheng <Dongsheng.Wang@freescale.com>
cc: Scott Wood <scottwood@freescale.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Hongtao Jia <hongtao.jia@freescale.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 04/17] powerpc: mpic: use IRQCHIP_SKIP_SET_WAKE instead
 of redundant mpic_irq_set_wake
In-Reply-To: <SN1PR0301MB1616CF7415825908030E0C829D440@SN1PR0301MB1616.namprd03.prod.outlook.com>
Message-ID: <alpine.DEB.2.11.1509230958300.4371@nanos>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-5-git-send-email-sudeep.holla@arm.com>
 <1442965805.19102.303.camel@freescale.com>
 <SN1PR0301MB1616AD6C1C410ACB49A5D9279D440@SN1PR0301MB1616.namprd03.prod.outlook.com>
 <alpine.DEB.2.11.1509230545580.5606@nanos>
 <SN1PR0301MB1616CF7415825908030E0C829D440@SN1PR0301MB1616.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 23 Sep 2015, Wang Dongsheng wrote:
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> > owner@vger.kernel.org] On Behalf Of Thomas Gleixner
> > Sent: Wednesday, September 23, 2015 11:49 AM
> > To: Wang Dongsheng-B40534
> > Cc: Wood Scott-B07421; Sudeep Holla; linux-pm@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Rafael J. Wysocki; Benjamin Herrenschmidt; Paul
> > Mackerras; Michael Ellerman; Jia Hongtao-B38951; Marc Zyngier; linuxppc-
> > dev@lists.ozlabs.org
> > Subject: RE: [PATCH 04/17] powerpc: mpic: use IRQCHIP_SKIP_SET_WAKE instead of
> > redundant mpic_irq_set_wake

Can you please fix you mail client to get rid of that silly copy of
the mail header?

> > On Wed, 23 Sep 2015, Wang Dongsheng wrote:
> > > > On Mon, 2015-09-21 at 16:47 +0100, Sudeep Holla wrote:
> > > > > mpic_irq_set_wake return -ENXIO for non FSL MPIC and sets IRQF_NO_SUSPEND
> > > > > flag for FSL ones. enable_irq_wake already returns -ENXIO if irq_set_wak
> > > > > is not implemented. Also there's no need to set the IRQF_NO_SUSPEND flag
> > > > > as it doesn't guarantee wakeup for that interrupt.
> > > > >
> > >
> > > Non-freescale return -ENXIO, is there any issue? If non-freescale
> > > platform does not support it, but IPs still use
> > > enable/disable_irq_wake, we should return a error number.
> > 
> > You can just set IRQCHIP_SKIP_SET_WAKE for FSL chips and not for the
> > others.
> > 
> > > @Scott:
> > > If set this flag we cannot keep a irq as a wakeup source when system going to
> > > SUSPEND or MEM.
> > >
> > > irq_set_wake() means we can set this irq as a wake source.
> > > IRQCHIP_SKIP_SET_WAKE is ignore irq_set_wake() feature.
> > 
> > Nonsense. IRQCHIP_SKIP_SET_WAKE merily tells the core not to bail on
> > !chip->irq_set_wake(), but its still marking the interrupt as wakeup
> > source and therefor not masking it on suspend.
> > 
> 
> Sorry, I just check irq_set_irq_wake() code, right, IRQCHIP_SKIP_SET_WAKE also can
> going to irqd_set to mask IRQD_WAKEUP_STATE.
> 
> Yes, this flag just skip the irq_set_wake() not this feature.

And just for completeness. That commit 5ff04b7287d87c 'powerpc/mpic:
add irq_set_wake support' is another example of trainwreck engineering.

    desc->action->flags |= IRQF_NO_SUSPEND;

This is not only horribly avoiding any of the existing APIs, it's also
broken as hell. desc->action can be NULL when that is called.

It seems fleascale is hell bent to fiddle with the guts of the core
code mindlessly. See commit c866cda47f2c

Yours grumpy

      tglx
