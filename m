Return-Path: <neko@genesi-usa.com>
Message-ID: <48E24278.4010306@genesi-usa.com>
Date: Tue, 30 Sep 2008 10:15:04 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>, linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Re: USB support on mpc5200 broken
References: <9e4733910809241451x7492d2a9s56b4cb4ee0fe0244@mail.gmail.com>
	<9e4733910809241809r58bddc2ax4759b70c3f07f6cf@mail.gmail.com>
	<1222307447.8277.147.camel@pasglop>
	<48E02FD0.8000809@genesi-usa.com>
	<20080929034329.GB8694@yookeroo.seuss>
In-Reply-To: <20080929034329.GB8694@yookeroo.seuss>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


David Gibson wrote:
> 
> This, of course, is exactly why I *don't* recommend embedded platforms
> move to including the device tree in the flashed firmware.  Keeping
> the device tree in the bootwrapper means that it *is* updated with the
> kernel and we don't have to mess around with as much backwards
> compatibility junk.

Pardon my language, but this is such bullshit.

This isn't "including a device tree in flashed firmware", this is
"having a real Open Firmware". We don't embed anything in there, it's
procedurally generated on each boot.

Our whole problem here is that we have a device tree which was fixed
for production before the device tree specification was nailed down
for the MPC5200B, and it's still in flux. We can't be expected to
walk lock-step with a 3 month kernel development cycle and we certainly
do not appreciate sidelining real firmware in favor of static device
trees which need to be compiled *per board*.

All the FDT does is move a lot of extra hardcoded values out of the
kernel and into a just-as-annoying extra file you need to be wary of
keeping up to date since the format and specification changes so much.

We never had this much whining about Apple's device tree, people just
implemented the workarounds..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
