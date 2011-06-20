Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1EC2CB6F83
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2011 03:19:44 +1000 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5KGtXZT013195
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Jun 2011 12:55:33 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5KHJfIW144818
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Jun 2011 13:19:41 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p5KDJSZP023861
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Jun 2011 10:19:29 -0300
Message-ID: <4DFF80FD.8080600@linux.vnet.ibm.com>
Date: Mon, 20 Jun 2011 22:48:53 +0530
From: deepthi <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] perf_events: Enable idle state tracing for pseries (ppc64)
References: <20110601123554.GA12492@deepthi.in.ibm.com>
	<1308284659.32158.4.camel@pasglop>
In-Reply-To: <1308284659.32158.4.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
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

On Friday 17 June 2011 09:54 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2011-06-01 at 18:05 +0530, Deepthi Dharwar wrote:
>> Hi,
>>
>> Please find below a patch, which has perf_events added for pseries (ppc64)
>> platform in order to emit the trace required for perf timechart. 
>> It essentially enables perf timechart for pseries platfrom to analyse
>> power savings events like cpuidle states.
> 
> Unless I'm mistaken, you added traces to dedicated CPU idle sleep but
> not shared processor. Any reason ?
> 
Yes, the traces were added only to dedicated CPU idle sleep and not for 
shared processor. This was added only for RFC purpose, and looking for 
comments from trace implementation point of view. This can be
easily extended to the latter too.

> Also I don't really know that tracing stuff but what's the point of
> having start/end _and trace_cpu_idle if you're going to always start &
> end around a single occurence of trace_cpu_idle ?
> 
power_start/end are the APIs that were used initially
and they are going to be deprecated in the upcoming kernel releases.
trace_cpu_idle call is going to replace power start/end routines. 
To maintain backward compatibility and uniformity, both the routines 
have been used.
(ref:https://lkml.org/lkml/2010/11/14/60)

> Wouldn't there be a way to start/end and then trace the snooze and
> subsequent cede within the same start/end section or that makes no
> sense ?
> 
We wanted to find the residency time of both Snooze as well as cede 
separately. Knowing this will help us tweak our cpuidle code. So, both 
have been captured separately.

> Also would there be any interest in doing the tracing more generically
> in idle.c ?
> 
Yes, this tracing is already implemented for Intel platform. This would
be a part of cpuidle framework. Going further, once the power cpuidle 
framework is ported and ready, we will extend this trace there as well.
(ref:https://lkml.org/lkml/2011/6/7/375)

> Cheers,
> Ben.
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

Regards,
Deepthi
