Date: Sun, 19 Aug 2001 19:18:10 -0400
From: Ben Collins <bcollins@debian.org>
To: Ira Weiny <iweiny@acm.org>
Cc: Linux1394dev <linux1394-devel@lists.sourceforge.net>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Task Queue Imediate Bottom Halfs question.
Message-ID: <20010819191810.E10646@visi.net>
References: <3B803FEE.7079F34C@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B803FEE.7079F34C@acm.org>; from iweiny@acm.org on Sun, Aug 19, 2001 at 03:38:38PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Aug 19, 2001 at 03:38:38PM -0700, Ira Weiny wrote:
> This is going to seem like a real stupid question but I just got burned
> because I did not know the answer and I would like to know.
>
> In the 1394 stack (OHCI) the IRQ handler schedules "bottom half tasklets
> (task queues in the old stack)".  They are scheduled to be "imediate"
> bottom half's.  I thought (wrongly) that a bottom half executed out of
> IRQ time with interrupts __enabled__.  As a result I put in a Async Rec
> handler which used printk (60ms worth to be exact).  Needless to say
> this greatly disturbed our ISO transfers which did not get processed.
>
> So, my question is, why use a bottom half here?  Or really what is the
> difference between scheduling a task queue (tasklet) imediate vs just
> running the code in the IRQ handler?

A performance hit? Running it straight from the interrupt handler mean
that the handler is blocking until the request is finished. Not only
does it have to wait for the ohci layer to process it, but also the
ieee1394 layer, which in turn processes to the protocol drivers (sbp2,
etc.). Really bad.

Ben

--
 .----------=======-=-======-=========-----------=====------------=-=-----.
/  Ben Collins  --  ...on that fantastic voyage...  --  Debian GNU/Linux   \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
