Return-Path: <linuxppcleo@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.232])
	by ozlabs.org (Postfix) with ESMTP id D6DC167B56
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Oct 2006 01:56:28 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id t14so1194839wxc
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 08:56:27 -0700 (PDT)
Message-ID: <a0bc9bf80609300856q234d5acoe6b08dcf6016d9be@mail.gmail.com>
Date: Sat, 30 Sep 2006 23:56:27 +0800
From: "Li Yang" <LeoLi@freescale.com>
Sender: linuxppcleo@gmail.com
To: "Dan Malek" <dan@embeddedalley.com>
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
In-Reply-To: <EBD0615C-4F22-430F-BD23-1283DF98F1B3@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20060927155626.4d5ca19c@vitb.ru.mvista.com>
	<4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>
	<20060927165556.04c8d5d7@vitb.ru.mvista.com>
	<CE624A83-809E-4180-800E-660A578FFCFC@embeddedalley.com>
	<20060927112201.293fef44@localhost.localdomain>
	<EBD0615C-4F22-430F-BD23-1283DF98F1B3@embeddedalley.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dan,

I do share the same concern as you.  Single image for multiple
platforms is a great feature for server and desktop, but not as
valuable to embedded devices.  Response time and footprint are more
important concerns.  However, OTOH, OF device tree is a good
architecture for code reuse and porting.  It is better for reuse as it
enables code sharing between embedded and desktop devices.  It is more
and more popular to use peripherals from desktop on embedded systems.
Better for porting because:  from the single DTS file, we can get/set
all the information about the system, instead of hacking into dozens
of drivers.  It is a tough choice to make.

Well, I have an idea.  Maybe it can relief the side effect of DT to
embedded systems, but I'm even not sure if it is feasible or not.  If
we can rework the prom APIs, make them to have two modes, embedded and
non-embedded.  It should be switched using a configuration option.
For non-embedded mode, they just act the same as what we have now,
which get properties from looking up the tree at runtime.  While in
embedded mode, the prom APIs actually compile the properties to be
looked up in tree into the code as const values.  Thus save the
time/space consumed by look-up.  Well.  The implementation maybe too
complex, maybe needs overhaul to dtc.  I'm just sharing the idea to
see what others think about it.  ;)

- Leo

On 9/28/06, Dan Malek <dan@embeddedalley.com> wrote:
>
> On Sep 27, 2006, at 12:22 PM, Olof Johansson wrote:
>
> > Yes, also called "board port hell".
>
> I tend to think people skilled to do a board port
> will still create something elegant and functional
> given whatever the existing model.
>
> > ....   So you can boot the same kernel binary on
> > several boards, as long as the drivers are built in and the correct
> > device tree is used. Has everyone missed/forgotten that objective
> > completely?
>
> That was never an objective when we started, although
> it seems some people involved in the implementation
> think it's the only objective.  It just happens to be a side
> effect when convenient.
>
> If you could look back over the eight or more years
> of embedded Linux development with PowerPC, this
> discussion of supporting multiple boards with
> single binaries has occurred.  In all cases, we never
> considered it a requirement, there are many others
> more important in embedded systems.  Our greatest
> concern was sharing code among all platforms, but
> in a way we could still configure the most compact
> and highest performance code for a particular
> processor and board.
>
> Although processors are faster and memory is larger
> today, embedded systems are still trying to do more with
> less.  We still try to run the slowest processor speed to
> conserve power and meet environmental requirements.
> Memory still costs money, and designs try to use the
> minimum amount to be cost competitive.  IMHO, the same
> requirements for compact and efficient code are just
> as important today as they were when we had the first
> discussion years ago.  Conversion of the information,
> kernel code just hanging around in case it may be used
> on some board but not another and reliance on a
> particular version of boot code are things we have
> always tried to avoid.  We are competing against other
> processor architectures that are more compact and
> resource friendly, it would be nice to not lose in
> those product designs.
>
> > The device tree describes the system, not how to program it. I think
> > that's where the confusion might be.
>
> There is no confusion.  This device tree discussion was started
> several years ago by a couple of us trying to find a way to better
> describe the wide variety of PowerPC SOC processor peripheral
> variants.  Kumar and I had many discussions about this, since
> my old static internal memory maps weren't going to work well.
> The IBM microelectronics folks were also looking for something
> similar.  We thought a _simple_ flat device tree along with
> the platform data would be sufficient to define this internal
> peripheral mapping.  I wasn't too keen on the idea, but didn't
> have the time to provide any alternative implementation
> against the Freescale coding machine :-)
>
> Now, we have something that is way more complex than
> we initially thought was necessary, trying to describe nearly
> everything addressable in the system instead of just the
> internal memory map.  I suspect the software to attain
> (IMHO the useless) goal of a single binary for multiple
> boards will create exponentially complex software,
> something that highly reliable embedded systems
> are trying to avoid.
>
> > I.e. create a generic "board-controller" device node, and put a
> > suitable "compatible" property in there, so the right board controller
> > driver can be chosen based on it. Having the address of the controller
> > in there helps too, especially if there are two boards out there with
> > the same controller but at different memory location.
>
> What value does this provide to my client trying
> to create a cost effective wireless home networking
> device?  It certainly doesn't make the board port
> from hell any easier, since cramming the software
> into 4M of flash will likely cause the choice of a
> processor other than PowerPC that can configure
> a smaller kernel and use a tiny custom piece of
> boot code.  Highly configurable development/evaluation
> boards running a single binary aren't high volume
> products, and the additional resources required
> by such software could ensure real products aren't
> developed with PPCs.  We need to be sensitive
> to this.
>
> Thanks.
>
>        -- Dan
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
