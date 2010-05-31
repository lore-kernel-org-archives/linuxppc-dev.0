Return-Path: <paulus@ozlabs.org>
Date: Tue, 1 Jun 2010 08:40:40 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] KVM: PPC: elide struct thread_struct instances from stack
Message-ID: <20100531224040.GA22927@brick.ozlabs.ibm.com>
References: <m26323onam.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m26323onam.fsf@igel.home>
Cc: linuxppc-dev@ozlabs.org, Alexander Graf <agraf@suse.de>,
	kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 31, 2010 at 09:59:13PM +0200, Andreas Schwab wrote:

> Instead of instantiating a whole thread_struct on the stack use only the
> required parts of it.

...

> +_GLOBAL(kvm_cvt_fd)
> +	lfd	0,0(r5)			/* load up fpscr value */
> +	MTFSF_L(0)
> +	lfs	0,0(r3)
> +	stfd	0,0(r4)
> +	mffs	0
> +	stfd	0,0(r5)			/* save new fpscr value */
> +	blr
> +
> +_GLOBAL(kvm_cvt_df)
> +	lfd	0,0(r5)			/* load up fpscr value */
> +	MTFSF_L(0)
> +	lfd	0,0(r3)
> +	stfs	0,0(r4)
> +	mffs	0
> +	stfd	0,0(r5)			/* save new fpscr value */
> +	blr

I re-read the relevant part of the PowerPC architecture spec
yesterday, and it seems pretty clear that the FPSCR doesn't affect the
behaviour of lfs and stfs, and is not affected by them.  So in fact 4
out of the 7 instructions in each of those procedures are unnecessary
(and similarly for the cvt_fd/df used in the alignment fixup code).

Paul.
