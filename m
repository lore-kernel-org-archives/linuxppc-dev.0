Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 5D8E667B1A
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 01:08:22 +1100 (EST)
Date: Mon, 27 Mar 2006 08:06:41 -0600
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] kdump: Fix for machine checkstop on DMA fault
Message-ID: <20060327140641.GA5025@pb15.lixom.net>
References: <44222462.2030103@us.ibm.com>
	<20060323053854.GA17693@pb15.lixom.net>
	<200603231706.35508.michael@ellerman.id.au>
	<20060323061904.GA22439@pb15.lixom.net>
	<20060323201258.GA5538@pb15.lixom.net>
	<1143435899.28580.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1143435899.28580.7.camel@localhost.localdomain>
From: Olof Johansson <olof@lixom.net>
Cc: Olaf Hering <olh@suse.de>, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 27, 2006 at 04:04:58PM +1100, Michael Ellerman wrote:
> I disagree. In most cases the kdump kernel will be loaded by the boot
> scripts, so reserving TCE space then is ~= reserving it for the life of
> the first kernel. Given that TCE space is a scarce commodity I don't
> think reserving it in the first kernel is a viable option.

Well, hopefully the kdump kernel doesn't need as much table space as a
regular kernel, so the loss would be limited, but if you're willing to
do the reserve instead; that'd be better.

> What we should do is modify the second kernel so that instead of
> clearing the TCE tables it instead walks the tables and detects existing
> mappings, and then marks those as reserved so they're not overwritten.

Yep, that's exactly what my first proposal was.

> This should give us 100% safety from the second kernel reusing a mapping
> and copping a rogue DMA, and doesn't inflict any penalty on the first
> kernel. It does fall down if there's no TCE space left for a device when
> the second kernel comes up, but I think that's the best trade off.

Correct. The time it could be a disadvantage is when there's been a
driver bug that leaks mappings that causes the machine to go down (i.e.
into the kdump kernel). Whatever device has been leaking might not be
usable since the table will be 100% full.


-Olof
