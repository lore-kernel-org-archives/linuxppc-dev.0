Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 30F2BDDE19
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 23:20:26 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id b2so1319530ana.81
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 05:20:25 -0700 (PDT)
Date: Tue, 18 Mar 2008 07:20:18 -0500
From: Josh Boyer <jwboyer@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Please pull linux-2.6-mpc52xx.git
Message-ID: <20080318072018.30e2bde6@hansolo.jdub.homelinux.org>
In-Reply-To: <fa686aa40803171942u78d2aa68y47c1de3321f727f1@mail.gmail.com>
References: <fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com>
	<20080318002650.AE701246C5@gemini.denx.de>
	<fa686aa40803171942u78d2aa68y47c1de3321f727f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 17 Mar 2008 20:42:14 -0600
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> On Mon, Mar 17, 2008 at 6:26 PM, Wolfgang Denk <wd@denx.de> wrote:
> > Dear Grant,
> >
> >
> >  in message <fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com> you wrote:
> >  >
> >  > However, I have declined (for now) to pick up the defconfigs for those
> >  > boards and instead merged in the config features they require into the
> >  > mpc5200 defconfig.  My primary reason for doing so is to increase the
> >  > likelyhood that full featured kernels are built and tested so that
> >  > situations where board ports conflict with each other are caught and
> >  > fixed.
> >
> >  I know what you mean, and I agree with the idea.
> >
> >  Unfortunately I think it's impossible to implement, especially on such
> >  embedded processors with their high level of pin multiplexing.
> >
> >  For example, if you want to  include  testing  of  the  FEC  ethernet
> >  driver,  you  will probably fail to test the second USB port. I think
> >  it's simply not possible to test all possible  options  in  a  single
> >  kernel  configuration - first it doesn't work (for example because of
> >  pin multiplexing issues), second you will likely not be able to  find
> >  hardware that implements all features at once.
> 
> I don't think this example really applies.  Yes, I agree that I cannot
> test all the functions, but that does not preclude building in all the
> drivers and making sure that they don't cause a conflict by just being
> present.  For instance, I can build a single kernel image right now
> that should boot and fully run on the Efika, lite5200, tqm and motion
> pro boards (although the Efika has a different wrapper).  I can only
> test it on the Efika and lite5200 boards and I have to rely on other
> people for the boards I don't have.  If it breaks; I expect to receive
> an irate email in my Inbox telling me to fix it!
> 
> pin multiplexing shouldn't be an issue at all.  Only the devices which
> are instantiated in the device tree will actually get initialized so
> if the pins aren't hooked up then it shouldn't be in the tree.

That's not entirely true.  Devices that are muxed can be added to the
tree just fine.  What I've done on 440 boards that have devices that
share pins is to add a status = "disabled"; property to the device that
doesn't have pins at the moment.

See my patch for of_device_is_available for how to query that.  I'll be
throwing that in my tree soon if Paul doesn't pick it up.

josh
