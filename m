Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id 6C94D67A03
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 05:52:03 +1000 (EST)
Date: Fri, 28 Apr 2006 12:52:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: FT u-boot shim
Message-ID: <20060428195201.GB458@smtp.west.cox.net>
References: <4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<265F73F8-F641-4EDD-B88F-A2B2F7FA1308@kernel.crashing.org>
	<20060425182418.GA1132@gate.ebshome.net>
	<200604251329.35584.bcook@bpointsys.com>
	<248CD1B3-A33B-47F5-AFE8-F7C9DDCD1D0B@kernel.crashing.org>
	<20060425185314.GC1132@gate.ebshome.net>
	<1448E56E-1327-40D5-BE44-0DC103AC3E8A@kernel.crashing.org>
	<17489.64606.75404.314368@cargo.ozlabs.ibm.com>
	<EA2821E8-FB7E-4DDA-8C18-C659B5483DC2@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EA2821E8-FB7E-4DDA-8C18-C659B5483DC2@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 28, 2006 at 11:01:20AM -0500, Kumar Gala wrote:

> However, I really hate introducing some third project that is  
> required.  If we decide to pull ALL of boot wrappers out of the  
> kernel tree than I'd be ok with it.  But until that time I think this  
> lives under arch/powerpc/boot/...

The more I think about this, and hear about what some vendors do,
pulling arch/p*pc/boot/ out of the kernel is making more and more sense.
Especially with the serial headache, a depends-on-nothing,
can-translate-$(firmware information) tool might be best.

> What I envision as the way one boots for something like u-boot is one  
> of three options:
> 1. using an old u-boot + boot wrapper (bd_t -> wrapper -> kernel)
> 2. using a u-boot that is ft aware + dtb (boot command in u-boot  
> takes kernel & dtb images, updates blob and passes to kernel)
> 3. using a u-boot that is ft aware + built in dtb.

And more generally:
1. using an old firmware + kernel boot wrapper (firmware->dtb converter)
boots kernel.
2. using a dtb-aware firmware boots kernel (compressed or not) and
passes dtb in.

> The issue is that for a given system/board you may need to support  
> multiple or all three.  This raises the question where does the .dts  
> live.  For the time being I say it lives in the boot wrapper part of  
> the kernel tree.  Thus we handle the three cases as follows:

We could stick it in the seprate kernel boot wrapper project.  But I
really think this really has to live in two places.  The kernel should
be The Owner, as until *BSD or something adopts this, it's a
Linux-specific thing.  But any firmware that wishes to skip the kernel
boot wrapper and be a direct kernel booter, will need to own a copy.

-- 
Tom Rini
http://gate.crashing.org/~trini/
