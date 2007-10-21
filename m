Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910710210701x67b2e99frd0784ac2c8bd27fd@mail.gmail.com>
Date: Sun, 21 Oct 2007 10:01:43 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Device trees and audio codecs
In-Reply-To: <471B550F.3090907@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910710200833x5d1c55b5l2cd400f77c13ec87@mail.gmail.com>
	<471B550F.3090907@freescale.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/21/07, Timur Tabi <timur@freescale.com> wrote:
> > For development purposes I'm using an Efika as a target platform. It
> > is easy enough to load the i2s driver using the device tree. I can add
> > entries to the i2s node to trigger loading of the generic sta9766
> > codec driver. How do I trigger loading the Efika specific fabric
> > driver?
>
> You don't need a device tree entry to trigger loading a driver.  You can just
> load the driver and initialize it in its __init function.
>
> However, in this case, you might want to do what I'm doing -- putting a probe
> function in the fabric driver for the i2s device (which gets its own node
> under the SOC node), and then in that probe function search for all the other
> nodes that you need.

Doing it that way will make the kernel specific to the target device.
Currently I can load the same mpc5200 kernel on several different
target devices since the platform specific code is triggered in the
probe machine phase.

I tried making the fabric driver into a platform driver instead of an
openfirmware driver, but the mpc5200 code is not initializing platform
drivers correctly.

I could insert calls into arch/powerpc/platforms/52xx/whatever to load
the specific asoc fabric, but doing that is a mess. There must be a
way to trigger loading of machine specific drivers

> Since the Apple audio drivers are not ASoC drivers, I suggest we don't pay
> attention to what they do.

Those Apple drivers are very similar to asoc drivers. They could
easily be folded into the asoc code.


-- 
Jon Smirl
jonsmirl@gmail.com
