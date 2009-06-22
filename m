Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1EF6FB7125
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 08:21:37 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6B050DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 08:21:36 +1000 (EST)
Subject: Re: Boot failure on the powerstation with 2.6.30 latest
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brian King <brking@linux.vnet.ibm.com>
In-Reply-To: <4A3FAD31.2060703@linux.vnet.ibm.com>
References: <1245683801.6901.8.camel@mulgrave.site>
	<4A3FAD31.2060703@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Tue, 23 Jun 2009 08:21:21 +1000
Message-Id: <1245709281.20062.7.camel@pasglop>
Mime-Version: 1.0
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
	linuxppc-dev@ozlabs.org, Pekka Enberg <penberg@cs.helsinki.fi>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-06-22 at 11:11 -0500, Brian King wrote:
> James,
> 
> I was running into a similar hang on one of my Power boxes as well.
> Reverting c868d550115b9ccc0027c67265b9520790f05601 allowed by system
> to boot. It looks like that patch injected a bug where we can end up
> waiting on an uninitialized mutex:
> 
> [c0000000009f3c30] c00000000052c7dc .mutex_lock+0x34/0x50
> [c0000000009f3cb0] c00000000008b190 .get_online_cpus+0x3c/0x74
> [c0000000009f3d40] c000000000146cd0 .kmem_cache_create+0xcc/0x548
> [c0000000009f3e50] c000000000032ae0 .pgtable_cache_init+0x28/0x6c
> [c0000000009f3ee0] c000000000780960 .start_kernel+0x1ec/0x520
> [c0000000009f3f90] c0000000000083d8 .start_here_common+0x1c/0x44
> 
> The mutex gets initialized in cpu_hotplug_init, which doesn't get called until
> after pgtable_cache_init.

Ah good, I didn't have a chance to track that one down yet.

So the problem here is that we must do pgtable_cache_init there because
vmalloc is initialized right after, which relies on allocating page
tables and that will need kmem caches on some archs.

So I suspect we need to sort out this mutex, either initializing it from
elsewhere, moving cpu_hotplug_init() earlier, or avoiding it when the
kernel state isn't SYSTEM_RUNNING, I haven't looked in details yet.

Cheers,
Ben.

> -Brian
> 
> James Bottomley wrote:
> > 2.6.30-rc8 worked fine ... unless this is a known problem, I suppose I
> > can begin bisecting.
> > 
> > The boot log of the hang is:
> > 
> > Please wait, loading kernel...
> >    Elf64 kernel loaded...
> > Loading ramdisk...
> > ramdisk loaded at 02500000, size: 8280 Kbytes
> > OF stdout device is: /ht/isa@8/serial@2f8
> > Preparing to boot Linux version 2.6.30 (jejb@claymoor) (gcc version 4.3.3 (Debian 4.3.3-10) ) #1 SMP Mon Jun 22 09:59:35 CDT 2009
> > command line: root=/dev/sda3 ro console=ttyS0,19200n1 
> > memory layout at init:
> >   alloc_bottom : 0000000002d16000
> >   alloc_top    : 0000000030000000
> >   alloc_top_hi : 0000000080000000
> >   rmo_top      : 0000000030000000
> >   ram_top      : 0000000080000000
> > instantiating rtas at 0x000000002fff5000... done
> > boot cpu hw idx 0000000000000000
> > starting cpu hw idx 0000000000000001... done
> > starting cpu hw idx 0000000000000002... done
> > starting cpu hw idx 0000000000000003... done
> > copying OF device tree...
> > Building dt strings...
> > Building dt structure...
> > Device tree strings 0x0000000003117000 -> 0x0000000003117640
> > Device tree struct  0x0000000003118000 -> 0x000000000311b000
> > Calling quiesce...
> > returning from prom_init
> > 
> > So it looks like some type of early boot failure or handoff in head_64
> > 
> > James
> > 
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 
