From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 4 Mar 2003 16:35:15 -0700
To: Dan Malek <dan@embeddededge.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch boot/common/relocate.S to start kernel at 0x000c
Message-ID: <20030304233515.GC4683@rover.farnsworth.org>
References: <20030304191644.GA4524@rover.farnsworth.org> <3E64FD53.3030107@embeddededge.com> <20030304201302.GA4683@rover.farnsworth.org> <3E650AAF.7060804@embeddededge.com> <20030304230849.GB4683@rover.farnsworth.org> <3E6534FA.9070503@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E6534FA.9070503@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 04, 2003 at 11:21:30PM +0000, Dan Malek wrote:
> Dale Farnsworth wrote:
>
> >-	nop	/* used by __secondary_hold on prep (mtx) and chrp smp */
> >-	nop	/* used by __secondary_hold on prep (mtx) and chrp smp */
> >+	/*
> >+	 * The first two words are used by __secondary_hold on SMP systems.
> >+	 * The second word may be overwritten before the first cpu runs
> >+	 * here, so we branch around it.
> >+	 */
> >+	b	__start
> >+	nop
> > 	nop
>
> I thought of this, but the comment on the first nop bothered me.
> Was it just a cut/paste without updating the comment, or could the nop
> and location zero be used by MP systems just like the one at location 0x04?

In __secondary_hold, location 0x4 is written by secondary cpus, and
location 0x0 is read, so I guess the comment is accurate, that both
locations are "used".  Cpu 0 writes location 0 to tell the secondary
cpus they can continue.

I know the above code works for my dual-7455 system.

Thanks,
-Dale

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
