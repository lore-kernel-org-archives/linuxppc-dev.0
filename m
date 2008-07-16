Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A2008DE178
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 09:42:34 +1000 (EST)
In-Reply-To: <1dce2aab6509053e60f7a59a30974749@bga.com>
References: <1dce2aab6509053e60f7a59a30974749@bga.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <51d268160cd0a8f92f75ff0962c1488a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [HOW] binutils-2.17 breaks the 2.6.26 kernel
Date: Thu, 17 Jul 2008 01:41:16 +0200
To: Milton Miller <miltonm@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Alan Modra <amodra@bigpond.net.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> . = ALIGN(0x1000)   /* this align directive aparently gets lost
>                        when stripping the file */
>
> .rodata: AT (.rodata - LOAD_OFFSET): {
>   ...
> }
>
> the effects of that align were dropped during strip, shifting all
> following sections up in memory and the resulting failure.

The ELF headers show the .rodata section to have 256 byte alignment
only, but after the "bad" strip it isn't even aligned to that
anymore (file offset).  Curious.

I still can't reproduce this, but getting the bad binary now (it's
huge, heh).  We'll see.


Segher
