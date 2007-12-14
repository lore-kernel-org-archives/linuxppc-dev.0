Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 53719DDDFD
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 11:05:45 +1100 (EST)
Subject: Re: apm_emulation regression
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
In-Reply-To: <1197590675.15741.195.camel@pasglop>
References: <1197427530.8385.59.camel@pasglop>
	<1197482587.6558.145.camel@johannes.berg>
	<200712140110.44406.rjw@sisk.pl>
	<1197590675.15741.195.camel@pasglop>
Content-Type: text/plain
Date: Fri, 14 Dec 2007 11:05:12 +1100
Message-Id: <1197590712.15741.197.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-pm <linux-pm@lists.osdl.org>, ralf <ralf@linux-mips.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-12-14 at 11:04 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2007-12-14 at 01:10 +0100, Rafael J. Wysocki wrote:
> > 
> > Hmm.
> > 
> > I'm not that familiar with the APM emulation code, but the description
> > of the
> > problem above suggests that the APM emulation can install a suspend
> > notifier for this purpose.
> 
> It can use the new notifier that happens before freezing yes. Johannes,
> I think that's pretty much what my old powermac implementation did
> (using my private notifier scheme I had there), might be worth reviving
> that bit and sticking it into the generic apm_emu ...

Note that you may want to improve on it with a timeout in case userspace
doesn't ack...

Ben.
