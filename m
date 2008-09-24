Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E65CEDDE9F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Sep 2008 07:47:13 +1000 (EST)
Subject: Re: Regarding select() on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <1222240130.8277.67.camel@pasglop>
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E206@insardxms01.ap.sony.com>
	<200809240823.12484.arnd@arndb.de> <1222237739.8277.62.camel@pasglop>
	<200809240845.52262.arnd@arndb.de> <1222240130.8277.67.camel@pasglop>
Content-Type: text/plain
Date: Thu, 25 Sep 2008 07:46:46 +1000
Message-Id: <1222292806.8277.95.camel@pasglop>
Mime-Version: 1.0
Cc: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>,
	linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> If that is true, then _any_ syscall that takes an int value must have
> a ppc specific sign-extending compat wrapper, are you sure that is
> the case ?

Ok, so that's crap that has been bitrotting. We -do- need to sign extend
everywhere and it looks like we forgot to do it on anything recent, like
signalfd4...

Ben.
