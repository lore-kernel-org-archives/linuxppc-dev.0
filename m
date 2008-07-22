Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 71857DDFDE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 04:06:46 +1000 (EST)
Date: Tue, 22 Jul 2008 13:05:06 -0500
From: Scott Wood <scottwood@freescale.com>
To: Stephen Horton <SHorton@kodiaknetworks.com>
Subject: Re: Problem with cuImage Linux entry from old U-boot
Message-ID: <20080722180506.GB13940@loki.buserror.net>
References: <295C5089A56CE143B316E5F67CA99CB001D0626A@cowboy.inovate.inovate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <295C5089A56CE143B316E5F67CA99CB001D0626A@cowboy.inovate.inovate.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Jul 21, 2008 at 03:39:55PM -0500, Stephen Horton wrote:
> I have made great strides with help from this mailing list and its
> archives. I now have a compiled cuImage ready to boot from my older
> working u-boot 1.1.2. I now seem to be stuck at the kernel entry point.
> I'm not sure if I'm trying to jump into the kernel at the wrong address,
> or if I have a serial console issue that prevents me from seeing anymore
> progress.

Most likely the latter, or some other issue that prevents the kernel from
booting to the point where the serial console functions.

> Linux/PowerPC load: ip=bootp root=/dev/nfs rw nfsroot=/opt/gentoo
> console=ttyMM0,9600n8
> Finalizing device tree... flat tree at 0x7423a0
> 
>  
> 
> ------
> 
>  
> 
> If I run 'nm' on my elf image, I expect to find some entry point address
> that corresponds to 0x7423a0, but this is not the case. 

Why would you expect that?  It's a dynamically allocated chunk of memory
that holds the device tree that is passed to the kernel.  It's not an entry
point; the entry point to the kernel is zero.

-Scott
