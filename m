Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75A8FDDE01
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 08:06:16 +1000 (EST)
Subject: Re: [PATCH][RT][PPC64] Fix preempt unsafe paths accessing per_cpu
	variables
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chirag Jog <chirag@linux.vnet.ibm.com>
In-Reply-To: <20080718101133.GO20277@linux.vnet.ibm.com>
References: <20080709160543.GG7101@linux.vnet.ibm.com>
	<1216085521.7740.37.camel@pasglop>
	<20080717125645.GN20277@linux.vnet.ibm.com>
	<1216325671.7740.359.camel@pasglop>
	<20080718101133.GO20277@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Date: Sat, 19 Jul 2008 08:05:30 +1000
Message-Id: <1216418730.7740.451.camel@pasglop>
Mime-Version: 1.0
Cc: linux-rt-users@vger.kernel.org, Josh Triplett <josht@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Nivedita Singhvi <niv@us.ibm.com>,
	"Timothy R. Chavez" <tim.chavez@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
	linux.kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> With the original patch, the pending batch does get flushed 
> in a non-preemptable region. 
> I am resending the original with just adding the necesary comments.

Your comment isn't what I meant. What I meant is that if the process
is context switched while walking the page tables, the low level powerpc
context switch code should also perform a ﻿__flush_tlb_pending.

BTW. Is the pte_lock also not a real spinlock anymore ? That may break
other assumptions the powerpc mm code is doing.

This -rt stuff is just too scary, it changes some fundamental semantics
of the spinlocks. yuck.

Ben.
