Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 09E4CB7D64
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Apr 2010 18:04:10 +1000 (EST)
Subject: Re: [Patch 1/1] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: prasad@linux.vnet.ibm.com
In-Reply-To: <20100315062909.GA19279@in.ibm.com>
References: <20100308181232.GA3406@in.ibm.com>
	<20100308181448.GA5538@in.ibm.com> <1268374776.2209.74.camel@pasglop>
	<20100315062909.GA19279@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Apr 2010 18:03:31 +1000
Message-ID: <1270627411.2300.71.camel@pasglop>
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Alan Stern <stern@rowland.harvard.edu>,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ok so too many problems with your last patch, I didn't have time to fix
them all, so it's not going into -next this week.

Please, test with a variety of defconfigs (iseries, cell, g5 for
example), and especially with CONFIG_PERF_EVENTS not set. There are
issues in the generic header for that (though I'm told some people are
working on a fix).

Basically, we need something like CONFIG_HW_BREAKPOINTS that is set
(maybe optionally, maybe not) with CONFIG_PERF_EVENTS and
CONFIG_HAVE_HW_BREAKPOINT. Then you can use that to properly fix the
ifdef'ing in include/linux/hw_breakpoints.h, and fix the various other
cases in powerpc code where you are testing for the wrong thing.

Cheers,
Ben.
