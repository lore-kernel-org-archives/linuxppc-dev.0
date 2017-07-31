Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLb3Z3Jm0zDrCm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 20:17:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH] powerpc: improve accounting of non maskable interrupts
In-Reply-To: <20170729132257.8132-1-npiggin@gmail.com>
References: <20170729132257.8132-1-npiggin@gmail.com>
Date: Mon, 31 Jul 2017 20:17:13 +1000
Message-ID: <87efsw6hcm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> This fixes a case of double counting MCEs on PowerNV.
>
> Adds a counter for the system reset interrupt, which will
> see more use as a debugging NMI.
>
> Adds a soft-NMI counter for the 64s watchdog. Although this could cause
> confusion because it only fires when interrupts are soft-disabled, so it
> won't increment much even when the watchdog is running.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> I can split these out or drop any objectionable bits. At least the
> MCE we should fix, not sure if the other bits are wanted.

Yeah if you can split it please that would be good.

I'm not sure how useful it is to count the SOFT NMIs. I guess it's not
much overhead so we may as well, if nothing else it might be handy for
us debugging.

If you can make the ifdef look less horrendous that would be great :D -
perhaps a kconfig symbol that keys off both.

cheers
