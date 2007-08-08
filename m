Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <20070807042050.GJ13522@localhost.localdomain>
References: <20070807042050.GJ13522@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BDA0DE7D-8AD8-4116-ABE0-2DF6AE72A516@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Fix small race in 44x tlbie function
Date: Wed, 8 Aug 2007 10:20:45 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Todd Inglett <tinglett@us.ibm.com>, Volkmar Uhlig <vuhlig@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 6, 2007, at 11:20 PM, David Gibson wrote:

> The 440 family of processors don't have a tlbie instruction.  So, we
> implement TLB invalidates by explicitly searching the TLB with tlbsx.,
> then clobbering the relevant entry, if any.  Unfortunately the PID for
> the search needs to be stored in the MMUCR register, which is also
> used by the TLB miss handler.  Interrupts were enabled in _tlbie(), so
> an interrupt between loading the MMUCR and the tlbsx could cause
> incorrect search results, and thus a failure to invalide TLB entries
> which needed to be invalidated.
>
> This patch fixes the problem in both arch/ppc and arch/powerpc by
> inhibiting interrupts (even critical and debug interrupts) across the
> relevant instructions.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
> Paul, this one's a bugfix, which I think should go into 2.6.23.

Did you actually see this happen?

- k
