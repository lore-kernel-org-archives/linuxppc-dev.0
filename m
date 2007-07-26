Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 65FF6DDE18
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 07:26:46 +1000 (EST)
Message-ID: <46A91130.8000907@semihalf.com>
Date: Thu, 26 Jul 2007 23:25:04 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [patch 07/35] pasemi_mac: stop using the pci config space
	accessors for register read/writes
References: <20070705170233.258351000@lixom.net>
	<20070705170235.314700000@lixom.net>
In-Reply-To: <20070705170235.314700000@lixom.net>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Olof,

Olof Johansson wrote:
> Move away from using the pci config access functions for simple register
> access.  Our device has all of the registers in the config space (hey,
> from the hardware point of view it looks reasonable :-), so we need to
> somehow get to it. Newer firmwares have it in the device tree such that
> we can just get it and ioremap it there (in case it ever moves in future
> products). For now, provide a hardcoded fallback for older firmwares.

I have recently tried to apply a group of your MAC patches that includes the one from this email. Strangely, I got a pretty random kernel panics (or kernel freezes) when this patch is included. Panics happen in a random, places and have random causes. What I observed is that replacing newly introduced mac->iob_regs with the corresponding offset from (already ioremapped) hose->cfg_data removed the problem. So, it seems that dereferencing pointers based on a second ioremap on a subset of 0xe000_0000 addresses is problematic. 

Here are the questions that come to my mind:

- I am testing on a A2 hw, what what your testing setup, anything newer than this (something closer B0 maybe), did you have a chance to try that on a A2 board?
- Is there any particular patch or set of patches/updates that this patch may depend on?

Switching from pci accessors to direct in_* out_* calls drops the guard pci spinlock. Initially, I thought that this may be the reason, but it's not, adding the spinlock is not solving the problem. But anyway, shouldn't we be using it to coordinate access?

Thanks,
Marian
