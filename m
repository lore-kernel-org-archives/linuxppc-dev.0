Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 579AB2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 07:25:02 +1000 (EST)
Message-ID: <1377206679.20722.10.camel@snotra.buserror.net>
Subject: Re: [RFC PATCH V3 3/5] powerpc/cpuidle: Generic powerpc backend
 cpuidle driver.
From: Scott Wood <scottwood@freescale.com>
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Thu, 22 Aug 2013 16:24:39 -0500
In-Reply-To: <5215A69F.4090904@linux.vnet.ibm.com>
References: <20130819042736.8609.17890.stgit@deepthi.in.ibm.com>
 <20130819042818.8609.77060.stgit@deepthi.in.ibm.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259010226D5@039-SN2MPN1-021.039d.mgd.msft.net>
 <5211F0E0.7080507@linux.vnet.ibm.com>
 <1376936241.31636.352.camel@snotra.buserror.net>
 <521447E7.5000302@linux.vnet.ibm.com>
 <1377115703.5029.14.camel@snotra.buserror.net>
 <5215A69F.4090904@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Wang Dongsheng-B40534 <B40534@freescale.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>,
 "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-08-22 at 11:20 +0530, Deepthi Dharwar wrote:
> On 08/22/2013 01:38 AM, Scott Wood wrote:
> > On Wed, 2013-08-21 at 10:23 +0530, Deepthi Dharwar wrote:
> >> On 08/19/2013 11:47 PM, Scott Wood wrote:
> >>> What actual functionality is common to all powerpc but not common to
> >>> other arches?
> > 
> 
> The functionality here is idle states on powerpc  like the snooze loop
> that is common.
> Also, the basic registration of the driver, hotplug notifier etc for
> powerpc.

The snooze loop uses things like SPRN_PURR, get_lppaca(), and CTRL which
aren't common to all PPC (they might be common to all book3s64).  I also
don't see any hook for the low power mode entry -- is "snooze" just a
busy loop plus the de-emphasis stuff like HMT and CTRL[RUN]?  I'm not
familiar with the term "snooze" in this context.  I don't think we'd use
anything like that on our chips; we'd always at least "wait" or "doze"
depending on the chip.

It's not clear what is powerpc-specific about the notifier -- perhaps it
should go in drivers/cpuidle/.

> > The way forward is to give this file a more appropriate name based on
> > the hardware that it actually targets -- and to refactor it so that the
> > answer to that question is not complicated.
> 
> Sure, thanks.
> Our idea was to have POWER archs idle states merged at the first go.
> Only that is what is enabled in the current version (V4 posted out)
> ( Code is enabled for PSERIES and POWERNV only)
> If needed, other POWERPC archs might benefit by extending the same
> driver, that is why it is named cpuidle-powerpc.c
> 
> But if having cpuidle backend-driver separately for other powerpc arcs
> makes sense such that each one have their own state information etc
> then it makes sense to name the files as cpuidle-power.c,
> cpuilde-ppc32.c and so on.

Thanks.

-Scott
