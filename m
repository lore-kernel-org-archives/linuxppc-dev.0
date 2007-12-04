Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 190EEDDF3D
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 07:31:31 +1100 (EST)
Subject: Re: [PATCH v2 2/2] [POWERPC] Use new machine_xxx_initcall hooks in
	platform code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200712042036.00785.arnd@arndb.de>
References: <20071202061028.21193.39309.stgit@trillian.secretlab.ca>
	<fa686aa40712040536h18bd60d3xf89af1f89f6a92ad@mail.gmail.com>
	<fa686aa40712040621r3103bae9hd900c23d48273360@mail.gmail.com>
	<200712042036.00785.arnd@arndb.de>
Content-Type: text/plain
Date: Wed, 05 Dec 2007 07:31:13 +1100
Message-Id: <1196800273.13230.333.camel@pasglop>
Mime-Version: 1.0
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, olof@lixom.net
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-12-04 at 20:35 +0100, Arnd Bergmann wrote:
> 
> 1. If another platform gets added that uses the same firmware feature,
> it
> will automatically do the right thing.

Yes but is it something that we want to happen ? That is, do we want
code somewhere in a platform/foo dir to run when using platform/bar
because they happen to share a feature ?

I don't think so ... such code should be located elsewhere, maybe in
sysdev, where it's clear that it's shared.

Thus, thing that is -really- platform specific and wants to stay in the
platform code should move to the new mechanism I believe.

As for PS3, will there ever be another platform using LV1 ? If that is
the case, we may want to create a shared directory with all the LV1
bits...

> 2. The call to firmware_has_feature() turns into a compile-time check
> in
> many cases, so if the kernel does not contain support for any firmware
> with the given feature, all the code referenced it can get optimized
> away by the compiler.

The machine init stuff will soon get rid of whatever test is in it too,
as soon as I get to do the ELF magic.

Ben.
