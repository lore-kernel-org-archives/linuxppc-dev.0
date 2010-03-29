Return-Path: <temerkhanov@yandex.ru>
Received: from forward3.mail.yandex.net (forward3.mail.yandex.net [77.88.46.8])
	by ozlabs.org (Postfix) with ESMTP id B5B52B7C67
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Mar 2010 07:14:57 +1100 (EST)
From: Sergey Temerkhanov <temerkhanov@yandex.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] [RFC] Xilinx MPMC SDMA subsystem
Date: Mon, 29 Mar 2010 23:04:39 +0400
References: <201003172118.41559.temerkhanov@cifronik.ru>
	<1269877373.6173.27.camel@iscandar.digidescorp.com>
	<fa686aa41003290856t24a248a5j5dfda623ed2805c0@mail.gmail.com>
In-Reply-To: <fa686aa41003290856t24a248a5j5dfda623ed2805c0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201003292304.39657.temerkhanov@yandex.ru>
Cc: microblaze-uclinux@itee.uq.edu.au,
	Sergey Temerkhanov <temerkhanov@cifronik.ru>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	steve@digidescorp.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 29 March 2010 19:56:15 Grant Likely wrote:
> On Mon, Mar 29, 2010 at 9:42 AM, Steven J. Magnani
> 
> <steve@digidescorp.com> wrote:
> > On Fri, 2010-03-26 at 17:53 -0600, Grant Likely wrote:
> >> I've not got time to review this patch right now, but Sergey and
> >> Steven, you both posted MPMC drivers on the same day; Steven on the
> >> microblaze list and Sergey on the powerpc list.  Can you two please
> >> coordinate and figure out how to mork toward a single driver that will
> >> meet both your needs?  I don't want to have 2 drivers (3 if you count
> >> the ll_temac driver) in mainline for the same hardware interface.
> >
> > I don't think we'll end up with a single driver. A MPMC DMA Engine
> > driver is useful only on "loopback" SDMA ports. Sergey's code looks like
> > a nice generic interface to Xilinx SDMA HW that could be used by the
> > xlldma and ll_temac drivers, for instance. Both of those will get
> > smaller, but won't go away.

Yes, it's like having IBM EMAC driver and MAL layer or something 

> >
> > For this to be useful to me, it would need to be located somewhere more
> > accessible than arch/powerpc and it would need to have initialization
> > methods that don't depend on OF. In my build I would have platform code
> > that binds to the xlldma platform attachment, which would call Sergey's
> > SDMA code to assign it the proper resources.
> 
> That should be fine.

Well, I'll look at my old code for the platform interface bindings. I remember 
it worked well on arch/ppc with my other drivers.

> 
> > Any objections to having Sergey's code live in drivers/dma, and putting
> > sdma.h out in include/linux? Might need to tweak the file/function names
> > some to head off namespace issues. Or is there some other strategy for
> > managing Xilinx-related drivers common to both Microblaze and PowerPC?
> 
> I have no objections.  This sounds like a good plan.

Or we can put Xilinx-related headers to, i.e., include/linux/xilinx. There 
might be some other candidates for this. 
> 
> g.
> 

Regards, Sergey Temerkhanov, Cifronic ZAO
