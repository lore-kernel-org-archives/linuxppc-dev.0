Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8E65A1A05F9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 05:11:00 +1000 (AEST)
Date: Thu, 17 Sep 2015 10:38:10 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Scott Wood <scottwood@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [BUG] Revert 0b05e2d671c4 'powerpc/32: cacheable_memcpy becomes
 memcpy'
Message-ID: <20150917153806.GC2613@gate.crashing.org>
References: <alpine.DEB.2.11.1509161816310.3951@nanos>
 <1442420984.2909.179.camel@freescale.com>
 <alpine.DEB.2.11.1509162159110.3951@nanos>
 <20150916215435.48bee4d3@grimm.local.home>
 <alpine.DEB.2.11.1509170911120.3951@nanos>
 <20150917092931.56475b7d@gandalf.local.home>
 <alpine.DEB.2.11.1509171630130.3951@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.11.1509171630130.3951@nanos>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 17, 2015 at 04:38:52PM +0200, Thomas Gleixner wrote:
> [    2.398263] Instruction dump:
> [    2.401297] 01000000 00037000 00000000 00000000 f0000000 00000001 0a641e09 acde4823 
> [    2.409237] 000f0000 179a7b00 07de2900 03ef1480 <01f78a40> 0001c200 60000000 9421fff0 

Those are not instructions (until the nop).

Starting three back from the failing instruction, those are

	396000000 132000000 66000000 <33000000> 115200

so something has been scribbling what looks like clock frequencies
over your code.  Judging from the register contents this has happened
some time before.

Some device trees have similar numbers, e.g. media5200.dts does.


Segher
