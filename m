Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBDvm1bn9zDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 22:11:48 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/3] powerpc/powernv: Avoid the secondary hold spinloop
 for OPAL boot
In-Reply-To: <20171006061005.29891-2-npiggin@gmail.com>
References: <20171006061005.29891-1-npiggin@gmail.com>
 <20171006061005.29891-2-npiggin@gmail.com>
Date: Tue, 10 Oct 2017 22:11:46 +1100
Message-ID: <87efqbw93h.fsf@concordia.ellerman.id.au>
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

> OPAL boot does not insert secondaries at 0x60 to wait at the secondary
> hold spinloop. Instead it keeps them held in firmware until the
> opal_start_cpu call is made, which directs them where the caller
> specifies. Linux inserts them into generic_secondary_smp_init(), which
> is after the secondary hold spinloop (they go on to spin at the per-CPU
> paca loops, but that is another step).
>
> So avoid waiting on this spinloop when booting with OPAL firmware.
> It always just times out.
>
> This saves 100ms boot time on bare metal, and 10s of seconds when
> booting the simulator in SMP.

Oh nice, that's real facepalm territory.

It'd be neater if we just inserted them at 0x60, but the sequence is
wrong.

Can we fix it just by making spinning_secondaries zero on OPAL?

cheers
