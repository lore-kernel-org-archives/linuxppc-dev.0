Date: Fri, 11 Jun 2004 14:24:37 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Travis Sawyer <tsawyer+linuxppc@sandburst.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 440GX tlb problem?
Message-ID: <20040611142437.A1795@home.com>
References: <1086979205.29360.5.camel@pavement.sandburst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1086979205.29360.5.camel@pavement.sandburst.com>; from tsawyer+linuxppc@sandburst.com on Fri, Jun 11, 2004 at 02:40:05PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jun 11, 2004 at 02:40:05PM -0400, Travis Sawyer wrote:
>
> Greetings:
>
> I'm attempting to bring up a new board (our custom hw) and am blowing an
> Instruction TLB error in head_440.S where the original TLB for SDRAM

head_440.S indicates you are using a really old kernel.

> (u-boot and initial kernel space) is invalidated after we've switched to
> 0xc000_0000.

What do you mean?  Your u-boot port has invalidated caches? are you
running out of 0xc0000000 before you get here?  Which TLB entry are
you executing from?

> the instructions:
> 3:/*	iccci   r0,r0    rcblach 12/19/02 clear all caches again on 1/17/03
> I took out these changes
> 	dccci   r0,r0    again clear all caches */
> 	cmpwi	r23,62
> 	beq	4f
> 	li	r6,0
> 	tlbwe   r6,r23,PPC440_TLB_PAGEID
> 	sync

By the comments, it's an IBM supplied kernel.  This isn't anything
in the kernel.org or linuxppc kernel trees.

> The exception hits when the sync is executed.

Maybe you are executing from TLB entry 62, that's one of the
undocumented limitations...you can entry head_44x.S running in
entry 62.

> Any ideas?

Can you try a current kernel tree? kernel.org 2.4 or 2.6.  The IBM
kernel trees are old and buggy (_buggier_).

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
