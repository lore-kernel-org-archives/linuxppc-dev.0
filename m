Date: Fri, 18 Jun 2004 08:29:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Martin Habets <errandir_news@mph.eclipse.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Make install target work
Message-ID: <20040618152951.GC811@smtp.west.cox.net>
References: <20040616181652.GA7240@palantir8> <20040616190548.GD24479@smtp.west.cox.net> <20040617113822.GB9175@palantir8> <20040617150358.GI24479@smtp.west.cox.net> <20040618091707.GA15958@palantir8>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040618091707.GA15958@palantir8>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jun 18, 2004 at 10:17:07AM +0100, Martin Habets wrote:

> On Thu, Jun 17, 2004 at 08:03:58AM -0700, Tom Rini wrote:
> >
> > On Thu, Jun 17, 2004 at 12:38:22PM +0100, Martin Habets wrote:
> >
> > > On Wed, Jun 16, 2004 at 12:05:48PM -0700, Tom Rini wrote:
> > > >
> > > > On Wed, Jun 16, 2004 at 07:16:52PM +0100, Martin Habets wrote:
> > > >
> > > > > This patch makes the install target work. After all, it is already
> > > > > mentioned in the 'make help' output.
> > > > > The only question is, should it install zImage by default? I always
> > > > > install vmlinux, so I used that.
> > > >
> > > > Given the number of different ways we have to deal with (this really
> > > > only handles pmac) I'd much rather just have boot/install.sh run either
> > > > the distribution or user-provided script.
> > >
> > > Ehh.. that's exactly what install.sh tries to do! Only if both of these
> > > do not exist will the bottom part of the code be executed.
> >
> > Right.  And it's the bits at the bottom that I don't like.
>
> Ok, so you'd like to fail if neither nethod is avaiable (right?). I have no
> problem with that, but realize that it causes some inconsistent behaviour
> compared to other architectures.

By fail just:
echo "No install method found, nothing installed"
is fine.

> Can you explain why or what you don't like, please?
>
> > > The distribution provided scripts want an image to install. I agree
> > > that it is impossible to supply the right image for all systems.
> > > But maybe it is possible to echance this patch for some systems,
> > > providing a different image based on config settings?
> >
> > Possibly.  But I'm not convinced that the complexity will buy us
> > anything over the distribution script (which should cover all of the
> > pmac cases, if not, bug your distribution :)) and the user provided
> > hook.
>
> Yes, covering all cases in the kernel would be overkill, but I did not
> suggest that.

I'm talking about the complexity of covering most of the cases, for
non-pmac.  But..

> Pushing all this to the distribution script is not right
> either.

I disagree.  Given that the common case is using yaboot, that's not a
big burden on the distribution.  But if one decides to support grub or
U-Boot (with the latter being a bit more likely, IMHO, since it's what
the Pegasos boards use, I believe), it does become a distribution
problem to know how it set things up so that the user can add new
kernels, not the kernels responsibility to know where it has to put
something for a given distribution.

> That's not much more than a fancy copy script, and keeping it in
> sync with kernel code (directory and filenames) would be impossible.

This is rather static information, and I've taken some pains to ensure
that image names / locations have stayed consistent in 2.$(stable).

> Besides, this kind of logic belongs in the kernel, if anywhere.
>
> But there is an intermediate solution, which should satisfy all users:
> a makefile variable can be overruled by users, e.g.
> 	make BOOTIMAGE=arch/ppc/boot/images/zImage.prep install

Actually, Sam Ravnborg introduced a patch, which I think will be
accepted soon, to add a BOOT_IMAGE variable to the Makefiles, so that
'make rpm/deb/tarball' will be cleaner.  Once that happens, we can
revisit the idea of hooking an install script up, for all of the various
targets.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
