Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2462DDDF4
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 17:31:22 +1000 (EST)
Subject: Re: [PATCH] fixes for the SLB shadow buffer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <24613.1186034191@neuling.org>
References: <17055.1185944172@neuling.org>
	<18096.6654.934841.561238@cargo.ozlabs.ibm.com>
	<31580.1185948147@neuling.org>
	<1186004885.22717.50.camel@farscape.rchland.ibm.com>
	<24613.1186034191@neuling.org>
Content-Type: text/plain
Date: Thu, 02 Aug 2007 17:31:10 +1000
Message-Id: <1186039870.5495.595.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, will_schmidt@vnet.ibm.com,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-08-02 at 15:56 +1000, Michael Neuling wrote:
> 
> But even in the case of a checkpoint restart, the ordering will be
> preserved as the NIA we get as part of the checkpoint will have all
> previous instructions complete and none of the following instructions
> started.

Instruction completion isn't enough to ensure storage ordering. The
stores may well be complete but the data still in separate store queues.

> So I guess the questions is, does PHYP even need to access the shadow
> buffer of another CPU, while that other CPU is in flight.  I'm not
> sure
> that they can as they can't read the entire buffer atomically if the
> target CPU is still active.  So PHYP must stop instructions on the
> target CPU, before it reads it's shadow buffer.  Hence no ordering
> problems.
> 
> I should probably talk to some PHYP guys to confirm, but i think we
> can
> remove all the barriers when writing to the shadow buffer

Bah, just keep then in, eieio's won't hurt much and it doesn't look like
a critically hot code path.

Ben.
