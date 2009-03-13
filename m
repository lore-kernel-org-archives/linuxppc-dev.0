Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 56026DE0B7
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 09:45:58 +1100 (EST)
Subject: Re: [RFC] Moving toward smarter disabling of FPRs, VRs, and VSRs
	in the MSR
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <6F79BA93-346D-479F-BD63-D1D89B289D6F@kernel.crashing.org>
References: <1236975831.3137.61.camel@localhost.localdomain>
	<6F79BA93-346D-479F-BD63-D1D89B289D6F@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 14 Mar 2009 09:45:51 +1100
Message-Id: <1236984351.25062.71.camel@pasglop>
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


> If these applications are aware they are heavy users (of FP, VMX, VSX)  
> can we not use a sysctl()?  Doing so wouldn't be that difficult.
> 
> I think trying to do something based on a runtime heuristic sounds a  
> bit iffy.

Another option might be simply to say that if an app has used FP, VMX or
VSX -once-, then it's likely to do it again and just keep re-enabling
it :-)

I'm serious here, do we know that many cases where these things are used
seldomly once in a while ?

An if we do, maybe then a simple counter in the task struct... if the
app re-enables it more than a few consecutive switches, then make it
stick. I have the feeling that would work out reasonably well.

Cheers,
Ben.
