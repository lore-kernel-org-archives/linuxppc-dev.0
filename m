Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 758D2DDE17
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 09:34:43 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8RNYcTa007005
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 19:34:38 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8RNYcE5420912
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 17:34:38 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8RNYb7o020024
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 17:34:38 -0600
Date: Thu, 27 Sep 2007 18:34:37 -0500
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 2/2]: PCI Error Recovery: Symbios SCSI First Failure
Message-ID: <20070927233437.GF18686@austin.ibm.com>
References: <20070420204114.GL31947@austin.ibm.com>
	<20070420204720.GM31947@austin.ibm.com>
	<20070926150216.GH3899@parisc-linux.org>
	<20070927220022.GC18686@austin.ibm.com>
	<20070927221031.GY3899@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070927221031.GY3899@parisc-linux.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 27, 2007 at 04:10:31PM -0600, Matthew Wilcox wrote:
> In the error handler, we wait_for_completion(io_reset_wait).
> In sym2_io_error_detected, we init_completion(io_reset_wait).
> Isn't it possible that we hit the error handler before we hit the
> io_error_detected path, and thus the completion wait is lost?
> Since the completion is already initialised in sym_attach(), I don't
> think we need to initialise it in sym2_io_error_detected().
> Makes sense to just delete it?

Good catch. But no ... and I had to study this a bit. Bear with me:

It is enough to call init_completion() once, and not once per use:
it initializes spinlocks, which shouldn't be intialized twice. 

But, that completion might be used multiple times when there are
multiple errors, and so, before using it a second time, one must 
set completion->done = 0.  The INIT_COMPLETION() macro does this. 

One must have completion->done = 0 before every use, as otherwise, 
wait_for_completion() won't actually wait. And since complete_all()
sets x->done += UINT_MAX/2, I'm pretty sure x->done won't be zero
the next time we use it, unless we make it so.

So I need to find a place to safely call INIT_COMPLETION() again, 
after the completion has been used. At the moment, I'm stumped
as to where to do this. 

---- [think ... think ... think] ----

I think the race you describe above is harmless. The first time
that sym_eh_handler() will run, it will be with SYM_EH_ABORT, 
in it doesn't matter if we lose that, since the device is hosed
anyway. At some later time, it will run with SYM_EH_DEVICE_RESET
and then SYM_EH_BUS_RESET and then SYM_EH_HOST_RESET, and we won't 
miss those, since, by now, sym2_io_error_detected() will have run.

So, by my reading, I'd say that init_completion() in
sym2_io_error_detected() has to stay (although perhaps
it should be replaced by the INIT_COMPLETION() macro.)
Removing it will prevent correct operation on the second 
and subsequent errors.

--Linas
