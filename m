Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id A40CEDDE04
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 15:15:46 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so61285anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 21:15:43 -0700 (PDT)
Message-ID: <fa686aa40803182115k241050f0meafccc29b4ef16@mail.gmail.com>
Date: Tue, 18 Mar 2008 22:15:43 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [RFC] Xilinx: Add generic configuration option to enable
	all xilinx drivers.
In-Reply-To: <20080212213120.D51157F806B@mail176-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080212213120.D51157F806B@mail176-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 12, 2008 at 3:31 PM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
> In the future, this will be used to provide similar configuration for
>  PowerPC and Microblaze.  It may also be convenient for those using
>  Xilinx cores as peripherals for external processors, rather than
>  explicitly having a dependance on the processor architecture.
>
>  Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
>
>  ---
>
>  Grant,
>
>  This is the patch, updated for all of the drivers that I think are in
>  the tree.  I think the problematic parts may be the ppc part, which is
>  required for backward compatibility.  If this has to wait until ppc
>  dies, then that's fine with me, I guess.
>
>  It may also be better to clean up the Kconfig lines for Sysace and
>  framebuffer drivers by having PPC32 or PPC4xx select XILINX_DRIVERS.
>  My understanding is that those config options are there because of
>  people using external PPCs with those devices in the FPGA.

Hey Steve;

I haven't forgotten about this patch, but I've been thinking about it
some more and I'm coming to the conclusion that it might just be
better to eliminate driver dependence on XILINX_DRIVERS and
XILINX_VIRTEX entirely and instead just make each of them "depends on
PPC32 || MICROBLAZE".  There's no reason to restrict compiling these
drivers to platforms that are known to have xilinx parts on them.

I know that in most cases they will not be used, but by relaxing the
dependencies they will get compile tested on more platforms than they
are now and they'll get picked up for make allyesconfigs builds.  In
my mind this means greater chances of compile bugs getting found and
reported.

In fact, it would be nice to drop the PPC32 || MICROBLAZE dependency
too; but I think the drivers are using io primitives at the moment
that are not portable to x86.

Thoughts?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
