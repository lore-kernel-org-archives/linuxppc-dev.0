Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A24C81007D7
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 08:27:42 +1000 (EST)
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Darren Hart <dvhltc@us.ibm.com>
In-Reply-To: <4C488CCD.60004@us.ibm.com>
References: <4C488CCD.60004@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 23 Jul 2010 08:25:09 +1000
Message-ID: <1279837509.1970.24.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Gautham R Shenoy <ego@in.ibm.com>,
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

On Thu, 2010-07-22 at 11:24 -0700, Darren Hart wrote:
> 
> 1) How can the preempt_count() get mangled across the H_CEDE hcall?
> 2) Should we call preempt_enable() in cpu_idle() prior to cpu_die() ?

The preempt count is on the thread info at the bottom of the stack.

Can you check the stack pointers ?

Cheers,
Ben.
