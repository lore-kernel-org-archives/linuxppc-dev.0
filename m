Date: Thu, 20 Jun 2002 15:34:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH and RFC] Remove request_8xxirq
Message-ID: <20020620223455.GM16052@opus.bloom.county>
References: <20020620203455.GG16052@opus.bloom.county> <3D124351.1020800@embeddededge.com> <20020620213925.GH16052@opus.bloom.county> <3D12513E.1000905@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D12513E.1000905@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 20, 2002 at 06:03:42PM -0400, Dan Malek wrote:
>
> Tom Rini wrote:
>
> >Yes, Andy who did that part of the code and claims that PCI does indeed
> >work on it.
>
> I know Andy is sitting on a ton of 82xx PCI changes that would be nice
> to see checked in some day. :-)

Well, Andy says that to get PCI happy all he had to do was to stop using
request_8xxirq.  So that patch should make PCI nice 'n happy there, but
it's untested.

> >I don't follow you here.  Is this just another complaint about how the
> >normal way of handling cascades is ugly?
>
> Sort of.  The problem is you often have to program the CPM interrupt
> vector for a particular device into the CPM.  For example, you may have
> to tell the SCC2 device on the CPM what vector to use, which in turn
> is also used to configure the interrupt controller.  Using this scheme
> of this patch, these two numbers are different because you give
> request_irq()
> a different number than you program into the CPM for this device.  There
> are more and more integrated controllers that do this, and using hardcoded
> values with offsets isn't going to work in those cases.

'hardcoded == bad', mental note made.

> The other problem is the "namespace" of request_irq() usually assumes
> numbers 0 to 15 are an 8259, and many legacy devices are hardcoded to
> use these numbers.  Now, on the 8xx and 8260, you have changed what these
> values mean.  I believe I saw a patch from Wolfgang that left request_irq()
> alone (and left the other 8xx and CPM interrupt request functions as they
> were),
> but in request_irq() he remapped the number to be something meaningful on
> 8xx.
>
> I would kind of prefer his patches to this one.

I believe this is tied into the "let the good drivers actually work and
the bad ones give a 'meaningful' blow-up" part of the patch.

> >If a 'generic PC function' calls with the wrong parameters, fix the
> >function.  Right now we happily panic() on all of the correctly written
> >drivers as well as the broken ones.  This makes it possible to actually
> >test drivers to see which ones are broken and fix them.
>
> See Wolfgang's patches......

I don't see how that fixes the panic() in request_irq().

> >Perhaps sometime later in 2.5 a 'real design improvement' will happen.
> >But I also don't see what that has to do with this, other than the
> >8xx/8260 way of doing things is going.
>
> The 8xx is more complicated due to its multiple cascaded interrupts.
> The 8260 removed the CPM cascade, making it more simple to implement.
> What do Andy's patches for 8260+PCI look like?  There has to be a
> cascade in there someplace that isn't represented in any of these patches.

He says they just work.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
