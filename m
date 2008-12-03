Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CCE0CDDDE6
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 15:16:31 +1100 (EST)
Date: Tue, 2 Dec 2008 20:14:45 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: __cpu_up vs. start_secondary race?
In-Reply-To: <20081203021624.GE6829@localdomain>
Message-ID: <Pine.LNX.4.64.0812022009220.10176@t2.domain.actdsltmp>
References: <20081201213016.GC6829@localdomain>
	<1228169318.7356.146.camel@pasglop>
	<20081203021624.GE6829@localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2 Dec 2008, Nathan Lynch wrote:
> Apart from barriers (or lack thereof), the fact that __cpu_up gives up
> after a more-or-less arbitrary period seems... well, arbitrary.  If we
> get to "Processor X is stuck" then something is seriously wrong:
> there's either a kernel bug or a platform issue, and the CPU just
> kicked is in an unknown state.  Polling indefinitely seems safer, no?

I recently fixed a bug that did this.  There was a bug in how the secondary
CPU's memory was mapped (in some non-mailine code, not fixed).  It was nice
to get the warning and have the kernel not hang.  On embedded systems with
only network access and no persistent storage for system logs, a kernel
hang is a lot more a pain.
