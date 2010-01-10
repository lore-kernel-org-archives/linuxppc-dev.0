Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96DC61007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jan 2010 07:40:00 +1100 (EST)
Subject: Re: Allocator MAX_ORDER exceeds SECTION_SIZE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Buesch <mb@bu3sch.de>
In-Reply-To: <201001101915.57627.mb@bu3sch.de>
References: <201001101431.10736.mb@bu3sch.de> <201001101915.57627.mb@bu3sch.de>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 Jan 2010 07:39:51 +1100
Message-ID: <1263155991.724.3.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2010-01-10 at 19:15 +0100, Michael Buesch wrote:
> On Sunday 10 January 2010 14:31:09 Michael Buesch wrote:
> > I get the following compilation failure, if 64k pages is selected
> > on 2.6.32.3 on a PowerMAC config:
> > 
> > include/linux/mmzone.h:947:2: error: #error Allocator MAX_ORDER exceeds SECTION_SIZE
> > 
> > Any idea?
> > 
> 
> Ok, I figured out that lowering CONFIG_FORCE_MAX_ZONEORDER from 13 to 9
> seems to fix the problem.
> That error message could really need some improvement and at least a hint on what to do and why.
> 
> I'm also wondering, if the kconfig entry for CONFIG_FORCE_MAX_ZONEORDER could
> somehow be limited to 9, if 64k pages is enabled.

There's some stuff in there to try to change the max order but KConfig
never quite get it right I think.

Cheers,
Ben.
