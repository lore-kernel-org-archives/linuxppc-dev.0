Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C2B6B2BDEB
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Dec 2004 20:22:37 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
In-Reply-To: <20041201101130.05f71600@pirandello>
References: <1101877409.5672.2.camel@gaston>
	<20041201083617.5b72a115@pirandello> <1101891934.5592.0.camel@gaston>
	<20041201101130.05f71600@pirandello>
Content-Type: text/plain
Date: Wed, 01 Dec 2004 20:22:03 +1100
Message-Id: <1101892923.5593.17.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: TEST: Sleep patch #6
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2004-12-01 at 10:11 +0100, Colin Leroy wrote:
> On 01 Dec 2004 at 20h12, Benjamin Herrenschmidt wrote:
> 
> Hi, 
> 
> > > Compiling that. btw, you didn't add the "&& !wol" before sungem's suspend call...
> > 
> > What do you mean ? the whole code block is now in !wol...
> 
> I'm just being stupid, i didn't see that :)
> So much for trying to read patches before having had my coffee...
> 
> > Note that I'm still having problems with the cache ... I'm asking
> > Moto/Freescale...
> 
> With which CPUs? I did notice zero problems with patch #5 (without freq scaling).

On my 7455 rev 3.3 at least. cpufreq on mine uses the PMU as well, thus
approx. the same code path as sleep. By doing freq. switches in a loop
from a shell script, I can make it crash in a few iterations. It seem to
be solid if I add an ugly displacement flush before the cache flush
code, but that should not be necessary and thus makes me think something
is wrong with the code.

Ben.
