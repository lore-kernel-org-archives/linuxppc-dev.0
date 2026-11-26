Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42403606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 22:11:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jb9kN2Cznz2y8W;
	Fri, 27 Nov 2026 09:11:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795731100;
	cv=none; b=hkNit/CwLRml2vTQhU+R3UtqRfPGXNTVLGFNipH2oqFIvBoK2o7BrqBH81b8xI1RZEZh9b0YPva6TUuHVsIUN2OLfARlW4OIIKlRPod0gYqGs/2YelHB4l/cdZPs58MV94ix4ffQcEhbDJjeljg4ZnXIYD4JjLGHUfzONyf10AdhfEWaepEwibFpSuiYW8uDGM4KGNKwWoju7gaYtzKof94XEjbjifMnK4Lu4Cfj0sFHkzRoC+910sJDCAROjtxe67vVdd4RKKdh6HK4eoYHLkKtj/Z25Pd1Z3axn7KHlP5Tkoa9+4VAkLkL3m2QUQsuZF07AQuOQ7yaO8I/GFpf1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795731100; c=relaxed/relaxed;
	bh=wHvE1l0kMHT2nk7YO83+COp/bxmgQEjusWruwEZU4yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHsTwA2msC6aU9laC3dMKu9IynMssEmWHWL72D7VPqbUkhSU9qBtFAEn3qaY6+dukNopZi2QoLlLEmMvTcw29Qi50zPgUM/V2SnuWLnNj+MTc7SEKuiBwwGcUnA5a+goVQrHwM7XDI9vVN7bLWEhyUiS72yAZFgoyfKNiJM+LRkkJlm8FZ06KbSaXrlLrzMixSqvJ/9znIy887mASkxs1LaKc0LewY/Ic8zgpohUu41bisxX5Uxwae9dspLhCIooViU0Ewufn+Y5DheJGnwyIzLEqlyQ1LbTeGw/heuuOw3T0CRh9PhRCGFFmWL/8HeB3lOqjTO+UV+1WU35p4CPEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jb9kM0vCXz2y2h
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 09:11:37 +1100 (AEDT)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AQMAWQx1330611;
	Thu, 26 Nov 2026 16:10:32 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 6AQMAWTx1330610;
	Thu, 26 Nov 2026 16:10:32 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Thu, 26 Nov 2026 16:10:32 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: debian-powerpc <debian-powerpc@lists.debian.org>,
        gentoo-powerpc <gentoo-powerpc@lists.gentoo.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Should the community reconsider their efforts on PowerPC?
Message-ID: <awiuWDTdFq4Wel-o@gate>
References: <5793bff62d5995d322659d4a1d311bc4c795a829.camel@physik.fu-berlin.de>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5793bff62d5995d322659d4a1d311bc4c795a829.camel@physik.fu-berlin.de>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi!

On Thu, Nov 26, 2026 at 10:04:36PM +0100, John Paul Adrian Glaubitz wrote:
> as some of you may know, IBM has been pushing to deprecate any PowerPC
> platforms that they aren't earning money with anymore. This includes
> mainly POWER platforms before POWER8 and big-endian PowerPC.

Yup.  Those of course are still the most-used PowerPC targets.  And they
still will be for a long time, you can still buy second-hand Apple
PowerPC boxes.  There just were very many made!

> Recently, IBM engineers have remove JIT support in OpenJDK after sending
> an email for feedback to a non-public, unmonitored Debian email address [1].

Bah.  All Open-Source development should be done on public, publicly
archived mailing lists, of course.  The way everything was always done
since time immemorial.

> Since IBM engineers have also killed off support for big-endian PowerPC
> in Golang, V8 and also don't look after LLVM on big-endian PowerPC anymore,
> I wonder what is left for the community working on PowerPC.
> 
> I personally feel that IBM thinks they own the PowerPC platform in the
> open-source world and can single-handedly decide whether a certain project
> will support older PowerPC targets or not. And I'm starting to feel that
> this will sooner or later also happen to the kernel parts, GCC and binutils.

This will never happen to those projects!  Not as long as I have any say
in it, anyway.

That they decide to not invest any more time for BE or older uarchs for
Golang (or any other project where they are the main investor) is well
defendable (albeit in some ways quite lazy, and it hurts the communities
of course, you get much better code if your code work in any endianness
by design!  And how much does it cost to once in a while do a test
build?  It does not have to work on real hardware, just test that it
builds!)

> As someone who has invested endless hours of my free time into working
> Linux and open-source software on PowerPC, I feel really let down by
> how IBM is handling this and currently I feel like it's starting to become
> pointless to invest my free time working on PowerPC support in Linux
> and open-source projects.

I understand your worries!

It will be a really cold day in hell before the kernel will remove
powerpc-linux or powerpc64-linux, it is the usual target people use to
test BE with, after all.  s390 and Sparc people will hate it if it all
is shoved onto their plates :-)


Segher

