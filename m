Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8C25D1007DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 15:27:19 +1100 (EST)
Subject: Re: [RFC PATCH 02/19] powerpc: gamecube: device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <49443.84.105.60.153.1259172058.squirrel@gate.crashing.org>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<49443.84.105.60.153.1259172058.squirrel@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Nov 2009 15:27:12 +1100
Message-ID: <1259209632.16367.246.camel@pasglop>
Mime-Version: 1.0
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-11-25 at 19:00 +0100, Segher Boessenkool wrote:
> > +	memory {
> > +		device_type = "memory";
> > +		/* 24M minus framebuffer memory area (640*576*2*2) */
> > +		reg = <0x00000000 0x01698000>;
> 
> Put the whole 24MB here, probe the framebuffer address and size
> in the platform code?

Agreed. That's what I was proposing. Though you need to be careful about
early boot code that will try to allocate the hash table etc... or even
the DT itself. So you need to probe and reserve the fb really early,
for example in the platform probe() routine itself. Or you can stick it
in the reserve map too I suppose.

> > +		video@0c002000 {
> > +			compatible = "nintendo,flipper-video";
> > +			reg = <0x0c002000 0x100>;
> > +			interrupts = <8>;
> > +			interrupt-parent = <&pic>;
> > +			/* XFB is the eXternal FrameBuffer */
> > +			xfb-start = <0x01698000>; /* end-of-ram - xfb-size */
> > +			xfb-size = <0x168000>;
> 
> XFB address isn't fixed on the hardware, and the kernel might
> want to move it, and you can easily probe for it anyway.  Remove
> these last two properties please.

Ok but you need to know what it was setup to by the FW no ? To avoid
having a temporary display "glitch" while booting... Also on a 24M
config,it might get tough for the driver to allocate 2M contiguous like
that if it's done late in the boot process.
> 
> > +		auxram@0c005000 {
> > +			compatible = "nintendo,flipper-auxram";
> > +			reg = <0x0c005000 0x200>;	/* DSP */
> > +			interrupts = <6>;
> > +			interrupt-parent = <&pic>;
> > +		};
> > +
> > +		audio@0c005000 {
> > +			compatible = "nintendo,flipper-audio";
> > +			reg = <0x0c005000 0x200		/* DSP */
> > +			       0x0c006c00 0x20>;	/* AI */
> > +			interrupts = <6>;
> > +			interrupt-parent = <&pic>;
> > +		};
> 
> These two have the same address, not good.  Just remove the
> auxram node?

Or make it a child of audio ? :-)

Cheers,
Ben.
