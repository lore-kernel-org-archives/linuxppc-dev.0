Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 39F39DE145
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 14:22:25 +1100 (EST)
Subject: Re: [RFC] Moving toward smarter disabling of FPRs, VRs, and VSRs
	in the MSR
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: rsa@us.ibm.com
In-Reply-To: <1236997906.3346.8.camel@localhost.localdomain>
References: <1236975831.3137.61.camel@localhost.localdomain>
	<6F79BA93-346D-479F-BD63-D1D89B289D6F@kernel.crashing.org>
	<1236984351.25062.71.camel@pasglop>
	<1236997906.3346.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 14 Mar 2009 14:22:18 +1100
Message-Id: <1237000938.25062.74.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Will Schmidt <will_schmidt@vnet.ibm.com>,
	Steven Munroe <sjmunroe@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Both of these thoughts came to mind.  I don't have a particular
> preference.  It's very likely that a process which results in the
> enabling of FP,VMX, or VSX may continue to use the facility for the
> duration of it's lifetime.  Threads would be even more likely to exhibit
> this behavior.
> 
> The case where this might not be true is if we use VMX or VSX for string
> routine optimization in GLIBC.  This will require metrics to prove it's
> utility of course.  Perhaps what I can do in the string routines is
> check if the bits are already set and use the facility if it is already
> enabled and the usage scenario warrants it, i.e. if the size and
> alignment of the data are in a sweet spot as indicated by profiling
> data.

Or we just add some instrumentation to today kernel to see how often
those gets enabled and then not-re-enabled on the next time slice and do
some stats with common workloads.

Ben.
