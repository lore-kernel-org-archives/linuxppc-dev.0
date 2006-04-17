Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A7C9167A58
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Apr 2006 23:46:04 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PowerBook5,4 -- no sound?
References: <878xq51t61.fsf@briny.internal.ondioline.org>
	<je1wvxo70l.fsf@sykes.suse.de>
	<1145220233.9833.11.camel@localhost.localdomain>
	<je7j5phz9j.fsf@sykes.suse.de>
	<1145231658.9833.17.camel@localhost.localdomain>
	<je3bgdhwre.fsf@sykes.suse.de>
	<1145233812.9833.21.camel@localhost.localdomain>
Date: Mon, 17 Apr 2006 15:45:59 +0200
In-Reply-To: <1145233812.9833.21.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Mon, 17 Apr 2006 10:30:12 +1000")
Message-ID: <je1wvwfh7s.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Interesting... I would have expected that setup to work... Oh well... at
> this point, the best to do is to add support for your G5 to Johannes new
> snd-aoa

I agree.  Unfortunately, the i2sbus probing already fails, due to
requesting a memory region that is already (partially) claimed by other
resources:

request_mem_region(80000000 - 80000fff, i2sbus control)

      80000000-8007ffff : 0.80000000:mac-io
        8000002c-8000002f : 0.0000004c:fans
        80000030-80000033 : 0.0000004c:fans
        80000034-80000037 : 0.0000004c:fans
        8000004c-8000004f : 0.0000004c:fans
        80000050-8000008a : 0.00000050:gpio

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
