Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id D8289DDE26
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 13:14:50 +1000 (EST)
Date: Fri, 4 Jul 2008 13:14:49 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH v2] Change the default link address for pSeries zImage
	kernels.
Message-ID: <20080704031449.GW20457@bakeyournoodle.com>
References: <1a551391a3c4925271cc86cb2e957aaccb0b599c.1214208801.git.tony@bakeyournoodle.com>
	<4ca08ab3df251d90440c962ef15ead1a72d75f05.1214276944.git.tony@bakeyournoodle.com>
	<20080702150432.GA5910@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080702150432.GA5910@aepfle.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 02, 2008 at 05:04:32PM +0200, Olaf Hering wrote:
 
> Setting real-base to what?

32Mb, or any other value big enough to allow the tftp to fit in
${real-base} - ${load-base}.  I admitt it's far from ideal.
 
> What currently happens with a large boot file is:
> Firmware loads the zImage at load-base, finds that the ELF file is too
> large to fit into the memory window and stops.
> 
> With your patch, firmware loads 12566528 bytes, and starts the zImage.
> The result is a truncated file, the initrd will be corrupted, kernel
> panic in populate_rootfs().

Okay that's not the behaviour I see here on the POWER4 machines, they
grab the firt n bytes (probabbly 12566528), and then abort with a
message about image being too large and it cannot be split.
(something akin to https://bugzilla.novell.com/show_bug.cgi?id=350212 )
 
> The only system where firmware relocates itself from 12MB to 32MB is a
> p640 with firmware version NAN04194.
> All other systems seem to ignore the NOTE section, real-base remains at
> 0xc00000

Add I thought /all/ POWER4 systems were unable to relocate OF
(regardless of whether the request is from the NOTE or from set-env
real-base).
 
> So I do not think your patch is a real improvement,
> clear error vs. silent corruption.
> 
> Do you happen to know how to automate the changing the value of
> real-base? The addnote change has appearently no effect on recent
> systems.

It's there for POWER5 and on.  I was sure that no POWER4 machines could
be reloacted, but you say that your p640 can.

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
