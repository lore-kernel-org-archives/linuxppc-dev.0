Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 24812B6F84
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 02:30:49 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5LGIsr5019904
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2011 12:18:54 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5LGUXct602192
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2011 12:30:33 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p5LATgce003060
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2011 04:29:44 -0600
Message-ID: <4E00C6DE.1030001@linux.vnet.ibm.com>
Date: Tue, 21 Jun 2011 21:59:18 +0530
From: deepthi <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] perf_events: Enable idle state tracing for pseries (ppc64)
References: <20110601123554.GA12492@deepthi.in.ibm.com>
	<1308284659.32158.4.camel@pasglop>	<4DFF80FD.8080600@linux.vnet.ibm.com>
	<1308606133.32158.143.camel@pasglop>
In-Reply-To: <1308606133.32158.143.camel@pasglop>
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

On Tuesday 21 June 2011 03:12 AM, Benjamin Herrenschmidt wrote:
> On Mon, 2011-06-20 at 22:48 +0530, deepthi wrote:
>> On Friday 17 June 2011 09:54 AM, Benjamin Herrenschmidt wrote:
>>> On Wed, 2011-06-01 at 18:05 +0530, Deepthi Dharwar wrote:
>>>> Hi,
>>>>
>>>> Please find below a patch, which has perf_events added for pseries (ppc64)
>>>> platform in order to emit the trace required for perf timechart. 
>>>> It essentially enables perf timechart for pseries platfrom to analyse
>>>> power savings events like cpuidle states.
>>>
>>> Unless I'm mistaken, you added traces to dedicated CPU idle sleep but
>>> not shared processor. Any reason ?
>>>
>> Yes, the traces were added only to dedicated CPU idle sleep and not for 
>> shared processor. This was added only for RFC purpose, and looking for 
>> comments from trace implementation point of view. This can be
>> easily extended to the latter too.
> 
> Please do both.
> 
Yes, I ll do so.

>>> Also I don't really know that tracing stuff but what's the point of
>>> having start/end _and trace_cpu_idle if you're going to always start &
>>> end around a single occurence of trace_cpu_idle ?
>>>
>> power_start/end are the APIs that were used initially
>> and they are going to be deprecated in the upcoming kernel releases.
>> trace_cpu_idle call is going to replace power start/end routines. 
>> To maintain backward compatibility and uniformity, both the routines 
>> have been used.
>> (ref:https://lkml.org/lkml/2010/11/14/60ref:https://lkml.org/lkml/2010/11/14/60)
> 
> Backward compatible with what ? Userspace ? Do we care in that specific
> case since it's a new feature ?
> 
Going forward, we can just have trace_cpu_idle call and 
remove the power_start/end calls.

>>> Wouldn't there be a way to start/end and then trace the snooze and
>>> subsequent cede within the same start/end section or that makes no
>>> sense ?
>>>
>> We wanted to find the residency time of both Snooze as well as cede 
>> separately. Knowing this will help us tweak our cpuidle code. So, both 
>> have been captured separately.
>>
>>> Also would there be any interest in doing the tracing more generically
>>> in idle.c ?
>>>
>> Yes, this tracing is already implemented for Intel platform. This would
>> be a part of cpuidle framework. Going further, once the power cpuidle 
>> framework is ported and ready, we will extend this trace there as well.
>> (ref:https://lkml.org/lkml/2011/6/7/375)
> 
> So do we need to apply this patch at all since the cpuidle stuff is
> happening too ?
> 

Well, not really. This is more for RFC purpose. 
I just wanted to share this patch, as we are using it to evaluate
cpu idle on ppc64.

> Cheers,
> Ben.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
