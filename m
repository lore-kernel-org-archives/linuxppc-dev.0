Date: Fri, 18 Jun 2004 10:17:07 +0100
From: Martin Habets <errandir_news@mph.eclipse.co.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Make install target work
Message-ID: <20040618091707.GA15958@palantir8>
References: <20040616181652.GA7240@palantir8> <20040616190548.GD24479@smtp.west.cox.net> <20040617113822.GB9175@palantir8> <20040617150358.GI24479@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040617150358.GI24479@smtp.west.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 17, 2004 at 08:03:58AM -0700, Tom Rini wrote:
>
> On Thu, Jun 17, 2004 at 12:38:22PM +0100, Martin Habets wrote:
>
> > On Wed, Jun 16, 2004 at 12:05:48PM -0700, Tom Rini wrote:
> > >
> > > On Wed, Jun 16, 2004 at 07:16:52PM +0100, Martin Habets wrote:
> > >
> > > > This patch makes the install target work. After all, it is already
> > > > mentioned in the 'make help' output.
> > > > The only question is, should it install zImage by default? I always
> > > > install vmlinux, so I used that.
> > >
> > > Given the number of different ways we have to deal with (this really
> > > only handles pmac) I'd much rather just have boot/install.sh run either
> > > the distribution or user-provided script.
> >
> > Ehh.. that's exactly what install.sh tries to do! Only if both of these
> > do not exist will the bottom part of the code be executed.
>
> Right.  And it's the bits at the bottom that I don't like.

Ok, so you'd like to fail if neither nethod is avaiable (right?). I have no
problem with that, but realize that it causes some inconsistent behaviour
compared to other architectures.
Can you explain why or what you don't like, please?

> > The distribution provided scripts want an image to install. I agree
> > that it is impossible to supply the right image for all systems.
> > But maybe it is possible to echance this patch for some systems,
> > providing a different image based on config settings?
>
> Possibly.  But I'm not convinced that the complexity will buy us
> anything over the distribution script (which should cover all of the
> pmac cases, if not, bug your distribution :)) and the user provided
> hook.

Yes, covering all cases in the kernel would be overkill, but I did not
suggest that. Pushing all this to the distribution script is not right
either. That's not much more than a fancy copy script, and keeping it in
sync with kernel code (directory and filenames) would be impossible.
Besides, this kind of logic belongs in the kernel, if anywhere.

But there is an intermediate solution, which should satisfy all users:
a makefile variable can be overruled by users, e.g.
	make BOOTIMAGE=arch/ppc/boot/images/zImage.prep install
This can be used with a distribution script or a user provided one.
If the distribution scripts ever become smart enough, which I seriously
doubt, the override is no longer needed.
What do you think of this approach?

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
