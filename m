Return-Path: <rsa@us.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3994BDE189
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 13:32:00 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n2E2TqtB032224
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 20:29:52 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2E2VudK097828
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 20:31:56 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n2E2VuvC000556
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 20:31:56 -0600
Subject: Re: [RFC] Moving toward smarter disabling of FPRs, VRs, and VSRs
	in the MSR
From: Ryan Arnold <rsa@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1236984351.25062.71.camel@pasglop>
References: <1236975831.3137.61.camel@localhost.localdomain>
	<6F79BA93-346D-479F-BD63-D1D89B289D6F@kernel.crashing.org>
	<1236984351.25062.71.camel@pasglop>
Content-Type: text/plain
Date: Fri, 13 Mar 2009 21:31:46 -0500
Message-Id: <1236997906.3346.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Will Schmidt <will_schmidt@vnet.ibm.com>,
	Steven Munroe <sjmunroe@us.ibm.com>
Reply-To: rsa@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2009-03-14 at 09:45 +1100, Benjamin Herrenschmidt wrote:
> > If these applications are aware they are heavy users (of FP, VMX, VSX)  
> > can we not use a sysctl()?  Doing so wouldn't be that difficult.
> > 
> > I think trying to do something based on a runtime heuristic sounds a  
> > bit iffy.
> 
> Another option might be simply to say that if an app has used FP, VMX or
> VSX -once-, then it's likely to do it again and just keep re-enabling
> it :-)
> 
> I'm serious here, do we know that many cases where these things are used
> seldomly once in a while ?
> 
> An if we do, maybe then a simple counter in the task struct... if the
> app re-enables it more than a few consecutive switches, then make it
> stick. I have the feeling that would work out reasonably well.

Both of these thoughts came to mind.  I don't have a particular
preference.  It's very likely that a process which results in the
enabling of FP,VMX, or VSX may continue to use the facility for the
duration of it's lifetime.  Threads would be even more likely to exhibit
this behavior.

The case where this might not be true is if we use VMX or VSX for string
routine optimization in GLIBC.  This will require metrics to prove it's
utility of course.  Perhaps what I can do in the string routines is
check if the bits are already set and use the facility if it is already
enabled and the usage scenario warrants it, i.e. if the size and
alignment of the data are in a sweet spot as indicated by profiling
data.

Regards,
Ryan
