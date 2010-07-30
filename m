Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8B6871007D1
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 13:38:08 +1000 (EST)
Date: Thu, 29 Jul 2010 20:36:32 -0700
From: Greg KH <gregkh@suse.de>
To: Feng Kan <fkan@apm.com>
Subject: Re: [PATCH 1/2 v1.03] Add support for DWC OTG HCD function.
Message-ID: <20100730033632.GB27275@suse.de>
References: <4C4E0449.2070108@caviumnetworks.com>
	<20100726220513.GA9671@suse.de> <20100726220809.GA9784@suse.de>
	<AANLkTinbTnrr9DCiSgKngAjaak=U0qDYcCxbNZR4Nm3D@mail.gmail.com>
	<20100726231616.GA25342@suse.de>
	<AANLkTikDpxcOj=TgD5697HOzPOanECGd4G6QaXZmoS98@mail.gmail.com>
	<20100730005045.GB22683@suse.de>
	<AANLkTikSH8_QXV2qsBR+vxsjvQwNdx2st3vfbRpfsMff@mail.gmail.com>
	<20100730012650.GB24931@suse.de>
	<AANLkTimiox6UbUnhSRLgC06S2kfcDOANA08gm3m++TXd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimiox6UbUnhSRLgC06S2kfcDOANA08gm3m++TXd@mail.gmail.com>
Cc: linux-usb@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>,
	linuxppc-dev@ozlabs.org, Mark Miesfeld <mmiesfeld@apm.com>,
	Ted Chan <tchan@apm.com>, Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 29, 2010 at 07:02:44PM -0700, Feng Kan wrote:
> On Thu, Jul 29, 2010 at 6:26 PM, Greg KH <gregkh@suse.de> wrote:
> > On Thu, Jul 29, 2010 at 06:19:25PM -0700, Feng Kan wrote:
> >> Hi Greg:
> >>
> >> On Thu, Jul 29, 2010 at 5:50 PM, Greg KH <gregkh@suse.de> wrote:
> >> > On Thu, Jul 29, 2010 at 05:14:59PM -0700, Feng Kan wrote:
> >> >> Hi Greg:
> >> >>
> >> >> We will change to a BSD 3 clause license header. Our legal counsel is
> >> >> talking to Synopsis to make this change.
> >> >
> >> > Why BSD? ??You do realize what that means when combined within the body
> >> > of the kernel, right?
> >> >
> >>
> >> FKAN: We will shoot for a dual BSD/GPL license such as the one in the HP
> >> ?? ?? ?? ?? ?? ??Hil driver.
> >
> > What specific driver is this?
> 
> FKAN: this is driver/input/serio/hil_mlc.c and quite a number of others.

Ok, thanks.

Are you _sure_ that you didn't take any existing GPL code and put it
into this driver when making it?  Did all contributors to the code
release their contributions under both licenses?

> > And are you sure that all of the contributors to the code agree with
> > this licensing change? ??Are you going to require contributors to
> > dual-license their changes?
> >
> > If so, why keep it BSD, what does that get you?
> 
> FKAN: for one thing, to make it future proof on other submissions.

What do you mean by this?  What can you do with this code other than use
it on a Linux system?  You can't put it into any other operating system
with a different license, can you?

> >> > Are you going to be expecting others to contribute back to the code
> >> > under this license, or will you accept the fact that future
> >> > contributions from the community will cause the license to change?
> >
> >
> > You didn't answer this question, which is a very important one before I
> > can accept this driver.
> 
> FKAN: Yes, all of the above. Our legal is working on that. I thought by default
>            GPL defines the above statement.

The GPL does, but as you are trying to dual-license the code, you have
to be careful about how you accept changes, and under what license.
It's a lot more work than I think you realize.  What process do you have
in place to handle this?

> >> >> We will resubmit once this is in place. Please let me know if you have
> >> >> any additional concerns.
> >> >
> >> > My main concern is that you, and everyone else involved in the driver,
> >> > never considered the license of the code in the first place and expected
> >> > the kernel community to accept it as-is, placing the problem on us.
> >>
> >> FKAN: Please don't think this is the case, we gone through this exercise
> >> ?? ?? ?? ?? ?? with Denx.
> >
> > What is "Denx"?
> 
> FKAN: U-Boot Denx.de

Ah, thanks.

> >> We had legal looking into the header before submission
> >> ?? ?? ?? ?? ?? to them and the kernel.
> >
> > Then what happened here? ??Just curious as to how the driver was public
> > for so long before someone realized this.
> >
> 
> FKAN:  this was few years back. At the time we had the header changed
>            so it was BSD like to be accepted by Denx.
> 
> >> > What will be done in the future to prevent this from happening again?
> >>
> >> FKAN: agreed, once bitten .... :)
> >
> > That didn't answer the question :)
> 
> FKAN: we have a system of checks for every patch that goes out. I will send
>            out a guideline to all reviewer to make sure the header
> follow kernel precedence.

But you took this code from a different vendor, are you able to properly
identify the code contributions to this base and what license it is
under and where they got it from?

>            Legal is quite aware of the issue now too.

As they should be :)

Please reconsider the dual licensing unless you really are ready to
handle the implications of it.

thanks,

greg k-h
