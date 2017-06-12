Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmbMS2gq0zDqM2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 00:47:00 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id v14so14482769pgn.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 07:47:00 -0700 (PDT)
Date: Tue, 13 Jun 2017 00:46:45 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 03/14] powerpc/64s: idle provide a default idle for POWER9
Message-ID: <20170613004645.097e17a8@roar.ozlabs.ibm.com>
In-Reply-To: <20170612085316.GB10921@in.ibm.com>
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-4-npiggin@gmail.com>
 <20170612085316.GB10921@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 12 Jun 2017 14:23:16 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> Hi Nick,
> 
> On Mon, Jun 12, 2017 at 09:58:24AM +1000, Nicholas Piggin wrote:
> > Before the cpuidle driver is enabled, provide a default idle
> > function similarly to POWER7/8.
> > 
> > This should not have much effect, because the cpuidle driver
> > for powernv is mandatory, but if that changes we should have
> > a fallback.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/platforms/powernv/idle.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> > index f188d84d9c59..e327e1585ddc 100644
> > --- a/arch/powerpc/platforms/powernv/idle.c
> > +++ b/arch/powerpc/platforms/powernv/idle.c
> > @@ -677,6 +677,8 @@ static int __init pnv_init_idle_states(void)
> > 
> >  	if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
> >  		ppc_md.power_save = power7_idle;
> > +	else if (supported_cpuidle_states & OPAL_PM_STOP_INST_FAST)
> > +		ppc_md.power_save = power9_idle;  
> 
> We are already initializing this in pnv_power9_idle_init() depending
> on whether the device tree has exposed at least one INST_FAST idle
> state. Else this should be NULL, because the firmware doesn't want us
> to use a platform idle state!

Ah I missed that, thanks. Will drop this one.

Thanks,
Nick
