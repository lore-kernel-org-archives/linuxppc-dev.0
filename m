Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [209.128.68.125])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8471868164
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Sep 2005 07:00:39 +1000 (EST)
Date: Wed, 14 Sep 2005 17:55:22 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Message-ID: <20050914205521.GA9808@dmt.cnet>
References: <4326968F.5030609@2net.co.uk>
	<20050913122541.GB9076@cathedrallabs.org>
	<20050913151132.GF10602@dmt.cnet>
	<20050913172213.GA3964@oops.ghostprotocols.net>
	<20050913180440.GC14889@dmt.cnet>
	<20050914154218.GA4335@oops.ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050914154218.GA4335@oops.ghostprotocols.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: gdb hangs on Linux 2.6.11 on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Sep 14, 2005 at 12:42:18PM -0300, Aristeu Sergio Rozanski Filho wrote:
> Hi Marcelo,
> 
> > flash_test is trying to handle a signal, can you print some information
> > about it in get_signal_to_deliver (before ptrace_stop), such as si_signo:
> > 
> > typedef struct siginfo {
> >         int si_signo;
> >         int si_errno;
> >         int si_code;
> > 
> > ptrace_stop() calls do_notify_parent_cldstop() to wakeup gdb, maybe
> > there's something wrong during wakeup?
> > 
> > The box locks up completly or its just gdb that freezes?
> seems it's more simple than I thought: seems to be a problem with serial
> console as I'm able to use gdb using ssh
> Is serial console (using ttyCPM) supposed to work with gdb?

Using a different device than the one used by the serial console? Yes, 
think so..
