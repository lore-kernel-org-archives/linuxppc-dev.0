Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EFC32DDF18
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 09:33:40 +1100 (EST)
Subject: Re: [linux-pm] [PATCH 02/12] powermac: support G5 CPU hotplug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17867.40281.175422.116673@cargo.ozlabs.ibm.com>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124610.392302000@sipsolutions.net>
	<1170940494.4385.51.camel@johannes.berg>
	<1170941321.4385.61.camel@johannes.berg>
	<17867.40281.175422.116673@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 09 Feb 2007 09:33:32 +1100
Message-Id: <1170974012.2620.384.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>,
	linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Are you sure this is necessary?  IIRC, the if (!cpu_is_offline(cpu)) a
> little bit further down is there to cope with this exact situation.
> And cpu hotplug already works on G4 SMP powermacs, where we can't
> physically remove the cpu either - we just put it into sleep mode with
> interrupts disabled, which is what we would be doing on a G5 powermac
> also.

I've always had doubts about wether SLEEP with EE off was legal and
wouldn't actually still go out of sleep when getting an interrupt... In
that case, at least on CPUs where the DEC acts "level" triggered, we
need to at least reset the DEC to some sane value.

Ben.
