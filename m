Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id BAD9F2BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Nov 2004 05:17:28 +1100 (EST)
Date: Tue, 9 Nov 2004 11:17:07 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Felix Radensky <felix@allot.com>
Message-ID: <20041109111707.A14471@home.com>
References: <4190FDED.3080605@allot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4190FDED.3080605@allot.com>;
	from felix@allot.com on Tue, Nov 09, 2004 at 07:27:09PM +0200
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 405GPr ioremap problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Nov 09, 2004 at 07:27:09PM +0200, Felix Radensky wrote:
> Hi, folks
> 
> I have a 405GPr based board with 512M of RAM.
> My kernel is 2.4.17 from Monta Vista Linux 2.1.
> I'm  trying to reserve 64M on boot using mem=448M
> and map it later by
> 
> ioremap(__pa(high_memory), 64*(1<<20));
> 
> This worked fine when system had 256M of RAM,
> but now ioremap fails. If I understand the kernel
> code correctly, by adding more RAM I've reduced
> the vmalloc/ioremap space. I can also see that this
> space is reduced dramatically on boot by mappings
> done in arch/ppc/kernel/ppc4xx_setup.c:m4xx_map_io()
> 
> Is there any way to fix problem ? Is it necessary to have
> a 1:1 virtual to physical mappings as its done in m4xx_map_io()
> or maybe higher virtual addresses can be used, thus
> allowing to save some precious ioremap space.

This is exactly why the PPC44x ports don't use io_block_map()...
it can interfere with dynamic mappings.  It is not necessary to
have 1:1 virtual to physical mappings nor is it necessary to
have m4xx_map_io() at all. One can use ioremap() to map any
space and let the kernel place things intelligently. In order
to use serial console you'll have to use early_serial_setup()
after you've ioremapped the UART...once you've removed the
io_block_map() call. Look at other ports to see how this is
done.

Someday I might get down my list to cleaning up 40x stuff in 2.6.

-Matt
