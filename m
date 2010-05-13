Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 71F67B7DB3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 May 2010 20:47:16 +1000 (EST)
Subject: Re: "event-scan failed" logflood
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1273730685.25436.66.camel@concordia>
References: <20100513041329.1972.qmail@kosh.dhis.org>
	<1273730685.25436.66.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 13 May 2010 20:46:47 +1000
Message-ID: <1273747607.21352.185.camel@pasglop>
Mime-Version: 1.0
Cc: pacman@kosh.dhis.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-05-13 at 16:04 +1000, Michael Ellerman wrote:
> It's probably caused by 3d541c4b7f6efd55a98189afd1b2f1c9d048c1b3.
> 
> Is Pegasos a chrp, I can't remember. It did get called in the old chrp
> code, and the comments suggest you have to call it.
> 
> It's not obvious looking at the diff why it would be failing now but
> didn't previously.

Well, first it should be called once per second, not 60 times per
second, so something is wrong there...

Then, it wouldn't surprise me if the Pegasos RTAS didn't implement
the event scan properly. Maybe we failed silently before that ? I
doubt it's necessary there anyways.

It would be relatively easy to avoid starting the event scan on a
pegasos, I think we have a _chrp_type variable that can be tested
for that.

Cheers,
Ben.
