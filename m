Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7A72EB6F87
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2011 14:24:39 +1000 (EST)
Subject: Re: [PATCH] perf_events: Enable idle state tracing for pseries (ppc64)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: deepthi@linux.vnet.ibm.com
In-Reply-To: <20110601123554.GA12492@deepthi.in.ibm.com>
References: <20110601123554.GA12492@deepthi.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Jun 2011 14:24:19 +1000
Message-ID: <1308284659.32158.4.camel@pasglop>
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

On Wed, 2011-06-01 at 18:05 +0530, Deepthi Dharwar wrote:
> Hi,
> 
> Please find below a patch, which has perf_events added for pseries (ppc64)
> platform in order to emit the trace required for perf timechart. 
> It essentially enables perf timechart for pseries platfrom to analyse
> power savings events like cpuidle states.

Unless I'm mistaken, you added traces to dedicated CPU idle sleep but
not shared processor. Any reason ?

Also I don't really know that tracing stuff but what's the point of
having start/end _and trace_cpu_idle if you're going to always start &
end around a single occurence of trace_cpu_idle ?

Wouldn't there be a way to start/end and then trace the snooze and
subsequent cede within the same start/end section or that makes no
sense ?

Also would there be any interest in doing the tracing more generically
in idle.c ?

Cheers,
Ben.
