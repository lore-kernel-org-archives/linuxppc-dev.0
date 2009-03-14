Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CF485DE0F9
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Mar 2009 00:54:23 +1100 (EST)
In-Reply-To: <1236997906.3346.8.camel@localhost.localdomain>
References: <1236975831.3137.61.camel@localhost.localdomain>
	<6F79BA93-346D-479F-BD63-D1D89B289D6F@kernel.crashing.org>
	<1236984351.25062.71.camel@pasglop>
	<1236997906.3346.8.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2204A047-8251-4280-8E8A-9707F882C9C5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] Moving toward smarter disabling of FPRs, VRs,
	and VSRs in the MSR
Date: Sat, 14 Mar 2009 14:55:07 +0100
To: rsa@us.ibm.com
Cc: Will Schmidt <will_schmidt@vnet.ibm.com>,
	Steven Munroe <sjmunroe@us.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> It's very likely that a process which results in the
> enabling of FP,VMX, or VSX may continue to use the facility for the
> duration of it's lifetime.  Threads would be even more likely to  
> exhibit
> this behavior.
>
> The case where this might not be true is if we use VMX or VSX for  
> string
> routine optimization in GLIBC.  This will require metrics to prove  
> it's
> utility of course.

OTOH, the main cost of using VMX etc. is exactly this register save/ 
restore,
and it's a win otherwise pretty much always.  I.e., as soon as you take
that initial hit, almost anything can get a speedup from VMX.  So  
even if
you do not see an overall speedup from, say, only some optimised string
routines, it probably is worth it anyway as it pays the initial cost for
enabling more optimisations later.


Segher
