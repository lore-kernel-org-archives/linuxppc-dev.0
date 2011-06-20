Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 28C87B6F81
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2011 07:43:05 +1000 (EST)
Subject: Re: [PATCH] perf_events: Enable idle state tracing for pseries (ppc64)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: deepthi <deepthi@linux.vnet.ibm.com>
In-Reply-To: <4DFF80FD.8080600@linux.vnet.ibm.com>
References: <20110601123554.GA12492@deepthi.in.ibm.com>
	<1308284659.32158.4.camel@pasglop>
	<4DFF80FD.8080600@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 21 Jun 2011 07:42:13 +1000
Message-ID: <1308606133.32158.143.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-06-20 at 22:48 +0530, deepthi wrote:
> On Friday 17 June 2011 09:54 AM, Benjamin Herrenschmidt wrote:
> > On Wed, 2011-06-01 at 18:05 +0530, Deepthi Dharwar wrote:
> >> Hi,
> >>
> >> Please find below a patch, which has perf_events added for pseries (ppc64)
> >> platform in order to emit the trace required for perf timechart. 
> >> It essentially enables perf timechart for pseries platfrom to analyse
> >> power savings events like cpuidle states.
> > 
> > Unless I'm mistaken, you added traces to dedicated CPU idle sleep but
> > not shared processor. Any reason ?
> > 
> Yes, the traces were added only to dedicated CPU idle sleep and not for 
> shared processor. This was added only for RFC purpose, and looking for 
> comments from trace implementation point of view. This can be
> easily extended to the latter too.

Please do both.

> > Also I don't really know that tracing stuff but what's the point of
> > having start/end _and trace_cpu_idle if you're going to always start &
> > end around a single occurence of trace_cpu_idle ?
> > 
> power_start/end are the APIs that were used initially
> and they are going to be deprecated in the upcoming kernel releases.
> trace_cpu_idle call is going to replace power start/end routines. 
> To maintain backward compatibility and uniformity, both the routines 
> have been used.
> (ref:https://lkml.org/lkml/2010/11/14/60ref:https://lkml.org/lkml/2010/11/14/60)

Backward compatible with what ? Userspace ? Do we care in that specific
case since it's a new feature ?

> > Wouldn't there be a way to start/end and then trace the snooze and
> > subsequent cede within the same start/end section or that makes no
> > sense ?
> > 
> We wanted to find the residency time of both Snooze as well as cede 
> separately. Knowing this will help us tweak our cpuidle code. So, both 
> have been captured separately.
> 
> > Also would there be any interest in doing the tracing more generically
> > in idle.c ?
> > 
> Yes, this tracing is already implemented for Intel platform. This would
> be a part of cpuidle framework. Going further, once the power cpuidle 
> framework is ported and ready, we will extend this trace there as well.
> (ref:https://lkml.org/lkml/2011/6/7/375)

So do we need to apply this patch at all since the cpuidle stuff is
happening too ?

Cheers,
Ben.
