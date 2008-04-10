Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Thu, 10 Apr 2008 13:03:29 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: ppc440 caches - change proposal [RFC]
Message-ID: <20080410130329.560bd1cb@zod.rchland.ibm.com>
In-Reply-To: <fa686aa40804091250u1f532cddj9e3897969a98349c@mail.gmail.com>
References: <20080408225329.5EC171A8007D@mail11-dub.bigfish.com>
	<1207695415.14711.11.camel@pasglop>
	<fa686aa40804081615n284aa750n12ceb0bf1d1bcce1@mail.gmail.com>
	<20080409180042.511531370055@mail134-sin.bigfish.com>
	<fa686aa40804091250u1f532cddj9e3897969a98349c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: John Bonesio <john.bonesio@xilinx.com>, Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 9 Apr 2008 13:50:43 -0600
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> On Wed, Apr 9, 2008 at 12:00 PM, John Bonesio <john.bonesio@xilinx.com> wrote:
> >  I understand that many people are using a bootloader that already sets up the
> > cache for the kernel, but I'm wondering if Xilinx boards are really a special
> > case, or if there may be other non-Xilinx related systems that would also not
> > be using a bootloader.
> 
> I think there are very few cases of platforms not using some form of firmware.

Indeed.

> >  I also understand the desire to avoid code that does the same work more than
> > once, but I wonder if in this case, it's creating too strong a dependence on
> > the specific behavior of a certain bootloader.
> >  I also wonder if arch/powerpc is being made more complex by trying to split
> >  out this code change into a Xilinx specific area, when the change could just
> > be rolled into head_40x.S and we could do away with virtex405-head.S.
> 
> In general, I think that the wrapper does not want to touch the cache
> settings.  In the common case where firmware exists and sets up the
> cache then to turn off the cache again would throw away what firmware
> already had in cache and slow down the boot.
> 
> That being said, I'm not the bootwrapper expert.  If other think that
> it belongs in head_40x.S then I have no objections.
> 
> Josh, any thoughts?

This may or may not be OK.  In the general case, I think Grant is right
in that the wrapper tends to avoid mucking with cache settings that
were already setup by the firmware.

For 405 specifically, it could go either way.  And we actually already
ignore the cache settings for real mode anyway once it gets to
MMU_init_hw, but I wouldn't be surprised if an assumption was made
there as well.

josh
