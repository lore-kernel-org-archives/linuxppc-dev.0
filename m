Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 30D38DDDFB
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Feb 2008 17:05:43 +1100 (EST)
Message-ID: <47AE9434.4000705@pikatech.com>
Date: Sun, 10 Feb 2008 01:05:40 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Could the DTS experts look at this?
References: <47ACE630.8090101@pikatech.com> <200802100647.56590.arnd@arndb.de>
In-Reply-To: <200802100647.56590.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> I guess the cleanest solution would be to include two complete device trees
> for this platform, and then choose the correct one in cuboot-warp.c based
> on the board revision.
>
> The obvious disadvantage of this is that you'd get two device trees
> that you need to keep in sync with every change, so it might not
> be very practical.
>
>   
Keeping two device trees would be awkward. My final solution will 
probably be to just have
the 4M flash partition layout. Since we really only use the partition 
information to write to the partitions from a user mode program, I can 
live with having to flash the images from u-boot.

But if we where planning on moving forward with two configurations, 
which we where planning to do, this would not be an option. We would 
need to auto configure *and* possibly add partitions based on size.

> Maybe we can introduce a more generic way of having conditional
> device nodes in the tree that get knocked out in the boot wrapper.
>   
Of even a way to have ifdefs in the dts. In this case, we have to build 
a specific version of u-boot for each nor size (WARNING: This may not be 
*technically* true, but this is how we are handling it). Having to set a 
config and build a specific kernel, while not ideal, would also be a 
reasonable solution.

Just throwing out ideas. In the short term this is not a problem, but in 
the long term?

Cheers,
   Sean
