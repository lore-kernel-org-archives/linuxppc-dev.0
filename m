Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 64ACF1007D4
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 15:13:31 +1000 (EST)
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: svaidy@linux.vnet.ibm.com
In-Reply-To: <20100723050814.GA26162@dirshya.in.ibm.com>
References: <4C488CCD.60004@us.ibm.com> <1279837509.1970.24.camel@pasglop>
	<4C48DADE.1050409@us.ibm.com> <4C491E14.9010100@us.ibm.com>
	<20100723050814.GA26162@dirshya.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 23 Jul 2010 15:11:00 +1000
Message-ID: <1279861860.1970.74.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Darren Hart <dvhltc@us.ibm.com>,
	Gautham R Shenoy <ego@in.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Will Schmidt <willschm@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-07-23 at 10:38 +0530, Vaidyanathan Srinivasan wrote:
> Yes.  extended_cede_processor() will return with interrupts enabled in
> the cpu. (This is done by the hypervisor).  Under normal cases we
> cannot be interrupted because no IO interrupts are routed to us after
> xics_teardown_cpu() and since the CPU is out of the map, nobody will
> send us IPIs.

What about decrementer ?

> Though H_CEDE will return with interrupts enabled, it is unlikely that
> an interrupt can be delivered in this context. 

Well, if interrupts are soft-disabled, even if one occurs, we will just
mask and return, so that at least should be ok.

Cheers,
Ben.
