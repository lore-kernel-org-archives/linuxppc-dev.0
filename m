Return-Path: <neko@genesi-usa.com>
Message-ID: <48E243C5.7000100@genesi-usa.com>
Date: Tue, 30 Sep 2008 10:20:37 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: USB support on mpc5200 broken
References: <9e4733910809241451x7492d2a9s56b4cb4ee0fe0244@mail.gmail.com>	
	<9e4733910809241809r58bddc2ax4759b70c3f07f6cf@mail.gmail.com>	
	<1222307447.8277.147.camel@pasglop>
	<48E02FD0.8000809@genesi-usa.com>	
	<20080929034329.GB8694@yookeroo.seuss>
	<9e4733910809290714td2dc6cclecf2e2b080a80ca1@mail.gmail.com>
In-Reply-To: <9e4733910809290714td2dc6cclecf2e2b080a80ca1@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> 
> Efika has this:
> compatible = "fsl,mpc5200b-ohci","fsl,mpc5200-ohci";

It doesn't :D

My system, running production firmware, says

ohci-bigendian,ohci-be,mpc5200-ohci,mpc5200-usb

This is what we were recommended to use at the time. There is a patch
on www.powerdeveloper.org which tweaks the tree to make it ultra-compliant
with the Linux version of things, which implements every variation. It
also implements a suggested patch which added a "big-endian" property
(not built in to the compatible property, but another property).

I don't see why THAT patch got reverted as it was a great idea that we
all agreed was a great idea.

Linux development around here is getting really schizophrenic. Nobody
is writing these decisions down even as comments in the source code..

> If we really need a big endian flag, should it be an attribute?

Yes.

> Shouldn't the driver already know it is being used on a BE machine?

No; you can have little endian OHCI controllers on big endian machines.
It's a property of the host controller, not the system architecture, just
like PCI is always little endian (except when you have magic in hardware
like Amiga PowerUP cards which endianswap for you :)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
