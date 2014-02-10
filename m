Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C32192C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Feb 2014 14:11:05 +1100 (EST)
Message-ID: <1392001823.3996.21.camel@pasglop>
Subject: Re: [PATCH v2] powerpc ticket locks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Torsten Duwe <duwe@lst.de>
Date: Mon, 10 Feb 2014 14:10:23 +1100
In-Reply-To: <20140207165801.GC2107@lst.de>
References: <20140207165801.GC2107@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Tom Musta <tommusta@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Scott Wood <scottwood@freescale.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-02-07 at 17:58 +0100, Torsten Duwe wrote:
>  typedef struct {
> -       volatile unsigned int slock;
> -} arch_spinlock_t;
> +       union {
> +               __ticketpair_t head_tail;
> +               struct __raw_tickets {
> +#ifdef __BIG_ENDIAN__          /* The "tail" part should be in the MSBs */
> +                       __ticket_t tail, head;
> +#else
> +                       __ticket_t head, tail;
> +#endif
> +               } tickets;
> +       };
> +#if defined(CONFIG_PPC_SPLPAR)
> +       u32 holder;
> +#endif
> +} arch_spinlock_t __aligned(4);

That's still broken with lockref (which we just merged).

We must have the arch_spinlock_t and the ref in the same 64-bit word
otherwise it will break.

We can make it work in theory since the holder doesn't have to be
accessed atomically, but the practicals are a complete mess ...
lockref would essentially have to re-implement the holder handling
of the spinlocks and use lower level ticket stuff.

Unless you can find a sneaky trick ... :-(

Ben.
