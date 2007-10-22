Return-Path: <timur@freescale.com>
Message-ID: <471CA082.1050304@freescale.com>
Date: Mon, 22 Oct 2007 08:07:14 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Device trees and audio codecs
References: <9e4733910710200833x5d1c55b5l2cd400f77c13ec87@mail.gmail.com>	
	<471B550F.3090907@freescale.com>
	<9e4733910710210701x67b2e99frd0784ac2c8bd27fd@mail.gmail.com>
In-Reply-To: <9e4733910710210701x67b2e99frd0784ac2c8bd27fd@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> Doing it that way will make the kernel specific to the target device.
> Currently I can load the same mpc5200 kernel on several different
> target devices since the platform specific code is triggered in the
> probe machine phase.

Maybe I need to take a look at your code, but the fabric driver is, in 
effect, a platform-specific driver.  Its job is to figure out what 
hardware is on the board, how it's connected, and then initialize and 
connect the other drivers as appropriate.

> I tried making the fabric driver into a platform driver instead of an
> openfirmware driver, but the mpc5200 code is not initializing platform
> drivers correctly.

Yeah, that wouldn't work.  Platform drivers are initialized way too early.

> I could insert calls into arch/powerpc/platforms/52xx/whatever to load
> the specific asoc fabric, but doing that is a mess. There must be a
> way to trigger loading of machine specific drivers

Either you do it at driver __init time, or via a probe.  The probe 
actually occurs at __init time, anyway, so they're kinda the same thing. 
  The only thing the probe gets you is that you're called multiple times 
for each instance of a node in the tree.

>> Since the Apple audio drivers are not ASoC drivers, I suggest we don't pay
>> attention to what they do.
> 
> Those Apple drivers are very similar to asoc drivers. They could
> easily be folded into the asoc code.

Perhaps, but that's a job for another day (and another developer).
