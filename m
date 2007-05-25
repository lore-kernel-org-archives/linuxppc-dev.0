Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C8497DDF4A
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 08:49:03 +1000 (EST)
Subject: Re: [patch 5/7] ps3: Disk Storage Driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200705251826.25572.arnd@arndb.de>
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.575306000@sonycom.com>
	<200705251826.25572.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 26 May 2007 08:48:55 +1000
Message-Id: <1180133335.19517.16.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Geert.Uytterhoeven@sonycom.com, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> So the hypervison uses guest-real addresses here? I would have expected
> it to use the kernel page tables, which lets you use vmap() to do
> scatter-gather.

Ugh ? Maybe s390 can do that but no other hypervisor that I know
about :-) It would be nice, sure, but heh.

> I don't really understand what the kthread is needed for. You probably
> thought about multiple options and ended up with this, but having
> a comment in front of it might be helpful.

Yeah, me neither... the driver looks very very very unefficient to me. I
though the kthread was useful for hotplug detection becasue the
hypervisor don't signal us, but from the patch, it looks like it's also
used for actual request processing which is very yucky.

Ben.
