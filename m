Message-ID: <008901c451b5$0aa87880$5200a8c0@transengfb16d1>
From: "LarrZheng" <larryzheng@transengines.com>
To: "Matt Porter" <mporter@kernel.crashing.org>,
	"Travis Sawyer" <tsawyer+linuxppc@sandburst.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <1086979205.29360.5.camel@pavement.sandburst.com> <20040611142437.A1795@home.com>
Subject: Re: 440GX tlb problem?
Date: Mon, 14 Jun 2004 10:12:27 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Matt
    I think TLB entry has something wrong between linuxppc-2.5-ocp and
linuxppc-2.4 kerenl,  in 2.4 all works right. but in 2.5-cop tlb entry 63
will not work right on our 440gx board, so i change tlb entry to 62(as same
as linuxppc-2.4/head_44x.s),  then the board can be boot normally, would you
check it?

Larry





----- Original Message -----
From: "Matt Porter" <mporter@kernel.crashing.org>
To: "Travis Sawyer" <tsawyer+linuxppc@sandburst.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Saturday, June 12, 2004 5:24 AM
Subject: Re: 440GX tlb problem?


>
> On Fri, Jun 11, 2004 at 02:40:05PM -0400, Travis Sawyer wrote:
> >
> > Greetings:
> >
> > I'm attempting to bring up a new board (our custom hw) and am blowing an
> > Instruction TLB error in head_440.S where the original TLB for SDRAM
>
> head_440.S indicates you are using a really old kernel.
>
> > (u-boot and initial kernel space) is invalidated after we've switched to
> > 0xc000_0000.
>
> What do you mean?  Your u-boot port has invalidated caches? are you
> running out of 0xc0000000 before you get here?  Which TLB entry are
> you executing from?
>
> > the instructions:
> > 3:/* iccci   r0,r0    rcblach 12/19/02 clear all caches again on 1/17/03
> > I took out these changes
> > dccci   r0,r0    again clear all caches */
> > cmpwi r23,62
> > beq 4f
> > li r6,0
> > tlbwe   r6,r23,PPC440_TLB_PAGEID
> > sync
>
> By the comments, it's an IBM supplied kernel.  This isn't anything
> in the kernel.org or linuxppc kernel trees.
>
> > The exception hits when the sync is executed.
>
> Maybe you are executing from TLB entry 62, that's one of the
> undocumented limitations...you can entry head_44x.S running in
> entry 62.
>
> > Any ideas?
>
> Can you try a current kernel tree? kernel.org 2.4 or 2.6.  The IBM
> kernel trees are old and buggy (_buggier_).
>
> -Matt
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
