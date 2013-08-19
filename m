Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 88AB42C007B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 04:17:34 +1000 (EST)
Message-ID: <1376936241.31636.352.camel@snotra.buserror.net>
Subject: Re: [RFC PATCH V3 3/5] powerpc/cpuidle: Generic powerpc backend
 cpuidle driver.
From: Scott Wood <scottwood@freescale.com>
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Mon, 19 Aug 2013 13:17:21 -0500
In-Reply-To: <5211F0E0.7080507@linux.vnet.ibm.com>
References: <20130819042736.8609.17890.stgit@deepthi.in.ibm.com>
 <20130819042818.8609.77060.stgit@deepthi.in.ibm.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259010226D5@039-SN2MPN1-021.039d.mgd.msft.net>
 <5211F0E0.7080507@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 Wang Dongsheng-B40534 <B40534@freescale.com>,
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

On Mon, 2013-08-19 at 15:48 +0530, Deepthi Dharwar wrote:
> Hi Dongsheng,
> 
> On 08/19/2013 11:22 AM, Wang Dongsheng-B40534 wrote:
> > I think we should move the states and handle function to arch/power/platform*
> > The states and handle function is belong to backend driver, not for this, different platform have different state.
> > Different platforms to make their own deal with these states.
> > 
> > I think we cannot put all the status of different platforms and handler in this driver.
> 
> The idea here is a single powerpc back-end driver, which does a runtime
> detection of the platform it is running and choose the right
> idle states table. This was one of outcome of V2 discussion.

I see a lot more in there than just detecting a platform and choosing a
driver.

> I feel there is no harm in keeping the state information in the same
> file. We do have x86, which has all its variants information in one
> file. One place will have all the idle consolidated information of
> all the platform variants. If community does feel, we need to
> have just the states information in arch specific file, we can do so.

What actual functionality is common to all powerpc but not common to
other arches?

> >> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> >> index 0e2cd5c..99ee5d4 100644
> >> --- a/drivers/cpuidle/Kconfig
> >> +++ b/drivers/cpuidle/Kconfig
> >> @@ -42,6 +42,13 @@ config CPU_IDLE_ZYNQ
> >>  	help
> >>  	  Select this to enable cpuidle on Xilinx Zynq processors.
> >>
> >> +config CPU_IDLE_POWERPC
> >> +	bool "CPU Idle driver for POWERPC platforms"
> >> +	depends on PPC64
> > 
> > Why not PPC?
> 
> PPC64 seems to a good place to began the consolidation work. This
> patch-set has not been tested for PPC32 currently.

PPC64 is a bad place to start if you want it to be generic, because it
means you'll end up growing dependencies on other things that are PPC64
only.  There are too many arbitrary 32/64 differences as is.

-Scott
