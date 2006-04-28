Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 30A6A679FB
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 02:01:31 +1000 (EST)
In-Reply-To: <17489.64606.75404.314368@cargo.ozlabs.ibm.com>
References: <4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<265F73F8-F641-4EDD-B88F-A2B2F7FA1308@kernel.crashing.org>
	<20060425182418.GA1132@gate.ebshome.net>
	<200604251329.35584.bcook@bpointsys.com>
	<248CD1B3-A33B-47F5-AFE8-F7C9DDCD1D0B@kernel.crashing.org>
	<20060425185314.GC1132@gate.ebshome.net>
	<1448E56E-1327-40D5-BE44-0DC103AC3E8A@kernel.crashing.org>
	<17489.64606.75404.314368@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EA2821E8-FB7E-4DDA-8C18-C659B5483DC2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: FT u-boot shim
Date: Fri, 28 Apr 2006 11:01:20 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 28, 2006, at 6:28 AM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> If we have a u-boot shim there are some questions that need  
>> answering:
>> * where should the .dts live (hate duplicating the file both in u-
>> boot and kernel source tree)
>> * how does build system find .dts
>> * a Kconfig option to enable shim
>> * assume done as a boot wrapper of sorts
>
> What I think would be useful is a stand-alone tool that would take a
> kernel and a dts and construct an image that is bootable on a given
> board by its existing firmware.  That means there would either need to
> be a version of the tool for each firmware, or alternatively a set of
> command-line options to tell it what sort of firmware you have.
>
> This wouldn't have to be done at kernel build time; it could be
> potentially be done much later.  Hopefully then the board vendors
> could take on the job of generating the dts.  In fact for some boards
> the board-support package could be just the dts.
>
> This tool would need to insert a suitable shim, which might actually
> need to contain code to pull stuff out of a firmware-specific
> structure such as a bd_t, and stuff it into the dts.  That should be
> doable provided there is a convention about labels in the dts for
> things such as memory size, ethernet mac address, etc.
>
> Clearly it is neater if the firmware can supply the device-tree blob
> directly, and just boot a raw kernel.  However, there will always be
> situations where we don't get to choose the firmware, so I think we
> need this tool.

I agree with this (after having it beaten into me :).

However, I really hate introducing some third project that is  
required.  If we decide to pull ALL of boot wrappers out of the  
kernel tree than I'd be ok with it.  But until that time I think this  
lives under arch/powerpc/boot/...

What I envision as the way one boots for something like u-boot is one  
of three options:
1. using an old u-boot + boot wrapper (bd_t -> wrapper -> kernel)
2. using a u-boot that is ft aware + dtb (boot command in u-boot  
takes kernel & dtb images, updates blob and passes to kernel)
3. using a u-boot that is ft aware + built in dtb.

The issue is that for a given system/board you may need to support  
multiple or all three.  This raises the question where does the .dts  
live.  For the time being I say it lives in the boot wrapper part of  
the kernel tree.  Thus we handle the three cases as follows:

1. built as part of the boot wrapper
2. build a multi image u-boot image, one section for the blob
3. point u-boot build system at .dts

- kumar
