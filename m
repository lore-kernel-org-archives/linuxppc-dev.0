Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711190733m6ba3b723mfd9f6239b252ef1e@mail.gmail.com>
Date: Mon, 19 Nov 2007 10:33:31 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Revisited, audio codec device tree entries.
In-Reply-To: <4741A443.4080900@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
	<0fd3304ee694b2dc6a8f3055c08dc015@kernel.crashing.org>
	<9e4733910711181349q1f840bc2w8d30bb33d2a353ce@mail.gmail.com>
	<4740C0E3.5080704@genesi-usa.com> <4741A443.4080900@freescale.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/19/07, Timur Tabi <timur@freescale.com> wrote:
> Matt Sealey wrote:
> > Jon Smirl wrote:
> >> The codec-fabric node was just being used to trigger the loading of
> >> the platform specific driver.
> >
> > Just remember one thing.
> >
> > 1) the term "fabric" when coined for audio drivers is a new, ALSA SoC
> > specific term. It isn't relevant for anything but ALSA SoC drivers.
>
> Earlier this year, when I started working on an ASoC driver, the fabric driver
> was called a "machine driver".

ALSA is using the term fabric in the aoa directory, and the term
'machine' in the soc directory.  They both mean the same thing, but it
is very confusing to call this a machine driver when we are talking
about device trees. Once everything gets settled the aoa code should
be merged into the soc code, it is almost identical in architecture.

>
> > 2) this device tree stuff will end up in more than Linux device trees
>
> Sorry, I don't understand.  The device trees are technically OS-independent,
> so technically there's no such thing as a "Linux device tree".  In addition,
> the current master repository for device trees happens to be the Linux kernel,
>   so I'm not sure where else device trees are going to be.
>
> > 3) you're going to piss off Open Firmware developers by specifying
> > very Linux-specific features in a device tree the same way Apple
> > pissed off Linux developers by encoding MacOS X-specific features in
> > the device tree.
>
> The current device trees have left their OF roots behind.  Sure, we try to
> conform as much as possible, but they're not OF trees any more.
>
> > Audio driver control like this has to be very specific for a good
> > reason; you can do it a billion ways to Sunday. I'd suggest basically
> > that if you must control a device in a way that needs to be defined by
> > a device which can change address (either dynamically on boot or by
> > board design change - per revision, for example, or with a change of
> > controller) then simply use the device tree to report this address
> > so that you can have the same basic fabric driver (all in Linux) which
> > can handle minor modifications of your board design.
>
> My position is that the "fabric" driver should be loaded as a normal device
> tree and it should use the device tree to pick up some data to help it
> instantiate the other drivers.  I'll be posting the code to my PowerPC ASoC
> driver in a couple weeks.
>
> > If you require the codec to be subservient to some "fabric" then I
>
> The codec is subservient to a bus (sometimes multiple buses), which is why it
> is a child to bus nodes.
>
> --
> Timur Tabi
> Linux Kernel Developer @ Freescale
>


-- 
Jon Smirl
jonsmirl@gmail.com
